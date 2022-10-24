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
                SL:UnRegisterLUAEvent("LUA_EVENT_LEVELCHANGE", "转生")
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
        end


----------界面关闭按钮act-----------------
        local btn_close = GUI:Button_Create(_parent, "btn_close", 870, 515, "res/01/010008.png")
        if btn_close then
            GUI:Button_loadTexturePressed(btn_close, "res/01/010009.png")   
            GUI:addOnClickEvent(btn_close, function()
                GUI:Win_Close(_parent)
                SL:UnRegisterLUAEvent("LUA_EVENT_LEVELCHANGE", "转生")
            end)
        end


----------界面标题act-----------------
        local title = GUI:Text_Create(_parent, "title", 520, 558, 20, "#D6C6AD", "转    生")


----------转身数字与图片act-----------------
        local tx_atlsas = GUI:TextAtlas_Create(_parent, "tx_atlsas", 572, 482, 0, "res/01/010007.png", 19, 25, 0)
        if tx_atlsas then
            GUI:setAnchorPoint(tx_atlsas, 0.5, 0.5)
        end
        GUI:Image_Create(_parent, "zs_img", 460, 470, "res/01/010004.png")

        
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


----------等级描述属性act-----------------
        GUI:Text_Create(_parent, "renwu", 458, 125, 16, "#C0C0C0", "人物")
        GUI:Text_Create(_parent, "dqlevel", 492, 125, 16, "#4AE74A", "999级")

        GUI:Text_Create(_parent, "xrenwu", 558, 125, 16, "#C0C0C0", "转身降")
        GUI:Text_Create(_parent, "xdqlevel", 607, 125, 16, "#4AE74A", "999级")


----------消耗描述属性act-----------------
        for i=1,2 do
            GUI:Layout_Create(_parent, "LC_xh"..i, 500, 210-(i*30), 265,30,false)
        end


----------转生按钮act-----------------
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
    -- 当前转生等级、等级、下一转生等级
    local zlv = SL:GetRoleData().reinLv
    local level = SL:GetRoleData().level
    local nzlv = zlv + 1
    -- 当前转生表、下一转生表
    local tab = cfg[zlv]
    local ntab = cfg[nzlv]
    -- 拿到艺术字控件来显示当前转生等级
    local tx_atlsas = GUI:GetWindow(GUIparent,"tx_atlsas")
    if tx_atlsas then
        SL:Print("aaaaaaaaa")
        GUI:TextAtlas_setString(tx_atlsas,zlv)
    end
    -- 当前转生属性、下一转生属性
    local rt = tab.Attribute0
    local nrt = ntab.Attribute0

	SLUpdateAttrShow(rt,3,GUIparent,"shuxing","shuxz",1)
	SLUpdateAttrShow(nrt,3,GUIparent,"xshuxing","xshuxz",1)

    -- 等级描述
    local dqlevel = GUI:GetWindow(GUIparent,"dqlevel")
    local xdqlevel = GUI:GetWindow(GUIparent,"xdqlevel")
    if dqlevel then
        if xdqlevel then
            local cost_tab = tab.Consume
            if zlv < #cfg then
                GUI:Text_setString(dqlevel,tab.Level.."级")
                local nrt = tab.DelLv
                GUI:Text_setString(xdqlevel,nrt.."级")
                for i=1,#cost_tab do
                    local LC_xh = GUI:GetWindow(GUIparent,"LC_xh"..i)
                    GUI:removeAllChildren(LC_xh)
                    local cost_name = SL:GetItemNameByIndex(cost_tab[i][1])
                    local cost_num = cost_tab[i][2]
                    local bag_num = SL:GetItemNumberByIndex(cost_tab[i][1])
                    local cost_str = SLChangeColour(bag_num,cost_num,cost_name)
                    GUI:RichText_Create(LC_xh, "LC_xh_text", 0, 10, cost_str, 265)
                end
            else
                GUI:setVisible(dqlevel,false)
                GUI:setVisible(xdqlevel,false)
                for i=1,2 do
                        local LC_xh = GUI:GetWindow(GUIparent,"LC_xh"..i)
                        GUI:setVisible(LC_xh,false)
                end
            end
        end
    end
end

function ZhuanSheng.ok()
    local zlv = SL:GetRoleData().reinLv
    if zlv < #cfg then
        SL:Print(cfg[0].Name)
        SL:SubmitForm("A/转生", "zhuanshengok")
    else
        SL:ShowSystemTips("已满转")
    end
end

ZhuanSheng.main()
















