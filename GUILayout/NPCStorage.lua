NpcStorage = {}

function NpcStorage.main( skipPage )
    local parent  = GUI:Attach_Parent()
    local screenW = SL:GetScreenWidth()
    local screenH = SL:GetScreenHeight()
    local pSizeWid = 539
    local pSizeHgt = 444

    -- 全屏
    local Layout = GUI:Layout_Create(parent, "Layout", 0, 0, screenW, screenH)

    -- 容器
    local touch = GUI:Layout_Create(parent, "touch", 0, 185, pSizeWid+30, pSizeHgt)
    GUI:setTouchEnabled(touch, true)

    -- 容器
    local PMainUI = GUI:Layout_Create(parent, "PMainUI", 0, 185, pSizeWid, pSizeHgt)
    GUI:setTouchEnabled(PMainUI, true)
    GUI:Win_SetDrag(parent, PMainUI)

    -- 背景图
    local FrameBG = GUI:Image_Create(PMainUI, "FrameBG", 0, 0, "res/public/bg_npc_06.png")

    -- 关闭按钮
    local CloseButton = GUI:Button_Create(PMainUI, "CloseButton", pSizeWid, pSizeHgt, "res/public/1900000510.png")
    GUI:Button_loadTexturePressed(CloseButton, "res/public/1900000511.png")
    GUI:setAnchorPoint(CloseButton, 0, 1)
    GUI:addOnClickEvent(CloseButton, function () GUI:Win_Close(parent) end)

    -- 锁
    local ImageLock = GUI:Image_Create(PMainUI, "ImageLock", 0, 0, "res/public/icon_tyzys_01.png")
    GUI:setAnchorPoint(ImageLock, 0.5, 0.5)
    GUI:setVisible(ImageLock, false)

    local PanelItems = GUI:Layout_Create(PMainUI, "PanelItems", 15, 427, 508, 384, true)
    GUI:setAnchorPoint(PanelItems, 0, 1)
    local PanelTouch = GUI:Layout_Create(PMainUI, "PanelTouch", 15, 427, 508, 384, true)
    GUI:setAnchorPoint(PanelTouch, 0, 1)

    local BtnQuick = GUI:Button_Create(PMainUI, "BtnQuick", 300, 20, "res/public/1900000652.png")
    GUI:Button_loadTextureDisabled(BtnQuick, "res/public/1900000652_1.png")
    GUI:Button_loadTexturePressed(BtnQuick, "res/public/1900000652_1.png")
    GUI:setContentSize(BtnQuick, {width = 82, height = 29})
    GUI:setAnchorPoint(BtnQuick, 0.5, 0.5)
    GUI:Button_setTitleText(BtnQuick, "快速存取")
    GUI:Button_setTitleFontSize(BtnQuick, 18)
    GUI:Button_setTitleColor(BtnQuick, "#FFFFFF")

    local BtnReset = GUI:Button_Create(PMainUI, "BtnReset", 450, 20, "res/public/1900000652.png")
    GUI:Button_loadTextureDisabled(BtnReset, "res/public/1900000652_1.png")
    GUI:Button_loadTexturePressed(BtnReset, "res/public/1900000652_1.png")
    GUI:setContentSize(BtnReset, {width = 82, height = 29})
    GUI:setAnchorPoint(BtnReset, 0.5, 0.5)
    GUI:Button_setTitleText(BtnReset, "仓库整理")
    GUI:Button_setTitleFontSize(BtnReset, 18)
    GUI:Button_setTitleColor(BtnReset, "#FFFFFF")

    local posY = pSizeHgt - 150
    local distance = 75

    -- 包裹一
    local Page1 = GUI:Button_Create(PMainUI, "Page1", pSizeWid, posY, "res/public/1900000641.png")
    GUI:Button_loadTextureDisabled(Page1, "res/public/1900000640.png")
    GUI:Button_loadTexturePressed(Page1, "res/public/1900000640.png")
    GUI:setTouchEnabled(Page1, true)
    GUI:addOnClickEvent(Page1, function()
        NpcStorage.PageTo(1)
    end)
    posY = posY - distance
    local PageText1 = GUI:Text_Create(Page1, "PageText", 13, 60, 14, "#ffffff", "一")
    GUI:setAnchorPoint(PageText1, 0.5, 0.5)

    -- 包裹二
    local Page2 = GUI:Button_Create(PMainUI, "Page2", pSizeWid, posY, "res/public/1900000641.png")
    GUI:Button_loadTextureDisabled(Page2, "res/public/1900000640.png")
    GUI:Button_loadTexturePressed(Page2, "res/public/1900000640.png")
    GUI:setTouchEnabled(Page2, true)
    GUI:addOnClickEvent(Page2, function()
        NpcStorage.PageTo(2)
    end)
    posY = posY - distance
    local PageText2 = GUI:Text_Create(Page2, "PageText", 13, 60, 14, "#ffffff", "二")
    GUI:setAnchorPoint(PageText2, 0.5, 0.5)
    -- 包裹三
    local Page3 = GUI:Button_Create(PMainUI, "Page3", pSizeWid, posY, "res/public/1900000641.png")
    GUI:Button_loadTextureDisabled(Page3, "res/public/1900000640.png")
    GUI:Button_loadTexturePressed(Page3, "res/public/1900000640.png")
    GUI:setTouchEnabled(Page3, true)
    GUI:addOnClickEvent(Page3, function()
        NpcStorage.PageTo(3)
    end)
    posY = posY - distance
    local PageText3 = GUI:Text_Create(Page3, "PageText", 13, 60, 14, "#ffffff", "三")
    GUI:setAnchorPoint(PageText3, 0.5, 0.5)

    -- 包裹四
    local Page4 = GUI:Button_Create(PMainUI, "Page4", pSizeWid, posY, "res/public/1900000641.png")
    GUI:Button_loadTextureDisabled(Page4, "res/public/1900000640.png")
    GUI:Button_loadTexturePressed(Page4, "res/public/1900000640.png")
    GUI:setTouchEnabled(Page4, true)
    GUI:addOnClickEvent(Page4, function()
        NpcStorage.PageTo(4)
    end)
    posY = posY - distance
    local PageText4 = GUI:Text_Create(Page4, "PageText", 13, 60, 14, "#ffffff", "四")
    GUI:setAnchorPoint(PageText4, 0.5, 0.5)

    -- 包裹五
    local Page5 = GUI:Button_Create(PMainUI, "Page5", pSizeWid, posY, "res/public/1900000641.png")
    GUI:Button_loadTextureDisabled(Page5, "res/public/1900000640.png")
    GUI:Button_loadTexturePressed(Page5, "res/public/1900000640.png")
    GUI:setTouchEnabled(Page5, true)
    GUI:addOnClickEvent(Page5, function()
        NpcStorage.PageTo(5)
    end)
    posY = posY - distance
    local PageText5 = GUI:Text_Create(Page5, "PageText", 13, 60, 14, "#ffffff", "五")
    GUI:setAnchorPoint(PageText5, 0.5, 0.5)
end