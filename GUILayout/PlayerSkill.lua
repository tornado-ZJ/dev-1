PlayerSkill = {}

function PlayerSkill.main()
    local parent  = GUI:Attach_Parent()
    local attachW = 348
    local attachH = 478

    local _ResPath = "res/private/player_skill/"

    local SkillUI = GUI:Layout_Create(parent, "SkillUI", 0, 0, attachW, attachH, true)
    GUI:setTouchEnabled(SkillUI, true)

    local BG = GUI:Image_Create(SkillUI, "BG", 0, 0, _ResPath.."1900015001.png")
    GUI:setContentSize(BG, {width = attachW, height = attachH})

    local BtmImage = GUI:Image_Create(SkillUI, "BtmImage", 0, 0, "res/public/bg_hhdb_01.jpg")
    GUI:setContentSize(BtmImage, {width = attachW, height = 60})

    local BtnSet = GUI:Button_Create(SkillUI, "BtnSet", attachW / 2, 30, "res/public/1900000680.png")
    GUI:Button_loadTexturePressed(BtnSet, "res/public/1900000680_1.png")
    GUI:Button_setTitleColor(BtnSet, "#FFFFFF")
    GUI:Button_setTitleFontSize(BtnSet, 18)
    GUI:setAnchorPoint(BtnSet, 0.5, 0.5)
    GUI:Button_setTitleText(BtnSet, "技能配置")

    -- ListView
    local lSize = {
        width  = attachW - 10,
        height = attachH - 70
    }
    local ListView = GUI:ListView_Create(SkillUI, "ListView", 5, 63, lSize.width, lSize.height, 1)

-- [[ ListView item
    local item = GUI:Layout_Create(SkillUI, "item", 0, 0, lSize.width, 60, true)
    GUI:setVisible(item, false)
    local tip_bg = GUI:Image_Create(item, "tip_bg", 68, 29, _ResPath.."1900015004.png")
    GUI:setContentSize(tip_bg, {width = 270, height = 60})
    GUI:Image_setScale9Slice(tip_bg, 20, 20, 4, 4)
    GUI:setAnchorPoint(tip_bg, 0, 0.5)
    local skillIcon = GUI:Image_Create(item, "skillIcon", 35, 30, _ResPath.."1900015031.png")
    GUI:setAnchorPoint(skillIcon, 0.5, 0.5)
    local imageLv = GUI:Image_Create(item, "imageLv", 157, 48, _ResPath.."1900015021.png")
    GUI:setAnchorPoint(imageLv, 0, 0.5)
    local imageExp = GUI:Image_Create(item, "imageExp", 73, 22, _ResPath.."1900015020.png")
    GUI:setAnchorPoint(imageExp, 0, 0.5)
    -- 技能名称
    local skillName = GUI:Text_Create(item, "skillName", 73, 48, 16, "#FFFFFF", "")
    GUI:setAnchorPoint(skillName, 0, 0.5)
    -- 技能等级
    local skillLevel = GUI:Text_Create(item, "skillLevel", 193, 48, 16, "#FFFFFF", "")
    GUI:setAnchorPoint(skillLevel, 0, 0.5)
    -- 技能等级
    local skillTrain = GUI:Text_Create(item, "skillTrain", 123, 22, 16, "#FFFFFF", "")
    GUI:setAnchorPoint(skillTrain, 0, 0.5)
    -- 技能描述
    local skillLevelUp = GUI:Text_Create(item, "skillLevelUp", 73, 22, 16, "#FFFFFF", "")
    GUI:setAnchorPoint(skillName, 0, 0.5)
-- ]]
end