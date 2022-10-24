TradePlayerEquip = {}

function TradePlayerEquip.main()
    local parent  = GUI:Attach_Parent()
    local attachW = 348
    local attachH = 478

    local _ResPath = "res/private/player_main_layer_ui/player_main_layer_ui_mobile/"

    local EquipUI = GUI:Layout_Create(parent, "EquipUI", 0, 0, attachW, attachH, true)
    GUI:setTouchEnabled(EquipUI, true)

    local BG = GUI:Image_Create(EquipUI, "BG", 0, 0,  _ResPath.."bg_juese_03.png")

    local GuildFlag = GUI:Image_Create(EquipUI, "GuildFlag", 606, 407, "res/private/guild_ui/guild_icon.png")
    GUI:setAnchorPoint(GuildFlag, 0.5, 0.5)

    -- 行会名字
    local Text_Guildinfo = GUI:Text_Create(EquipUI, "Text_Guildinfo", 10, attachH-15, 16, "#FFFFFF", "行会名字")
    GUI:setAnchorPoint(Text_Guildinfo, 0, 0.5)

    -------------------------------------------------------------------------------------------------------------
    -- 人物模型
    local NodePlayerModel = GUI:Node_Create(EquipUI, "NodePlayerModel", 174, 219)
    -- 衣服
    local PanelPos0 = GUI:Layout_Create(EquipUI, "PanelPos0", 180, 240, 174, 197, false)
    GUI:setAnchorPoint(PanelPos0, 0.5, 0.5)
    GUI:setTouchEnabled(PanelPos0, true)
    -- 武器
    local PanelPos1 = GUI:Layout_Create(EquipUI, "PanelPos1", 67, 306, 120, 206, false)
    GUI:setAnchorPoint(PanelPos1, 0.5, 0.5)
    GUI:setTouchEnabled(PanelPos1, true)
    -- 盾牌/双剑
    local PanelPos16 = GUI:Layout_Create(EquipUI, "PanelPos16", 244, 208, 85, 140, false)
    GUI:setAnchorPoint(PanelPos16, 0.5, 0.5)
    GUI:setTouchEnabled(PanelPos16, true)

    -- 勋章
    local PanelPos2 = GUI:Layout_Create(EquipUI, "PanelPos2", 318, 202.5, 52, 52, false)
    GUI:setAnchorPoint(PanelPos2, 0.5, 0.5)
    local PanelBg = GUI:Image_Create(PanelPos2, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    local DefaultIcon = GUI:Image_Create(PanelPos2, "DefaultIcon", 26, 26, _ResPath.."1900015033.png")
    GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node2 = GUI:Node_Create(EquipUI, "Node2", 318, 202.5)
    GUI:setTouchEnabled(PanelPos2, true)
    
    -- 项链
    local PanelPos3 = GUI:Layout_Create(EquipUI, "PanelPos3", 318, 260, 52, 52, false)
    GUI:setAnchorPoint(PanelPos3, 0.5, 0.5)
    local PanelBg = GUI:Image_Create(PanelPos3, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    local DefaultIcon = GUI:Image_Create(PanelPos3, "DefaultIcon", 26, 26, _ResPath.."1900015032.png")
    GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node3 = GUI:Node_Create(EquipUI, "Node3", 318, 260)
    GUI:setTouchEnabled(PanelPos3, true)

    -- 头盔
    -- local PanelPos4 = GUI:Layout_Create(EquipUI, "PanelPos4", 174, 350, 52, 52, false)
    -- GUI:setAnchorPoint(PanelPos4, 0.5, 0.5)
    -- local PanelBg = GUI:Image_Create(PanelPos4, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    -- GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    -- local DefaultIcon = GUI:Image_Create(PanelPos4, "DefaultIcon", 26, 26, "")
    -- GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node4 = GUI:Node_Create(EquipUI, "Node4", 174, 350)

    -- 左手镯(左右以人物内观内的左右为标准)
    local PanelPos5 = GUI:Layout_Create(EquipUI, "PanelPos5", 318, 145, 52, 52, false)
    GUI:setAnchorPoint(PanelPos5, 0.5, 0.5)
    local PanelBg = GUI:Image_Create(PanelPos5, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    local DefaultIcon = GUI:Image_Create(PanelPos5, "DefaultIcon", 26, 26, _ResPath.."1900015034.png")
    GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node5 = GUI:Node_Create(EquipUI, "Node5", 318, 145)
    GUI:setTouchEnabled(PanelPos5, true)

    -- 右手镯
    local PanelPos6 = GUI:Layout_Create(EquipUI, "PanelPos6", 30, 145, 52, 52, false)
    GUI:setAnchorPoint(PanelPos6, 0.5, 0.5)
    local PanelBg = GUI:Image_Create(PanelPos6, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    local DefaultIcon = GUI:Image_Create(PanelPos6, "DefaultIcon", 26, 26, _ResPath.."1900015034.png")
    GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node6 = GUI:Node_Create(EquipUI, "Node6", 30, 145)
    GUI:setTouchEnabled(PanelPos6, true)

     -- 左戒指
     local PanelPos7 = GUI:Layout_Create(EquipUI, "PanelPos7", 318, 87.5, 52, 52, false)
     GUI:setAnchorPoint(PanelPos7, 0.5, 0.5)
     local PanelBg = GUI:Image_Create(PanelPos7, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
     GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
     local DefaultIcon = GUI:Image_Create(PanelPos7, "DefaultIcon", 26, 26, _ResPath.."1900015035.png")
     GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
     local Node7 = GUI:Node_Create(EquipUI, "Node7", 318, 87.5)
     GUI:setTouchEnabled(PanelPos7, true)

    -- 右戒指
    local PanelPos8 = GUI:Layout_Create(EquipUI, "PanelPos8", 30, 87.5, 52, 52, false)
    GUI:setAnchorPoint(PanelPos8, 0.5, 0.5)
    local PanelBg = GUI:Image_Create(PanelPos8, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    local DefaultIcon = GUI:Image_Create(PanelPos8, "DefaultIcon", 26, 26, _ResPath.."1900015035.png")
    GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node8 = GUI:Node_Create(EquipUI, "Node8", 30, 87.5)
    GUI:setTouchEnabled(PanelPos8, true)

    -- 护身符位置 玉佩 宝珠
    local PanelPos9 = GUI:Layout_Create(EquipUI, "PanelPos9", 87.5, 30, 52, 52, false)
    GUI:setAnchorPoint(PanelPos9, 0.5, 0.5)
    local PanelBg = GUI:Image_Create(PanelPos9, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    local DefaultIcon = GUI:Image_Create(PanelPos9, "DefaultIcon", 26, 26, _ResPath.."1900015036.png")
    GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node9 = GUI:Node_Create(EquipUI, "Node9", 87.5, 30)
    GUI:setTouchEnabled(PanelPos9, true)

    -- 腰带
    local PanelPos10 = GUI:Layout_Create(EquipUI, "PanelPos10", 145.2, 30, 52, 52, false)
    GUI:setAnchorPoint(PanelPos10, 0.5, 0.5)
    local PanelBg = GUI:Image_Create(PanelPos10, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    local DefaultIcon = GUI:Image_Create(PanelPos10, "DefaultIcon", 26, 26, _ResPath.."1900015038.png")
    GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node10 = GUI:Node_Create(EquipUI, "Node10", 145.2, 30)
    GUI:setTouchEnabled(PanelPos10, true)

    -- 鞋子
    local PanelPos11 = GUI:Layout_Create(EquipUI, "PanelPos11", 202.8, 30, 52, 52, false)
    GUI:setAnchorPoint(PanelPos11, 0.5, 0.5)
    local PanelBg = GUI:Image_Create(PanelPos11, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    local DefaultIcon = GUI:Image_Create(PanelPos11, "DefaultIcon", 26, 26, _ResPath.."1900015037.png")
    GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node11 = GUI:Node_Create(EquipUI, "Node11", 202.8, 30)
    GUI:setTouchEnabled(PanelPos11, true)

    -- 宝石
    local PanelPos12 = GUI:Layout_Create(EquipUI, "PanelPos12", 260.4, 30, 52, 52, false)
    GUI:setAnchorPoint(PanelPos12, 0.5, 0.5)
    local PanelBg = GUI:Image_Create(PanelPos12, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    local DefaultIcon = GUI:Image_Create(PanelPos12, "DefaultIcon", 26, 26, _ResPath.."1900015039.png")
    GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node12 = GUI:Node_Create(EquipUI, "Node12", 260.4, 30)
    GUI:setTouchEnabled(PanelPos12, true)

    -- 斗笠（斗笠位置比较特殊 属于和头盔位置同部位）
    -- local PanelPos13 = GUI:Layout_Create(EquipUI, "PanelPos13", 174, 350, 52, 52, false)
    -- GUI:setAnchorPoint(PanelPos13, 0.5, 0.5)
    -- local PanelBg = GUI:Image_Create(PanelPos13, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    -- GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    -- local DefaultIcon = GUI:Image_Create(PanelPos13, "DefaultIcon", 26, 26, "")
    -- GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node13 = GUI:Node_Create(EquipUI, "Node13", 174, 350)

    -- 左下 军鼓
    local PanelPos14 = GUI:Layout_Create(EquipUI, "PanelPos14", 30, 30, 52, 52, false)
    GUI:setAnchorPoint(PanelPos14, 0.5, 0.5)
    local PanelBg = GUI:Image_Create(PanelPos14, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    local DefaultIcon = GUI:Image_Create(PanelPos14, "DefaultIcon", 26, 26, _ResPath.."1900015040.png")
    GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node14 = GUI:Node_Create(EquipUI, "Node14", 30, 30)
    GUI:setTouchEnabled(PanelPos14, true)

    -- 右下 马牌
    local PanelPos15 = GUI:Layout_Create(EquipUI, "PanelPos15", 318, 30, 52, 52, false)
    GUI:setAnchorPoint(PanelPos15, 0.5, 0.5)
    local PanelBg = GUI:Image_Create(PanelPos15, "PanelBg", 26, 26, _ResPath.."icon_chenghd_03.png")
    GUI:setAnchorPoint(PanelBg, 0.5, 0.5)
    local DefaultIcon = GUI:Image_Create(PanelPos15, "DefaultIcon", 26, 26, _ResPath.."1900015041.png")
    GUI:setAnchorPoint(DefaultIcon, 0.5, 0.5)
    local Node15 = GUI:Node_Create(EquipUI, "Node15", 318, 30)
    GUI:setTouchEnabled(PanelPos15, true)
    
    -- 十二生肖
    local BestRingBox = GUI:Layout_Create(EquipUI, "BestRingBox", 318, 310, 46, 36, true)
    GUI:setAnchorPoint(BestRingBox, 0.5, 0.5)
    local icon = GUI:Button_Create(BestRingBox, "icon", 23, 18, "res/private/player_best_rings_ui/player_best_rings_ui_mobile/btn_jewelry_1_0.png")
    GUI:setAnchorPoint(icon, 0.5, 0.5)
end
