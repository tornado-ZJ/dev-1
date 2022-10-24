GuildEditTitle = {}

function GuildEditTitle.main()
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
    local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", screenW/2, screenH/2, 400, 286)
    GUI:setAnchorPoint(FrameLayout, {x=0.5, y=0.5})
    GUI:setTouchEnabled(FrameLayout, true)

    -- 背景图
    local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/public/1900000675.jpg")
    GUI:setContentSize(FrameBG, {width = 400, height = 286})

    -- 确定
    local BtnOk = GUI:Button_Create(FrameLayout, "BtnOk", 280, 40, "res/public/1900000611.png")
    GUI:setAnchorPoint(BtnOk, {x=0.5, y=0.5})
    GUI:Button_setTitleText(BtnOk, "确定")
    GUI:Button_setTitleFontSize(BtnOk, 16)
    GUI:addOnClickEvent(BtnOk, function ()
        GuildEditTitle._SaveOpt(GuildEditTitle._EditInputs)
    end)

    -- 取消
    local BtnCancel = GUI:Button_Create(FrameLayout, "BtnCancel", 120, 40, "res/public/1900000611.png")
    GUI:setAnchorPoint(BtnCancel, {x=0.5, y=0.5})
    GUI:Button_setTitleText(BtnCancel, "取消")
    GUI:Button_setTitleFontSize(BtnCancel, 16)
    GUI:addOnClickEvent(BtnCancel, function()
        GUI:Win_Close(parent)
    end)

    -- 关闭按钮
    local CloseButton = GUI:Button_Create(FrameLayout, "CloseButton", 400, 286, "res/public/1900000510.png")
    GUI:Button_loadTexturePressed(CloseButton, "res/public/1900000511.png")
    GUI:setAnchorPoint(CloseButton, {x=0, y=1})
    GUI:setTouchEnabled(CloseButton, true)
    GUI:addOnClickEvent(CloseButton, function()
        GUI:Win_Close(parent)
    end)

    -- 列表
    local List = GUI:ListView_Create(FrameLayout, "List", 15, 77, 370, 195, 1)
    GUI:ListView_setItemsMargin(List, 5)

    GuildEditTitle._EditInputs = {}

    -- 获取 title 数据列表
    local TitleDatas = GuildEditTitle._GetGuildTitleData()
    GUI:removeAllChildren(List)
    for i,v in ipairs(TitleDatas) do
        GuildEditTitle.AddItem(GUI:Layout_Create(List, "item"..i, 0, 0, 370, 32, true), i)
    end
end

function GuildEditTitle.AddItem(item, i)
    local y = 16
    local EditInput_bg = GUI:Image_Create(item, "EditInput_bg", 92, y, "res/public/1900000668.png")
    GUI:setAnchorPoint(EditInput_bg, {x=0, y=0.5})
    local EditInput = GUI:TextInput_Create(item, "EditInput", 96, y, 148, 20, 16)
    GUI:setAnchorPoint(EditInput_bg, {x=0, y=0.5})
    GUI:setAnchorPoint(EditInput, {x=0, y=0.5})
    GUI:Text_setTextHorizontalAlignment(EditInput, 0) 
    GUI:TextInput_setInputMode(EditInput, 0)
    GUI:TextInput_setFontColor(EditInput, "#ffffff")

    -- 获得 title 名字
    local titleName = GuildEditTitle._GetTitleNameByIndex( i )
    GUI:TextInput_setString(EditInput, titleName)

    -- 把 EditInput 存储在 GuildEditTitle._EditInputs 中
    GuildEditTitle._EditInputs[i] = EditInput

    -- 称谓标签
    local Text = GUI:Text_Create(item, "Text", 80, y, 16, "#F2E7CF", "称谓"..i)
    GUI:setAnchorPoint(Text, 1, 0.5)
    
    return item
end
