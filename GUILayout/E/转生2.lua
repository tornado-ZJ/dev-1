ZhuanSheng = {}

local cfg = cfg_zhuansheng
local GUIparent = ""

ZhuanSheng.main = function()
    local _parent = GUI:Win_Create("QSQ_zhuansheng", 0, 0, 0, 0, false, false, true, false)
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

----------界面关闭按钮act-----------------
        local btn_close = GUI:Button_Create(_parent, "btn_close", 870, 515, "res/01/010008.png")
        if btn_close then
            GUI:Button_loadTexturePressed(btn_close, "res/01/010009.png")   
            GUI:addOnClickEvent(btn_close, function()
                GUI:Win_Close(_parent)
            end)
        end

----------界面标题act-----------------
        local title = GUI:Text_Create(_parent, "title", 520, 558, 20, "#D6C6AD", "转    生")

        -- ---------八卦背景act-----------------
        local kg_bagua = GUI:Layout_Create(_parent, "kg_bagua", 203, 66, 692, 446, true)
        if kg_bagua then
            GUI:Image_Create( kg_bagua, "bg_bagua", -140, -150, "res/01/010011.png")
            GUI:Image_Create( kg_bagua, "bg_dazuo", 240, 150, "res/01/010012.png")
        end

        -- 当前转生背景图片
        GUI:Image_Create( _parent, "bg_dqzs", 460, 470, "res/01/010004.png")
        -- 艺术字显示当前转生 数
        local tx_atlsas_dqzs = GUI:TextAtlas_Create(_parent, "tx_atlsas_dqzs", 572, 482, 0, "res/01/010007.png", 19, 25, "0")
        if tx_atlsas_dqzs then
            GUI:setAnchorPoint(tx_atlsas_dqzs, 0.5, 0.5)
        end

        -- 当前属性
        GUI:Image_Create(_parent, "dq_kuang", 228, 255, "res/01/010001.png")
        GUI:Image_Create(_parent, "dq_img", 278, 360, "res/01/010002.png")

        GUI:Text_Create(_parent, "shuxing1", 258, 330, 16, "#C0C0C0", "生  命")
        GUI:Text_Create(_parent, "shuxing2", 258, 300, 16, "#C0C0C0", "攻  击")
        GUI:Text_Create(_parent, "shuxing3", 258, 270, 16, "#C0C0C0", "防  御")

        GUI:Text_Create(_parent, "shuxz1", 335, 330, 16, "#C0C0C0", 0)
        GUI:Text_Create(_parent, "shuxz2", 335, 300, 16, "#C0C0C0", 0)
        GUI:Text_Create(_parent, "shuxz3", 335, 270, 16, "#C0C0C0", 0)

        -- 下阶属性
        GUI:Image_Create(_parent, "xdq_kuang", 678, 255, "res/01/010001.png")
        GUI:Image_Create(_parent, "xdq_img", 728, 360, "res/01/010003.png")

        GUI:Text_Create(_parent, "xshuxing1", 708, 330, 16, "#C0C0C0", "生  命")
        GUI:Text_Create(_parent, "xshuxing2", 708, 300, 16, "#C0C0C0", "攻  击")
        GUI:Text_Create(_parent, "xshuxing3", 708, 270, 16, "#C0C0C0", "防  御")

        GUI:Text_Create(_parent, "xshuxz1", 785, 330, 16, "#4AE74A", 0)
        GUI:Text_Create(_parent, "xshuxz2", 785, 300, 16, "#4AE74A", 0)
        GUI:Text_Create(_parent, "xshuxz3", 785, 270, 16, "#4AE74A", 0)

        -- ----------等级描述-----------------
        GUI:Text_Create(_parent, "renwu", 458, 125, 16, "#C0C0C0", "人物")
        GUI:Text_Create(_parent, "dqlevel", 492, 125, 16, "#4AE74A", "999级")

        GUI:Text_Create(_parent, "xrenwu", 558, 125, 16, "#C0C0C0", "转身降")
        GUI:Text_Create(_parent, "xdqlevel", 607, 125, 16, "#4AE74A", "999级")

        -- 消耗-------
        for i = 1, 2 do
            GUI:Layout_Create(_parent, "LC_xh"..i, 500, 210-(i*30), 265,30,false)
        end
       

        -- 转生按钮-----------
        local btn_zs = GUI:Button_Create(_parent, "btn_zs", 495, 80, "res/01/010005.png")
        if btn_zs then
            local tx_btn_zs = GUI:Text_Create(btn_zs, "tx_btn_zs", 55, 20, 18, "#D6C6AD", "转  生")
            GUI:setAnchorPoint(tx_btn_zs, 0.5, 0.5)
            GUI:Button_loadTexturePressed(btn_zs, "res/01/010006.png")
            GUI:addOnClickEvent(btn_zs, function()
                ZhuanSheng.ok()
            end)
        end
    end
    ZhuanSheng.updateUI()
    SL:RegisterLUAEvent("LUA_EVENT_LEVELCHANGE", "转生", ZhuanSheng.updateUI)

end


function ZhuanSheng.updateUI()
    -- 人物基本信息
    local data = SL:GetRoleData()
    -- 当前转生等级
    local cur_reinlv = data.reinLv
    -- 拿到转生表信息
    local cur_reinlv_tbl = cfg[cur_reinlv]
    
    local next_reinlv_tbl = cfg[cur_reinlv + 1]
    if cur_reinlv >= 30 then
        next_reinlv_tbl = cfg[cur_reinlv]
    end
    -- 艺术字显示转生等级
    local tx_atlsas_dqzs = GUI:GetWindow(GUIparent, "tx_atlsas_dqzs")
    if tx_atlsas_dqzs then
        GUI:TextAtlas_setString(tx_atlsas_dqzs, cur_reinlv)
    end
    -- 当前转生属性、下一转生属性
    local cur_attr = cur_reinlv_tbl.Attribute0
    local next_attr = next_reinlv_tbl.Attribute0
    SLUpdateAttrShow(cur_attr, 3, GUIparent, "shuxing", "shuxz", 1)
    SLUpdateAttrShow(next_attr, 3, GUIparent, "xshuxing", "xshuxz", 1)

--  当前人物等级
    local cur_level = data.level
    -- 拿到当前等级和转生降级的控件
    local dqlevel = GUI:GetWindow(GUIparent, "dqlevel")
    local xdqlevel = GUI:GetWindow(GUIparent, "xdqlevel")
    if dqlevel and xdqlevel then
        -- 如果转生未满
        if cur_reinlv < #cfg then
            -- 设置当前等级和转生降的等级
            GUI:Text_setString(dqlevel, cur_level.."级")
            GUI:Text_setString(xdqlevel, next_reinlv_tbl.DelLv.."级")
            -- 转生消耗
            local cost_tbl = cur_reinlv_tbl.Consume
            for i = 1, #cost_tbl do
                local LC_xh = GUI:GetWindow(GUIparent, "LC_xh"..i)
                GUI:removeAllChildren(LC_xh)
                local cost_name = SL:GetItemNameByIndex(cost_tbl[i][1])
                local cost_num = cost_tbl[i][2]
                local bag_num = SL:GetItemNumberByIndex(cost_tbl[i][1])
                local cost_str = SLChangeColour(bag_num, cost_num, cost_name)
                GUI:RichText_Create(LC_xh, "LC_xh_text", 0,10, cost_str,265)
            end
            -- 转生已满
        else
            -- 设置当前等级
            GUI:Text_setString(dqlevel, cur_level.."级")
            -- 将转生需要下降的等级设为不可见
            local xrenwu = GUI:GetWindow(GUIparent, "xrenwu")
            GUI:setVisible(xdqlevel,false)
            GUI:setVisible(xrenwu,false)
            -- 将消耗设为不可见
            for i=1,2 do
                local LC_xh = GUI:GetWindow(GUIparent,"LC_xh"..i)
                GUI:setVisible(LC_xh,false)
            end
        end
    end

end

function ZhuanSheng.ok()
    local cur_reinlv = SL:GetRoleData().reinLv
    if cur_reinlv >= #cfg then
        SL:ShowSystemTips("已满转")
    else
        -- SL:Print(cfg[0].Name)
        SL:SubmitForm("A/转生", "zhuanshengok")
    end
end


ZhuanSheng.main()
















