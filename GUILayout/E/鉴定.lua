JianDing = {}

--local cfg = cfg_JianDing
local GUIparent = ""

local btn_page = 0
local type_tab = {0,1,2,3}  --该组定义为 鉴定组
local where_tab = {"武 器","衣 服","头 盔","项 链","腰 带","靴 子"}


JianDing.main = function()
    local _parent = GUI:Win_Create("QSQ_JianDing", 0, 0, 0, 0, false, false, true, false)
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
            GUI:Image_Create(kg_bagua, "bg_dazuo", 240, 150, "res/01/010012.png")
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
        local title = GUI:Text_Create(_parent, "title", 520, 558, 20, "#D6C6AD", "鉴  定")



----------当前属性act-----------------
        GUI:Image_Create(_parent, "dq_kuang", 228, 255, "res/01/010001.png")
        GUI:Image_Create(_parent, "dq_img", 278, 360, "res/01/010002.png")

        GUI:Text_Create(_parent, "shuxing1", 258, 330, 16, "#C0C0C0", "生  命")
        GUI:Text_Create(_parent, "shuxing2", 258, 300, 16, "#C0C0C0", "攻  击")
        GUI:Text_Create(_parent, "shuxing3", 258, 270, 16, "#C0C0C0", "防  御")

        GUI:Text_Create(_parent, "shuxz1", 335, 330, 16, "#C0C0C0", 0)
        GUI:Text_Create(_parent, "shuxz2", 335, 300, 16, "#C0C0C0", 0)
        GUI:Text_Create(_parent, "shuxz3", 335, 270, 16, "#C0C0C0", 0)


----------转生按钮act-----------------
        local btn_zs = GUI:Button_Create(_parent, "btn_zs", 495, 80, "res/01/010005.png")
        if btn_zs then
            local tx_btn_zs = GUI:Text_Create(btn_zs, "tx_btn_zs", 55, 20, 18, "#D6C6AD", "鉴  定")
            GUI:setAnchorPoint(tx_btn_zs, 0.5, 0.5)
            GUI:Button_loadTexturePressed(btn_zs, "res/01/010006.png")
            GUI:addOnClickEvent(btn_zs, function()
                JianDing.ok()
            end)
        end

----------最中间物品框act-----------------

        GUI:Layout_Create(_parent, "LC_item", 495, 300, 100,100,false)

----------右测属性act-----------------

        GUI:Layout_Create(_parent, "LC_attr", 670, 70, 200,420,false)


----------装备位按钮act-----------------
        for i = 1, 6 do
            local btn_zs = GUI:Button_Create(_parent, "btn_where"..i, 125+(i*80), 513, "res/custom/common2/222.png")
            if btn_zs then
                local tx_btn_zs = GUI:Text_Create(btn_zs, "tx_btn_zs", 38, 15, 16, "#00FFE4", where_tab[i])
                GUI:setContentSize(btn_zs,{width=77,height=30})
                GUI:setAnchorPoint(tx_btn_zs, 0.5, 0.5)
                GUI:addOnClickEvent(btn_zs, function()
                    JianDing.updateUI(i)
                end)
            end
            if i == 1 then          --设置默认
                JianDing.updateUI(i)
            end
        end
    end
end


function JianDing.updateUI(param)
    if btn_page ~= 0 then
        local btn_where = GUI:GetWindow(GUIparent,"btn_where"..btn_page)
        if btn_where then
            GUI:Button_setBright(btn_where,true)
            local tx_btn_zs = GUI:GetWindow(btn_where, "tx_btn_zs")
            GUI:Text_setTextColor(tx_btn_zs, "#00FFE4")
        end
    end

    local item_data = {}

    local data = SL:GetEquipDataByPos(1)        --这里需要根据按钮 选择 装备位
    if data ~= nil then
        item_data.makeindex = data.MakeIndex
        item_data.look = true
        item_data.bgVisible = true
        item_data.count = 1
        item_data.color = 255


        local LC_item = GUI:GetWindow(GUIparent,"LC_item")
        if LC_item then
            GUI:removeAllChildren(LC_item)
            GUIItemShow_Create(LC_item,"item_show",20,20,item_data)
        end
        local item_att0 = {}    --提取 自定义 属性id 与 属性值
        local num = 1
        for i=1,4 do
            local attExtra = data.ExtAbil[type_tab[i]] --根据装备信息与自定义组 获取自定义属性
            if attExtra ~= nil then
                for k,v in pairs(attExtra) do
                    item_att0[num] = item_att0[num] or {}
                    item_att0[num][1] = k
                    item_att0[num][2] = v
                    num = num + 1
                end
            end
        end

        local item_att = data.attribute --提取基础 str
        item_att = SLStrSplitByMore(item_att, {"|","#"})
        local item_att1 = {}        --提取基础 属性id 与属性值 
        for k,v in ipairs(item_att) do
            item_att1[k] = item_att1[k] or {}
            item_att1[k][1] = v[2]
            item_att1[k][2] = v[3]
        end
        local LC_attr = GUI:GetWindow(GUIparent,"LC_attr")
        if LC_attr then
            GUI:removeAllChildren(LC_attr)
            local cattr1 = SLAttrToClient(item_att1, 2)
            local y = 380               --属性展示长度 即使创建  每个物品属性长度不一样 每次都要清除创建
            GUI:Text_Create(LC_attr, "shuxing_name", 30, y-5, 16, "#4a9cce", "[基础属性]:")
            for i = 1,#cattr1 do
                y = y-30
                GUI:Text_Create(LC_attr, "shuxing"..i, 34, y, 16, "#C0C0C0", "生  命")
                GUI:Text_Create(LC_attr, "shuxz"..i, 115, y, 16, "#4AE74A", 0)
            end

            SLUpdateAttrShow(item_att1,#cattr1,LC_attr,"shuxing","shuxz",2)
            if #item_att0 ~= 0 then
                y = y-40
                local cattr0 = SLAttrToClient(item_att0, 2)
                GUI:Text_Create(LC_attr, "xshuxing_name", 30, y-5, 16, "#4a9cce", "[鉴定属性]:")
                for i = 1,#cattr0 do
                    y = y-30
                    GUI:Text_Create(LC_attr, "xshuxing"..i, 34, y, 16, "#C0C0C0", "生  命")
                    GUI:Text_Create(LC_attr, "xshuxz"..i, 115, y, 16, "#4AE74A", 0)
                end
                SLUpdateAttrShow(item_att0,#cattr0,LC_attr,"xshuxing","xshuxz",2)
            end
        end
    end




    if btn_page == param then return end

    local btn_where = GUI:GetWindow(GUIparent,"btn_where"..param)
    if btn_where then
        GUI:Button_setBright(btn_where,false)
        local tx_btn_zs = GUI:GetWindow(btn_where, "tx_btn_zs")
        GUI:Text_setTextColor(tx_btn_zs, "#DEBA6C")
    end

    btn_page = param

   
    
end



function JianDing.ok()
    SL:SubmitForm("A/鉴定", "identify",btn_page)
end


JianDing.main()
















