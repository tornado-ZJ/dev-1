zhuanshengzhili = {}
local cfg = {
    name = "转生之力",
    shuxing = {
        [1] = {
            [1] = 1,
            [2] = 1000,
        },
    },
    effectid = 30111,
    msg = {
        rmbbuzu = '{"Msg":"<font color=\'#ff0000\'>RMB点不足！</font>","Type":9}',
        juanxianchenggong = '{"Msg":"<font color=\'#ff0000\'>开启狂暴成功！</font>","Type":9}',
    },
}

local GUIparent = ""
local Win_W, Win_H = 815, 575

zhuanshengzhili.main = function()
    SL:print("111")
    SL:SubmitForm("A/转生之力", "SyncResponse")
    SL:print(222)
end
zhuanshengzhili.main()
----同步信息
function zhuanshengzhili.SyncResponse(data)
    --SL:print("SyncResponse")
    print(data)
    if not GUI:GetWindow(nil, "leiming") then
        zhuanshengzhili.createUI()
    else
        zhuanshengzhili.updateUI()
    end
end

zhuanshengzhili.createUI = function()
    local _parent = GUI:Win_Create("zhuanshengzhili", 0, 0, 0, 0, false, false, true, false)
    if _parent then
        GUIparent = _parent
        GUI:Timeline_Window1(_parent)
        local winSize = SL:GetScreenSize()
        local x = winSize.width / 2
        local y = winSize.height / 2
        local w = winSize.width
        local h = winSize.height

        local layout = GUI:Layout_Create(_parent, "diban", x, y, w, h)
        if layout then
            GUI:setAnchorPoint(layout, 0.5, 0.5)
        end
        --关闭背景
        local bg_close = GUI:Image_Create(_parent, "bg_close", 0, 0, "res/ui/npc/转生之力/1.png")
        if bg_close then
            GUI:setContentSize(bg_close, { width = w, height = h })
            GUI:setTouchEnabled(bg_close, true)
            GUI:addOnClickEvent(bg_close, function()
                SL:UnRegisterLUAEvent("LUA_EVENT_LEVELCHANGE", "转生刷新")
                GUI:Win_Close(_parent)
            end)
        end
        --背景框
        local img_bg = GUI:Image_Create(_parent, "img_bg", 111.00, 40.00, "res/ui/npc/转生之力/2.png")
        GUI:setContentSize(img_bg, 815, 575)
        GUI:setIgnoreContentAdaptWithSize(img_bg, false)
        GUI:setTouchEnabled(img_bg, true)
        GUI:setTag(img_bg, -1)

        --  标题
        local text_title = GUI:Text_Create(_parent, "text_title", 223.00, 537.00, 20, "#ffeed9", [[转生之力]])
        GUI:setTouchEnabled(text_title, false)
        GUI:setTag(text_title, -1)

        --  关闭按钮
        local btn_close = GUI:Button_Create(_parent, "btn_close", 856.00, 510.00, "res/ui/npc/转生之力/3.png")
        GUI:Button_loadTexturePressed(btn_close, "res/ui/npc/转生之力/4.png")
        GUI:Button_loadTextureDisabled(btn_close, "res/private/gui_edit/Button_Disable.png")
        GUI:setTouchEnabled(btn_close, true)
        GUI:setTag(btn_close, -1)
        GUI:addOnClickEvent(btn_close, function()
            SL:UnRegisterLUAEvent("LUA_EVENT_LEVELCHANGE", "转生刷新")
            GUI:Win_Close(_parent)
        end)

        --  当前属性容器
        local layer_dangqianshuxing = GUI:Layout_Create(_parent, "layer_dangqianshuxing", 599.00, 218.00, 200.00, 200.00, false)
        GUI:Layout_setBackGroundColorType(layer_dangqianshuxing, 1)
        GUI:Layout_setBackGroundColor(layer_dangqianshuxing, "#96c8ff")
        GUI:Layout_setBackGroundColorOpacity(layer_dangqianshuxing, 140)
        GUI:setTouchEnabled(layer_dangqianshuxing, false)
        GUI:setTag(layer_dangqianshuxing, -1)

        --  下一属性容器
        local layer_xiayishuxing = GUI:Layout_Create(_parent, "layer_xiayishuxing", 227.00, 218.00, 200.00, 200.00, false)
        GUI:Layout_setBackGroundColorType(layer_xiayishuxing, 1)
        GUI:Layout_setBackGroundColor(layer_xiayishuxing, "#96c8ff")
        GUI:Layout_setBackGroundColorOpacity(layer_xiayishuxing, 140)
        GUI:setTouchEnabled(layer_xiayishuxing, false)
        GUI:setTag(layer_xiayishuxing, -1)
    --    转生阶数艺术字
        local atlas_zhuansheng = GUI:TextAtlas_Create(_parent, "atlas_zhuansheng",545,492,0,"res/ui/npc/转生之力/8.png",19,25,0)

        -- Create 转生按钮
        local btn_zhuansheng = GUI:Button_Create(_parent, "btn_zhuansheng", 465.00, 132.00, "res/ui/npc/转生之力/6.png")
        GUI:Button_loadTexturePressed(btn_zhuansheng, "res/ui/npc/转生之力/7.png")
        GUI:Button_loadTextureDisabled(btn_zhuansheng, "res/private/gui_edit/Button_Disable.png")
        GUI:Button_setTitleColor(btn_zhuansheng, "#ef6f18")
        GUI:Button_setTitleFontSize(btn_zhuansheng, 18)
        GUI:Button_setTitleText(btn_zhuansheng, "转生进阶")
        GUI:setTouchEnabled(btn_zhuansheng, true)
        GUI:setTag(btn_zhuansheng, -1)
        GUI:addOnClickEvent(btn_zhuansheng, function()
            local reinLv = SL:GetRoleData().reinLv
            if reinLv >= 99 then
                SL:ShowSystemTips("转生已满级！！！")
                return
            end
            SL:SubmitForm("A/转生之力","zhuansheng", reinLv)
        end)
        zhuanshengzhili.updateUI()
        --SL:RegisterLUAEvent("LUA_EVENT_LEVELCHANGE", "转生", ZhuanSheng.updateUI)
        SL:RegisterLUAEvent("LUA_EVENT_LEVELCHANGE", "转生刷新", zhuanshengzhili.updateUI)
    end
end

function zhuanshengzhili.updateUI()
    GUI:TextAtlas_setString(GUI:GetWindow(GUIparent,"atlas_zhuansheng"), SL:GetRoleData().reinLv )
end


