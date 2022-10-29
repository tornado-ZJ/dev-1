ShaJuan = {}
local GUIparent = ""
local Win_W, Win_H = 815, 575
local cur_chenghao = 0
local lastPage = 1



function ShaJuan.main()
    SL:SubmitForm("A/沙捐", "SyncResponse")
end

ShaJuan.main()
ShaJuan.SyncResponse = function(data)
    if not data then
        return
    end
    local sendList = SL:JsonDecode(data)
    --当前称号 0 未开启 1 狂暴之王 2 狂暴之尊 3 狂暴之神
    cur_chenghao = sendList[1]
    if not GUI:GetWindow(nil, "shachengjuanxian") then
        ShaJuan.createUI()
    else
        ShaJuan.updateUI()
    end
end

ShaJuan.createUI = function()
    local parent = GUI:Win_Create("shachengjuanxian", 0, 0, 0, 0, false, false, true, false)
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
    GUI:setContentSize(ImageView_1, 112, 450)
    GUI:setIgnoreContentAdaptWithSize(ImageView_1, false)
    GUI:setTouchEnabled(ImageView_1, false)
    GUI:setTag(ImageView_1, -1)

    -- Create ListView_1
    local ListView_1 = GUI:ListView_Create(FrameLayout, "ListView_1", 29.00, 43.00, 105.00, 440.00, 1)
    GUI:ListView_setBackGroundColorType(ListView_1, 1)
    GUI:ListView_setBackGroundColor(ListView_1, "#ffffff")
    GUI:ListView_setItemsMargin(ListView_1, 1)
    GUI:ListView_setBackGroundColorOpacity(ListView_1, 0)
    GUI:setTouchEnabled(ListView_1, true)
    GUI:setTag(ListView_1, -1)

    -- Create Button_1
    for i = 1, #cfg_kuangbao do
        local Button = GUI:Button_Create(ListView_1, "Button_" .. i, 0.00, 414.00, "res/public/1900000661.png")
        GUI:Button_loadTextureDisabled(Button, "res/public/1900000660.png")
        GUI:Button_setTitleColor(Button, color[1])
        GUI:Button_setTitleFontSize(Button, 14)
        --local text = GUI:Text_Create(Button, "Text_title"..i, 0,0,16, "#ffffff", cfg_kuangbao[i].name)
        --GUI:setAnchorPoint(text,-0.75,-0.5)
        GUI:Button_setTitleText(Button, cfg_kuangbao[i].name)
        GUI:setTouchEnabled(Button, true)
        GUI:setTag(Button, -1)
        GUI:addOnClickEvent(Button, function()
            ShaJuan.page(i)
        end)
    end



    -- 关闭按钮
    local CloseButton = GUI:Button_Create(FrameLayout, "CloseButton", 780, 492, "res/public/1900000510.png")
    GUI:Button_loadTexturePressed(CloseButton, "res/public/1900000511.png")
    GUI:setTouchEnabled(CloseButton, true)
    GUI:addOnClickEvent(CloseButton, function()
        GUI:Win_Close(parent)
    end)
    ShaJuan.updateUI()
end

ShaJuan.updateUI = function()
    ShaJuan.page(1)
end

ShaJuan.page = function(index)
    local parent = GUIparent
    local ListView_1 = GUI:GetWindow(parent, "FrameLayout/ListView_1")
    local last_Button = GUI:GetWindow(ListView_1, "Button_" .. lastPage)
    GUI:Button_setBrightEx(last_Button, true)
    GUI:Button_setTitleColor(last_Button, color[1])

    local cur_Button = GUI:GetWindow(ListView_1, "Button_" .. index)
    GUI:Button_setBrightEx(cur_Button, false)
    GUI:Button_setTitleColor(cur_Button, color[2])
    lastPage = index
end