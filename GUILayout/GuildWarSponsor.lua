GuildWarSponsor = {}

GuildWarSponsor._TextPosX = {
    [1] = 90, [2] = 263, [3] = 400, [4] = 563
}

function GuildWarSponsor.main()
    local parent  = GUI:Attach_Parent()
    local screenW = SL:GetScreenWidth()
    local screenH = SL:GetScreenHeight()

    -- 全屏关闭
    local CloseLayout = GUI:Layout_Create(parent, "CloseLayout", 0, 0, screenW, screenH)
    GUI:Layout_setBackGroundColorType(CloseLayout, 1)
    GUI:Layout_setBackGroundColor(CloseLayout, "#000000")
    GUI:Layout_setBackGroundColorOpacity(CloseLayout, 150)
    GUI:setTouchEnabled(CloseLayout, true)

    -- 容器
    local PopLayer = GUI:Layout_Create(parent, "PopLayer", screenW/2, screenH/2, 450, 179)
    GUI:setAnchorPoint(PopLayer, {x=0.5, y=0.5})
    GUI:setTouchEnabled(PopLayer, true)

    -- 背景图
    local FrameBG = GUI:Image_Create(PopLayer, "FrameBG", 0, 0, "res/public/1900000600.png")

    -- 线
    local line_bg = GUI:Image_Create(PopLayer, "line_bg", 340, 350, "res/public/bg_yyxsz_01.png")
    GUI:setAnchorPoint(line_bg, {x=0.5, y=0.5})
    GUI:setContentSize(line_bg, {width = 660, height = 2})
    local line1 = GUI:Image_Create(line_bg, "line1", 450, 20, "res/public/bg_yyxsz_02.png")
    GUI:setAnchorPoint(line1, {x=0.5, y=0.5})
    GUI:setContentSize(line1, {width = 2, height = 40})

    -- 标题
    local NodeTitle = GUI:Node_Create(PopLayer, "NodeTitle", 225, 153)
    GUI:setAnchorPoint(NodeTitle, 0.5, 0.5)

    local TextTime = GUI:Text_Create(PopLayer, "TextTime", 212, 118, 16, "#F2E7CF", "")
    GUI:setAnchorPoint(TextTime, 1, 0.5)
    local TimeBg = GUI:Image_Create(PopLayer, "TimeBg", 265, 118, "res/public/1900000668.png")
    GUI:Image_setScale9Slice(TimeBg, 22, 22 , 4, 4)
    GUI:setContentSize(TimeBg, {width = 100, height = 31})
    GUI:setAnchorPoint(TimeBg, {x=0.5, y=0.5})
    GUI:setTouchEnabled(TimeBg, true)

    local BtnArrow = GUI:Button_Create(TimeBg, "BtnArrow", 80, 15.5, "res/public/btn_szjm_01.png")
    GUI:setAnchorPoint(BtnArrow, {x=0.5, y=0.5})
    local Time = GUI:Text_Create(TimeBg, "Time", 34, 16, 16, "#F2E7CF", "")
    GUI:setAnchorPoint(Time, 0.5, 0.5)

    local labCost = GUI:Text_Create(PopLayer, "labCost", 212, 85, 16, "#F2E7CF", "")
    GUI:setAnchorPoint(labCost, 1, 0.5)
    local TextCost = GUI:Text_Create(PopLayer, "TextCost", 214, 85, 16, "#0BC50B", "")
    GUI:setAnchorPoint(TextCost, 0, 0.5)

    -- 取消 按钮
    local BtnCancel = GUI:Button_Create(PopLayer, "BtnCancel", 112, 40, "res/public/1900000660.png")
    GUI:setAnchorPoint(BtnCancel, {x=0.5, y=0.5})
    GUI:Button_setTitleText(BtnCancel, "取消")
    GUI:Button_setTitleFontSize(BtnCancel, 16)
    GUI:addOnClickEvent(BtnCancel, function () SL:CloseGuildWarSponsorUI() end)

    -- 确定 按钮
    local BtnOk = GUI:Button_Create(PopLayer, "BtnOk", 378, 40, "res/public/1900000660.png")
    GUI:setAnchorPoint(BtnOk, {x=0.5, y=0.5})
    GUI:Button_setTitleText(BtnOk, "确定")
    GUI:Button_setTitleFontSize(BtnOk, 16)

    -- 关闭按钮
    local CloseButton = GUI:Button_Create(PopLayer, "CloseButton", 680, 400, "res/public/1900000510.png")
    GUI:Button_loadTexturePressed(CloseButton, "res/public/1900000511.png")
    GUI:setAnchorPoint(CloseButton, {x=0, y=1})
    GUI:addOnClickEvent(CloseButton, function () SL:CloseGuildWarSponsorUI() end)

    local ListBg = GUI:Image_Create(PopLayer, "ListBg", 265, 100, "res/public/1900000677.png")
    GUI:setAnchorPoint(ListBg, 0.5, 1)
    GUI:Image_setScale9Slice(ListBg, 15, 15, 20, 20)
    GUI:setContentSize(ListBg, {width = 125, height = 155})
    GUI:setVisible(ListBg, false)
    
    -- List
    local ListView = GUI:ListView_Create(ListBg, "ListView", 5, 5, 115, 145, 1)
    -- ListCell
    GuildWarSponsor.CreateListCell(PopLayer)
end

function GuildWarSponsor.CreateListCell(parent)
    local ListCell = GUI:Layout_Create(parent, "ListCell", 0, 0, 115, 35)
    GUI:setTouchEnabled(ListCell, true)
    GUI:setVisible(ListCell, false)

    local ImageSel = GUI:Image_Create(ListCell, "ImageSel", 0, 0, "res/public/1900000678.png")
    GUI:setContentSize(ImageSel, {width = 115, height = 35})
    GUI:Image_setScale9Slice(ImageSel, 20, 20, 5, 5)

    local Text = GUI:Text_Create(ListCell, "Text", 57.5, 17.5, 16, "#F7F0E2", "")
    GUI:setAnchorPoint(Text, 0.5, 0.5)
end