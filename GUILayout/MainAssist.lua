MainAssist = {}

MainAssist.jobIconPath = {"res/private/main/assist/1900012533.png", "res/private/main/assist/1900012534.png", "res/private/main/assist/1900012535.png"}
MainAssist.monsterIconPath = "res/private/main/assist/1900012536.png"

function MainAssist.main( ... )
    local parent = GUI:Attach_Parent()

    local Panel_assist = GUI:Layout_Create(parent, "Panel_assist", 0, 0,  244, 188)
    GUI:setAnchorPoint(Panel_assist, 0, 1)
   
    local Panel_content = GUI:Layout_Create(Panel_assist, "Panel_content", 42, 0, 202, 188)
    local Image_1  =  GUI:Image_Create(Panel_content, "Image_1", 101, 94, "res/private/main/assist/1900012571.png")
    GUI:setAnchorPoint(Image_1, 0.5, 0.5)

    -- 任务
    local Panel_mission = GUI:Layout_Create(Panel_content, "Panel_mission", 0, 0, 202, 188)
    local ListView_mission = GUI:ListView_Create(Panel_mission, "ListView_mission", 101, 94, 200, 185, 1)
    GUI:setAnchorPoint(ListView_mission, 0.5, 0.5)
    GUI:ListView_setClippingEnabled(ListView_mission, true)
    GUI:ListView_setGravity(ListView_mission, 0)

    -- 组队
    local Panel_team = GUI:Layout_Create(Panel_content, "Panel_team", 0, 0, 202, 188)
    local Panel_member = GUI:Layout_Create(Panel_team, "Panel_member", 0, 0, 202, 188)
    local Image_2  =  GUI:Image_Create(Panel_member, "Image_2", 101, 190, "res/private/main/assist/1900012571.png")
    GUI:setAnchorPoint(Image_2, 0.5, 1)

    local ListView_member = GUI:ListView_Create(Panel_member, "ListView_member", 101, 187, 200, 157, 1)
    GUI:setAnchorPoint(ListView_member, 0.5, 1)
    GUI:ListView_setClippingEnabled(ListView_member, true)
    GUI:ListView_setGravity(ListView_member, 0)

    local Button_invite = GUI:Button_Create(Panel_member, "Button_invite", 101, 1, "res/private/main/assist/btn_zudui_02.png")
    GUI:setAnchorPoint(Button_invite, 1, 0)
    GUI:Button_loadTexturePressed(Button_invite, "res/private/main/assist/btn_zudui_01.png")
    GUI:Button_setTitleColor(Button_invite, "#FFFFFF")
    GUI:Button_setTitleFontSize(Button_invite, 14)
    GUI:Button_setTitleText(Button_invite, "邀请队员")
    GUI:Button_titleEnableOutline(Button_invite, "#111111", 1)

    local Button_member = GUI:Button_Create(Panel_member, "Button_member", 101, 1, "res/private/main/assist/btn_zudui_02.png")
    GUI:setAnchorPoint(Button_member, 0, 0)
    GUI:Button_loadTexturePressed(Button_member, "res/private/main/assist/btn_zudui_01.png")
    GUI:Button_setTitleColor(Button_member, "#FFFFFF")
    GUI:Button_setTitleFontSize(Button_member, 14)
    GUI:Button_setTitleText(Button_member, "队伍列表")
    GUI:Button_titleEnableOutline(Button_member, "#111111", 1)

    local Panel_empty = GUI:Layout_Create(Panel_team, "Panel_empty", 0, 0, 202, 188)

    local Button_create = GUI:Button_Create(Panel_empty, "Button_create", 101, 132, "res/private/main/assist/1900000652.png")
    GUI:setAnchorPoint(Button_create, 0.5, 0.5)
    GUI:Button_setTitleColor(Button_create, "#f8e6c6")
    GUI:Button_setTitleFontSize(Button_create, 16)
    GUI:Button_setTitleText(Button_create, "创建队伍")
    GUI:Button_titleEnableOutline(Button_create, "#111111", 2)

    local Button_near = GUI:Button_Create(Panel_empty, "Button_near", 101, 75, "res/private/main/assist/1900000653.png")
    GUI:setAnchorPoint(Button_near, 0.5, 0.5)
    GUI:Button_setTitleColor(Button_near, "#f8e6c6")
    GUI:Button_setTitleFontSize(Button_near, 16)
    GUI:Button_setTitleText(Button_near, "附近队伍")
    GUI:Button_titleEnableOutline(Button_near, "#111111", 2)

    -- 人物/怪物
    local Panel_enemy = GUI:Layout_Create(Panel_assist, "Panel_enemy", 42, 0, 202, 188)
    local Image_3  =  GUI:Image_Create(Panel_enemy, "Image_3", 101, 94, "res/private/main/assist/1900012571.png")
    GUI:setAnchorPoint(Image_3, 0.5, 0.5)

    local Panel_player = GUI:Layout_Create(Panel_enemy, "Panel_player", 0, 0, 202, 188)
    local ListView_player = GUI:ListView_Create(Panel_player, "ListView_player", 101, 94, 200, 185, 1)
    GUI:setAnchorPoint(ListView_player, 0.5, 0.5)
    GUI:ListView_setClippingEnabled(ListView_player, true)
    GUI:ListView_setGravity(ListView_player, 0)

    local Panel_monster = GUI:Layout_Create(Panel_enemy, "Panel_monster", 0, 0, 202, 188)
    local ListView_monster = GUI:ListView_Create(Panel_monster, "ListView_monster", 101, 94, 200, 185, 1)
    GUI:setAnchorPoint(ListView_monster, 0.5, 0.5)
    GUI:ListView_setClippingEnabled(ListView_monster, true)
    GUI:ListView_setGravity(ListView_monster, 0)

    -- 切换
    local Panel_group = GUI:Layout_Create(Panel_assist, "Panel_group", 0, 0, 42, 188)
    local BtnG_content = GUI:Layout_Create(Panel_group, "BtnG_content", 0, 0, 42, 188)

    local Button_mission = GUI:Button_Create(BtnG_content, "Button_mission", 21, 105, "res/private/main/assist/1900012554.png")
    GUI:setAnchorPoint(Button_mission, 0.5, 0)
    GUI:Button_loadTexturePressed(Button_mission, "res/private/main/assist/1900012554.png")
    GUI:Button_loadTextureDisabled(Button_mission, "res/private/main/assist/1900012555.png")

    local Button_team = GUI:Button_Create(BtnG_content, "Button_team", 21, 83, "res/private/main/assist/1900012556.png")
    GUI:setAnchorPoint(Button_team, 0.5, 1)
    GUI:Button_loadTexturePressed(Button_team, "res/private/main/assist/1900012556.png")
    GUI:Button_loadTextureDisabled(Button_team, "res/private/main/assist/1900012557.png")

    local BtnG_enemy = GUI:Layout_Create(Panel_group, "BtnG_enemy", 0, 0, 42, 188)
    
    local Button_player = GUI:Button_Create(BtnG_enemy, "Button_player", 21, 105, "res/private/main/assist/1900012550.png")
    GUI:setAnchorPoint(Button_player, 0.5, 0)
    GUI:Button_loadTexturePressed(Button_player, "res/private/main/assist/1900012550.png")
    GUI:Button_loadTextureDisabled(Button_player, "res/private/main/assist/1900012551.png")

    local Button_monster = GUI:Button_Create(BtnG_enemy, "Button_monster", 21, 83, "res/private/main/assist/1900012552.png")
    GUI:setAnchorPoint(Button_monster, 0.5, 1)
    GUI:Button_loadTexturePressed(Button_monster, "res/private/main/assist/1900012552.png")
    GUI:Button_loadTextureDisabled(Button_monster, "res/private/main/assist/1900012553.png")

    local Button_change = GUI:Button_Create(Panel_group, "Button_change", 21, 94, "res/private/main/assist/1900012558.png")
    GUI:setAnchorPoint(Button_change, 0.5, 0.5)
    GUI:Button_loadTexturePressed(Button_change, "res/private/main/assist/1900012559.png")

    -- 隐藏按钮
    local Panel_hide = GUI:Layout_Create(parent, "Panel_hide", 245, 0, 21, 188)
    GUI:setAnchorPoint(Panel_hide, 0, 1)

    local Image_hide_bg = GUI:Image_Create(Panel_hide, "Image_hide_bg", 10.5, 94, "res/private/main/assist/1900012573.png")
    GUI:setAnchorPoint(Image_hide_bg, 0.5, 0.5)

    local Button_hide = GUI:Button_Create(Panel_hide, "Button_hide", 10.5, 94, "res/private/main/assist/1900012566.png")
    GUI:setAnchorPoint(Button_hide, 0.5, 0.5)

    local tSize = GUI:getContentSize(Image_hide_bg)
    GUI:Layout_Create(Button_hide, "TouchSize", -5, -71, tSize.width+5, tSize.height, false)
end

function MainAssist.createMissionCell(parent)
    if not parent then
        return
    end
 
    local mission_cell = GUI:Layout_Create(parent, "mission_cell", 0, 0, 200, 60)
    GUI:setTouchEnabled(mission_cell, true)

    local Button_act = GUI:Button_Create(mission_cell, "Button_act", 100, 30)
    GUI:Button_loadTexturePressed(Button_act, "res/private/main/assist/1900000678.png")
    GUI:setAnchorPoint(Button_act, 0.5, 0.5)
    GUI:setContentSize(Button_act, {width = 200, height = 60})

    local image_line = GUI:Image_Create(mission_cell, "image_line", 100, 0, "res/public/1900000667_1.png")
    GUI:setAnchorPoint(image_line, 0.5, 0)
    GUI:setContentSize(image_line, {width = 200, height = 1})

    local Node_1 = GUI:Node_Create(mission_cell, "Node_1", 10, 55)
    local Node_2 = GUI:Node_Create(mission_cell, "Node_2", 10, 30)

    local Node_sfx = GUI:Node_Create(mission_cell, "Node_sfx", 100, 30)
end

function MainAssist.createTeamMemberCell(parent)
    if not parent then
        return
    end

    local member_cell = GUI:Layout_Create(parent, "member_cell", 0, 0, 200, 50)
    GUI:setTouchEnabled(member_cell, true)

    local Image_job = GUI:Image_Create(member_cell, "Image_job", 25, 30, "res/private/main/assist/1900012536.png")
    GUI:setAnchorPoint(Image_job, 0.5, 0.5)
    
    local Text_level = GUI:Text_Create(member_cell, "Text_level", 25, 10, 16, "#FFFFFF", "Lv:%s")
    GUI:setAnchorPoint(Text_level, 0.5, 0.5)
    GUI:Text_enableOutline(Text_level, "#111111", 1)

    local Text_name = GUI:Text_Create(member_cell, "Text_name", 115, 35, 16, "#FFFFFF", "我是玩家名字名字")
    GUI:setAnchorPoint(Text_name, 0.5, 0.5)
    GUI:Text_enableOutline(Text_name, "#111111", 1)

    local Image_hp = GUI:Image_Create(member_cell, "Image_hp", 115, 20, "res/private/main/assist/1900012530.png")
    GUI:setAnchorPoint(Image_hp, 0.5, 0.5)
    GUI:setContentSize(Image_hp, {width = 132, height = 8})

    local LoadingBar_hp = GUI:LoadingBar_Create(member_cell, "LoadingBar_hp", 115, 20, "res/private/main/assist/1900012532.png", 0)
    GUI:setAnchorPoint(LoadingBar_hp, 0.5, 0.5)
    GUI:setContentSize(LoadingBar_hp, {width = 130, height = 6})

    local Image_mp = GUI:Image_Create(member_cell, "Image_mp", 115, 10, "res/private/main/assist/1900012530.png")
    GUI:setAnchorPoint(Image_mp, 0.5, 0.5)
    GUI:setContentSize(Image_mp, {width = 132, height = 8})

    local LoadingBar_mp = GUI:LoadingBar_Create(member_cell, "LoadingBar_mp", 115, 10, "res/private/main/assist/19000125321.png", 0)
    GUI:setAnchorPoint(LoadingBar_mp, 0.5, 0.5)
    GUI:setContentSize(LoadingBar_mp, {width = 130, height = 6})

    local Image_leader = GUI:Image_Create(member_cell, "Image_leader", 200, 50, "res/private/main/assist/19000125322.png")
    GUI:setAnchorPoint(Image_leader, 1, 1)
    
    local Text_status = GUI:Text_Create(member_cell, "Text_status", 115, 15, 18, "#FFFFFF", "远离")
    GUI:setAnchorPoint(Text_status, 0.5, 0.5)
   
end

function MainAssist.createEnemyCell(parent)
    if not parent then
        return
    end

    local enemy_cell = GUI:Layout_Create(parent, "enemy_cell", 0, 0, 200, 40)
    GUI:setTouchEnabled(enemy_cell, true)
    GUI:setAnchorPoint(enemy_cell, 0.5, 1)

    local Image_target = GUI:Image_Create(enemy_cell, "Image_target", 100, 20, "res/private/main/assist/1900000678.png")
    GUI:setAnchorPoint(Image_target, 0.5, 0.5)
    GUI:setContentSize(Image_target, {width = 200, height = 40})

    local Image_icon = GUI:Image_Create(enemy_cell, "Image_icon", 35, 20, "res/private/main/assist/1900012534.png")
    GUI:setAnchorPoint(Image_icon, 0.5, 0.5)
    GUI:setContentSize(Image_icon, {width = 28, height = 28})

    local Image_name = GUI:Image_Create(enemy_cell, "Image_name", 120, 33, "res/private/main/assist/1900012531.png")
    GUI:setAnchorPoint(Image_name, 0.5, 1)
    GUI:setContentSize(Image_name, {width = 132, height = 18})

    local Text_name = GUI:Text_Create(enemy_cell, "Text_name", 120, 25, 16, "#FFFFFF", "xxxxx")
    GUI:setAnchorPoint(Text_name, 0.5, 0.5)
    GUI:Text_enableOutline(Text_name, "#111111", 1)

    local Image_hp = GUI:Image_Create(enemy_cell, "Image_hp", 120, 10, "res/private/main/assist/1900012531.png")
    GUI:setAnchorPoint(Image_hp, 0.5, 0.5)
    GUI:setContentSize(Image_hp, {width = 132, height = 8})

    local LoadingBar_hp = GUI:LoadingBar_Create(enemy_cell, "LoadingBar_hp", 120, 10, "res/private/main/assist/1900012532.png", 0)
    GUI:setAnchorPoint(LoadingBar_hp, 0.5, 0.5)
    GUI:setContentSize(LoadingBar_hp, {width = 130, height = 6})
 

end