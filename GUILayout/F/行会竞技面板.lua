familyGifts = {}

local _cfg = cfg_hanghuijingji         --行会竞技表单

local playersnum

local gifts_info = {}
local gifts_boss_info = {}
--------------------------------------------↓↓↓ 本地方法 ↓↓↓--------------------------------------------
local _state = {
    not_receive     = 0,        --未领取
    yes_receive     = 1,        --可领取
    has_receive     = 2,        --已领取
}

local _color = {[true] = "#787974",[false] = "#FFFFB7"}

local _rich_text_color = {[true] = "#00FF00",[false] = "#808080"}

local wnd_w,wnd_h = 540,450                         --大背景图宽高

local handle, _parent

local richText = {
    "<font color='#FFFFFF'>行会成员数量达到%d人 </font><font color='%s'>(%s)</font>",
    "<font color='#FFD700'>行会额外奖励 </font><font color='%s'>(%s)</font>",
}
--------------------------------------------↓↓↓ 网络消息 ↓↓↓--------------------------------------------
--同步信息
function familyGifts.SyncResponse(data)
    data = string.gsub(data, "'","")
    data = SL:JsonDecode(data)

    -- print("同步信息,familyGifts",type(data),type(familyGifts_data))
    playersnum = tonumber(data[1])
    gifts_info = data[2]
    gifts_boss_info = data[3]

    if not GUI:GetWindow(nil,"ActivityMain/layout_main/familyGifts") then
        familyGifts.createUI()
    else
        familyGifts.updataUI()
    end
end

function familyGifts.getGift(idx)
    SL:SubmitForm("F/行会竞技表单","RequestGetGift",idx)
end
--------------------------------------------↓↓↓ UI创建 ↓↓↓--------------------------------------------
function familyGifts.createUI()
    _parent = GUI:GetWindow(nil,"ActivityMain/layout_main")
    if not _parent then return end
    _parent = GUI:Image_Create(_parent, "familyGifts", -154,0, "res/custom/zhigou/img_bg.jpg")
    if _parent then
        GUI:setContentSize(_parent,{width = 734 - 42, height = 447})

        handle = GUI:Image_Create(_parent, "img_title_1", wnd_w / 2 + 150,370, "res/custom/zhigou/4.png")
        GUI:setAnchorPoint(handle, 0.5,0)

        handle = GUI:Image_Create(_parent, "img_title_2", wnd_w / 2 + 150,330, "res/custom/zhigou/5.png")
        GUI:setAnchorPoint(handle, 0.5,0)


        --行会竞技奖励
        local list_handle = GUI:ListView_Create(_parent, "ListView_1", 155, 0, wnd_w,293, 1)
        if list_handle then
            GUI:ListView_setClippingEnabled(list_handle,true)
            GUI:ListView_setItemsMargin(list_handle, 5)

            local str = ""
            for i, v in ipairs(_cfg) do
                local layout = GUI:Layout_Create(list_handle, "layout_item_"..i,0,0, wnd_w,80)
                -- GUI:Layout_setBackGroundColor(layout, "#FFB6C1")
                -- GUI:Layout_setBackGroundColorType(layout, 1)
                -- GUI:Layout_setBackGroundColorOpacity(layout, 100)

                local item_x,item_y = 15,5

                for j, var in ipairs(v.reward) do
                    handle = GUI:Image_Create(layout, "itemshow1_"..j, item_x,item_y, "res/custom/common/object_di_1.png")
                    GUI:ItemShow_Create(handle, "item",3,3, {index = var[1], count = var[2], look = true})
                    GUI:setScale(handle, 0.6)
                    item_x = item_x + 50
                end

                item_x = 245


                str = string.format(richText[1],v.goal, _rich_text_color[playersnum >= v.goal], playersnum.."/"..v.goal)

                handle = GUI:RichText_Create(layout, "title_1", 5,55, str, 265,16)

                local hasNum = gifts_boss_info[i]

                str = string.format(richText[2], _rich_text_color[hasNum > 0], hasNum.."/"..v.bossCount)

                handle = GUI:RichText_Create(layout, "title_2", 245,55, str, 265,16)

                for j, var in ipairs(v.bossReward) do
                    handle = GUI:Image_Create(layout, "itemshow2_"..j, item_x,item_y, "res/custom/common/object_di_1.png")
                    GUI:ItemShow_Create(handle, "item",3,3, {index = var[1], count = var[2], look = true})
                    GUI:setScale(handle, 0.6)
                    item_x = item_x + 50
                end

                handle = GUI:Button_Create(layout, "btn_click", 470, 23, "res/01/010005.png")
                if handle then

                    GUI:addOnClickEvent(handle, function() familyGifts.getGift(i) end)

                    GUI:setAnchorPoint(handle, 0.5, 0.5)

                    local txt_handle = GUI:Text_Create(handle, "tx_btn", 55,18, 17, "#FFFFB7", "领取奖励")
                    GUI:setAnchorPoint(txt_handle, 0.5, 0.5)

                    local img_handle = GUI:Image_Create(handle, "img_redPonit", 95,15, "res/custom/common/img_2.png")
                    GUI:setScale(img_handle, 0.9)
                end
            end
        end
    end
    familyGifts.updataUI()
end

--更新UI
function familyGifts.updataUI()
    local _parent = GUI:GetWindow(nil,"ActivityMain/layout_main/familyGifts")
    if not _parent then return end

    handle = GUI:GetWindow(_parent,"tx_day")
    if handle then
        GUI:TextAtlas_setString(handle, lj_day)
    end

    for i, v in ipairs(_cfg) do
        local state = gifts_info[i] or _state.not_receive

        local str = "立即领取"
        if state == _state.not_receive then
            str = "不可领取"
        elseif state == _state.has_receive then
            str = "已 领 取"
        end

        local layout = GUI:GetWindow(_parent,"ListView_1/layout_item_"..i)

        handle = GUI:GetWindow(layout,"btn_click")
        if handle then
            GUI:Button_setBright(handle,state == _state.yes_receive)
            GUI:Image_setGrey(handle,state ~= _state.yes_receive)
        end

        handle = GUI:GetWindow(layout,"btn_click/tx_btn")
        if handle then
            GUI:Text_setTextColor(handle, _color[state ~= _state.yes_receive])
            GUI:Text_setString(handle, str)
        end

        handle = GUI:GetWindow(layout,"btn_click/img_redPonit")
        if handle then
            GUI:setVisible(handle,state == _state.yes_receive)
        end

        handle = GUI:GetWindow(layout,"title_2")
        if handle then
            GUI:removeFromParent(handle)

            local hasNum = gifts_boss_info[i]

            str = string.format(richText[2], _rich_text_color[hasNum > 0], hasNum.."/"..v.bossCount)

            handle = GUI:RichText_Create(layout, "title_2", 245,55, str, 265,16)
        end
    end
end