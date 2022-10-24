GuildMain = {}

function GuildMain.main()
    local parent  = GUI:Attach_Parent()
    local attachW = GUIShare.WinView.Width
    local attachH = GUIShare.WinView.Height

    GuildMain._Attr = {
        attachW = attachW, attachH = attachH
    }

    local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, attachW, attachH, true)
    GUI:setTouchEnabled(FrameLayout, true)

    local BG = GUI:Image_Create(FrameLayout, "BG", attachW / 2, attachH / 2, "res/private/guild_ui/bg_guild.png")
    GUI:setAnchorPoint(BG, {x=0.5, y=0.5})

    local GuildFlag = GUI:Image_Create(FrameLayout, "GuildFlag", 606, 407, "res/private/guild_ui/guild_icon.png")
    GUI:setAnchorPoint(GuildFlag, {x=0.5, y=0.5})

    -- 行会名字
    local GuildName = GUI:Text_Create(FrameLayout, "GuildName", 243, 377, 16, "#FFF600", "")
    GUI:setAnchorPoint(GuildName, {x=0.5, y=0.5})

    -- 会长名字
    local MasterName = GUI:Text_Create(FrameLayout, "MasterName", 607, 377, 16, "#F2E7CF", "")
    GUI:setAnchorPoint(MasterName, {x=0.5, y=0.5})

    local Content_Bg = GUI:Image_Create(FrameLayout, "Content_Bg", 477, 25, "res/private/guild_ui/guild_att_bg.png")
    GUI:Image_setScale9Slice(Content_Bg, 5, 5, 5, 5)
    GUI:setContentSize(Content_Bg, {width = 255, height = 240})

    -- 公告
    local NoticePic = GUI:Image_Create(FrameLayout, "NoticePic", 607, 280, "res/private/guild_ui/title_guild.png")
    GUI:setAnchorPoint(NoticePic, {x=0.5, y=0.5})

    -- 公告内容
    local EditInput = GUI:TextInput_Create(FrameLayout, "EditInput", 483, 30, 243, 230, 16)
    GUI:Text_setTextHorizontalAlignment(EditInput, 0) 
    GUI:TextInput_setInputMode(EditInput, 0)
    GUI:setTouchEnabled(EditInput, true)
end
