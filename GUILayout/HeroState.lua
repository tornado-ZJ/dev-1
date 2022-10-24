HeroState = {}

function HeroState.main()
    local parent  = GUI:Attach_Parent()
    local screenW = SL:GetScreenWidth()
    local screenH = SL:GetScreenHeight()
    local _PathRes = "/res/private/player_hero/"

    -- 全屏
    local CloseLayout = GUI:Layout_Create(parent, "CloseLayout", 0, 0, screenW, screenH)

    -- 容器
    local HeroPanel = GUI:Layout_Create(parent, "HeroPanel", 275, 615, 201, 94)
    GUI:setAnchorPoint(HeroPanel, 0, 1)
    GUI:setTouchEnabled(HeroPanel, true)

    local BtnHero = GUI:Button_Create(parent, "BtnHero", 865, 450, _PathRes .. "btn_login1.png")
    GUI:Button_loadTexturePressed(BtnHero, _PathRes .. "btn_login2.png")
    GUI:setAnchorPoint(BtnHero, 0.5, 0.5)

    local BtnLock = GUI:Button_Create(parent, "BtnLock", 865, 340, _PathRes .. "btn_heji_05_1.png")
    GUI:Button_loadTexturePressed(BtnLock, _PathRes .. "btn_heji_05_1.png")
    GUI:Button_loadTextureDisabled(BtnLock, _PathRes .. "btn_heji_05.png")
    GUI:setAnchorPoint(BtnLock, 0.5, 0.5)

    local BtnBag = GUI:Button_Create(HeroPanel, "BtnBag", 135, -13, _PathRes .. "btn_bag1.png")
    GUI:Button_loadTexturePressed(BtnBag, _PathRes .. "btn_bag2.png")
    GUI:setAnchorPoint(BtnBag, 0.5, 0.5)

    local BtnState = GUI:Button_Create(HeroPanel, "BtnState", 45, -13, _PathRes .. "btn_state1.png")
    GUI:Button_loadTexturePressed(BtnState, _PathRes .. "btn_state2.png")
    GUI:setAnchorPoint(BtnState, 0.5, 0.5)

    -- 背景
    GUI:Image_Create(HeroPanel, "PanelBG", 4, 5, _PathRes .. "00010.png")

    -- 头像
    local Head = GUI:Image_Create(HeroPanel, "Head", 42, 42,  _PathRes .. "01210.png")
    GUI:setAnchorPoint(Head, 0.5, 0.5)

    -- 名字
    local Name = GUI:Text_Create(HeroPanel, "Name", 133, 79, 14, "#FFFFFF", "哈哈哈")
    GUI:setAnchorPoint(Name, 0.5, 0.5)

    -- 等级
    local lvBg = GUI:Image_Create(HeroPanel, "lvBg", 16, 16,  _PathRes .. "btn_heji_01.png")
    GUI:setAnchorPoint(lvBg, 0.5, 0.5)
    local Level = GUI:Text_Create(HeroPanel, "Level", 16, 16, 14, "#FFFFFF", "0")
    GUI:setAnchorPoint(Level, 0.5, 0.5)

    -- HP
    local HpBar = GUI:LoadingBar_Create(HeroPanel, "HpBar", 136, 63, _PathRes .. "01061.png", 0)
    GUI:setAnchorPoint(HpBar, 0.5, 0.5)
    -- MP
    local MpBar = GUI:LoadingBar_Create(HeroPanel, "MpBar", 139, 50.5, _PathRes .. "01062.png", 0)
    GUI:setAnchorPoint(MpBar, 0.5, 0.5)
    -- EXP
    local ExpBar = GUI:LoadingBar_Create(HeroPanel, "ExpBar", 140, 37.5, _PathRes .. "01064.png", 0)
    GUI:setAnchorPoint(ExpBar, 0.5, 0.5)

    -- 英雄信息点击层
    local PanelInfo = GUI:Layout_Create(HeroPanel, "PanelInfo", 76, 8, 124, 82, true)
    GUI:setTouchEnabled(PanelInfo, true)

    -- 忠字
    local ImageZ1 = GUI:Image_Create(HeroPanel, "ImageZ1", 92, 21,  _PathRes .. "btn_heji_07.png")
    GUI:setAnchorPoint(ImageZ1, 0.5, 0.5)
    local ImageZ2 = GUI:Image_Create(HeroPanel, "ImageZ2", 132, 21,  _PathRes .. "btn_heji_06.png")
    GUI:setAnchorPoint(ImageZ2, 0.5, 0.5)
    local Text_Z = GUI:Text_Create(HeroPanel, "Text_Z", 132, 21, 14, "#ffffff", "")
    GUI:setAnchorPoint(Text_Z, {x=0.5, y=0.5})

    -- 状态
    local StateBg = GUI:Image_Create(HeroPanel, "StateBg", 181, 21,  _PathRes .. "btn_heji_02.png")
    GUI:setAnchorPoint(StateBg, 0.5, 0.5)
    local Text_State = GUI:Text_Create(HeroPanel, "Text_State", 181, 21, 14, "#ffffff", "")
    GUI:setAnchorPoint(Text_State, {x=0.5, y=0.5})
end