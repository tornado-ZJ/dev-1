KuangBao = {}
local GUIparent = ""
local Win_W, Win_H = 815, 575

function KuangBao.main()
    SL:SubmitForm("A/狂暴", "SyncResponse")
end

KuangBao.main()
KuangBao.SyncResponse = function(data)
    if not data then
        return
    end
    local sendList = SL:JsonDecode(data)
    data = sendList[1]
    if not GUI:GetWindow(nil, "kuangbao") then
        KuangBao.createUI()
    else
        KuangBao.updateUI()
    end
end

KuangBao.createUI = function()
    local parent = GUI:Win_Create("kuangbao", 0, 0, 0, 0, false, false, true, false)
    GUIparent = parent
    local screenW = SL:GetScreenWidth()
    local screenH = SL:GetScreenHeight()
    local layoutW = GUIShare.WinView.LayWidth
    local layoutH = GUIShare.WinView.LayHeight

    -- 全屏关闭
    local CloseLayout = GUI:Layout_Create(parent, "CloseLayout", 0, 0, screenW, screenH)
    GUI:Layout_setBackGroundColorType(CloseLayout, 1)
    GUI:Layout_setBackGroundColor(CloseLayout, "#000000")
    GUI:Layout_setBackGroundColorOpacity(CloseLayout, 150)
    GUI:setTouchEnabled(CloseLayout, true)
    GUI:addOnClickEvent(CloseLayout, function()
        GUI:Win_Close(parent)
    end)

    -- 容器
    local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", screenW / 2, screenH / 2, layoutW, layoutH)
    GUI:setAnchorPoint(FrameLayout, { x = 0.5, y = 0.5 })

    -- 背景图
    local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/public/1900000610.png")
    GUI:setTouchEnabled(FrameBG, true)

    -- 龙头
    local DressIMG = GUI:Image_Create(FrameLayout, "DressIMG", -14, 474, "res/public/1900000610_1.png")

    -- 标题
    local TitleText = GUI:Text_Create(FrameLayout, "TitleText", 32, 498, 18, "#ffffff", "狂暴之力")

    --左侧背景147 87
    local ImageView_1 = GUI:Image_Create(FrameLayout, "ImageView_1", 25.00, 39.00, "res/public/1900000664.png")
    GUI:Image_setScale9Slice(ImageView_1, 10, 10, 10, 10)
    GUI:setContentSize(ImageView_1, 181, 450)
    GUI:setIgnoreContentAdaptWithSize(ImageView_1, false)
    GUI:setTouchEnabled(ImageView_1, false)
    GUI:setTag(ImageView_1, -1)

    -- Create ListView_1
    local ListView_1 = GUI:ListView_Create(FrameLayout, "ListView_1", 29.00, 43.00, 175.00, 444.00, 1)
    GUI:ListView_setBackGroundColorType(ListView_1, 1)
    GUI:ListView_setBackGroundColor(ListView_1, "#9696ff")
    GUI:ListView_setItemsMargin(ListView_1, 1)
    GUI:ListView_setBackGroundColorOpacity(ListView_1, 0)
    GUI:setTouchEnabled(ListView_1, true)
    GUI:setTag(ListView_1, -1)

    -- Create Button_1
    --local Button_1 = GUI:Button_Create(ListView_1, "Button_1", 0.00, 414.00, "res/public/1900001023.png")
    local Button_1 = GUI:Button_Create(ListView_1, "Button_1", 0.00, 414.00, "res/public/1900000663_2.png")
    GUI:Button_loadTextureDisabled(Button_1, "res/public/1900000663_1.png")
    GUI:Button_setTitleColor(Button_1, "#ffffff")
    GUI:Button_setTitleFontSize(Button_1, 14)
    GUI:Button_setTitleText(Button_1, "Button")
    GUI:setTouchEnabled(Button_1, true)
    GUI:Button_setTitleColor(Button_1, "#b2b2b2")
    GUI:setTag(Button_1, -1)

    -- 关闭按钮
    local CloseButton = GUI:Button_Create(FrameLayout, "CloseButton", 780, 492, "res/public/1900000510.png")
    GUI:Button_loadTexturePressed(CloseButton, "res/public/1900000511.png")
    GUI:setTouchEnabled(CloseButton, true)
    GUI:addOnClickEvent(CloseButton, function()
        GUI:Win_Close(parent)
    end)
end

KuangBao.updateUI = function()

end
