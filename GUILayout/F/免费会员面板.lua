freeVip = {}

local _color = {[true] = "#787974",[false] = "#FFFFB7"}

local freeVipPage = nil

local GUIparent = nil

local _parent,handle

local wnd_w,wnd_h = 815,575                         --大背景图宽高

local freeVip_Lv,task_info,gifts_info

local _state = {
    flag_no = 0,
    flag_yes = 1,
}

function freeVip.main()
    local FormParam = SL.FormParam[1]
    FormParam = string.gsub(FormParam, "'","")
    FormParam = SL:JsonDecode(FormParam)
    freeVip_Lv = tonumber(FormParam[1])
    task_info = FormParam[2]
    gifts_info = FormParam[3]

    _parent = GUI:Win_Create("freeVip", 0, 0, 0, 0, false, false, true, false)
    local winSize = SL:GetScreenSize()              --获取屏幕宽高
    local x = winSize.width / 2
    local y = winSize.height / 2
    local w = winSize.width
    local h = winSize.height

    GUIparent = _parent

    handle = GUI:Layout_Create(_parent, "layout_close", x, y, w, h)
    if handle then
        GUI:Layout_setBackGroundColor(handle, "#000000")
        GUI:Layout_setBackGroundColorType(handle, 1)
        GUI:Layout_setBackGroundColorOpacity(handle, 100)
        GUI:setAnchorPoint(handle, 0.5, 0.5)
        GUI:setTouchEnabled(handle, true)
        GUI:addOnClickEvent(handle, function()
            GUI:Win_Close(GUIparent)
        end)
    end

    handle = GUI:Image_Create(_parent, "img_bg", x, y, "res/01/010000.png")
    if handle then
        GUI:setAnchorPoint(handle, 0.5, 0.5)
        GUI:setContentSize(handle,{width = wnd_w, height = wnd_h})
        GUI:setTouchEnabled(handle, true)

        local _fahandle = handle
        handle = GUI:Button_Create(_fahandle, "btn_close", wnd_w - 25,wnd_h - 20, "res/01/010008.png")
        if handle then
            GUI:setAnchorPoint(handle, 1,1)
            GUI:Button_loadTexturePressed(handle, "res/01/010009.png")
            GUI:addOnClickEvent(handle, function()
                GUI:Win_Close(GUIparent)
            end)
        end

        handle = GUI:Image_Create(_fahandle, "img_bg1", 62,21, "res/custom/vip/img_bg_1.jpg")
        if handle then
            GUI:setContentSize(handle,{width = 734 - 42, height = 447})
        end

        handle = GUI:Text_Create(_fahandle, "txt_title", wnd_w / 2,wnd_h - 35, 20, "#D6C6AD", "免费会员")
        if handle then
            GUI:setAnchorPoint(handle, 0.5,1)
        end

        handle = GUI:Node_Create(_fahandle, "node_title_1", 220,337)
        GUI:Image_Create(handle, "vip", 0,0, "res/custom/vip/txt_VIP.png")
        GUI:Image_Create(handle, "特权", 64,0, "res/custom/vip/txt_tequan.png")
        GUI:Image_Create(handle, "num", 43,0, "res/custom/vip/1.png")

        handle = GUI:Node_Create(_fahandle, "node_title_2", 516,337)
        GUI:Image_Create(handle, "gift", 0,0, "res/custom/vip/vip_gift.png")
        GUI:Image_Create(handle, "task", 0,0, "res/custom/vip/vip_task.png")

        handle = GUI:Node_Create(_fahandle, "node_main", 190,220)
        -- GUI:RichText_Create(handle, "rich_condition", 0, 0, "<font color='0x01d1ff'>打宝概率提升12%<br>装备回收比例提升30%<br>对怪每秒伤害提升19200</font>", 190)

        --左侧页签
        local btn_x,btn_y = 0,5
        local list_handle = GUI:ListView_Create(_fahandle, "ListView_1", 122, 22, 116, wnd_h - 230, 1)
        if list_handle then
            GUI:setAnchorPoint(list_handle, 0.5,0)
            GUI:ListView_setClippingEnabled(list_handle,true)
            GUI:ListView_setItemsMargin(list_handle, 5)
            for i, v in ipairs(cfg_xiuxian) do
                handle = GUI:Button_Create(list_handle, "page1_"..i, btn_x,btn_y, "res/01/010005.png")
                if handle then
                    local txt_handle = GUI:Text_Create(handle, "title", 55,5, 18, _color[true], v.name)
                    GUI:setAnchorPoint(txt_handle, 0.5, 0)

                    GUI:Button_loadTexturePressed(handle, "res/01/010006.png")
                    GUI:Button_loadTextureDisabled(handle, "res/01/010006.png")
                    GUI:addOnClickEvent(handle, function()
                        freeVip.updataPage(i)
                    end)
                end
            end
            if freeVip_Lv and cfg_xiuxian[freeVip_Lv + 1] then
                freeVip.updataPage(freeVip_Lv + 1,true)
            else
                freeVip.updataPage(1,true)
            end
        end
    end

    handle = GUI:Image_Create(_parent, "img_b2", 58 + 160,18 + 31, "res/custom/painting/vip_welfare_item_frame.png")
    if handle then
        GUI:Image_setScale9Slice(handle, 10, 10, 10, 10)
        GUI:setContentSize(handle,{width = 734 - 35, height = 455})
        GUI:setLocalZOrder(handle,99)
    end
end

function freeVip.updataPage(page,isFirst)  --参数(页签id,是否首次打开面板
    if not cfg_xiuxian[page] then return end

    --上一次选择按钮
    if freeVipPage and not isFirst then
        handle = GUI:GetWindow(GUIparent, "img_bg/ListView_1/page1_"..freeVipPage)
        GUI:Button_setBrightEx(handle, true)
        local txt_handle = GUI:GetWindow(handle, "title")
        GUI:Text_setTextColor(txt_handle, _color[true])
    end
    if page == freeVipPage then return end

    freeVipPage = page
    handle = GUI:GetWindow(GUIparent, "img_bg/ListView_1/page1_"..freeVipPage)
    GUI:Button_setBrightEx(handle,false)
    local txt_handle = GUI:GetWindow(handle, "title")
    GUI:Text_setTextColor(txt_handle, _color[false])
    freeVip.updataUI()
end

local imgUI = {}
function freeVip.updataUI()
    local _parent = GUI:GetWindow(nil,"freeVip/img_bg")
    if not _parent then return end

    local cfg = cfg_xiuxian[freeVipPage]

    handle = GUI:GetWindow(_parent,"node_title_1/num")
    GUI:Image_loadTexture(handle,"res/custom/vip/"..freeVipPage..".png")

    handle = GUI:GetWindow(_parent,"node_title_2/gift")
    GUI:setVisible(handle,freeVip_Lv >= freeVipPage)

    handle = GUI:GetWindow(_parent,"node_title_2/task")
    GUI:setVisible(handle,freeVip_Lv < freeVipPage)

    _parent = GUI:GetWindow(_parent,"node_main")
    GUI:removeAllChildren(_parent)
    GUI:RichText_Create(_parent, "rich_condition", 0, 0, cfg.condition, 190)

    local x,y = 105,-182
    for i, v in ipairs(cfg.pet) do
        handle = GUI:Image_Create(_parent, "itemshow"..i, x,y, "res/custom/common/object_di_1.png")
        local itemshow = GUI:ItemShow_Create(handle, "item",3,3, {index = v[1], count = v[2], look = true})
        GUI:setScale(handle, 0.7)
        GUI:Image_setGrey(handle,freeVip_Lv >= freeVipPage)
        GUI:ItemShow_setIconGrey(itemshow,freeVip_Lv >= freeVipPage)
        x = x + 60
    end

    if freeVip_Lv >= freeVipPage then
        GUI:Image_Create(_parent, "img_flagyes1", 475,-182, "res/custom/common/com_txt_ylq2.png")

        local list_handle = GUI:ListView_Create(_parent, "ListView_2", 410, -30, 350, 120, 2)
        GUI:setAnchorPoint(list_handle, 0.5,0)
        GUI:ListView_setClippingEnabled(list_handle,true)
        GUI:ListView_setItemsMargin(list_handle, 5)

        for i, v in ipairs(cfg.prefix) do
            handle = GUI:Image_Create(list_handle, "itemshow"..i, 0,20, "res/custom/common/object_di_1.png")
            local itemshow = GUI:ItemShow_Create(handle, "item",3,3, {index = v[1], count = v[2], look = true})
            GUI:setScale(handle, 0.9)
            GUI:Image_setGrey(handle,gifts_info[freeVipPage] == _state.flag_yes)
            GUI:ItemShow_setIconGrey(itemshow,gifts_info[freeVipPage] == _state.flag_yes)
        end

        if gifts_info[freeVipPage] == _state.flag_no then
            handle = GUI:Button_Create(_parent, "btn_buy", 308,-80, "res/01/010005.png")
            local txt_handle = GUI:Text_Create(handle, "title", 62.5,17.5, 15, _color[false], cfg.jiage.."灵符购买")
            GUI:setAnchorPoint(txt_handle, 0.5, 0.5)

            GUI:setContentSize(handle,{width = 125, height = 35})
            GUI:Button_loadTexturePressed(handle, "res/01/010006.png")
            GUI:Button_loadTextureDisabled(handle, "res/01/010006.png")
            GUI:addOnClickEvent(handle, function()
                freeVip.buyGift(freeVipPage)
            end)
        elseif gifts_info[freeVipPage] == _state.flag_yes then
            handle = GUI:Image_Create(_parent, "img_flagyes2", 334,-80, "res/custom/common/com_txt_ygm.png")
        end
    else
        if freeVipPage ~= freeVip_Lv + 1 then
            handle = GUI:Image_Create(_parent, "img_flagyes3", 234,-0, "res/custom/vip/img_txt_2.png")
        else
            local btn_handle = GUI:Button_Create(_parent, "btn_gift", 435,-175, "res/01/010005.png")
            local txt_handle = GUI:Text_Create(btn_handle, "title", 55,7, 15, _color[false],"免费激活VIP")
            GUI:setAnchorPoint(txt_handle, 0.5, 0)

            GUI:Button_loadTexturePressed(btn_handle, "res/01/010006.png")
            GUI:Button_loadTextureDisabled(btn_handle, "res/01/010006.png")
            GUI:addOnClickEvent(btn_handle, function()
                freeVip.goToGift()
            end)

            local max = #cfg.goal[1]
            local limit = 2
            local idx = 0
            local item_w,item_h = 170,108

            local num = math.ceil(max/limit)
            local list_handle = GUI:ListView_Create(_parent, "ListView_3", 372, -120, 380, 230, 1)
            GUI:setAnchorPoint(list_handle, 0.5,0)
            GUI:ListView_setClippingEnabled(list_handle,true)
            GUI:ListView_setItemsMargin(list_handle, 5)
            for i = 1, num do
                handle = GUI:Layout_Create(list_handle, "layout_item_"..i, 0,0, 350, 105)
                if handle then
                    GUI:setAnchorPoint(handle, 0.5, 0.5)
                    GUI:setTouchEnabled(handle, true)

                    for j = 1, limit do
                        idx = idx + 1
                        if idx <= max then
                            local _handle = GUI:Image_Create(handle, "item_"..j, (j - 1) * (item_w + 20) + 10, -5, "res/custom/common2/1900000602.png")
                            GUI:Image_setScale9Slice(_handle, 10, 10, 10, 10)
                            GUI:setAnchorPoint(_handle, 0,0)
                            GUI:setContentSize(_handle,{width = item_w, height = item_h})
                            GUI:setTouchEnabled(_handle, true)
                            imgUI["item_"..idx] = _handle
                        end
                    end
                end
            end
            for i, v in ipairs(cfg.goal[1]) do
                handle = imgUI["item_"..i]
                local size = GUI:getContentSize(handle)
                local img_handle = GUI:Image_Create(handle, "img_rich_bg", size.width/2, size.height/2, "res/custom/common2/1900000602.png")
                GUI:setAnchorPoint(img_handle, 0.5,0.5)
                local txt_handle = GUI:RichText_Create(handle, "rich_condition", 7, size.height - 15, "任务"..i.."：<br>"..cfg_goals[v].goInfo, 160,15)
                GUI:setAnchorPoint(txt_handle, 0,1)
                if task_info[i] == _state.flag_yes then
                    GUI:Image_Create(handle, "img_flagyes4", 115,15, "res/custom/common/com_txt_ywc.png")
                else
                    btn_handle = GUI:Button_Create(handle, "go_"..i, 95,15, "res/01/010005.png")
                    txt_handle = GUI:Text_Create(btn_handle, "title", 35,4, 15, _color[false],"前往")
                    GUI:setAnchorPoint(txt_handle, 0.5, 0)

                    GUI:Image_setScale9Slice(btn_handle, 10, 10, 10, 10)
                    GUI:setContentSize(btn_handle,{width = 70, height = 28})
                    GUI:Button_loadTexturePressed(btn_handle, "res/01/010006.png")
                    GUI:Button_loadTextureDisabled(btn_handle, "res/01/010006.png")
                    GUI:addOnClickEvent(btn_handle, function()
                        freeVip.goToTask(i)
                    end)
                end
            end
        end
    end
end

function freeVip.SyncResponse(FormParam)
    FormParam = string.gsub(FormParam, "'","")
    FormParam = SL:JsonDecode(FormParam)
    freeVip_Lv = tonumber(FormParam[1])
    task_info = FormParam[2]
    gifts_info = FormParam[3]
    freeVip.updataUI()
end

function freeVip.buyGift(index)
    SL:SubmitForm("F/mianfeihuiyuan","RequestBuyGifts",index)
end

function freeVip.goToTask(index)
    SL:ShowSystemTips("任务"..index.."跳转<font color='#00FF00'>[当前演示版本自动完成该任务]</font>")
    SL:SubmitForm("F/mianfeihuiyuan","RequestGmBox_1",index)
end

function freeVip.goToGift()
    SL:SubmitForm("F/mianfeihuiyuan","RequestUpgrade")
end

freeVip.main()