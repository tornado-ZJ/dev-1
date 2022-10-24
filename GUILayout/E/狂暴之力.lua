KuangBao = {}

local cfg = {
    [1] = {
        name = "狂暴之力",
        cost = {
            [1] = {
                [1] = 12, --rmb
                [2] = 100,
            },
        },
        shuxing = {
            [1] = {
                [1] = 1,
                [2] = 1000,
            },
            [2] = {
                [1] = 3,
                [2] = 1000,
            },
            [3] = {
                [1] = 58,
                [2] = 10000,
            }
        },
        diaoluo = {
            [1] = {
                [1] = 12, -- rmb
                [2] = 50,
            },
        },
        shijian = {
            [1] = {
                [1] = 23,
                [2] = 8,
            },
        },
        effectid = 30111,
    },
}
local GUIparent = ""

function getcfg_kuangbao(actor)
    return cfg
end

KuangBao.main = function()
    local _parent = GUI:Win_Create("QSQ_kuangbao", 0, 0, 0, 0, false, false, true, false)
    if _parent then
        GUIparent = _parent
        local winSize = SL:GetScreenSize()              --获取屏幕宽高
        local x = winSize.width / 2
        local y = winSize.height / 2
        local w = winSize.width
        local h = winSize.height

        local layout = GUI:Layout_Create(_parent, "diban", x, y, w, h)
        if layout then
            GUI:setAnchorPoint(layout, 0.5, 0.5)                               
        end
----------关闭背景act-----------------
        local bg_close = GUI:Image_Create(_parent, "bg_close", 0, 0, "res/01/010010.png")
        if bg_close then
            GUI:setContentSize(bg_close, {width = w, height = h})
            GUI:setTouchEnabled(bg_close, true)
            GUI:addOnClickEvent(bg_close, function()
                GUI:Win_Close(_parent)
            end)
        end


----------界面框背景act-----------------
        local bg_kuang = GUI:Image_Create(_parent, "bg_kuang", 142, 45, "res/01/010000.png")
        if bg_kuang then
            GUI:setContentSize(bg_kuang,{width = 815, height = 575})
            GUI:setTouchEnabled(bg_kuang, true)
        end


---------八卦背景act-----------------
        local kg_bagua = GUI:Layout_Create(_parent, "kg_bagua", 203, 66, 692, 446, true)
        if kg_bagua then
            GUI:Image_Create(kg_bagua, "bg_bagua", -140, -150, "res/01/010011.jpg")
        end

        -- 人物特效
        GUI:Effect_Create(kg_bagua, "eff_kuangbao_1", 140, 300, 1, 2001, 0, 0, 0, 1)
        -- 狂暴特效
        GUI:Effect_Create(kg_bagua, "eff_kuangbao_2", 160, 300, 0, 30111, 0, 0, 0, 1)

----------界面关闭按钮act-----------------
        local btn_close = GUI:Button_Create(_parent, "btn_close", 870, 515, "res/01/010008.png")
        if btn_close then
            GUI:Button_loadTexturePressed(btn_close, "res/01/010009.png")   
            GUI:addOnClickEvent(btn_close, function()
                GUI:Win_Close(_parent)
            end)
        end

----------界面标题act-----------------
        local title = GUI:Text_Create(_parent, "title", 520, 558, 20, "#D6C6AD","狂暴之力")


----------属性-----------------
        GUI:Image_Create(_parent, "shuxing_kuang", 700, 400, "res/01/010062.png")
        -- GUI:Image_Create(_parent, "shuxing_img", 728, 360, "res/01/010002.png")
        GUI:Text_Create(_parent, "kuangbao_jieshao", 730, 405, 16, "#4AE74A", "狂暴介绍")

        GUI:Text_Create(_parent, "kuangbao_jieshao_xiaohao_text", 630, 304, 16, "#4AE74A", "消耗:")
        GUI:Text_Create(_parent, "kuangbao_jieshao_xiaohao_value", 730, 304, 16, "#4AE74A", "0")

        -- GUI:RichText_Create(_parent, "kuangbaojieshao", x, y, str, width, Size, Color, vspace, hyperlinkCB)

        -- GUI:Text_Create(_parent, "kuangbao_shuxing1", 708, 330, 16, "#C0C0C0", "生  命")
        -- GUI:Text_Create(_parent, "kuangbao_shuxing2", 708, 300, 16, "#C0C0C0", "攻  击")
        -- GUI:Text_Create(_parent, "kuangbao_shuxing3", 708, 270, 16, "#C0C0C0", "爆  率")



        -- local shuxing = cfg[1].shuxing
        -- GUI:Text_Create(_parent, "kuangbao_shuxing4", 785, 330, 16, "#4AE74A", shuxing[1][2])
        -- GUI:Text_Create(_parent, "kuangbao_shuxing5", 785, 300, 16, "#4AE74A", shuxing[2][2])
        -- GUI:Text_Create(_parent, "kuangbao_shuxing6", 785, 270, 16, "#4AE74A", shuxing[3][2])




----------狂暴按钮act-----------------
        local btn_zs = GUI:Button_Create(_parent, "btn_zs", 495, 80, "res/01/010005.png")
        if btn_zs then
            local tx_btn_zs = GUI:Text_Create(btn_zs, "tx_btn_zs", 55, 20, 18, "#D6C6AD", "开启狂暴")
            GUI:setAnchorPoint(tx_btn_zs, 0.5, 0.5)
            GUI:Button_loadTexturePressed(btn_zs, "res/01/010006.png")
            GUI:addOnClickEvent(btn_zs, function()
                KuangBao.ok()
            end)
        end
        KuangBao.updateUI()
    end
end


function KuangBao.updateUI()

    kuangbao_jieshao_xiaohao_text = GUI:GetWindow(GUIparent, "kuangbao_jieshao_xiaohao_text")
    GUI:Text_setString(kuangbao_jieshao_xiaohao_text, tostring(cfg[1].cost[1][1]))
    kuangbao_jieshao_xiaohao_value = GUI:GetWindow(GUIparent, "kuangbao_jieshao_xiaohao_value")
    GUI:Text_setString(kuangbao_jieshao_xiaohao_value, tostring(cfg[1].cost[1][2]))
end

function KuangBao.ok()
    SL:SubmitForm("A/狂暴之力", "kuangbaook")
end


KuangBao.main()
















