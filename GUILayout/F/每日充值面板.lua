DailyRecharge = {}

local DailyRecharge_data

local _cfg_lj   = cfg_leichong_tsleic       --累计领取奖励表

local _cfg_mr   = cfg_leichong_mr           --每日充值奖励表

local lj_day = 0
local lj_max_day = 0
local day_bill = 0
local lj_data = {}
local mr_data = {}
--------------------------------------------↓↓↓ 本地方法 ↓↓↓--------------------------------------------
local _state = {
    no_receive      = 0,        --不可领取
    yes_receive     = 1,        --可以领取
    has_receive     = 2,        --已领取
}

local _color = {[true] = "#787974",[false] = "#FFFFB7"}

local function string2num(tab)
    for key, value in pairs(tab) do
        if type(key) == "string" then
            local key_num = tonumber(key)
            if key_num then
                tab[key_num] = value
                tab[key] = nil
            end
        end
    end
    return tab
end
--------------------------------------------↓↓↓ 网络消息 ↓↓↓--------------------------------------------
--同步信息
function DailyRecharge.SyncResponse(data)
    data = string.gsub(data, "'","")
    DailyRecharge_data = SL:JsonDecode(data)

    -- print("同步信息,DailyRecharge",type(data),type(DailyRecharge_data))
    lj_day = DailyRecharge_data[1]
    day_bill = DailyRecharge_data[2]
    lj_max_day = DailyRecharge_data[3]
    lj_data = string2num(DailyRecharge_data[4].LJ_tab)
    mr_data = string2num(DailyRecharge_data[4].MR_tab)

    if not GUI:GetWindow(nil,"ActivityMain/layout_main/dailyRecharge") then
        DailyRecharge.createUI()
    else
        DailyRecharge.updateUI()
    end
end

function DailyRecharge.getLjGift(idx)
    SL:SubmitForm("F/每日充值表单","RequestGetLJGift",idx)
end

function DailyRecharge.getMrGift(idx)
    local state = mr_data[_cfg_mr[idx].money]
    if state == _state.no_receive then
        local _parent = GUI:GetWindow(nil,"ActivityMain")
        if _parent then
            GUI:Win_Close(_parent)
        end
        SL:OpenStoreUI(5)
    elseif state == _state.yes_receive then
        SL:SubmitForm("F/每日充值表单","RequestGetMRGift",idx)
    end
end
--------------------------------------------↓↓↓ UI创建 ↓↓↓--------------------------------------------
function DailyRecharge.createUI()
    local _parent = GUI:GetWindow(nil,"ActivityMain/layout_main")
    if not _parent then return end
    _parent = GUI:Image_Create(_parent, "dailyRecharge", -154,0, "res/custom/zhigou/img_bg.jpg")
    if _parent then
        GUI:setContentSize(_parent,{width = 734 - 42, height = 447})

        local handle = GUI:Image_Create(_parent, "img_1", 155, 345 + 13, "res/custom/zhigou/img_title.png")

        --进度条
        local item_x,item_y = 265,320
        local pro = 0

        handle = GUI:Image_Create(_parent, "img_daybg", item_x - 65,item_y - 15, "res/custom/zhigou/img_num_bg.png")

        handle = GUI:TextAtlas_Create(_parent, "tx_day", item_x - 35,item_y + 2, lj_day, "res/custom/zhigou/img_num.png", 12, 16, 0)
        GUI:setAnchorPoint(handle, 0.5,0)

        handle = GUI:Image_Create(_parent, "img_loadingBar_bg", item_x,item_y, "res/custom/zhigou/img_jindutiao.png_bg.png")

        handle = GUI:LoadingBar_Create(_parent, "loadingBar",item_x + 9,item_y + 4, "res/custom/zhigou/img_jindutiao.png", 0)
        GUI:LoadingBar_setPercent(handle, pro)

        --累计奖励
        item_x,item_y = 20,20
        local list_handle = GUI:ListView_Create(_parent, "ListView_LJ", 185, 345, 480 + 25,100, 2)
        if list_handle then
            GUI:ListView_setClippingEnabled(list_handle,true)
            GUI:ListView_setItemsMargin(list_handle, 5)

            local jump = 0
            for i, v in ipairs(_cfg_lj) do
                local layout = GUI:Layout_Create(list_handle, "layout_item_"..i,0,0, 85,100)
                if layout then
                    local state = lj_data[v.tianshu]

                    if _state.has_receive == state and jump == i - 1 then
                        jump = i
                    end

                    GUI:ListView_setClippingEnabled(layout,true)

                    handle = GUI:Image_Create(layout, "img_title", item_x - 20,item_y + 52, "res/custom/zhigou/11.png")

                    handle = GUI:Text_Create(layout, "tx_title", item_x + 23,item_y + 53, 16, "#E1BD70", "累计"..v.tianshu.."天")
                    GUI:setAnchorPoint(handle, 0.5,0)

                    handle = GUI:Image_Create(layout, "img_itembg", item_x,item_y, "res/custom/common/object_di_1.png")
                    GUI:setScale(handle, 0.7)

                    handle = GUI:ItemShow_Create(layout, "itemshow",item_x + 2,item_y + 2, {index = v.reward[1][1], count = v.reward[1][2], look = true})
                    GUI:setScale(handle, 0.7)

                    handle = GUI:Image_Create(layout, "img_redPonit", item_x + 35,item_y + 35, "res/custom/common/img_12.png")
                    GUI:setVisible(handle,state == _state.yes_receive)

                    handle = GUI:Image_Create(layout, "img_isget", item_x - 17,item_y - 20, "res/custom/common/com_txt_ylq.png")
                    GUI:setVisible(handle,state == _state.has_receive)

                    handle = GUI:Layout_Create(layout, "layout_click",0,0, 85,100)
                    GUI:setTouchEnabled(handle,state == _state.yes_receive)
                    GUI:addOnClickEvent(handle, function() DailyRecharge.getLjGift(i) end)
                end
            end
            GUI:ListView_jumpToItem(list_handle, jump)
        end

        --今日充值金额
        item_x,item_y = 150,255
        handle = GUI:Image_Create(_parent, "img_dayBillbg", item_x,item_y, "res/custom/common2/41.png")
        GUI:setContentSize(handle,{width = 200, height = 40})

        local str = "<font color='#FFFFB7'>今日累充：</font><font color='#4AE74A'>"..day_bill.."</font><font color='#FFFFB7'> 元</font>"
        handle = GUI:RichText_Create(_parent, "img_dayBill", item_x + 10,item_y + 10, str, 265)

        --每日奖励
        item_x,item_y = 20,20
        list_handle = GUI:ListView_Create(_parent, "ListView_Mr", 150, 0, 540,270, 2)
        if list_handle then
            GUI:ListView_setClippingEnabled(list_handle,true)
            GUI:ListView_setItemsMargin(list_handle, 0)

            local jump = 0
            for i, v in ipairs(_cfg_mr) do
                local state = mr_data[v.money]

                local layout = GUI:Layout_Create(list_handle, "layout_item_"..i,0,0, 200,270)
                if layout then
                    GUI:ListView_setClippingEnabled(layout,true)

                    handle = GUI:Image_Create(layout, "img_title", - 10,30, "res/custom/zhigou/13.png")

                    str = v.money < 1 and "免费礼包" or "今日充值"..v.money.."元"
                    local color = v.money < 1 and "#FFFFFF" or "#FFD700"
                    handle = GUI:Text_Create(layout, "tx_title", 100,190, 16, color, str)
                    GUI:setAnchorPoint(handle, 0.5,0)

                    item_x,item_y = 45,130
                    for j, var in ipairs(v.reward) do
                        if j > 4 then break end

                        handle = GUI:Image_Create(layout, "img_itembg"..j, item_x,item_y, "res/custom/common/object_di_1.png")
                        GUI:setScale(handle, 0.7)

                        handle = GUI:ItemShow_Create(layout, "itemshow"..j,item_x + 2,item_y + 2, {index = var[1], count = var[2], look = true})
                        GUI:setScale(handle, 0.7)

                        item_x = item_x + 60
                        if j % 2 == 0 then
                            item_x = 45
                            item_y = item_y - 60
                        end
                    end
                    handle = GUI:Button_Create(layout, "btn_click", 43,5, "res/01/010005.png")
                    if handle then
                        local txt_handle = GUI:Text_Create(handle, "tx_btn", 55,5, 18, "#FFFFB7", "立即领取")
                        GUI:setAnchorPoint(txt_handle, 0.5, 0)

                        local img_handle = GUI:Image_Create(handle, "img_redPonit", 95,15, "res/custom/common/img_2.png")
                        GUI:setScale(img_handle, 0.9)
                        GUI:setVisible(img_handle,state == _state.yes_receive)

                        if _state.has_receive == state and jump == i - 1 then
                            jump = i
                        end

                        GUI:addOnClickEvent(handle, function() DailyRecharge.getMrGift(i) end)
                    end
                end
            end
            GUI:ListView_jumpToItem(list_handle, jump)
        end
    end
    DailyRecharge.updateUI()
end

--更新UI
function DailyRecharge.updateUI()
    local _parent = GUI:GetWindow(nil,"ActivityMain/layout_main/dailyRecharge")
    if not _parent then return end

    local pro = lj_day / lj_max_day * 100
    if pro > 100 then
        pro = 100
    elseif pro < 0 then
        pro = 0
    end
    local handle = GUI:GetWindow(_parent,"loadingBar")
    if handle then
        GUI:LoadingBar_setPercent(handle, pro)
    end

    handle = GUI:GetWindow(_parent,"tx_day")
    if handle then
        GUI:TextAtlas_setString(handle, lj_day)
    end

    for i, v in ipairs(_cfg_lj) do
        local state = lj_data[v.tianshu]

        handle = GUI:GetWindow(_parent,"ListView_LJ/layout_item_"..i.."/img_redPonit")
        if handle then
            GUI:setVisible(handle,state == _state.yes_receive)
        end

        handle = GUI:GetWindow(_parent,"ListView_LJ/layout_item_"..i.."/img_isget")
        if handle then
            GUI:setVisible(handle,state == _state.has_receive)
        end

        handle = GUI:GetWindow(_parent,"ListView_LJ/layout_item_"..i.."/layout_click")
        if handle then
            GUI:setTouchEnabled(handle,state == _state.yes_receive)
        end
    end

    for i, v in ipairs(_cfg_mr) do
        local state = mr_data[v.money]

        local str = "立即领取"
        if _state.no_receive == state then
            str = "前往充值"
        elseif _state.has_receive == state then
            str = "已领取"
        end

        handle = GUI:GetWindow(_parent,"ListView_Mr/layout_item_"..i.."/btn_click")
        if handle then
            GUI:Button_setBright(handle,state ~= _state.has_receive)
            GUI:Image_setGrey(handle,state == _state.has_receive)
        end

        handle = GUI:GetWindow(_parent,"ListView_Mr/layout_item_"..i.."/btn_click/tx_btn")
        if handle then
            GUI:Text_setTextColor(handle, _color[state == _state.has_receive])
            GUI:Text_setString(handle, str)
        end

        handle = GUI:GetWindow(_parent,"ListView_Mr/layout_item_"..i.."/btn_click/img_redPonit")
        if handle then
            GUI:setVisible(handle,state == _state.yes_receive)
        end
    end
end