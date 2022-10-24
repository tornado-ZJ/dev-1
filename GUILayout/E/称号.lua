ChengHao = {}

local cfg = cfg_chenghao
local GUIparent = ""


ChengHao.main = function(data)
    SL:SubmitForm("A/称号","SyncResponse")
end

ChengHao.main()

--同步信息
function ChengHao.SyncResponse(chenghaoid)
    if not chenghaoid then return end
    -- SL:Print(type(tonumber(chenghaoid)))
    -- data = SL:JsonDecode(data)
    -- SL:Print(data)
    
    if not GUI:GetWindow(nil,"QSQ_chenghao") then
        ChengHao.createUI(tonumber(chenghaoid))
    else
        ChengHao.updateUI(tonumber(chenghaoid))
    end
end
ChengHao.createUI = function(chenghaoid)
    local _parent = GUI:Win_Create("QSQ_chenghao", 0, 0, 0, 0, false, false, true, false)
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
            GUI:Image_Create(kg_bagua, "bg_bagua", -140, -150, "res/01/010011.png")
            GUI:Image_Create(kg_bagua, "bg_dazuo", 240, 150, "res/01/010012.png")
            GUI:Effect_Create(kg_bagua, "chenghao_effect", 320, 320, 0, cfg_chenghao[1].effectid, 0, 0, 0, 1)
        end


----------界面关闭按钮act-----------------
        local btn_close = GUI:Button_Create(_parent, "btn_close", 870, 515, "res/01/010008.png")
        if btn_close then
            GUI:Button_loadTexturePressed(btn_close, "res/01/010009.png")   
            GUI:addOnClickEvent(btn_close, function()
                GUI:Win_Close(_parent)
            end)
        end

----------界面标题act-----------------
        local title = GUI:Text_Create(_parent, "title", 520, 558, 20, "#D6C6AD", "称    号")

----------当前属性act-----------------
        GUI:Image_Create(_parent, "dq_kuang", 228, 255, "res/01/010001.png")
        GUI:Image_Create(_parent, "dq_img", 278, 360, "res/01/010002.png")

        GUI:Text_Create(_parent, "shuxing1", 258, 330, 16, "#C0C0C0", "生  命")
        GUI:Text_Create(_parent, "shuxing2", 258, 300, 16, "#C0C0C0", "攻  击")
        GUI:Text_Create(_parent, "shuxing3", 258, 270, 16, "#C0C0C0", "防  御")

        GUI:Text_Create(_parent, "shuxz1", 335, 330, 16, "#C0C0C0", 0)
        GUI:Text_Create(_parent, "shuxz2", 335, 300, 16, "#C0C0C0", 0)
        GUI:Text_Create(_parent, "shuxz3", 335, 270, 16, "#C0C0C0", 0)


----------下阶属性act-----------------
        GUI:Image_Create(_parent, "xdq_kuang", 678, 255, "res/01/010001.png")
        GUI:Image_Create(_parent, "xdq_img", 728, 360, "res/01/010002.png")

        GUI:Text_Create(_parent, "xshuxing1", 708, 330, 16, "#C0C0C0", "生  命")
        GUI:Text_Create(_parent, "xshuxing2", 708, 300, 16, "#C0C0C0", "攻  击")
        GUI:Text_Create(_parent, "xshuxing3", 708, 270, 16, "#C0C0C0", "防  御")

        GUI:Text_Create(_parent, "xshuxz1", 785, 330, 16, "#4AE74A", 0)
        GUI:Text_Create(_parent, "xshuxz2", 785, 300, 16, "#4AE74A", 0)
        GUI:Text_Create(_parent, "xshuxz3", 785, 270, 16, "#4AE74A", 0)


----------转生按钮act-----------------
        local btn_chenghao = GUI:Button_Create(_parent, "btn_zs", 495, 80, "res/01/010005.png")
        if btn_chenghao then
            local tx_btn_zs = GUI:Text_Create(btn_chenghao, "tx_btn_zs", 55, 20, 18, "#D6C6AD", "称号晋升")
            GUI:setAnchorPoint(tx_btn_zs, 0.5, 0.5)
            GUI:Button_loadTexturePressed(btn_chenghao, "res/01/010006.png")
            GUI:addOnClickEvent(btn_chenghao, function()
                ChengHao.ok(chenghaoid)
                ChengHao.main()
            end)
        end
    end
    ChengHao.updateUI(chenghaoid)
end


function ChengHao.updateUI(chenghaoid)
    -- SL:Print("------------------")
    -- SL:Print(type(chenghaoid))
    -- SL:Print(#cfg_chenghao)
    local cur_chenghao = cfg_chenghao[chenghaoid]
    local next_chenghao = cfg_chenghao[chenghaoid + 1]
    if chenghaoid == #cfg_chenghao then
        next_chenghao = cur_chenghao
    end
    -- 更新属性显示
    local cur_attribute0 = cur_chenghao.Attribute0
    local next_attribute0 = next_chenghao.Attribute0
    SLUpdateAttrShow(cur_attribute0,3,GUIparent,"shuxing","shuxz",1)
	SLUpdateAttrShow(next_attribute0,3,GUIparent,"xshuxing","xshuxz",1)
    local kg_bagua = GUI:GetWindow(GUIparent, "kg_bagua")
    local chenghao_effect = GUI:GetWindow(kg_bagua, "chenghao_effect")
    GUI:removeFromParent(chenghao_effect)
    GUI:Effect_Create(kg_bagua, "chenghao_effect", 320, 320, 0, cur_chenghao.effectid, 0, 0, 0, 1)
end

function ChengHao.ok(chenghaoid)
    SL:Print(chenghaoid)
    if chenghaoid == #cfg_chenghao then
        SL:ShowSystemTips("称号已满")
    else
        SL:SubmitForm("A/称号", "chenghaook")
    end
end

















