SkillSetting = {}

function SkillSetting.main()
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
    GUI:addOnClickEvent(CloseLayout, function() GUI:Win_Close(parent) end)

    -- 容器
    local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", screenW/2, screenH/2, layoutW, layoutH)
    GUI:setAnchorPoint(FrameLayout, {x=0.5, y=0.5})

    -- 背景图
    local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/public/1900000610.png")
    GUI:setTouchEnabled(FrameBG, true)

    -- 龙头
    local DressIMG = GUI:Image_Create(FrameLayout, "DressIMG", -14, 474, "res/public/1900000610_1.png")

    -- 标题
    local TitleText = GUI:Text_Create(FrameLayout, "TitleText", 32, 498, 18, "#ffffff", "技能配置")

    -- 关闭按钮
    local CloseButton = GUI:Button_Create(FrameLayout, "CloseButton", 780, 492, "res/public/1900000510.png")
    GUI:Button_loadTexturePressed(CloseButton, "res/public/1900000511.png")
    GUI:setTouchEnabled(CloseButton, true)
    GUI:addOnClickEvent(CloseButton, function() GUI:Win_Close(parent) end)

    -- 内容 -------------
    local SetUI = GUI:Layout_Create(FrameLayout, "SetUI", GUIShare.WinView.HookX, GUIShare.WinView.HookY, attachW, attachH)
    GUI:setTouchEnabled(SetUI, true)

    GUI:Image_Create(SetUI, "pBg", 0, 0, "res/private/skill/bg_jnsz_01.jpg")

    local Image_title = GUI:Image_Create(SetUI, "Image_title", 160, 430, "res/private/skill/word_jnsz_01.png")
    GUI:setAnchorPoint(Image_title, {x=0.5, y=0.5})

    local line = GUI:Image_Create(SetUI, "line", 311, 0, "res/private/skill/word_jnsz_01.png")
    GUI:setContentSize(line, {width = 2, height = attachH})

    local Text_1 = GUI:Text_Create(SetUI, "Text_1", 518, 418, 16, "#FFFFFF", "左侧选择，右侧放入，即可设置")
    GUI:setAnchorPoint(Text_1, {x=0.5, y=0.5})

    local ScrollView_skills = GUI:ScrollView_Create(SetUI, "ScrollView_skills", 10, 5, 285, 410, 1)
    local ItemSkill = SkillSetting.createItemSKill(SetUI)
    GUI:setVisible(ItemSkill, false)

    -- 还原普攻
    local btnRestore = GUI:Button_Create(SetUI, "btnRestore", 420, 35, "res/public/1900000680.png")
    GUI:Button_loadTexturePressed(btnRestore, "res/public/1900000680_1.png")
    GUI:setAnchorPoint(btnRestore, {x=0.5, y=0.5})
    GUI:Button_setTitleFontSize(btnRestore, 16)
    GUI:Button_setTitleColor(btnRestore, "#FFFFFF")
    GUI:Button_setTitleText(btnRestore, "还原普攻")

    -- 键位重置
    local btnReset = GUI:Button_Create(SetUI, "btnReset", 600, 35, "res/public/1900000680.png")
    GUI:Button_loadTexturePressed(btnReset, "res/public/1900000680_1.png")
    GUI:setAnchorPoint(btnReset, {x=0.5, y=0.5})
    GUI:Button_setTitleFontSize(btnReset, 16)
    GUI:Button_setTitleColor(btnReset, "#FFFFFF")
    GUI:Button_setTitleText(btnReset, "键位重置")

    -- 技能槽位
    local tInfo = {
        [1] = {x = 610, y = 145, pic = "res/private/skill/1900012700.png"},
        [2] = {x = 486, y = 118, pic = "res/private/skill/1900012702.png"},
        [3] = {x = 506, y = 193, pic = "res/private/skill/1900012702.png"},
        [4] = {x = 562, y = 248, pic = "res/private/skill/1900012702.png"},
        [5] = {x = 637, y = 268, pic = "res/private/skill/1900012702.png"},
        [6] = {x = 406, y = 162, pic = "res/private/skill/1900012702.png"},
        [7] = {x = 429, y = 255, pic = "res/private/skill/1900012702.png"},
        [8] = {x = 496, y = 316, pic = "res/private/skill/1900012702.png"},
        [9] = {x = 586, y = 345, pic = "res/private/skill/1900012702.png"}
    }

    for i,v in ipairs(tInfo) do
        local ImageSkill = GUI:Image_Create(SetUI, "ImageSkill_"..i, v.x, v.y, v.pic)
        GUI:setAnchorPoint(ImageSkill, {x=0.5, y=0.5})
        if i > 1 then
            GUI:Text_Create(ImageSkill, "labNum", 0, 55, 16, "#FFFFFF", i-1)
        end
    end
end

function SkillSetting.createItemSKill(SetUI)
    local cell = GUI:Layout_Create(SetUI, "ItemSkillCell", 0, 0, 95, 110)
    GUI:setAnchorPoint(cell, {x=0, y=1})
    GUI:setTouchEnabled(cell, true)

    local skill_bg = GUI:Image_Create(cell, "skill_bg", 47.5, 65, "res/private/skill/1900012701.png")
    GUI:setAnchorPoint(skill_bg, {x=0.5, y=0.5})

    local skill_icon = GUI:Image_Create(cell, "skill_icon", 47.5, 65, "res/private/skill/1900012703.png")
    GUI:setAnchorPoint(skill_icon, {x=0.5, y=0.5})

    local skill_name = GUI:Text_Create(cell, "skill_name", 47.5, 15, 16, "#FFFFFF", "name")
    GUI:setAnchorPoint(skill_name, {x=0.5, y=0.5})

    return cell
end