GuildFrame = {}

function GuildFrame.main( skipPage )
    local parent  = GUI:Attach_Parent()
    local screenW = SL:GetScreenWidth()
    local screenH = SL:GetScreenHeight()
    local layoutW = GUIShare.WinView.LayWidth
    local layoutH = GUIShare.WinView.LayHeight
    local attachW = GUIShare.WinView.Width
    local attachH = GUIShare.WinView.Height

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
    local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", screenW/2, screenH/2, layoutW, layoutH)
    GUI:setAnchorPoint(FrameLayout, {x=0.5, y=0.5})
    GUI:setTouchEnabled(FrameLayout, true)

    -- 背景图
    local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/public/1900000610.png")

    -- 龙头
    local DressIMG = GUI:Image_Create(FrameLayout, "DressIMG", -14, 474, "res/public/1900000610_1.png")

    -- 标题
    local TitleText = GUI:Text_Create(FrameLayout, "TitleText", 32, 498, 18, "#ffffff", "")

    -- 内容挂接点
    local AttachLayout = GUI:Layout_Create(FrameLayout, "AttachLayout", GUIShare.WinView.HookX, GUIShare.WinView.HookY, attachW, attachH)

    -- 关闭按钮
    local CloseButton = GUI:Button_Create(FrameLayout, "CloseButton", 780, 492, "res/public/1900000510.png")
    GUI:Button_loadTexturePressed(CloseButton, "res/public/1900000511.png")
    GUI:setTouchEnabled(CloseButton, true)
    GUI:addOnClickEvent(CloseButton, function()
        GUI:Win_Close(parent)
    end)

    local posY = 380
    local distance = 75

    -- 行会
    local Page1 = GUI:Button_Create(FrameLayout, "Page1", 780, posY, "res/public/1900000641.png")
    GUI:Button_loadTextureDisabled(Page1, "res/public/1900000640.png")
    GUI:Button_loadTexturePressed(Page1, "res/public/1900000640.png")
    GUI:setTouchEnabled(Page1, true)
    GUI:addOnClickEvent(Page1, function()
        GuildFrame.PageTo(1)
    end)
    posY = posY - distance
    local PageText1 = GUI:Text_Create(Page1, "PageText", 13, 60, 18, "#ffffff", "行\n会")
    GUI:setAnchorPoint(PageText1, {x=0.5, y=0.5})

    -- 成员
    local Page2 = GUI:Button_Create(FrameLayout, "Page2", 780, posY, "res/public/1900000641.png")
    GUI:Button_loadTextureDisabled(Page2, "res/public/1900000640.png")
    GUI:Button_loadTexturePressed(Page2, "res/public/1900000640.png")
    GUI:setTouchEnabled(Page2, true)
    GUI:addOnClickEvent(Page2, function()
        GuildFrame.PageTo(2)
    end)
    posY = posY - distance
    local PageText2 = GUI:Text_Create(Page2, "PageText", 13, 60, 18, "#ffffff", "成\n员")
    GUI:setAnchorPoint(PageText2, {x=0.5, y=0.5})

    -- 列表
    local Page3 = GUI:Button_Create(FrameLayout, "Page3", 780, posY, "res/public/1900000641.png")
    GUI:Button_loadTextureDisabled(Page3, "res/public/1900000640.png")
    GUI:Button_loadTexturePressed(Page3, "res/public/1900000640.png")
    GUI:setTouchEnabled(Page3, true)
    GUI:addOnClickEvent(Page3, function()
        GuildFrame.PageTo(3)
    end)
    posY = posY - distance
    local PageText3 = GUI:Text_Create(Page3, "PageText", 13, 60, 18, "#ffffff", "列\n表")
    GUI:setAnchorPoint(PageText3, {x=0.5, y=0.5})

    if skipPage then
        return GuildFrame.PageTo(skipPage)
    end

    local isJoinGuild = SL:GetGuildData().isJoinGuild
    if isJoinGuild then
        GuildFrame.PageTo(1)
    else
        GUI:setVisible(Page1, false)
        GUI:setVisible(Page2, false)
        GUI:setVisible(Page3, false)
        GuildFrame.PageTo(3)
    end
end

function GuildFrame.PageTo(index)
    GuildFrame.index = index
end