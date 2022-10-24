Recycle = {}

local _cfg = cfg_recycle

local GUIparent = ""

local page1

local _parent,handle

local _color = {[true] = "#787974",[false] = "#FFFFB7"}

local wnd_w,wnd_h = 400,500                         --大背景图宽高

local isAuto,data,itemid

local allItems = {}

local _setDataType = {
    ["mainCheck"] = 1,              --主面板勾选
    ["secondaryCheck"] = 2,         --副面版勾选
    ["allCheck"] = 3,               --副面版全选/全不选
}

local _state = {
    not_check = 0,
    check = 1,
}

function Recycle.main()
    local FormParam = SL.FormParam[1]
    FormParam = string.gsub(FormParam, "'","")
    FormParam = SL:JsonDecode(FormParam)
    isAuto = tonumber(FormParam[1])
    data = FormParam[2]

    for i, value in ipairs(_cfg) do
        for j, var in ipairs(value) do
            for x, v in ipairs(var) do
                data[i][j][x] = data[i][j][tostring(x)]
                data[i][j][tostring(x)] = nil

                if data[i][j].ischoice == _state.check and data[i][j][x] == _state.check then
                    allItems[_cfg[i][j][x].itemid] = true
                end
            end
        end
    end

    local winSize = SL:GetScreenSize()              --获取屏幕宽高
    local x = winSize.width / 2 + 50
    local y = winSize.height / 2
    local w = winSize.width
    local h = winSize.height

    _parent = GUI:Win_Create("Recycle", 0,0,0,0, false, false, true, false)
    GUIparent = _parent

    handle = GUI:Image_Create(_parent, "recycleUI", x,y, "res/private/TradingBankLayer/bg_jiaoyh_05.png")
    if handle then
        GUI:Win_SetDrag(_parent, handle)
        GUI:Image_setScale9Slice(handle, 20, 20, 20, 20)
        GUI:setAnchorPoint(handle, 0, 0.5)
        GUI:setContentSize(handle,{width = wnd_w, height = wnd_h})
        GUI:setTouchEnabled(handle, true)

        local mainUI = handle

        handle = GUI:Button_Create(mainUI, "btn_close", wnd_w,wnd_h, "res/public/1900000510.png")
        GUI:setAnchorPoint(handle, 0,1)
        GUI:Button_loadTexturePressed(handle, "res/public/1900000511.png")
        GUI:addOnClickEvent(handle, function() Recycle.setItemShowChooseState(false) GUI:Win_Close(GUIparent) end)

        handle = GUI:Button_Create(mainUI, "btn_chick_all", 80 + 170,40, "res/public/1900000663.png")
        GUI:Button_loadTextureDisabled(handle, "res/public/1900000662.png")
        GUI:Button_loadTexturePressed(handle, "res/public/1900000662.png")
        GUI:addOnClickEvent(handle, function() SL:SubmitForm("F/回收表单","RequestEquip","") end)
        local txt_handle = GUI:Text_Create(handle, "tx_btn", 60, 18, 18, "#FFFFFF", "确 认 回 收")
        GUI:setAnchorPoint(txt_handle, 0.5, 0.5)

        local check_handle = GUI:CheckBox_Create(mainUI, "check_isAuto", 65,50, "res/01/010028.png", "res/01/010029.png")
        GUI:CheckBox_setSelected(check_handle, isAuto == _state.check)

        GUI:CheckBox_addOnEvent(check_handle, function(_check_handle,checkState)
            checkState = checkState == 0 and _state.check or _state.not_check

            isAuto = checkState
            SL:SubmitForm("F/回收表单","RequestAutoEquip",checkState)
        end)
        txt_handle = GUI:Text_Create(check_handle, "title", 28,0, 15, "#00FF00","开启自动回收功能")

        handle = GUI:Text_Create(mainUI, "txt_title", wnd_w / 2,wnd_h - 18, 20, "#D6C6AD", "装备回收系统")
        GUI:setAnchorPoint(handle, 0.5,1)

        handle = GUI:Image_Create(mainUI, "img_line", 12,106, "res/custom/common/img_line_2.png")
        GUI:setContentSize(handle,{width = wnd_w - 12 * 2, height = 5})

        handle = GUI:ListView_Create(mainUI, "list_checkBox_1", 11,wnd_h - 55, wnd_w - 22,wnd_h - 165, 1)
        GUI:setAnchorPoint(handle, 0,1)
        GUI:ListView_setClippingEnabled(handle,true)

        x,y = wnd_w,wnd_h - 140
        for i, v in ipairs(_cfg) do
            handle = GUI:Button_Create(mainUI, "page1_"..i, x,y, "res/public/1900000641.png")
            GUI:Button_loadTextureDisabled(handle, "res/public/1900000640.png")
            GUI:Button_loadTexturePressed(handle, "res/public/1900000640.png")
            GUI:addOnClickEvent(handle, function() Recycle.updataPage(i) end)

            local txt_handle = GUI:Text_Create(handle, "title", 0,50, 18, _color[true], v.title)
            GUI:setAnchorPoint(txt_handle, 0.1, 0)
            GUI:Text_setMaxLineWidth(txt_handle, 18)

            if i == 1 then
                Recycle.updataPage(i,true)
            end

            y = y - 80
        end
    end

    Recycle.setItemShowChooseState()
end

function Recycle.updataPage(index,isfirst)
    if not _cfg[index] then return end

    if index == page1 then return end

    --上一次选择按钮
    if page1 then
        handle = GUI:GetWindow(GUIparent, "recycleUI/page1_"..page1)
        GUI:Button_setBrightEx(handle, true)
        local txt_handle = GUI:GetWindow(handle, "title")
        GUI:Text_setTextColor(txt_handle, _color[true])
    end

    page1 = index
    handle = GUI:GetWindow(GUIparent, "recycleUI/page1_"..page1)
    GUI:Button_setBrightEx(handle,false)
    local txt_handle = GUI:GetWindow(handle, "title")
    GUI:Text_setTextColor(txt_handle, _color[false])

    Recycle.createCheckBox1()
end

local imgUI = {}
function Recycle.createCheckBox1()
    local cfg = _cfg[page1]
    if not cfg then return end

    local list_handle = GUI:GetWindow(GUIparent,"recycleUI/list_checkBox_1")
    if not list_handle then return end

    GUI:removeAllChildren(list_handle)

    local max = #cfg
    local limit = 2
    local num = math.ceil(max/limit)
    local idx = 0

    local item_w,item_h = 170,35

    for i = 1, num do
        _parent = GUI:Layout_Create(list_handle, "layout_item_"..i, 0,0, item_w * limit + 10, item_h + 10)
        if _parent then
            GUI:setAnchorPoint(_parent, 0.5, 0.5)
            GUI:setTouchEnabled(_parent, true)

            for j = 1, limit do
                idx = idx + 1
                if idx <= max then
                    handle = GUI:Layout_Create(_parent, "checkBox_"..idx, (j - 1) * (item_w + 7) + 20, 5, item_w, item_h)
                    GUI:setTouchEnabled(handle, true)
                    imgUI["checkBox_"..idx] = handle
                end
            end
        end
    end

    for i, v in ipairs(cfg) do
        _parent = imgUI["checkBox_"..i]
        GUI:addOnClickEvent(_parent, function() Recycle.createCheckBox2(i) end)

        local check_handle = GUI:CheckBox_Create(_parent, "check", 0,0, "res/01/010028.png", "res/01/010029.png")
        GUI:CheckBox_setSelected(check_handle, data[page1][i].ischoice == _state.check)
        GUI:CheckBox_addOnEvent(check_handle, function(_check_handle,checkState)
            checkState = checkState == 0 and _state.check or _state.not_check
            -- print("监听测试","editbox",checkState)
            -- print("监听测试",page1,i,checkState)
            data[page1][i].ischoice = checkState

            for _page3, var in ipairs(_cfg[page1][i]) do
                local bool = ((data[page1][i].ischoice == _state.check) and (data[page1][i][_page3] == _state.check)) and true or nil
                itemid = _cfg[page1][i][_page3].itemid
                allItems[itemid] = bool
            end

            Recycle.setItemShowChooseState()

            SL:SubmitForm("F/回收表单","SetUserData",_setDataType.mainCheck.."#"..page1.."#"..i.."#0#"..checkState)
        end)


        local txt_handle = GUI:Text_Create(_parent, "title", 30,0, 16, "#FFFFFF",cfg[i].name)
        GUI:Text_enableUnderline(txt_handle)
    end
end

local imgUI2 = {}
function Recycle.createCheckBox2(page2)
    local cfg = _cfg[page1] and _cfg[page1][page2] or nil
    if not cfg then return end

    local winSize = SL:GetScreenSize()              --获取屏幕宽高
    local x = winSize.width / 2 + 50
    local y = winSize.height / 2
    _Listparent = GUI:GetWindow(GUIparent,"layout_listPage")
    if _Listparent then
        GUI:removeAllChildren(_Listparent)
    else
        _Listparent = GUI:Layout_Create(GUIparent, "layout_listPage", 0,0, winSize.width, winSize.height)
        GUI:setAnchorPoint(_Listparent, 0, 0)
        GUI:setTouchEnabled(_Listparent, true)
        GUI:addOnClickEvent(_Listparent, function() GUI:removeFromParent(_Listparent) end)
    end



    handle = GUI:Image_Create(_Listparent, "recycle2UI", x,y, "res/private/TradingBankLayer/bg_jiaoyh_05.png")
    if handle then
        GUI:Image_setScale9Slice(handle, 20, 20, 20, 20)
        GUI:setAnchorPoint(handle, 0, 0.5)
        GUI:setContentSize(handle,{width = wnd_w, height = wnd_h})
        GUI:setTouchEnabled(handle, true)

        local mainUI = handle

        handle = GUI:Image_Create(mainUI, "img_line", 12,53, "res/custom/common/img_line_2.png")
        GUI:setContentSize(handle,{width = wnd_w - 12 * 2, height = 5})

        handle = GUI:Button_Create(mainUI, "btn_close", wnd_w,wnd_h, "res/public/1900000510.png")
        GUI:setAnchorPoint(handle, 0,1)
        GUI:Button_loadTexturePressed(handle, "res/public/1900000511.png")
        GUI:addOnClickEvent(handle, function() GUI:removeFromParent(_Listparent) end)

        handle = GUI:Text_Create(mainUI, "txt_title", wnd_w / 2,wnd_h - 18, 20, "#D6C6AD",cfg.name)
        GUI:setAnchorPoint(handle, 0.5,1)

        local list_handle = GUI:ListView_Create(mainUI, "list_checkBox_2", 11,wnd_h - 55, wnd_w - 22,wnd_h - 65 - 50, 1)
        GUI:setAnchorPoint(list_handle, 0,1)
        GUI:ListView_setClippingEnabled(list_handle,true)

        handle = GUI:Button_Create(mainUI, "btn_chick_all", 80,18, "res/public/1900000652.png")
        if handle then
            GUI:Button_loadTextureDisabled(handle, "res/public/1900000652_1.png")
            GUI:Button_loadTexturePressed(handle, "res/public/1900000652_1.png")

            GUI:addOnClickEvent(handle, function() Recycle.CheckAll(page1,page2,1) end)

            local txt_handle = GUI:Text_Create(handle, "tx_btn", 40,15, 16, "#FFFFFF", "全  选")
            GUI:setAnchorPoint(txt_handle, 0.5, 0.5)
        end

        handle = GUI:Button_Create(mainUI, "btn_chick_allnot", 240,18, "res/public/1900000652.png")
        if handle then
            GUI:Button_loadTextureDisabled(handle, "res/public/1900000652_1.png")
            GUI:Button_loadTexturePressed(handle, "res/public/1900000652_1.png")

            GUI:addOnClickEvent(handle, function() Recycle.CheckAll(page1,page2,0) end)

            local txt_handle = GUI:Text_Create(handle, "tx_btn", 40,15, 16, "#FFFFFF", "全不选")
            GUI:setAnchorPoint(txt_handle, 0.5, 0.5)
        end

        local max = #cfg
        local limit = 1
        local num = math.ceil(max/limit)
        local idx = 0

        local item_w,item_h = 170,45

        for i = 1, num do
            _parent = GUI:Layout_Create(list_handle, "layout_item_"..i, 0,0, item_w * limit + 10, item_h + 10)
            if _parent then
                GUI:setAnchorPoint(_parent, 0.5, 0.5)
                GUI:setTouchEnabled(_parent, true)

                for j = 1, limit do
                    idx = idx + 1
                    if idx <= max then
                        handle = GUI:Layout_Create(_parent, "checkBox_"..idx, (j - 1) * (item_w + 7) + 20, 5, item_w, item_h)
                        GUI:setTouchEnabled(handle, true)
                        imgUI2["checkBox_"..idx] = handle
                    end
                end
            end
        end

        for i, v in ipairs(cfg) do
            _parent = imgUI2["checkBox_"..i]

            handle = GUI:Image_Create(_parent, "img_bg1", 0,-5, "res/public/1900000664.png")
            GUI:setContentSize(handle,{width = 40, height = 40})

            local itemshow = GUI:ItemShow_Create(_parent, "itemshow",0,-5, {index = cfg[i].itemid, look = true})
            GUI:setScale(itemshow, 0.7)

            local check_handle = GUI:CheckBox_Create(_parent, "check", 50,5, "res/01/010028.png", "res/01/010029.png")
            -- local idx_str = tostring(i)
            GUI:CheckBox_setSelected(check_handle, data[page1][page2][i] == _state.check)
            GUI:CheckBox_addOnEvent(check_handle, function(_check_handle,checkState)
                checkState = checkState == 0 and _state.check or _state.not_check
                -- print("监听测试","editbox",checkState)
                -- print("监听测试",page1,page2,i,checkState)
                data[page1][page2][i] = checkState

                for _page3, var in ipairs(_cfg[page1][page2]) do
                    local bool = ((data[page1][page2].ischoice == _state.check) and (data[page1][page2][_page3] == _state.check)) and true or nil
                    itemid = _cfg[page1][page2][_page3].itemid
                    allItems[itemid] = bool
                end

                Recycle.setItemShowChooseState()

                SL:SubmitForm("F/回收表单","SetUserData",_setDataType.secondaryCheck.."#"..page1.."#"..page2.."#"..i.."#"..checkState)
            end)

            local txt_handle = GUI:Text_Create(_parent, "title", 80,5, 15, "#00FF00",cfg[i].txt)
            GUI:Text_enableUnderline(txt_handle)

            local priceName = SL:GetItemNameByIndex(cfg[i].price1[1][1])
            local priceNum = cfg[i].price1[1][2]
            if (priceNum % 10000 == 0) and (priceNum / 10000 > 1) then
                priceNum = priceNum/10000 .."万"
            end

            txt_handle = GUI:Text_Create(_parent, "money", 225,5, 15, "#00FF00",priceNum ..priceName)
            GUI:Text_enableUnderline(txt_handle)
        end
    end
end

function Recycle.CheckAll(param1,param2,param3)
    _parent = GUI:GetWindow(GUIparent,"layout_listPage/recycle2UI/list_checkBox_2")
    if _parent then
        for key, _handle in pairs(imgUI2) do
            handle = GUI:GetWindow(_handle,"check")
            if handle then
                GUI:CheckBox_setSelected(handle, param3 == _state.check)
            end
        end
    end


    for _page3, var in ipairs(_cfg[param1][param2]) do
        data[param1][param2][_page3] = param3

        local bool = ((data[param1][param2].ischoice == _state.check) and (data[param1][param2][_page3] == _state.check)) and true or nil
        itemid = _cfg[param1][param2][_page3].itemid
        allItems[itemid] = bool
    end

    Recycle.setItemShowChooseState()

    SL:SubmitForm("F/回收表单","SetUserData",_setDataType.allCheck.."#"..param1.."#"..param2.."#0#"..param3)
end


--背包道具勾选
function Recycle.setItemShowChooseState(param)
    if Bag._UI_ScrollView and not tolua.isnull(Bag._UI_ScrollView) then
        local bagData  = SL:GetBagDataByPage(Bag._selPage)
        for k,v in pairs(bagData or {}) do
            if v then
                local bool = allItems[v.Index] and true or false
                if param ~= nil then
                    bool = param
                end
                local itemShow = GUI:getChildByName(Bag._UI_ScrollView, tostring(v.MakeIndex))
                if itemShow then
                    GUI:ItemShow_setItemShowChooseState(itemShow, bool)
                end
            end
        end
    end
end

Recycle.main()