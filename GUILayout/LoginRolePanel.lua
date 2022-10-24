LoginRolePanel = {}

LoginRolePanel.animLightID  = {4121, 4127, 4123, 4129, 4125, 4131}      -- 人物常亮动画id  顺序：男战士、女战士、男法师、女法师、男道士、女道士
LoginRolePanel.animGToLID   = {4122, 4128, 4124, 4130, 4126, 4132}      -- 人物灰到亮动画id   
LoginRolePanel.animPos      = {x=0, y=170}                              -- 人物特效位置    (基于 Node_anim_1/2)

function LoginRolePanel.main()
    local parent = GUI:Attach_Parent()
    if not parent then
        return
    end

    local fontSize = 16

    local screenW = SL:GetScreenWidth()
    local screenH = SL:GetScreenHeight()

    local Panel_touch = GUI:Layout_Create(parent, "Panel_touch", 0, 0, screenW, screenH)
    GUI:setTouchEnabled(Panel_touch, true)

    local Panel_bg = GUI:Layout_Create(parent, "Panel_bg", screenW/2, screenH/2, 1136, 640)
    GUI:setAnchorPoint(Panel_bg, 0.5, 0.5)
    GUI:setTouchEnabled(Panel_bg, true)
    GUI:Layout_setBackGroundImage(Panel_bg, "res/private/login/bg_cjzy_02.jpg")

    local parentSize = GUI:getContentSize(Panel_bg)
    local pW   = parentSize.width
    local pH   = parentSize.height
    local Image_server_bg = GUI:Image_Create(Panel_bg, "Image_server_bg", pW/2, pH, "res/private/login/bg_cjzy_05.png")
    GUI:setAnchorPoint(Image_server_bg, {x=0.5, y=1})

    local Text_server_name = GUI:Text_Create(Panel_bg, "Text_server_name", pW/2, pH - 13, 15, "#FFFFFF", "服务器名")
    GUI:setAnchorPoint(Text_server_name, {x=0.5, y=0.5})

    local Panel_role_1 = GUI:Layout_Create(Panel_bg, "Panel_role_1", pW/2, 595, 350, 400)
    GUI:setAnchorPoint(Panel_role_1, {x=1, y=1})
    GUI:setTouchEnabled(Panel_role_1, true)

    local Image_1 = GUI:Image_Create(Panel_role_1, "Image_1", 175, 200, "res/private/login/bg_cjzy_03.png")
    GUI:setAnchorPoint(Image_1, {x=0.5, y=0.5})

    local Node_anim_1 = GUI:Node_Create(Panel_role_1, "Node_anim_1", 175, 0)

    local Panel_role_2 = GUI:Layout_Create(Panel_bg, "Panel_role_2", pW/2, 595, 350, 400)
    GUI:setAnchorPoint(Panel_role_2, {x=0, y=1})
    GUI:setTouchEnabled(Panel_role_2, true)

    local Image_2= GUI:Image_Create(Panel_role_2, "Image_2", 175, 200, "res/private/login/bg_cjzy_04.png")
    GUI:setAnchorPoint(Image_2, {x=0.5, y=0.5})

    local Node_anim_2 = GUI:Node_Create(Panel_role_2, "Node_anim_2", 175, 0)

    local Panel_info_1 = GUI:Layout_Create(Panel_bg, "Panel_info_1", pW/4, 0, 210, 200)
    GUI:setAnchorPoint(Panel_info_1, {x=0.5, y=0})
    
    local Img_infoBg_1 = GUI:Image_Create(Panel_info_1, "Img_infoBg_1", 105, 100, "res/private/login/bg_cjzy_01.png")
    GUI:setAnchorPoint(Img_infoBg_1, {x=0.5, y=0.5})

    local Image_3 = GUI:Image_Create(Panel_info_1, "Image_3", 45, 140, "res/private/login/word_cjzy_04.png")
    GUI:setAnchorPoint(Image_3, {x=0.5, y=0.5})

    local Button_select_1 = GUI:Button_Create(Panel_info_1, "Button_select_1", 140, 140, "res/private/login/btn_cjzy_01.png")
    GUI:setAnchorPoint(Button_select_1, {x=0.5, y=0.5})  
    GUI:Button_loadTexturePressed(Button_select_1, "res/private/login/btn_cjzy_01_1.png")
    GUI:Button_setTitleColor(Button_select_1, "#FFFFFF")
    GUI:Button_setTitleFontSize(Button_select_1, fontSize)
    GUI:Button_setTitleText(Button_select_1, "选 择")

    local Text_info1 = GUI:Text_Create(Panel_info_1, "Text_info1", 20, 105, fontSize, "#b0977a")
    GUI:setAnchorPoint(Text_info1, {x=0, y=0.5})
    GUI:Text_setString(Text_info1, "名字")
    GUI:Text_enableOutline(Text_info1, "#111111", 2)

    local Text_info1_0 = GUI:Text_Create(Panel_info_1, "Text_info1_0", 20, 77, fontSize, "#b0977a")
    GUI:setAnchorPoint(Text_info1_0, {x=0, y=0.5})
    GUI:Text_setString(Text_info1_0, "等级")
    GUI:Text_enableOutline(Text_info1_0, "#111111", 2)

    local Text_info1_1 = GUI:Text_Create(Panel_info_1, "Text_info1_1", 20, 50, fontSize, "#b0977a")
    GUI:setAnchorPoint(Text_info1_1, {x=0, y=0.5})
    GUI:Text_setString(Text_info1_1, "职业")
    GUI:Text_enableOutline(Text_info1_1, "#111111", 2)

    local Image_10 = GUI:Image_Create(Panel_info_1, "Image_10", 65, 105, "res/private/login/bg_cjzy_00.png")
    GUI:setAnchorPoint(Image_10, {x=0, y=0.5})
    GUI:setContentSize(Image_10, {width=120, height=20})
    local Image_11 = GUI:Image_Create(Panel_info_1, "Image_11", 65, 77, "res/private/login/bg_cjzy_00.png")
    GUI:setAnchorPoint(Image_11, {x=0, y=0.5})
    GUI:setContentSize(Image_11, {width=120, height=20})
    local Image_12 = GUI:Image_Create(Panel_info_1, "Image_12", 65, 50, "res/private/login/bg_cjzy_00.png")
    GUI:setAnchorPoint(Image_12, {x=0, y=0.5})
    GUI:setContentSize(Image_12, {width=120, height=20})

    local Text_name_1 = GUI:Text_Create(Panel_info_1, "Text_name_1", 70, 105, fontSize, "#FFFFFF")
    GUI:setAnchorPoint(Text_name_1, {x=0, y=0.5})
    GUI:Text_setString(Text_name_1, "传奇经典")

    local Text_level_1 = GUI:Text_Create(Panel_info_1, "Text_level_1", 70, 77, fontSize, "#FFFFFF")
    GUI:setAnchorPoint(Text_level_1, {x=0, y=0.5})
    GUI:Text_setString(Text_level_1, "9级")

    local Text_job_1 = GUI:Text_Create(Panel_info_1, "Text_job_1", 70, 50, fontSize, "#FFFFFF")
    GUI:setAnchorPoint(Text_job_1, {x=0, y=0.5})
    GUI:Text_setString(Text_job_1, "战士")

    --
    local Panel_info_2 = GUI:Layout_Create(Panel_bg, "Panel_info_2", pW*3/4, 0, 210, 200)
    GUI:setAnchorPoint(Panel_info_2, {x=0.5, y=0})
    
    local Img_infoBg_2 = GUI:Image_Create(Panel_info_2, "Img_infoBg_2", 105, 100, "res/private/login/bg_cjzy_01_1.png")
    GUI:setAnchorPoint(Img_infoBg_2, {x=0.5, y=0.5})

    local Image_4 = GUI:Image_Create(Panel_info_2, "Image_4", 45, 140, "res/private/login/word_cjzy_05.png")
    GUI:setAnchorPoint(Image_4, {x=0.5, y=0.5})

    local Button_select_2 = GUI:Button_Create(Panel_info_2, "Button_select_2", 140, 140, "res/private/login/btn_cjzy_02.png")
    GUI:setAnchorPoint(Button_select_2, {x=0.5, y=0.5})  
    GUI:Button_loadTexturePressed(Button_select_2, "res/private/login/btn_cjzy_02_1.png")
    GUI:Button_setTitleColor(Button_select_2, "#FFFFFF")
    GUI:Button_setTitleFontSize(Button_select_2, fontSize)
    GUI:Button_setTitleText(Button_select_2, "选 择")

    local Text_info2 = GUI:Text_Create(Panel_info_2, "Text_info2", 20, 105, fontSize, "#b0977a")
    GUI:setAnchorPoint(Text_info2, {x=0, y=0.5})
    GUI:Text_setString(Text_info2, "名字")
    GUI:Text_enableOutline(Text_info2, "#111111", 2)

    local Text_info2_0 = GUI:Text_Create(Panel_info_2, "Text_info2_0", 20, 77, fontSize, "#b0977a")
    GUI:setAnchorPoint(Text_info2_0, {x=0, y=0.5})
    GUI:Text_setString(Text_info2_0, "等级")
    GUI:Text_enableOutline(Text_info2_0, "#111111", 2)

    local Text_info2_1 = GUI:Text_Create(Panel_info_2, "Text_info2_1", 20, 50, fontSize, "#b0977a")
    GUI:setAnchorPoint(Text_info2_1, {x=0, y=0.5})
    GUI:Text_setString(Text_info2_1, "职业")
    GUI:Text_enableOutline(Text_info2_1, "#111111", 2)

    local Image_13 = GUI:Image_Create(Panel_info_2, "Image_13", 65, 105, "res/private/login/bg_cjzy_00.png")
    GUI:setAnchorPoint(Image_13, {x=0, y=0.5})
    GUI:setContentSize(Image_13, {width=120, height=20})
    local Image_14 = GUI:Image_Create(Panel_info_2, "Image_14", 65, 77, "res/private/login/bg_cjzy_00.png")
    GUI:setAnchorPoint(Image_14, {x=0, y=0.5})
    GUI:setContentSize(Image_14, {width=120, height=20})
    local Image_15 = GUI:Image_Create(Panel_info_2, "Image_15", 65, 50, "res/private/login/bg_cjzy_00.png")
    GUI:setAnchorPoint(Image_15, {x=0, y=0.5})
    GUI:setContentSize(Image_15, {width=120, height=20})

    local Text_name_2 = GUI:Text_Create(Panel_info_2, "Text_name_2", 70, 105, fontSize, "#FFFFFF")
    GUI:setAnchorPoint(Text_name_2, {x=0, y=0.5})
    GUI:Text_setString(Text_name_2, "传奇经典")

    local Text_level_2 = GUI:Text_Create(Panel_info_2, "Text_level_2", 70, 77, fontSize, "#FFFFFF")
    GUI:setAnchorPoint(Text_level_2, {x=0, y=0.5})
    GUI:Text_setString(Text_level_2, "9级")

    local Text_job_2 = GUI:Text_Create(Panel_info_2, "Text_job_2", 70, 50, fontSize, "#FFFFFF")
    GUI:setAnchorPoint(Text_job_2, {x=0, y=0.5})
    GUI:Text_setString(Text_job_2, "战士")

    --
    local Panel_act = GUI:Layout_Create(Panel_bg, "Panel_act", pW/2, 0, 350, 200)
    GUI:setAnchorPoint(Panel_act, {x=0.5, y=0})

    local Image_5 = GUI:Image_Create(Panel_act, "Image_5", 175, 100, "res/private/login/bg_cjzy_01_2.png")
    GUI:setAnchorPoint(Image_5, {x=0.5, y=0.5})

    local Button_start = GUI:Button_Create(Panel_act, "Button_start", 175, 144, "res/private/login/btn_kqyx_01.png")
    GUI:setAnchorPoint(Button_start, {x=0.5, y=0.5})  
    GUI:Button_loadTexturePressed(Button_start, "res/private/login/btn_fhyx_01_1.png")
    GUI:Button_setTitleColor(Button_start, "#FFFFFF")
    GUI:Button_setTitleFontSize(Button_start, fontSize)
    GUI:Button_setTitleText(Button_start, "开  始")

    local Button_leave = GUI:Button_Create(Panel_act, "Button_leave", 276, 100, "res/private/login/btn_fhyx_01.png")
    GUI:setAnchorPoint(Button_leave, {x=0.5, y=0.5})  
    GUI:Button_loadTexturePressed(Button_leave, "res/private/login/btn_fhyx_01_1.png")
    GUI:Button_setTitleColor(Button_leave, "#FFFFFF")
    GUI:Button_setTitleFontSize(Button_leave, fontSize)
    GUI:Button_setTitleText(Button_leave, "返  回")

    local Button_create = GUI:Button_Create(Panel_act, "Button_create", 74, 100, "res/private/login/btn_hfrw_01.png")
    GUI:setAnchorPoint(Button_create, {x=0.5, y=0.5})  
    GUI:Button_loadTexturePressed(Button_create, "res/private/login/btn_fhyx_01_1.png")
    GUI:Button_setTitleColor(Button_create, "#FFFFFF")
    GUI:Button_setTitleFontSize(Button_create, fontSize)
    GUI:Button_setTitleText(Button_create, "创建人物")

    local Button_delete = GUI:Button_Create(Panel_act, "Button_delete", 175, 100, "res/private/login/btn_scrw_01.png")
    GUI:setAnchorPoint(Button_delete, {x=0.5, y=0.5})  
    GUI:Button_loadTexturePressed(Button_delete, "res/private/login/btn_fhyx_01_1.png")
    GUI:Button_setTitleColor(Button_delete, "#FFFFFF")
    GUI:Button_setTitleFontSize(Button_delete, fontSize)
    GUI:Button_setTitleText(Button_delete, "删除人物")

    local Button_restore = GUI:Button_Create(Panel_act, "Button_restore", 175, 56, "res/private/login/btn_hfrw_01.png")
    GUI:setAnchorPoint(Button_restore, {x=0.5, y=0.5})  
    GUI:Button_loadTexturePressed(Button_restore, "res/private/login/btn_fhyx_01_1.png")
    GUI:Button_setTitleColor(Button_restore, "#FFFFFF")
    GUI:Button_setTitleFontSize(Button_restore, fontSize)
    GUI:Button_setTitleText(Button_restore, "恢复人物")

end

function LoginRolePanel.createRole( parent )
    if not parent then
        return
    end

    local screenW = SL:GetScreenWidth()
    local screenH = SL:GetScreenHeight()

    local offsetY = (screenH - 640)/2
    local Panel_role  = GUI:Layout_Create(parent, "Panel_role", screenW/2, screenH/2, screenW, screenH)
    GUI:setAnchorPoint(Panel_role, 0.5, 0.5)

    local Panel_anim = GUI:Layout_Create(Panel_role, "Panel_anim", screenW/2, 595 + offsetY, 350, 400)
    GUI:setAnchorPoint(Panel_anim, {x=1, y=1})
    
    local Node_anim = GUI:Node_Create(Panel_anim, "Node_anim", 175, 0)
    
    local Panel_info = GUI:Layout_Create(Panel_role, "Panel_info", screenW/2, 595 + offsetY, 350, 420)
    GUI:setAnchorPoint(Panel_info, {x=0, y=1})

    local Image_2 = GUI:Image_Create(Panel_info, "Image_2", 175, 210, "res/private/login/bg_cjzy_06.png")
    GUI:setAnchorPoint(Image_2, {x=0.5, y=0.5})

    local Button_close = GUI:Button_Create(Panel_info, "Button_close", 286, 387, "res/public/btn_normal_2.png")
    GUI:setAnchorPoint(Button_close, 0.5, 0.5)
    GUI:Button_loadTexturePressed(Button_close, "res/public/btn_pressed_2.png")

    local Image_7 = GUI:Image_Create(Panel_info, "Image_7", 157, 350, "res/private/login/word_cjzy_01.png")
    GUI:setAnchorPoint(Image_7, 0.5, 0.5)

    local Image_8 = GUI:Image_Create(Panel_info, "Image_8", 157, 310, "res/private/login/bg_cjzy_00.png")
    GUI:setAnchorPoint(Image_8, 0.5, 0.5)

    local TextInput_name = GUI:TextInput_Create(Panel_info, "TextInput_name", 149, 310, 140, 28, 20)
    GUI:setAnchorPoint(TextInput_name, 0.5, 0.5)
    GUI:TextInput_setFontColor(TextInput_name, "#FFFFFF")
    GUI:TextInput_setString(TextInput_name, "玩家名字")
    GUI:TextInput_setMaxLength(TextInput_name, 7)
    
    local Button_rand = GUI:Button_Create(Panel_info, "Button_rand", 235, 310, "res/private/login/btn_cjzy_03.png")
    GUI:setAnchorPoint(Button_rand, 0.5, 0.5)
    GUI:Button_loadTexturePressed(Button_rand, "res/private/login/btn_cjzy_03_1.png")

    local Image_7_0 = GUI:Image_Create(Panel_info, "Image_7_0", 157, 255, "res/private/login/word_cjzy_02.png")
    GUI:setAnchorPoint(Image_7_0, 0.5, 0.5)

    local Button_job_1 = GUI:Button_Create(Panel_info, "Button_job_1", 90, 210, "res/private/login/icon_cjzy_01.png")
    GUI:setAnchorPoint(Button_job_1, 0.5, 0.5)
    GUI:Button_loadTextureDisabled(Button_job_1, "res/private/login/icon_cjzy_01_1.png")

    local Button_job_2 = GUI:Button_Create(Panel_info, "Button_job_2", 136, 210, "res/private/login/icon_cjzy_02.png")
    GUI:setAnchorPoint(Button_job_2, 0.5, 0.5)
    GUI:Button_loadTextureDisabled(Button_job_2, "res/private/login/icon_cjzy_02_1.png")

    local Button_job_3 = GUI:Button_Create(Panel_info, "Button_job_3", 182, 210, "res/private/login/icon_cjzy_03.png")
    GUI:setAnchorPoint(Button_job_3, 0.5, 0.5)
    GUI:Button_loadTextureDisabled(Button_job_3, "res/private/login/icon_cjzy_03_1.png")

    local Button_job_4 = GUI:Button_Create(Panel_info, "Button_job_4", 229, 210, "res/private/login/icon_cjzy_04.png")
    GUI:setAnchorPoint(Button_job_4, 0.5, 0.5)
    GUI:Button_loadTexturePressed(Button_job_4, "res/private/login/icon_cjzy_04.png")

    local Image_7_0_0 = GUI:Image_Create(Panel_info, "Image_7_0_0", 157, 150, "res/private/login/word_cjzy_03.png")
    GUI:setAnchorPoint(Image_7_0_0, 0.5, 0.5)

    local Button_sex_1 = GUI:Button_Create(Panel_info, "Button_sex_1", 136, 105, "res/private/login/icon_cjzy_06.png")
    GUI:setAnchorPoint(Button_sex_1, 0.5, 0.5)
    GUI:Button_loadTextureDisabled(Button_sex_1, "res/private/login/icon_cjzy_06_1.png")

    local Button_sex_2 = GUI:Button_Create(Panel_info, "Button_sex_2", 182, 105, "res/private/login/icon_cjzy_05.png")
    GUI:setAnchorPoint(Button_sex_2, 0.5, 0.5)
    GUI:Button_loadTextureDisabled(Button_sex_2, "res/private/login/icon_cjzy_05_1.png")

    local Button_submit = GUI:Button_Create(Panel_info, "Button_submit", 157, 45, "res/private/login/btn_fhyx_01.png")
    GUI:setAnchorPoint(Button_submit, 0.5, 0.5)
    GUI:Button_loadTexturePressed(Button_submit, "res/private/login/btn_fhyx_01_1.png")
    GUI:Button_setTitleColor(Button_submit, "#FFFFFF")
    GUI:Button_setTitleFontSize(Button_submit, 14)
    GUI:Button_setTitleText(Button_submit, "提 交")

end

function LoginRolePanel.createRestore( parent )
    if not parent then
        return
    end

    local screenW = SL:GetScreenWidth()
    local screenH = SL:GetScreenHeight()

    local Panel_1 = GUI:Layout_Create(parent, "Panel_1", screenW/2, 570, 350, 420)
    GUI:setAnchorPoint(Panel_1, 1, 1)
    GUI:Layout_setBackGroundColor(Panel_1, "#4D4D4D")
    GUI:Layout_setBackGroundColorType(Panel_1, 1)
    GUI:Layout_setBackGroundColorOpacity(Panel_1, 102)

    local Text_1 = GUI:Text_Create(Panel_1, "Text_1", 80, 400, 20, "#FFFFFF", "角色名字")
    GUI:setAnchorPoint(Text_1, 0.5, 0.5)

    local Text_1_0 = GUI:Text_Create(Panel_1, "Text_1_0", 200, 400, 20, "#FFFFFF", "等级")
    GUI:setAnchorPoint(Text_1_0, 0.5, 0.5)

    local ListView_1 = GUI:ListView_Create(Panel_1, "ListView_1", 19, 12, 300, 360, 1)
    GUI:setAnchorPoint(ListView_1, 0, 0)
    GUI:ListView_setItemsMargin(ListView_1, 8)
    GUI:ListView_setClippingEnabled(ListView_1, true)

    local restore_cell = GUI:Layout_Create(Panel_1, "restore_cell", 0, 0, 300, 30)
    GUI:setVisible(restore_cell, false)
    GUI:Layout_setBackGroundColor(restore_cell, "#8B6914")
    GUI:Layout_setBackGroundColorType(restore_cell, 1)
    GUI:Layout_setBackGroundColorOpacity(restore_cell, 102)

    local Text_name = GUI:Text_Create(restore_cell, "Text_name", 15, 15, 20, "#FFFFFF", "-")
    GUI:setAnchorPoint(Text_name, 0, 0.5)

    local Text_level = GUI:Text_Create(restore_cell, "Text_level", 170, 15, 20, "#FFFFFF", "-")
    GUI:setAnchorPoint(Text_level, 0, 0.5)

    local btn_restore = GUI:Button_Create(restore_cell, "btn_restore", 255, 15, "Default/Button_Normal.png")
    GUI:setAnchorPoint(btn_restore, 0.5, 0.5)
    GUI:setContentSize(btn_restore, {width = 80, height = 28})
    GUI:Button_setTitleColor(btn_restore, "#f8e6c6")
    GUI:Button_setTitleFontSize(btn_restore, 18)
    GUI:Button_setTitleText(btn_restore, "恢复角色")
    GUI:Button_titleEnableOutline(btn_restore, "#111111", 2)
    GUI:Button_setScale9Slice(btn_restore, 15, 49, 11, 3)


    local Button_close = GUI:Button_Create(Panel_1, "Button_close", 330, 400, "res/public/btn_normal_2.png")
    GUI:setAnchorPoint(Button_close, 0.5, 0.5)
    GUI:Button_loadTexturePressed(Button_close, "res/public/btn_pressed_2.png")
end