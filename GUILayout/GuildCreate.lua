GuildCreate = {}

function GuildCreate.main()
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
    local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", screenW/2, screenH/2, 548, 326)
    GUI:setAnchorPoint(FrameLayout, {x=0.5, y=0.5})
    GUI:setTouchEnabled(FrameLayout, true)

    -- 背景图
    local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/public/1900000675.jpg")
    GUI:setContentSize(FrameBG, {width = 548, height = 326})

    -- 标题
    local bgTitle = GUI:Image_Create(FrameLayout, "bgTitle", 275, 285, "res/private/guild_ui/word_hhzy_11.png")
    GUI:setAnchorPoint(bgTitle, {x=0.5, y=0.5})

    local TitleText_1 = GUI:Text_Create(FrameLayout, "TitleText_1", 156, 240, 18, "#ffffff", "行会名字")
    GUI:setAnchorPoint(TitleText_1, {x=0.5, y=0.5})

    local TitleText_2 = GUI:Text_Create(FrameLayout, "TitleText_2", 156, 150, 18, "#ffffff", "需要道具")
    GUI:setAnchorPoint(TitleText_2, {x=0.5, y=0.5})

    -- 需要道具
    local Node_item = GUI:Node_Create(FrameLayout, "Node_item", 275, 150)
    GUI:setAnchorPoint(Node_item, {x=0.5, y=0.5})

    -- 输入框
    local input_bg = GUI:Image_Create(FrameLayout, "Input_bg", 335, 240, "res/public/1900000676.png")
    local input = GUI:TextInput_Create(FrameLayout, "Input", 337, 241.5, 195, 23, 18)
    GUI:setAnchorPoint(input_bg, {x=0.5, y=0.5})
    GUI:setAnchorPoint(input, {x=0.5, y=0.5})
    GUI:setContentSize(input_bg, {width = 200, height = 25})
    GUI:Image_setScale9Slice(input_bg, 21, 21, 10, 10)
    GUI:TextInput_setPlaceHolder(input, "请输入行会名")
    GUI:Text_setTextHorizontalAlignment(input, 0) 
    GUI:TextInput_setInputMode(input, 0)

    -- 创建行会按钮
    local BtnCreate = GUI:Button_Create(FrameLayout, "BtnCreate", 275, 40, "res/public/1900000660.png")
    GUI:setAnchorPoint(BtnCreate, {x=0.5, y=0.5})
    GUI:Button_setTitleText(BtnCreate, "创建行会")
    GUI:Button_setTitleFontSize(BtnCreate, 16)

    local CheckBox = GUI:CheckBox_Create(FrameLayout, "CheckBox", 340, 186, "res/public/1900000654.png", "res/public/1900000655.png")
    local cbLabel = GUI:Text_Create(CheckBox, "Label", 25, 0, 16, "#FFFFFF", "自动同意入会申请")
    GUI:setAnchorPoint(CheckBox, 0.5, 0.5)
    GUI:CheckBox_setSelected(CheckBox, false)
    -- CheckBox 触摸层
    GUI:Layout_Create(CheckBox, "TouchSize", 0, -1, GUI:getContentSize(CheckBox).width + GUI:getContentSize(cbLabel).width, 28, false)

    -- 输入框
    local input_level_bg = GUI:Image_Create(FrameLayout, "Input_level_bg", 337, 140, "res/public/1900000668.png")
    GUI:setContentSize(input_level_bg, {width = 40, height = 30})
    GUI:setAnchorPoint(input_level_bg, {x=0, y=0.5})

    local Input_level = GUI:TextInput_Create(input_level_bg, "Input_level", 20, 15, 30, 20, 18)
    GUI:setAnchorPoint(Input_level, {x=0.5, y=0.5})
    GUI:TextInput_setString(Input_level, "1")
    GUI:Text_setTextHorizontalAlignment(Input_level, 1)
    GUI:TextInput_setInputMode(Input_level, 2)

    local text = GUI:Text_Create(input_level_bg, "text", 45, 15, 16, "#F2E7CF", "级以上")
    GUI:setAnchorPoint(text, 0, 0.5)

    -- 关闭按钮
    local CloseButton = GUI:Button_Create(FrameLayout, "CloseButton", 561, 306, "res/public/1900000510.png")
    GUI:Button_loadTexturePressed(CloseButton, "res/public/1900000511.png")
    GUI:setAnchorPoint(CloseButton, {x=0.5, y=0.5})
    GUI:setTouchEnabled(CloseButton, true)
    GUI:addOnClickEvent(CloseButton, function ()
        SL:CloseGuildCreateUI()
        SL:OpenGuildMainUI()
    end)
end