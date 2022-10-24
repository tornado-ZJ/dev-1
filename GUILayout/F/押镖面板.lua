Yabiao = {}

local _color = {[true] = "#787974",[false] = "#FFFFB7"}

local yabiao_count,jiebiao_count

local _cfg = cfg_biaoche

local GUIparent = nil

local handle

local wnd_w,wnd_h = 815,575                         --大背景图宽高

local richText = {
    [true]  = "<font color='#00FF00'>今日%s次数：</font><font color='#00FF00'>%s</font>",
    [false] = "<font color='#FF0000'>今日%s次数：</font><font color='#FF0000'>%s</font>",
}

local winSize = SL:GetScreenSize()              --获取屏幕宽高
local x = winSize.width / 2
local y = winSize.height / 2
local w = winSize.width
local h = winSize.height

--------------------------------------------↓↓↓ 网络消息 ↓↓↓--------------------------------------------
--开始护送
function Yabiao.RequestEscort(_type)
    SL:SubmitForm("F/押镖表单","RequestEscort",_type)
end
--------------------------------------------↓↓↓ UI创建 ↓↓↓--------------------------------------------
function Yabiao.main()
    yabiao_count,jiebiao_count = tonumber(SL.FormParam[1]),tonumber(SL.FormParam[2])

    local _parent = GUI:Win_Create("Yabiao", 0, 0, 0, 0, false, false, true, false)

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

    _parent = GUI:Image_Create(_parent, "img_bg", x, y, "res/01/010000.png")
    if _parent then
        GUI:setAnchorPoint(_parent, 0.5, 0.5)
        GUI:setContentSize(_parent,{width = wnd_w, height = wnd_h})
        GUI:setTouchEnabled(_parent, true)

        handle = GUI:Button_Create(_parent, "btn_close", wnd_w - 25,wnd_h - 20, "res/01/010008.png")
        if handle then
            GUI:setAnchorPoint(handle, 1,1)
            GUI:Button_loadTexturePressed(handle, "res/01/010009.png")
            GUI:addOnClickEvent(handle, function()
                GUI:Win_Close(GUIparent)
            end)
        end

        handle = GUI:Image_Create(_parent, "img_bg1", 62,21, "res/custom/activity/bg.png")
        GUI:Image_setScale9Slice(handle, 10, 10, 10, 10)
        GUI:setContentSize(handle,{width = 734 - 42, height = 447})

        handle = GUI:Text_Create(_parent, "txt_title", wnd_w / 2,wnd_h - 37, 20, "#D6C6AD", "鬼谷押镖")
        GUI:setAnchorPoint(handle, 0.5,1)

        local str = string.format(richText[yabiao_count > 0],"押镖", yabiao_count.."/".._cfg[1].cishu)
        handle = GUI:RichText_Create(_parent, "txt_title_1", 405,55 + 60, str, 200,17)
        GUI:setAnchorPoint(handle, 0.5,0)

        str = string.format(richText[jiebiao_count > 0],"劫镖", jiebiao_count.."/".._cfg[1].cishu2)
        handle = GUI:RichText_Create(_parent, "txt_title_2", 405,20 + 60, str, 200,17)
        GUI:setAnchorPoint(handle, 0.5,0)

        for i, v in ipairs(_cfg) do
            local layout = GUI:Image_Create(_parent, "img_item"..i, 120 + (i - 1) * 340,150, "res/custom/activity/bg_"..i..".png")

            str = "押镖消耗：免费"
            if v.cost then
                str = "押镖消耗：         * "..v.cost[1][2]
                handle = GUI:ItemShow_Create(layout, "item_cost",125,-43, {index = v.cost[1][1],  look = true})
                GUI:setScale(handle, 0.6)
            end

            handle = GUI:Text_Create(layout, "txt_cost", 120,-15, 16, "#00FF00", str)
            GUI:setAnchorPoint(handle, 0.5,1)

            local list_handle = GUI:ListView_Create(layout, "ListView_item", 10, 10, 223,70, 2)
            GUI:ListView_setClippingEnabled(list_handle,true)
            GUI:ListView_setItemsMargin(list_handle, 5)

            for j, var in ipairs(v.showreward) do
                handle = GUI:Image_Create(list_handle, "itemshow_"..j, 0,0, "res/custom/activity/item_bg.png")
                GUI:setContentSize(handle,{width = 40, height = 40})

                handle = GUI:ItemShow_Create(handle, "item",3,3, {index = var[1], count = var[2], look = true})
                GUI:setScale(handle, 0.6)
            end

            handle = GUI:Button_Create(layout, "btn_goto"..i, 50,-100, "res/01/010005.png")
            local txt_handle = GUI:Text_Create(handle, "title", 140 / 2,48 / 2, 20, _color[false], "开始护送")
            GUI:setAnchorPoint(txt_handle, 0.5, 0.5)
            GUI:Button_loadTexturePressed(handle, "res/01/010006.png")
            GUI:Button_loadTextureDisabled(handle, "res/01/010006.png")
            GUI:setContentSize(handle,{width = 140, height = 45})
            GUI:addOnClickEvent(handle, function()
                Yabiao.RequestEscort(i)
            end)
        end
    end

    handle = GUI:Image_Create(GUIparent, "img_b2", 58 + 160,18 + 31, "res/custom/painting/vip_welfare_item_frame.png")
    if handle then
        GUI:Image_setScale9Slice(handle, 10, 10, 10, 10)
        GUI:setContentSize(handle,{width = 734 - 35, height = 455})
        GUI:setLocalZOrder(handle,99)
    end

end

Yabiao.main()