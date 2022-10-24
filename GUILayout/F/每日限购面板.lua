DailyStore = {}

local temp   = cfg_mystery_store           --每日限购表
local _cfg_store = {}                           --每日限购表
for i, v in ipairs(temp) do
    _cfg_store[v.group] = _cfg_store[v.group] or {}
    _cfg_store[v.group][v.index] = {
        idx = i,sellId = v.sellId,itemId = v.itemId,group = v.group,index = v.index,price = v.price,
    }
end

local _group
local _data = {}
--------------------------------------------↓↓↓ 本地方法 ↓↓↓--------------------------------------------
local _state = {
    not_buy     = 0,        --未购买
    has_buy     = 1,        --已购买
}

local _color = {[true] = "#787974",[false] = "#FFFFB7"}

local wnd_w,wnd_h = 540,450                         --大背景图宽高
--------------------------------------------↓↓↓ 网络消息 ↓↓↓--------------------------------------------
--同步信息
function DailyStore.SyncResponse(group,data)
    group = tonumber(group)
    if not _cfg_store[group] then return end
    _group = group

    data = string.gsub(data, "'","")
    _data = SL:JsonDecode(data)

    if not GUI:GetWindow(nil,"ActivityMain/layout_main/dailyStore") then
        DailyStore.createUI()
    else
        DailyStore.updateUI()
    end
end

function DailyStore.buyGift(idx)
    SL:SubmitForm("F/每日限购表单","RequestBuyGift",idx)
end
--------------------------------------------↓↓↓ UI创建 ↓↓↓--------------------------------------------
function DailyStore.createUI()

    local cfg = _cfg_store[_group]

    local _parent = GUI:GetWindow(nil,"ActivityMain/layout_main")
    if not _parent then return end
    _parent = GUI:Node_Create(_parent, "dailyStore", 0,0)
    if _parent then

        local handle = GUI:Image_Create(_parent, "img_title_1", wnd_w / 2,370, "res/custom/zhigou/4.png")
        GUI:setAnchorPoint(handle, 0.5,0)

        handle = GUI:Image_Create(_parent, "img_title_2", wnd_w / 2,330, "res/custom/zhigou/5.png")
        GUI:setAnchorPoint(handle, 0.5,0)

        --每日奖励
        local item_x,item_y = 265,320
        local list_handle = GUI:ListView_Create(_parent, "ListView_1", 0, 0, 540,350, 2)
        if list_handle then
            GUI:ListView_setClippingEnabled(list_handle,true)
            GUI:ListView_setItemsMargin(list_handle, 0)

            for i, v in ipairs(cfg) do
                local state = _data[i]

                local layout = GUI:Layout_Create(list_handle, "layout_item_"..i,0,0, 230,350)
                if layout then
                    GUI:ListView_setClippingEnabled(layout,true)

                    handle = GUI:Image_Create(layout, "img_title", - 10,60, "res/custom/zhigou/2.png")
                    GUI:setContentSize(handle,{width = 237, height = 268})

                    item_x,item_y = 77,175
                    local scale = 1
                    for j, var in ipairs(v.itemId) do
                        if j > 4 then break end

                        if j == 2 then
                            item_x = 45
                            item_y = item_y - 70
                        end

                        if j ~= 1 then
                            scale = 0.6
                        end

                        handle = GUI:Image_Create(layout, "img_itembg"..j, item_x,item_y, "res/custom/common/object_di_1.png")
                        GUI:setScale(handle, scale)

                        handle = GUI:ItemShow_Create(layout, "itemshow"..j,item_x + 2,item_y + 2, {index = var[1], count = var[2], look = true})
                        GUI:setScale(handle, scale)

                        item_x = item_x + 43
                    end

                    handle = GUI:Button_Create(layout, "btn_click", 53,30, "res/01/010005.png")
                    if handle then
                        local itemName = SL:GetItemNameByIndex(v.price[1][1])
                        local txt_handle = GUI:Text_Create(handle, "tx_btn", 55,19, 16, "#FFFFB7", v.price[1][2]..itemName)
                        GUI:setAnchorPoint(txt_handle, 0.5, 0.5)

                        local img_handle = GUI:Image_Create(handle, "img_redPonit", 95,15, "res/custom/common/img_2.png")
                        GUI:setScale(img_handle, 0.9)
                        GUI:setVisible(img_handle,state == _state.yes_receive)

                        GUI:addOnClickEvent(handle, function() DailyStore.buyGift(i) end)
                    end
                end
            end
        end
    end
    DailyStore.updateUI()
end

--更新UI
function DailyStore.updateUI()
    local _parent = GUI:GetWindow(nil,"ActivityMain/layout_main/dailyStore")
    if not _parent then return end

    local cfg = _cfg_store[_group]

    local state,str = _state.not_buy,""

    for i, v in ipairs(cfg) do
        state = _data[i]
        if _state.has_buy == state then
            str = "礼包已购买"
        else
            local itemName = SL:GetItemNameByIndex(v.price[1][1])
            str = v.price[1][2]..itemName
        end

        local handle = GUI:GetWindow(_parent,"ListView_1/layout_item_"..i.."/btn_click")
        if handle then
            GUI:Button_setBright(handle,state ~= _state.has_buy)
            GUI:Image_setGrey(handle,state == _state.has_buy)
        end

        handle = GUI:GetWindow(_parent,"ListView_1/layout_item_"..i.."/btn_click/tx_btn")
        if handle then
            GUI:Text_setTextColor(handle, _color[state == _state.has_buy])
            GUI:Text_setString(handle, str)
        end
    end
end