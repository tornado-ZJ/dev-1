MainSkill = {}

MainSkill.ui = {
    button = {
        juese = "res/ui/01/bottom/1900013010.png", --角色
        beibao = "res/ui/01/bottom/1900013011.png", --背包
        jineng = "res/ui/01/bottom/1900013012.png", --技能
        hanghui = "res/ui/01/bottom/1900013013.png", --行会
        zudui = "res/ui/01/bottom/1900013014.png", --组队
        jiaoyi = "res/ui/01/bottom/1900013015.png", --交易
        baitan = "res/ui/01/bottom/1900013016.png", --摆摊
        shezhi = "res/ui/01/bottom/1900013017.png", --设置
        tuichu = "res/ui/01/bottom/1900013018.png", --退出
        paimaihang = "res/ui/01/bottom/1900013019.png", --拍卖行
        qiangxing = "res/ui/01/bottom/1900013020.png", --强星
        fujin = "res/ui/01/bottom/1900013020.png", --附近
        jiaoyihang = "res/ui/01/bottom/jiaoyihang.png", --交易行
        haoyou = "res/ui/01/bottom/1900012583.png", --好友
        paihangbang = "res/ui/01/bottom/1900012587.png", --排行榜
        shejiao = "res/ui/01/bottom/1900012589.png", --社交
        youjian = "res/ui/01/bottom/1900012590.png", --邮件
        zhuansheng = "res/ui/01/bottom/1900012592.png", --转生
        zhuangban = "res/ui/01/bottom/1900012593.png", --装扮
        shangcheng = "res/ui/01/bottom/1900012595.png", --商城
        hecheng = "res/ui/01/bottom/1900012596.png", --合成
        cangku = "res/ui/01/bottom/1900012597.png", --仓库
        ronglu = "res/ui/01/bottom/1900012598.png", --熔炉
        qiehuan1 = "res/ui/01/bottom/1900012538.png", --切换1
        qiehuan2 = "res/ui/01/bottom/1900012580.png", --切换2
        guaji1 = "res/ui/01/bottom/1900012708.png", --挂机1
        guaji2 = "res/ui/01/bottom/1900012709.png", --挂机2
        shiqu1 = "res/ui/01/bottom/btn_zhijiemian_05.png", --拾取1
        shiqu2 = "res/ui/01/bottom/btn_zhijiemian_06.png", --拾取2
        jinengkuang = "res/ui/01/bottom/1900012017.png", --技能框
    }
}

MainSkill.skillSfx = {     -- 技能特效 press:按下 select:选择/开启
    press = 4001,
    select = 4005,
    mainPress = 4002
}

function MainSkill.main()
    local parent = GUI:Attach_Parent()
    local screenW = SL:GetScreenWidth()
    local screenH = SL:GetScreenHeight()
    -- 技能模块
    local Panel_skill = GUI:Layout_Create(parent, "Panel_skill", 0, 0, 320, 260)
    GUI:setAnchorPoint(Panel_skill, 1, 0)

    local Node_skill_1 = GUI:Node_Create(Panel_skill, "Node_skill_1", 241, 86.5)

    local Node_skill_2 = GUI:Node_Create(Panel_skill, "Node_skill_2", 130, 31.5)

    local Node_skill_3 = GUI:Node_Create(Panel_skill, "Node_skill_3", 142.5, 109)

    local Node_skill_4 = GUI:Node_Create(Panel_skill, "Node_skill_4", 186, 177.5)

    local Node_skill_5 = GUI:Node_Create(Panel_skill, "Node_skill_5", 260, 212)

    local Node_skill_6 = GUI:Node_Create(Panel_skill, "Node_skill_6", 51, 41.5)

    local Node_skill_7 = GUI:Node_Create(Panel_skill, "Node_skill_7", 62, 114)

    local Node_skill_8 = GUI:Node_Create(Panel_skill, "Node_skill_8", 93, 183.5)

    local Node_skill_9 = GUI:Node_Create(Panel_skill, "Node_skill_9", 147, 243.5)

    local Panel_quick_find = GUI:Layout_Create(Panel_skill, "Panel_quick_find", 240, 85, 120, 120)
    GUI:setAnchorPoint(Panel_quick_find, 0.5, 0.5)
    GUI:setTouchEnabled(Panel_quick_find, true)

    local Image_player = GUI:Image_Create(Panel_quick_find, "Image_player", 120, 120, "res/private/main/Skill/1900012706.png")
    GUI:setAnchorPoint(Image_player, 1, 1)

    local Image_monster = GUI:Image_Create(Panel_quick_find, "Image_monster", 0, 0, "res/private/main/Skill/1900012704.png")
    GUI:setAnchorPoint(Image_monster, 0, 0)

    local Image_hero = GUI:Image_Create(Panel_quick_find, "Image_hero", 0, 120, "res/private/main/Skill/1900012710.png")
    GUI:setAnchorPoint(Image_hero, 0, 1)

    local Button_attack = GUI:Button_Create(Panel_skill, "Button_attack", 320, 0, "res/private/main/Skill/icon_sifud_02.png")
    GUI:setAnchorPoint(Button_attack, 1, 0)
    GUI:Button_loadTexturePressed(Button_attack, "res/private/main/Skill/icon_sifud_03.png")

    local Panel_hide = GUI:Layout_Create(parent, "Panel_hide", 0, 0, screenW, screenH)
    GUI:setAnchorPoint(Panel_hide, 1, 0)
    GUI:setTouchEnabled(Panel_hide, true)

    -- 按钮模块
    local Panel_button = GUI:Layout_Create(parent, "Panel_button", 0, 0, 225, 355)
    GUI:setAnchorPoint(Panel_button, 1, 0)

    local Panel_constant = GUI:Layout_Create(Panel_button, "Panel_constant", 225, 345, 225, 70)
    GUI:setAnchorPoint(Panel_constant, 1, 1)

    local Button_change = GUI:Button_Create(Panel_constant, "Button_change", 225, 35, MainSkill.ui.button.qiehuan2)
    GUI:setAnchorPoint(Button_change, 1, 0.5)
    GUI:Button_loadTexturePressed(Button_change, MainSkill.ui.button.qiehuan2)

    local Image_change_act = GUI:Image_Create(Button_change, "Image_change_act", 30, 33, MainSkill.ui.button.qiehuan1)
    GUI:setAnchorPoint(Image_change_act, 0.5, 0.5)

    -- 装备
    local Panel_role = GUI:Button_Create(Panel_button, "Panel_role", 150, 350, MainSkill.ui.button.juese)
    if Panel_role then
        GUI:setContentSize(Panel_role, { width = 70, height = 70 })
        GUI:addOnClickEvent(Panel_role, function()
            SL:OpenMyPlayerUI()
        end)
    end

    -- 背包
    local Panel_bag = GUI:Button_Create(Panel_button, "Panel_bag", 80, 350, MainSkill.ui.button.beibao)
    if Panel_bag then
        GUI:setContentSize(Panel_bag, { width = 70, height = 70 })
        GUI:addOnClickEvent(Panel_bag, function()
            SL:OpenBagUI()
        end)
    end

    -- 自动挂机
    local Panel_auto = GUI:Button_Create(Panel_button, "Panel_auto", 10, 350, MainSkill.ui.button.guaji1)
    if Panel_auto then
        GUI:setScale(Panel_auto, 1.2)
        GUI:addOnClickEvent(Panel_auto, function()
            if SL:IsAFK() then
                SL:AFKEnd()
            else
                SL:AFKBegin()
            end
        end)

        local function afkUpdate()
            if SL:IsAFK() then
                GUI:Button_loadTextureNormal(Panel_auto, MainSkill.ui.button.guaji2)
            else
                GUI:Button_loadTextureNormal(Panel_auto, MainSkill.ui.button.guaji1)
            end
        end
        SL:RegisterLUAEvent("LUA_EVENT_AFKBEGIN", "11", afkUpdate)
        SL:RegisterLUAEvent("LUA_EVENT_AFKEND", "11", afkUpdate)
    end

    local Panel_active = GUI:Layout_Create(Panel_button, "Panel_active", 0, 285, 225, 280)
    GUI:setAnchorPoint(Panel_active, 0, 1)
    -- 按钮添加到Panel_active

    -- 拾取按钮
    local Button_pick = GUI:Button_Create(parent, "Button_pick", -160, 320, MainSkill.ui.button.shiqu1)
    GUI:setAnchorPoint(Button_pick, 0.5, 0.5)
    GUI:Button_loadTextureDisabled(Button_pick, MainSkill.ui.button.shiqu2)

    -- 英雄合击技能节点
    local Node_hj_skill = GUI:Node_Create(parent, "Node_hj_skill", -345, 244)

    MainSkill.activeUI(parent)
end

function MainSkill.createSkillCell(parent)
    if not parent then
        return
    end
    local Panel_bg = GUI:Layout_Create(parent, "Panel_bg", 0, 0, 65, 65)
    GUI:setAnchorPoint(Panel_bg, 0.5, 0.5)

    local Image_bg = GUI:Image_Create(Panel_bg, "Image_bg", 32.5, 32.5, MainSkill.ui.button.jinengkuang)
    GUI:setAnchorPoint(Image_bg, 0.5, 0.5)

    local skill_icon = GUI:Button_Create(Panel_bg, "skill_icon", 32.5, 32.5, MainSkill.ui.button.jinengkuang)
    GUI:setAnchorPoint(skill_icon, 0.5, 0.5)

    local Node_select = GUI:Node_Create(Panel_bg, "Node_select", 32.5, 32.5)
    local Node_on = GUI:Node_Create(Panel_bg, "Node_on", 32.5, 32.5)

    MainSkill.cdImagePath = "res/private/main/Skill/bg_lsxljm_05.png"
    MainSkill.sfxScale = { 0.9, 0.6 } -- {主技能， 其他} 特效缩放比例
    MainSkill.skillIconSize = { { width = 75, height = 75 }, { width = 55, height = 55 } }  -- {主技能， 其他} 技能图标大小
    MainSkill.skillKey1Bg = "res/ui/01/Skill/030013.png"
end

function MainSkill.activeUI(parent)
    local Panel_active = GUI:GetWindow(parent, "Panel_button/Panel_active")
    if Panel_active then
        --返回
        local actice1 = GUI:Button_Create(Panel_active, "actice1", 150, 0, MainSkill.ui.button.tuichu)
        if actice1 then
            --GUI:setContentSize(actice1, { width = 50, height = 45 })
            GUI:addOnClickEvent(actice1, function()
                SL:OnExitToRoleUI()
            end)
        end
        --设置
        local actice2 = GUI:Button_Create(Panel_active, "actice2", 75, 0, MainSkill.ui.button.shezhi)
        if actice2 then
            GUI:addOnClickEvent(actice2, function()
                SL:OpenSettingUI()
            end)
        end
        --技能
        local actice3 = GUI:Button_Create(Panel_active, "actice3", 0, 0, MainSkill.ui.button.jineng)
        if actice3 then
            GUI:addOnClickEvent(actice3, function()
                SL:OpenSkillSettingUI()
            end)
        end
        --行会
        local actice4 = GUI:Button_Create(Panel_active, "actice4", 150, 70, MainSkill.ui.button.hanghui)
        if actice4 then
            GUI:addOnClickEvent(actice4, function()
                SL:OpenGuildMainUI()
            end)
        end
        --转生  --
        local actice5 = GUI:Button_Create(Panel_active, "actice5", 75, 70, MainSkill.ui.button.zhuansheng)
        if actice5 then
            GUI:addOnClickEvent(actice5, function()
                GUI:Win_Open("A/转生")
            end)
        end
        --商城
        local actice6 = GUI:Button_Create(Panel_active, "actice6", 0, 70, MainSkill.ui.button.shangcheng)
        if actice6 then
            GUI:addOnClickEvent(actice6, function()
                SL:OpenStoreUI()
            end)
        end
        --邮件
        local actice7 = GUI:Button_Create(Panel_active, "actice7", 150, 140, MainSkill.ui.button.youjian)
        if actice7 then
            GUI:addOnClickEvent(actice7, function()
                SL:OpenSocialUI()
            end)
        end
        --时装
        local actice8 = GUI:Button_Create(Panel_active, "actice8", 75, 140, MainSkill.ui.button.zhuangban)
        if actice8 then
            GUI:addOnClickEvent(actice8, function()
                --SL:OpenSettingUI()
            end)
        end
        --拍卖行
        local actice9 = GUI:Button_Create(Panel_active, "actice9", 0, 140, MainSkill.ui.button.paimaihang)
        if actice9 then
            GUI:addOnClickEvent(actice9, function()
                SL:OpenAuctionUI()
            end)
        end
        --排行榜
        local actice11 = GUI:Button_Create(Panel_active, "actice11", 75, 210, MainSkill.ui.button.paihangbang)
        if actice11 then
            GUI:addOnClickEvent(actice11, function()
                SL:OpenRankUI()
            end)
        end
        --合成
        local actice12 = GUI:Button_Create(Panel_active, "actice12", 0, 210, MainSkill.ui.button.hecheng)
        if actice12 then
            GUI:addOnClickEvent(actice12, function()
                GUI:Win_Open("F/合成面板")
            end)
        end
    end
end

function MainSkill.createHeroSkillCell(parent)
    if not parent then
        return
    end
    local Panel_bg = GUI:Layout_Create(parent, "Panel_bg", 0, 0, 65, 65)

    local Image_bg = GUI:Image_Create(Panel_bg, "Image_bg", 32.5, 39, "res/private/main/bg_hejidj_01.png")
    GUI:setAnchorPoint(Image_bg, 0.5, 0.5)

    local Image_progress = GUI:Image_Create(Panel_bg, "Image_progress", 32.5, 32, "res/private/main/bg_hejidj_02.png")
    GUI:setAnchorPoint(Image_progress, 0.5, 0.5)

    local Button_icon = GUI:Button_Create(Panel_bg, "Button_icon", 32.5, 32.5, "res/private/main/bg_hejidj_01.png")
    GUI:setAnchorPoint(Button_icon, 0.5, 0.5)
    GUI:setContentSize(Button_icon, { width = 60, height = 60 })

    -- 特效节点
    local Node_sfx = GUI:Node_Create(Panel_bg, "Node_sfx", 32.5, 32.5)

    MainSkill.heroSfxParam = { 7222, -48, 38 }  -- {合击技能特效id, 坐标X, 坐标Y}
end