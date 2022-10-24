Jiaobiao = {}

local _cfg = cfg_biaoche

local _color = {[true] = "#787974",[false] = "#FFFFB7"}

local _type = tonumber(SL.FormParam[1]) or 0

local GUIparent = nil

local handle

local wnd_w,wnd_h = 370,300                         --大背景图宽高

local richText = {
    [true]  = "<font color='#FF0000'>今日%s次数：</font><font color='#FF0000'>%s</font>",
    [false] = "<font color='#FF0000'>今日%s次数：</font><font color='#FF0000'>%s</font>",
}

local winSize = SL:GetScreenSize()              --获取屏幕宽高
local x = winSize.width / 2
local y = winSize.height / 2
local w = winSize.width
local h = winSize.height

--------------------------------------------↓↓↓ 网络消息 ↓↓↓--------------------------------------------
--交镖
function Jiaobiao.RequestFinish()
    SL:SubmitForm("F/押镖表单","RequestFinish")
    GUI:Win_Close(GUIparent)
end
--传送
function Jiaobiao.RequestEnter()
    SL:SubmitForm("F/押镖表单","RequestEnter")
    GUI:Win_Close(GUIparent)
end
--------------------------------------------↓↓↓ UI创建 ↓↓↓--------------------------------------------
function Jiaobiao.main()
    cartcfg = SL.FormParam[1]

    local _parent = GUI:Win_Create("Jiaobiao", 0, 0, 0, 0, false, false, true, false)

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

    _parent = GUI:Image_Create(_parent, "img_bg", x, y, "res/custom/huishou/img_1.jpg")
    if _parent then
        GUI:setAnchorPoint(_parent, 0.5, 0.5)
        GUI:setContentSize(_parent,{width = wnd_w, height = wnd_h})
        GUI:setTouchEnabled(_parent, true)

        handle = GUI:Button_Create(_parent, "btn_close", wnd_w,wnd_h, "res/public/1900000510.png")
        if handle then
            GUI:setAnchorPoint(handle, 0,1)
            GUI:Button_loadTexturePressed(handle, "res/public/1900000511.png")
            GUI:addOnClickEvent(handle, function()
                GUI:Win_Close(GUIparent)
            end)
        end

        handle = GUI:Image_Create(_parent, "img_bg2", wnd_w / 2,wnd_h - 35, "res/custom/common/img_1.png")
        GUI:setAnchorPoint(handle   , 0.5, 0.5)
        handle = GUI:Text_Create(handle, "txt_title", 260 / 2,12 / 2, 19, "#FFFFFF", "钱庄老板")
        GUI:setAnchorPoint(handle, 0.5,0.5)

        local list_handle = GUI:ListView_Create(_parent, "ListView_item", 16, wnd_h / 3 - 15, wnd_w - 30,70, 2)
        GUI:ListView_setClippingEnabled(list_handle,true)
        GUI:ListView_setItemsMargin(list_handle, 9)

        handle = GUI:Button_Create(_parent, "btn_click_1", wnd_w / 2, 50, "res/01/010005.png")
        if handle then
            GUI:setVisible(handle,false)
            GUI:addOnClickEvent(handle, function() Jiaobiao.RequestFinish() end)
            GUI:setAnchorPoint(handle, 0.5, 0.5)
            local txt_handle = GUI:Text_Create(handle, "tx_btn", 55,18, 17, "#FFFFB7", "完成押镖")
            GUI:setAnchorPoint(txt_handle, 0.5, 0.5)
            local img_handle = GUI:Image_Create(handle, "img_redPonit", 95,15, "res/custom/common/img_2.png")
            GUI:setScale(img_handle, 0.9)
        end

        handle = GUI:Button_Create(_parent, "btn_click_2", wnd_w / 2, 50, "res/01/010005.png")
        if handle then
            GUI:setVisible(handle,false)
            GUI:addOnClickEvent(handle, function() Jiaobiao.RequestEnter() end)
            GUI:setAnchorPoint(handle, 0.5, 0.5)
            local txt_handle = GUI:Text_Create(handle, "tx_btn", 55,18, 17, "#FFFFB7", "继续押镖")
            GUI:setAnchorPoint(txt_handle, 0.5, 0.5)
        end
    end

    Jiaobiao.updataUI()
end

function Jiaobiao.updataUI(param)
    param = tonumber(param)

    _type = param or _type

    local _parent = GUI:GetWindow(GUIparent,"img_bg")
    if not _parent then return end

    local bool = _cfg[_type] and true or false

    local desc = bool and _cfg[1].Text or _cfg[2].Text

    handle = GUI:GetWindow(_parent, "txt_desc")
    if handle then
        GUI:removeFromParent(handle)
    end

    handle = GUI:RichText_Create(_parent, "txt_desc", wnd_w / 2,wnd_h - 100, desc, wnd_w,17)
    GUI:setAnchorPoint(handle, 0.5,0.5  )

    local list_handle = GUI:GetWindow(_parent, "ListView_item")
    GUI:removeAllChildren(list_handle)

    local gifts = bool and _cfg[_type].showreward or _cfg[1].showreward
    for i,item in ipairs(gifts) do
        handle = GUI:Image_Create(list_handle, "itemshow_"..i, 0,0, "res/custom/activity/item_bg.png")
        GUI:setContentSize(handle,{width = 60, height = 60})

        handle = GUI:ItemShow_Create(handle, "item",3,3, {index = item[1], count = item[2], look = true})
        GUI:setScale(handle, 0.9)
    end

    handle = GUI:GetWindow(_parent, "btn_click_1")
    GUI:setVisible(handle,bool)

    handle = GUI:GetWindow(_parent, "btn_click_2")
    GUI:setVisible(handle,not bool)
end

Jiaobiao.main()