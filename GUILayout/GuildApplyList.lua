GuildApplyList = {}

GuildApplyList._TextPosX = {
    [1] = 90, [2] = 263, [3] = 400, [4] = 563
}

function GuildApplyList.main()
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

    -- 底部横条图
    local btmImage = GUI:Image_Create(FrameLayout, "btmImage", 340, 43, "res/public/bg_hhdb_01.jpg")
    GUI:setAnchorPoint(btmImage, {x=0.5, y=0.5})
    GUI:setContentSize(btmImage, {width = 660, height = 64})

    -- 线
    local line_bg = GUI:Image_Create(FrameLayout, "line_bg", 340, 350, "res/public/bg_yyxsz_01.png")
    GUI:setAnchorPoint(line_bg, {x=0.5, y=0.5})
    GUI:setContentSize(line_bg, {width = 660, height = 2})
    local line1 = GUI:Image_Create(line_bg, "line1", 170, 20, "res/public/bg_yyxsz_02.png")
    GUI:setAnchorPoint(line1, {x=0.5, y=0.5})
    GUI:setContentSize(line1, {width = 2, height = 40})
    local line2 = GUI:Image_Create(line_bg, "line2", 335, 20, "res/public/bg_yyxsz_02.png")
    GUI:setAnchorPoint(line2, {x=0.5, y=0.5})
    GUI:setContentSize(line2, {width = 2, height = 40})
    local line3 = GUI:Image_Create(line_bg, "line3", 450, 20, "res/public/bg_yyxsz_02.png")
    GUI:setAnchorPoint(line3, {x=0.5, y=0.5})
    GUI:setContentSize(line3, {width = 2, height = 40})

    -- 标题
    local Title1 = GUI:Text_Create(FrameLayout, "Title1", GuildApplyList._TextPosX[1], 370, 16, "#F2E7CF", "玩家名字")
    GUI:setAnchorPoint(Title1, 0.5, 0.5)
    local Title2 = GUI:Text_Create(FrameLayout, "Title2", GuildApplyList._TextPosX[2], 370, 16, "#F2E7CF", "等级")
    GUI:setAnchorPoint(Title2, 0.5, 0.5)
    local Title3 = GUI:Text_Create(FrameLayout, "Title3", GuildApplyList._TextPosX[3], 370, 16, "#F2E7CF", "职业")
    GUI:setAnchorPoint(Title3, 0.5, 0.5)
    local Title4 = GUI:Text_Create(FrameLayout, "Title4", GuildApplyList._TextPosX[4], 370, 16, "#F2E7CF", "操作")
    GUI:setAnchorPoint(Title4, 0.5, 0.5)

    local CheckBox = GUI:CheckBox_Create(FrameLayout, "CheckBox", 35, 42, "res/public/1900000654.png", "res/public/1900000655.png")
    local cbLabel = GUI:Text_Create(CheckBox, "Label", 25, 0, 16, "#41CA44", "自动同意入会申请")
    GUI:setAnchorPoint(CheckBox, 0.5, 0.5)
    GUI:CheckBox_setSelected(CheckBox, false)
    -- CheckBox 触摸层
    GUI:Layout_Create(CheckBox, "TouchSize", 0, -1, GUI:getContentSize(CheckBox).width + GUI:getContentSize(cbLabel).width, 28, false)

    -- 输入框
    local input_bg = GUI:Image_Create(FrameLayout, "Input_bg", 220, 42, "res/public/1900000668.png")
    GUI:setContentSize(input_bg, {width = 40, height = 30})
    GUI:setAnchorPoint(input_bg, {x=0.5, y=0.5})

    local input = GUI:TextInput_Create(FrameLayout, "Input", 220, 42, 30, 20, 18)
    GUI:setAnchorPoint(input, {x=0.5, y=0.5})
    GUI:TextInput_setString(input, "1")
    GUI:Text_setTextHorizontalAlignment(input, 1)
    GUI:TextInput_setInputMode(input, 2)

    local text = GUI:Text_Create(FrameLayout, "text", 245, 42, 16, "#F2E7CF", "级以上")
    GUI:setAnchorPoint(text, 0, 0.5)

    -- 一键通过
    local BtnAll = GUI:Button_Create(FrameLayout, "BtnAll", 604, 42, "res/public/1900000660.png")
    GUI:setAnchorPoint(BtnAll, {x=0.5, y=0.5})
    GUI:Button_setTitleText(BtnAll, "一键通过")
    GUI:Button_setTitleFontSize(BtnAll, 16)

    -- 关闭按钮
    local CloseButton = GUI:Button_Create(FrameLayout, "CloseButton", 680, 400, "res/public/1900000510.png")
    GUI:Button_loadTexturePressed(CloseButton, "res/public/1900000511.png")
    GUI:setAnchorPoint(CloseButton, {x=0, y=1})
    GUI:setTouchEnabled(CloseButton, true)
    GUI:addOnClickEvent(CloseButton, function ()
        SL:CloseGuildApplyListUI()
        SL:OpenGuildMainUI(2)
    end)

    -- List
    local ListView = GUI:ListView_Create(FrameLayout, "ListView", 13, 76.5, 653, 270, 1)
    -- ListCell
    GuildApplyList.CreateItem(FrameLayout)
end

-- 列表中的样式在这里设置
function GuildApplyList.CreateItem(parent)
    local size = {
        width = 653, height = 50
    }
    local ListCell = GUI:Layout_Create(parent, "ListCell", 0, 0, size.width, size.height, true)
    GUI:setVisible(ListCell, false)


    local line = GUI:Image_Create(ListCell, "line", 0, 0, "res/public/bg_yyxsz_01.png")
    GUI:setPosition(line, 0, 1)
    
    -- 玩家名字
    local username = GUI:Text_Create(ListCell, "username", GuildApplyList._TextPosX[1] - 13, size.height / 2, 16, "#F2E7CF", "")
    GUI:setAnchorPoint(username, 0.5, 0.5)
    
    -- 等级
    local level = GUI:Text_Create(ListCell, "level", GuildApplyList._TextPosX[2] - 13, size.height / 2, 16, "#F2E7CF", "")
    GUI:setAnchorPoint(level, 0.5, 0.5)
    
    -- 职业
    local job = GUI:Text_Create(ListCell, "job", GuildApplyList._TextPosX[3] - 13, size.height / 2, 16, "#F2E7CF", "")
    GUI:setAnchorPoint(job, 0.5, 0.5)
    
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