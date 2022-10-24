GuildAllyApply = {}

function GuildAllyApply.main()
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
    local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", screenW/2, screenH/2, 680, 400)
    GUI:setAnchorPoint(FrameLayout, {x=0.5, y=0.5})
    GUI:setTouchEnabled(FrameLayout, true)

    -- 背景图
    local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/public/1900000675.jpg")
    GUI:setContentSize(FrameBG, {width = 680, height = 400})

    -- 线
    local line_bg = GUI:Image_Create(FrameLayout, "line_bg", 340, 350, "res/public/bg_yyxsz_01.png")
    GUI:setAnchorPoint(line_bg, {x=0.5, y=0.5})
    GUI:setContentSize(line_bg, {width = 660, height = 2})
    local line1 = GUI:Image_Create(line_bg, "line1", 450, 20, "res/public/bg_yyxsz_02.png")
    GUI:setAnchorPoint(line1, {x=0.5, y=0.5})
    GUI:setContentSize(line1, {width = 2, height = 40})

    -- 标题
    local Title1 = GUI:Text_Create(FrameLayout, "Title1", 235, 370, 16, "#F2E7CF", "申请详情")
    GUI:setAnchorPoint(Title1, 0.5, 0.5)
    local Title2 = GUI:Text_Create(FrameLayout, "Title2", 565, 370, 16, "#F2E7CF", "操作")
    GUI:setAnchorPoint(Title2, 0.5, 0.5)

    -- 关闭按钮
    local CloseButton = GUI:Button_Create(FrameLayout, "CloseButton", 680, 400, "res/public/1900000510.png")
    GUI:Button_loadTexturePressed(CloseButton, "res/public/1900000511.png")
    GUI:setAnchorPoint(CloseButton, {x=0, y=1})
    GUI:setTouchEnabled(CloseButton, true)
    GUI:addOnClickEvent(CloseButton, function () SL:CloseGuildAllyApplyUI() end)

    -- List
    local ListView = GUI:ListView_Create(FrameLayout, "ListView", 13, 13, 653, 333, 1)
    -- ListCell
    GuildAllyApply.CreateItem(FrameLayout)
end

-- 列表中的样式在这里设置
function GuildAllyApply.CreateItem(parent)
    local size = {
        width = 653, height = 50
    }
    local ListCell = GUI:Layout_Create(parent, "ListCell", 0, 0, size.width, size.height, true)
    GUI:setVisible(ListCell, false)

    local line = GUI:Image_Create(ListCell, "line", 0, 0, "res/public/bg_yyxsz_01.png")
    GUI:setPosition(line, 0, 1)
    
    -- 描述
    local Node_tips = GUI:Node_Create(ListCell,"Node_tips", 15, size.height / 2)
    GUI:setAnchorPoint(Node_tips, 0, 0.5)
    
    -- 拒绝按钮
    local btnDisagree = GUI:Button_Create(ListCell, "btnDisAgree", 500, size.height / 2, "res/public/1900000679.png")
    GUI:setAnchorPoint(btnDisagree, 0.5, 0.5)
    GUI:Button_setTitleText(btnDisagree, "拒绝")
    GUI:Button_setTitleColor(btnDisagree,"#F7F0E2")
    GUI:Button_setTitleFontSize(btnDisagree, 16)

    -- 同意按钮
    local btnAgree = GUI:Button_Create(ListCell, "btnAgree", 600, size.height / 2, "res/public/1900000679.png")
    GUI:setAnchorPoint(btnAgree, 0.5, 0.5)
    GUI:Button_setTitleText(btnAgree, "同意")
    GUI:Button_setTitleColor(btnAgree,"#F7F0E2")
    GUI:Button_setTitleFontSize(btnAgree, 16)
end