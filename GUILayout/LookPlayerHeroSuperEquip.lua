LookPlayerHeroSuperEquip = {}

function LookPlayerHeroSuperEquip.main()
    local parent  = GUI:Attach_Parent()
    local attachW = 348
    local attachH = 478

    local _ResPath = "res/private/player_main_layer_ui/player_main_layer_ui_mobile/"

    local SuperEquipUI = GUI:Layout_Create(parent, "SuperEquipUI", 0, 0, attachW, attachH, true)
    GUI:setTouchEnabled(SuperEquipUI, true)

    local BG = GUI:Image_Create(SuperEquipUI, "BG", 0, 0,  _ResPath.."bg_juese_03.png")

    local GuildFlag = GUI:Image_Create(SuperEquipUI, "GuildFlag", 606, 407, "res/private/guild_ui/guild_icon.png")
    GUI:setAnchorPoint(GuildFlag, 0.5, 0.5)

    -------------------------------------------------------------------------------------------------------------
    -- 人物模型
    local NodePlayerModel = GUI:Node_Create(SuperEquipUI, "NodePlayerModel", 174, 219)
    -- 衣服
    local PanelPos17 = GUI:Layout_Create(SuperEquipUI, "PanelPos17", 180, 240, 174, 197, false)
    GUI:setAnchorPoint(PanelPos17, 0.5, 0.5)

    -- 武器
    local PanelPos18 = GUI:Layout_Create(SuperEquipUI, "PanelPos18", 67, 306, 120, 206, false)
    GUI:setAnchorPoint(PanelPos18, 0.5, 0.5)
    -- 盾牌/双剑
    local PanelPos45 = GUI:Layout_Create(SuperEquipUI, "PanelPos45", 244, 208, 85, 140, false)
    GUI:setAnchorPoint(PanelPos45, 0.5, 0.5)

    -- 头盔
    local PanelPos21 = GUI:Layout_Create(SuperEquipUI, "PanelPos21", 174, 322, 50, 50, false)
    GUI:setAnchorPoint(PanelPos21, 0.5, 0.5)

     -- 勋章
     local PanelPos26 = GUI:Layout_Create(SuperEquipUI, "PanelPos26", 318, 202.5, 52, 52, false)
     GUI:setAnchorPoint(PanelPos26, 0.5, 0.5)
     local PanelBg = GUI:Image_Create(PanelPos26, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
     GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
     local DefaultIcon = GUI:Image_Create(PanelPos26, "DefaultIcon", 26, 26, _ResPath.."1900015033.png")
     GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
     local Node26 = GUI:Node_Create(SuperEquipUI, "Node26", 318, 202.5)

    -- 项链
    local PanelPos20 = GUI:Layout_Create(SuperEquipUI, "PanelPos20", 318, 260, 52, 52, false)
    GUI:setAnchorPoint(PanelPos20, 0.5, 0.5)
    local PanelBg = GUI:Image_Create(PanelPos20, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    local DefaultIcon = GUI:Image_Create(PanelPos20, "DefaultIcon", 26, 26, _ResPath.."1900015032.png")
    GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node20 = GUI:Node_Create(SuperEquipUI, "Node20", 318, 260)

    -- 左手镯(左右以人物内观内的左右为标准)
    local PanelPos22 = GUI:Layout_Create(SuperEquipUI, "PanelPos22", 318, 145, 52, 52, false)
    GUI:setAnchorPoint(PanelPos22, 0.5, 0.5)
    local PanelBg = GUI:Image_Create(PanelPos22, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    local DefaultIcon = GUI:Image_Create(PanelPos22, "DefaultIcon", 26, 26, _ResPath.."1900015034.png")
    GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node22 = GUI:Node_Create(SuperEquipUI, "Node22", 318, 145)

    -- 右手镯
    local PanelPos23 = GUI:Layout_Create(SuperEquipUI, "PanelPos23", 30, 145, 52, 52, false)
    GUI:setAnchorPoint(PanelPos23, 0.5, 0.5)
    local PanelBg = GUI:Image_Create(PanelPos23, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    local DefaultIcon = GUI:Image_Create(PanelPos23, "DefaultIcon", 26, 26, _ResPath.."1900015034.png")
    GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node23 = GUI:Node_Create(SuperEquipUI, "Node23", 30, 145)

    -- 左戒指
    local PanelPos24 = GUI:Layout_Create(SuperEquipUI, "PanelPos24", 318, 87.5, 52, 52, false)
    GUI:setAnchorPoint(PanelPos24, 0.5, 0.5)
    local PanelBg = GUI:Image_Create(PanelPos24, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    local DefaultIcon = GUI:Image_Create(PanelPos24, "DefaultIcon", 26, 26, _ResPath.."1900015035.png")
    GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node24 = GUI:Node_Create(SuperEquipUI, "Node24", 318, 87.5)

    -- 右戒指
    local PanelPos25 = GUI:Layout_Create(SuperEquipUI, "PanelPos25", 30, 87.5, 52, 52, false)
    GUI:setAnchorPoint(PanelPos25, 0.5, 0.5)
    local PanelBg = GUI:Image_Create(PanelPos25, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    local DefaultIcon = GUI:Image_Create(PanelPos25, "DefaultIcon", 26, 26, _ResPath.."1900015035.png")
    GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node25 = GUI:Node_Create(SuperEquipUI, "Node25", 30, 87.5)

    -- 护身符位置 玉佩 宝珠
    local PanelPos43 = GUI:Layout_Create(SuperEquipUI, "PanelPos43", 87.5, 30, 52, 52, false)
    GUI:setAnchorPoint(PanelPos43, 0.5, 0.5)
    local PanelBg = GUI:Image_Create(PanelPos43, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    local DefaultIcon = GUI:Image_Create(PanelPos43, "DefaultIcon", 26, 26, _ResPath.."1900015036.png")
    GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node43 = GUI:Node_Create(SuperEquipUI, "Node43", 87.5, 30)

    -- 腰带
    local PanelPos27 = GUI:Layout_Create(SuperEquipUI, "PanelPos27", 145.2, 30, 52, 52, false)
    GUI:setAnchorPoint(PanelPos27, 0.5, 0.5)
    local PanelBg = GUI:Image_Create(PanelPos27, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    local DefaultIcon = GUI:Image_Create(PanelPos27, "DefaultIcon", 26, 26, _ResPath.."1900015038.png")
    GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node27 = GUI:Node_Create(SuperEquipUI, "Node27", 145.2, 30)

    -- 鞋子
    local PanelPos28 = GUI:Layout_Create(SuperEquipUI, "PanelPos28", 202.8, 30, 52, 52, false)
    GUI:setAnchorPoint(PanelPos28, 0.5, 0.5)
    local PanelBg = GUI:Image_Create(PanelPos28, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    local DefaultIcon = GUI:Image_Create(PanelPos28, "DefaultIcon", 26, 26, _ResPath.."1900015037.png")
    GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node28 = GUI:Node_Create(SuperEquipUI, "Node28", 202.8, 30)

    -- 宝石
    local PanelPos29 = GUI:Layout_Create(SuperEquipUI, "PanelPos29", 260.4, 30, 52, 52, false)
    GUI:setAnchorPoint(PanelPos29, 0.5, 0.5)
    local PanelBg = GUI:Image_Create(PanelPos29, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    local DefaultIcon = GUI:Image_Create(PanelPos29, "DefaultIcon", 26, 26, _ResPath.."1900015039.png")
    GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node29 = GUI:Node_Create(SuperEquipUI, "Node29", 260.4, 30)

    -- 左下 军鼓
    local PanelPos44 = GUI:Layout_Create(SuperEquipUI, "PanelPos44", 30, 30, 52, 52, false)
    GUI:setAnchorPoint(PanelPos44, 0.5, 0.5)
    local PanelBg = GUI:Image_Create(PanelPos44, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    local DefaultIcon = GUI:Image_Create(PanelPos44, "DefaultIcon", 26, 26, _ResPath.."1900015040.png")
    GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node44 = GUI:Node_Create(SuperEquipUI, "Node44", 30, 30)

    -- 右下 马牌
    local PanelPos42 = GUI:Layout_Create(SuperEquipUI, "PanelPos42", 318, 30, 52, 52, false)
    GUI:setAnchorPoint(PanelPos42, 0.5, 0.5)
    local PanelBg = GUI:Image_Create(PanelPos42, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    local DefaultIcon = GUI:Image_Create(PanelPos42, "DefaultIcon", 26, 26, _ResPath.."1900015041.png")
    GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node42 = GUI:Node_Create(SuperEquipUI, "Node42", 318, 30)
end
