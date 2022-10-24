kuangbaozhili = {}
local cfg = {
    name = "狂暴之力",
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
    rich_str = {
        [1] = '<font color="#ff0000">1.</font><font color=\'#ffffff\'>花费</font><font color=\'#77ef67\'>100RMB点</font><font color=\'#ffffff\'>可激活</font><font color=\'#ff2d23\'>狂暴之力</font>'

    }
}

local GUIparent = ""
local haskuangbao = ""
local Win_W, Win_H = 815, 575

kuangbaozhili.main = function()
    local _parent = GUI:Win_Create("kuangbaozhili", 0, 0, 0, 0, false, false, true, false)
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
        local bg_close = GUI:Image_Create(_parent, "bg_close", 0, 0, "res/ui/npc/狂暴之力/1.png")
        if bg_close then
            GUI:setContentSize(bg_close, { width = w, height = h })
            GUI:setTouchEnabled(bg_close, true)
            GUI:addOnClickEvent(bg_close, function()
                GUI:Win_Close(_parent)
            end)
        end
        --背景框
        local img_bg = GUI:Image_Create(_parent, "img_bg", 111.00, 40.00, "res/ui/npc/狂暴之力/2.png")
        GUI:setContentSize(img_bg, 815, 575)
        GUI:setIgnoreContentAdaptWithSize(img_bg, false)
        GUI:setTouchEnabled(img_bg, true)
        GUI:setTag(img_bg, -1)

        -- Create 标题
        local text_title = GUI:Text_Create(_parent, "text_title", 223.00, 537.00, 20, "#ffeed9", [[沙城捐献]])
        GUI:setTouchEnabled(text_title, false)
        GUI:setTag(text_title, -1)

        -- Create 关闭按钮
        local btn_close = GUI:Button_Create(_parent, "btn_close", 856.00, 510.00, "res/ui/npc/狂暴之力/3.png")
        GUI:Button_loadTexturePressed(btn_close, "res/ui/npc/狂暴之力/4.png")
        GUI:Button_loadTextureDisabled(btn_close, "res/private/gui_edit/Button_Disable.png")
        GUI:setTouchEnabled(btn_close, true)
        GUI:setTag(btn_close, -1)
        GUI:addOnClickEvent(btn_close, function()
            GUI:Win_Close(_parent)
        end)
        --npc特效
        GUI:Effect_Create(_parent, "effect_kuangbao_npc", 350, 300, 1, 2001, 0, 0, 0, 1)
        --狂暴特效
        GUI:Effect_Create(_parent, "effect_kuangbao", 400, 350, 0, 30111, 0, 0, 0, 1)
        --狂暴说明
        GUI:RichText_Create(_parent, "rich_kuangbao", 550, 400, cfg.rich_str[1], 300, 20, nil, nil, nil)

        -- 开启狂暴按钮
        local btn_kuangbao_kaiqi = GUI:Button_Create(img_bg, "btn_kuangbao_kaiqi", 577.00, 94.00, "res/ui/npc/狂暴之力/6.png")
        GUI:Button_loadTexturePressed(btn_kuangbao_kaiqi, "res/ui/npc/狂暴之力/7.png")
        GUI:Button_loadTextureDisabled(btn_kuangbao_kaiqi, "res/private/gui_edit/Button_Disable.png")
        GUI:Button_setTitleColor(btn_kuangbao_kaiqi, "#ffffff")
        GUI:Button_setTitleFontSize(btn_kuangbao_kaiqi, 18)
        GUI:Button_setTitleText(btn_kuangbao_kaiqi, "开启狂暴")
        GUI:setTouchEnabled(btn_kuangbao_kaiqi, true)
        GUI:setTag(btn_kuangbao_kaiqi, -1)
        GUI:addOnClickEvent(btn_kuangbao_kaiqi, function()
            SL:SubmitForm("A/狂暴之力","kuangbao")
        end)
    end
end
kuangbaozhili.main()


