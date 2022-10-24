LZYFurnace = {}

local cfg = cfg_fenjiee
local cfg_fenjie = temp

local GUIparent = ""
local GUIparent2 = ""

local _state = {
    not_check = 0,
    check = 1,
}

local state_circle = {
    not_circle = 0,
    circle = 1
}
local isCherk = 1

local has_equip = {} --展示的装备表

local isAuto, data, data2
local allItems = {}
function LZYFurnace.createUI()

    local FormParam = SL.FormParam[1]
    isAuto = tonumber(SL.FormParam[1])

    local status = string.gsub(SL.FormParam[2], "'", "")
    data = SL:JsonDecode(status)
    -- dump(data)

    local status2 = string.gsub(SL.FormParam[3], "'", "")
    data2 = SL:JsonDecode(status2)
    -- dump(data2)

    --SL:Dump(cfg)

    local _parent = GUI:Win_Create("LZY_ronglu", 0, 0, 0, 0, false, false, true, false)
    if _parent then
        GUIparent = _parent
        local winSize = SL:GetScreenSize() -- 获取屏幕宽高
        local x = winSize.width / 2
        local y = winSize.height / 2
        local w = winSize.width
        local h = winSize.height

        local layout = GUI:Layout_Create(_parent, "diban", x, y, w, h)
        if layout then
            GUI:setAnchorPoint(layout, 0.5, 0.5)
        end

        ----------关闭背景act-----------------
        local bg_close = GUI:Image_Create(_parent, "bg_close", 0, 0, "res/01/010010.png")
        if bg_close then
            GUI:setContentSize(bg_close, {
                width = w,
                height = h
            })
            GUI:setTouchEnabled(bg_close, true)
            GUI:addOnClickEvent(bg_close, function()
                GUI:Win_Close(_parent)
            end)
        end

        ----------界面框背景act-----------------
        local bg_kuang = GUI:Image_Create(_parent, "bg_kuang", 142, 45, "res/01/010000.png")
        if bg_kuang then
            GUI:setContentSize(bg_kuang, {
                width = 855,
                height = 545
            })
            GUI:setTouchEnabled(bg_kuang, true)
        end

        --背景
        local img_bg = GUI:Image_Create(_parent, "img_bg", 202, 66, "res/custom/fenjie/img_1.jpg")
        --GUI:setScale(img_bg, 0.9)

        -- title
        local tx_title = GUI:Text_Create(_parent, "tx_title", 540, 530, 20, "#D6C6AD", "熔     炉")

        -- 关闭按钮
        local btn_close = GUI:Button_Create(_parent, "btn_close", 900, 520, "res/01/010033.png")
        if btn_close then
            GUI:Button_loadTexturePressed(btn_close, "res/01/010034.png")
            GUI:addOnClickEvent(btn_close, function()
                GUI:Win_Close(_parent)
            end)
        end

        --right
        local lyt_right = GUI:Layout_Create(_parent, "lyt_right", 652, 65, 285, 450)
        if lyt_right then
            local title = GUI:Text_Create(lyt_right, "title", 120, 418, 18, "#FFFACD", "可分解")
            local btn_rl = GUI:Button_Create(lyt_right, "btn_rl", 90, 10, "res/01/010005.png")
            if btn_rl then
                local text_rl = GUI:Text_Create(btn_rl, "text_rl", 32, 6, 18, "#FFD700", "熔  炼")
                GUI:addOnClickEvent(btn_rl, function()
                    dump(has_equip)
                    SL:SubmitForm("C/熔炉表单", "RongEquip", serialize(has_equip))
                    GUI:setTouchEnabled(btn_rl, false)
                end)
            end
        end

        --装备栏
        local _temp = {}
        for i, value in ipairs(cfg) do
            if data[i] == _state.check then
                for j, v in ipairs(value) do
                    if data2[i][j] == _state.check then
                        local idx_num = tonumber(v.equipid)
                        _temp[tonumber(v.equipid)] = true
                        --local num = SL:GetItemNumberByIndex(idx_num)
                        -- dump(a)
                        -- if num > 0 then
                        --     table.insert(has_equip, { idx_num, num })
                        -- end
                    end
                end
            end
        end

        local bagData = SL:GetBagData()
        --dump(bagData)
        for k, v in pairs(bagData) do
            print("v.Index", type(v.Index), v.Index, tostring(_temp[v.Index]))
            if _temp[v.Index] then
                print("v.Index", v.Index)
                table.insert(has_equip, { v.Index, isCherk, k })
            end
        end
        dump(has_equip)

        local lst_right = GUI:ListView_Create(_parent, "lst_right", 652, 118, 285, 355, 1)--物品框
        GUI:removeAllChildren(lst_right)
        if lst_right then
            for i, v in ipairs(has_equip) do
                local itemdata = {}
                itemdata.index = has_equip[i][1] -- 物品模板id
                itemdata.bgVisible = true -- 是否显示背景框
                itemdata.color = 225

                local max = #has_equip-- * v[2]
                local limit = 4
                local num = math.ceil(max / limit)
                local idx = 0
                for k = 1, num do
                    local lyt_item = GUI:Layout_Create(lst_right, "lyt_item" .. k, 0, 0, 395, 65)
                    if lyt_item then
                        for a = 1, limit do
                            idx = idx + 1
                            if idx <= max then
                                local texiao = GUI:ItemShow_Create(lyt_item, "texiao" .. a, -50 + 65 * a, 0, itemdata)
                                local img_item = GUI:Image_Create(lyt_item, "img_item" .. a, -50 + 65 * a, 0, "res/custom/NTGM/img_quan.png")
                                GUI:setContentSize(img_item, { width = 60, height = 60 })
                                local btn_item = GUI:Button_Create(lyt_item, "btn_item" .. a, -50 + 65 * a, 0, "res/custom/NTGM/img_quan.png")
                                GUI:setOpacity(btn_item, 0)
                                --GUI:setTouchEnabled(btn_item, true)
                                for b = 1, idx do
                                    GUI:addOnClickEvent(btn_item, function()
                                        isCherk = has_equip[b][2] == 0 and 1 or 0
                                        has_equip[b][2] = isCherk
                                        GUI:setVisible(img_item, isCherk == 1)                        
                                    end)
                                end
                            end
                        end
                    end
                end
            end

        end

        --left_low
        local text_shang = GUI:Text_Create(_parent, "text_shang", 320, 110, 15, "#FFFF00", "熔炼说明：")
        local text_xia = GUI:Text_Create(_parent, "text_xia", 320, 92, 15, "#F5FFFA", "熔炼装备几率获得强化石！！！")

        --left_top
        --local lyt_top = GUI:ListView_Create(_parent, "lyt_top", 200, 148, 450, 365, 1)
        local lyt_top = GUI:Layout_Create(_parent, "lyt_top", 200, 148, 450, 365)
        if lyt_top then
            -- GUI:Layout_setBackGroundColor(lyt_top, "#BEBEBE")
            -- GUI:Layout_setBackGroundColorType(lyt_top, 1) -- 背景色
            -- GUI:Layout_setBackGroundColorOpacity(lyt_top, 100)
            --自动熔炉功能
            local cb_zidong = GUI:CheckBox_Create(lyt_top, "cb_zidong", 267, 10, "res/01/010028.png", "res/01/010029.png")
            GUI:CheckBox_setSelected(cb_zidong, isAuto == _state.check)
            GUI:CheckBox_addOnEvent(cb_zidong, function(_check_handle, checkState)
                checkState = checkState == 0 and _state.check or _state.not_check
                isAuto = checkState
                SL:SubmitForm("C/熔炉表单", "RequestAutoEquip", checkState)
            end)

            local text_zidong = GUI:Text_Create(lyt_top, "text_zidong", 295, 8, 18, "#F8F8FF", "开启自动熔炉功能")
            GUI:setTouchEnabled(text_zidong, true)
            GUI:addOnClickEvent(text_zidong, function()

            end)
            LZYFurnace.Select()
        end

    end
end

--主面板
function LZYFurnace.Select()

    local max = #cfg
    local limit = 3
    local num = math.ceil(max / limit)
    local idx = 0

    local lyt_leixing = GUI:GetWindow(nil, "LZY_ronglu/lyt_top")
    if lyt_leixing then
        for i = 1, num do
            local lyt_item = GUI:Layout_Create(lyt_leixing, "lyt_item" .. i, 0, 340 - (i * 40), 450, 45)
            if lyt_item then
                for j = 1, limit do
                    idx = idx + 1
                    if idx <= max then
                        -- local lyt_box = GUI:Layout_Create(lyt_item, "lyt_box" .. idx, 20 + (j - 1) * 140, 10, 130, 40)
                        local cb_leixing = GUI:CheckBox_Create(lyt_item, "cb_leixing" .. idx, 20 + (j - 1) * 140, 20, "res/01/010028.png", "res/01/010029.png")
                        for i = 1, idx do
                            GUI:CheckBox_setSelected(cb_leixing, data[i] == _state.check)
                            GUI:CheckBox_addOnEvent(cb_leixing, function(_check_handle, checkState)
                                checkState = checkState == 0 and _state.check or _state.not_check
                                data[i] = checkState
                                SL:SubmitForm("C/熔炉表单", "SetUserData", i .. "#" .. checkState)
                            end)
                        end

                        local text_leixing = GUI:Text_Create(lyt_item, "text_leixing" .. idx, 43 + (j - 1) * 140, 18, 18, "#F8F8FF", cfg[idx].title)
                        GUI:Text_enableUnderline(text_leixing)
                        GUI:setTouchEnabled(text_leixing, true)
                        for i = 1, idx do
                            GUI:addOnClickEvent(text_leixing, function()
                                LZYFurnace.Select2(i)
                            end)
                        end
                    end

                end
            end
        end

    end
end

--副面板
local imgUI = {}
function LZYFurnace.Select2(page)
    local cfg2 = cfg[page]
    local _parent = GUI:Win_Create("LZY_equip", 0, 0, 0, 0, false, false, true, false)
    GUIparent2 = _parent
    if _parent then
        --背景
        local img_equip = GUI:Image_Create(_parent, "img_equip", 0, 0, "res/custom/hecheng/img_bg_3.png")
        if img_equip then
            GUI:Win_SetDrag(_parent, img_equip)--界面拖动
        end
        --关闭按钮
        local btn_close = GUI:Button_Create(_parent, "btn_close", 335, 392, "res/public/1900000510.png")
        if btn_close then
            GUI:Button_loadTexturePressed(btn_close, "res/public/1900000511.png")
            GUI:addOnClickEvent(btn_close, function()
                GUI:Win_Close(_parent)
            end)
        end

        --内容
        local item = 40
        local length_cfg2 = #cfg2
        local lsv_beizhu = GUI:ListView_Create(_parent, "lsv_beizhu", 10, 85, 315, 345, 1)
        local lyt_beizhu = GUI:Layout_Create(lsv_beizhu, "lyt_beizhu", 0, 0, 315, (item + 1) * length_cfg2)
        if lyt_beizhu then
            for i, v in ipairs(cfg2) do
                local cb_beizhu = GUI:CheckBox_Create(lyt_beizhu, "cb_beizhu" .. i, 55, item * length_cfg2 + 8 - (i * item), "res/01/010028.png", "res/01/010029.png")--复选框
                imgUI["cb_beizhu" .. i] = cb_beizhu

                GUI:CheckBox_setSelected(cb_beizhu, data2[page][i] == _state.check)
                GUI:CheckBox_addOnEvent(cb_beizhu, function(_check_handle, checkState)
                    checkState = checkState == 0 and _state.check or _state.not_check
                    data2[page][i] = checkState
                    SL:SubmitForm("C/熔炉表单", "SetUserData2", page .. "#" .. i .. "#" .. checkState)
                end)

                local text_beizhu = GUI:Text_Create(lyt_beizhu, "text_beizhu" .. i, 80, item * length_cfg2 + 6 - (i * item), 18, "#F8F8FF", cfg2[i].beizhu)--名称
                local img_txkuang = GUI:Image_Create(lyt_beizhu, "img_txkuang" .. i, 10, item * length_cfg2 - (i * item), "res/public/1900000664.png")--头像框
                GUI:setContentSize(img_txkuang, { width = 40, height = 40 })
                local texiao = GUI:ItemShow_Create(lyt_beizhu, "texiao" .. i, 10, item * length_cfg2 - (i * item), cfg2[i].equipid)
                GUI:setScale(texiao, 0.6)


            end
        end
        --bottom
        local line = GUI:Image_Create(_parent, "line", 10, 80, "res/custom/common/img_line_2.png")
        GUI:setContentSize(line, { width = 315, height = 5 })
        local btn_all = GUI:Button_Create(_parent, "btn_all", 60, 30, "res/01/010005.png")
        if btn_all then
            GUI:setContentSize(btn_all, { width = 80, height = 30 })
            GUI:Text_Create(btn_all, "text_all", 20, 4, 18, "#FFD700", "全 选")
            GUI:addOnClickEvent(btn_all, function()
                LZYFurnace.Allcheck(page)
            end)
        end
        local btn_noall = GUI:Button_Create(_parent, "btn_noall", 200, 30, "res/01/010005.png")
        if btn_noall then
            GUI:setContentSize(btn_noall, { width = 80, height = 30 })
            GUI:Text_Create(btn_noall, "text_all", 13, 4, 18, "#FFD700", "全不选")
            GUI:addOnClickEvent(btn_noall, function()
                LZYFurnace.Allnocheck(page)
            end)
        end

    end
end

function LZYFurnace.Allcheck(num)
    local zt_allcheck = GUI:GetWindow(GUIparent2, "lsv_beizhu/lyt_beizhu")
    -- if zt_allcheck then
    -- end
    for i, v in ipairs(cfg[num]) do
        local handle = GUI:GetWindow(zt_allcheck, "cb_beizhu" .. i)
        if handle then
            GUI:CheckBox_setSelected(handle, true)
        end
        SL:SubmitForm("C/熔炉表单", "SetUserData2", num .. "#" .. i .. "#" .. _state.check)
    end
end

function LZYFurnace.Allnocheck(num)
    local zt_allcheck = GUI:GetWindow(GUIparent2, "lsv_beizhu/lyt_beizhu")
    --GUI:CheckBox_setSelected(zt_allcheck, false)
    for i, v in ipairs(cfg[num]) do
        local handle = GUI:GetWindow(zt_allcheck, "cb_beizhu" .. i)
        if handle then
            GUI:CheckBox_setSelected(handle, false)
        end
        SL:SubmitForm("C/熔炉表单", "SetUserData2", num .. "#" .. i .. "#" .. _state.not_check)
    end
end
LZYFurnace.createUI()