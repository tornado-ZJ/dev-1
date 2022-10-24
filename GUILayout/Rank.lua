Rank = {}

function Rank.main( )
    local parent  = GUI:Attach_Parent()
    local screenW = SL:GetScreenWidth()
    local screenH = SL:GetScreenHeight()
    local ResPath = "res/private/rank_ui/rank_ui_mobile/"
    Rank._ResPath = ResPath
    -- 全屏
    local Layout = GUI:Layout_Create(parent, "Layout", 0, 0, screenW, screenH)
    GUI:setTouchEnabled(Layout, true)
    GUI:addOnClickEvent(Layout, function() SL:CloseRankUI() end)

    -- 容器
    local PMainUI = GUI:Layout_Create(parent, "PMainUI", screenW/2, screenH/2, 830, 536)
    GUI:setAnchorPoint(PMainUI, 0.5, 0.5)
    GUI:setTouchEnabled(PMainUI, true)

    local pBg = GUI:Image_Create(PMainUI, "pBg", 415, 268, ResPath.."1900020020.png")
    GUI:setAnchorPoint(pBg, 0.5, 0.5)

    local Image_title = GUI:Image_Create(PMainUI, "Image_title", 415, 490, ResPath.."1900020024.png")
    GUI:setAnchorPoint(Image_title, 0.5, 0.5)

    -- 关闭按钮
    local CloseButton = GUI:Button_Create(PMainUI, "CloseButton", 780, 450, "res/public/1900000510.png")
    GUI:Button_loadTexturePressed(CloseButton, "res/public/1900000511.png")
    GUI:addOnClickEvent(CloseButton, function() SL:CloseRankUI() end)

    -- 玩家页签
    local BtnPlayer = GUI:Button_Create(PMainUI, "BtnPlayer", 810, 340, ResPath.."1900012110.png")
    GUI:Button_loadTextureDisabled(BtnPlayer, ResPath.."1900012111.png")
    GUI:Button_loadTexturePressed(BtnPlayer, ResPath.."1900012111.png")
    GUI:setAnchorPoint(BtnPlayer, 0.5, 0.5)
    GUI:setRotation(BtnPlayer, 180)
    GUI:addOnClickEvent(BtnPlayer, function() Rank.ButtonTo(1) end)
    local Text_1 = GUI:Text_Create(BtnPlayer, "Text", 21, 44, 16, "#FFFFFF", "玩\n家")
    GUI:setAnchorPoint(Text_1, 0.5, 0.5)
    GUI:setRotation(Text_1, -180)

    -- 英雄页签
    local BtnHero = GUI:Button_Create(PMainUI, "BtnHero", 810, 250, ResPath.."1900012110.png")
    GUI:Button_loadTextureDisabled(BtnHero, ResPath.."1900012111.png")
    GUI:Button_loadTexturePressed(BtnHero, ResPath.."1900012111.png")
    GUI:setAnchorPoint(BtnHero, 0.5, 0.5)
    GUI:setRotation(BtnHero, 180)
    GUI:addOnClickEvent(BtnHero, function() Rank.ButtonTo(2) end)
    local Text_2 = GUI:Text_Create(BtnHero, "Text", 21, 44, 16, "#FFFFFF", "英\n雄")
    GUI:setAnchorPoint(Text_2, 0.5, 0.5)
    GUI:setRotation(Text_2, -180)

    -- 排名页签
    local posY = 330
    local distance = 90
    
    local PageNames = {
        [1] = "等\n级",   -- 所有 职业 按等级排名
        [2] = "战\n士",   -- 所有 战士 按等级排名
        [3] = "法\n师",   -- 所有 法师 按等级排名 
        [4] = "道\n士"    -- 所有 道士 按等级排名
    }

    for i=1,4 do
        local Page = GUI:Button_Create(PMainUI, "Page"..i, 30, posY, ResPath.."1900012110.png")
        GUI:Button_loadTexturePressed(Page, ResPath.."1900012111.png")
        GUI:Button_loadTextureDisabled(Page, ResPath.."1900012111.png")
        GUI:addOnClickEvent(Page, function() Rank.PageTo(i)
        end)
        local Text = GUI:Text_Create(Page, "Text", 20, 44, 16, "#ffffff", PageNames[i])
        GUI:setAnchorPoint(Text, 0.5, 0.5)

        posY = posY - distance
    end

    local PanelMyInfo = GUI:Layout_Create(PMainUI, "PanelMyInfo", 115, 30, 451, 30, true)
    local Text1_1 = GUI:Text_Create(PanelMyInfo, "Text1_1", 88, 15, 16, "#FFFFFF", "我的排名：")
    GUI:setAnchorPoint(Text1_1, 1, 0.5)

    local pRank = GUI:Text_Create(PanelMyInfo, "pRank", 95, 15, 16, "#FFFFFF", "")
    GUI:setAnchorPoint(pRank, 0, 0.5)

    local Text1_2 = GUI:Text_Create(PanelMyInfo, "Text1_2", 285, 15, 16, "#FFFFFF", "所属行会：")
    GUI:setAnchorPoint(Text1_2, 1, 0.5)

    local GuildName = GUI:Text_Create(PanelMyInfo, "GuildName", 288, 15, 16, "#FFFFFF", "")
    GUI:setAnchorPoint(GuildName, 0, 0.5)

    local ListView = GUI:ListView_Create(PMainUI, "ListView", 115, 65, 451, 370, 1)
    local ListViewCell = Rank.createListViewCell(PMainUI)
    GUI:setVisible(ListViewCell, false)

    -- 人物模型
    local Node_model = GUI:Node_Create(PMainUI, "Node_model", 635, 220)
    GUI:setAnchorPoint(Node_model, 0.5, 0.5)

    -- 查看玩家信息
    local BtnLook = GUI:Button_Create(PMainUI, "BtnLook", 637, 55, "res/public/1900000679.png")
    GUI:Button_loadTexturePressed(BtnLook, "res/public/1900000679_1.png")
    GUI:setAnchorPoint(BtnLook, 0.5, 0.5)
    GUI:Button_setTitleColor(BtnLook,"#FFFFFF")
    GUI:Button_setTitleFontSize(BtnLook, 16)
    GUI:Button_setTitleText(BtnLook, "查看")
end

function Rank.createListViewCell(parent)
    local Cell = GUI:Layout_Create(parent, "ListViewCell", 0, 0, 451, 40, true)
    GUI:setTouchEnabled(Cell, true)

    GUI:Image_Create(Cell, "CellBg", 0, 0, Rank._ResPath.."1900020022.png")

    local TRankBg = GUI:Image_Create(Cell, "TRankBg", 20, 20, Rank._ResPath.."1900020023.png")
    GUI:setAnchorPoint(TRankBg, 0.5, 0.5)

    local ImageRank = GUI:Image_Create(Cell, "ImageRank", 20, 20, Rank._ResPath.."1900020025.png")
    GUI:setAnchorPoint(ImageRank, 0.5, 0.5)
    local TextRank = GUI:Text_Create(Cell, "TextRank", 20, 20, 18, "#FFFFFF", 4)
    GUI:setAnchorPoint(TextRank, 0.5, 0.5)

    local TextName = GUI:Text_Create(Cell, "TextName", 118, 20, 16, "#FFFFFF", "")
    GUI:setAnchorPoint(TextName, 0.5, 0.5)

    local TextLevel = GUI:Text_Create(Cell, "TextLevel", 250, 20, 16, "#FFFFFF", "")
    GUI:setAnchorPoint(TextLevel, 0.5, 0.5)
    
    local TextGuildName = GUI:Text_Create(Cell, "TextGuildName", 380, 20, 16, "#FFFFFF", "")
    GUI:setAnchorPoint(TextGuildName, 0.5, 0.5)

    local SelRankBg = GUI:Image_Create(Cell, "SelRankBg", 0, 0, Rank._ResPath.."1900020028.png")
    GUI:setContentSize(SelRankBg, {width = 451, height = 40})
    GUI:setVisible(SelRankBg, false)

    return Cell
end
