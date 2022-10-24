boss = {}

boss.main = function()

    local _parent = GUI:Win_Create("QSQ_challengeboss", 0, 0, 0, 0, false, false, true, false)
    if _parent then
        local winSize = SL:GetScreenSize()
        local x = winSize.width / 2
        local y = winSize.height / 2
        local w = winSize.width
        local h = winSize.height

        local layout = GUI:Layout_Create(_parent, "diban", x, y, w, h)
        if layout then
            GUI:setAnchorPoint(layout, 0.5, 0.5)
        end

        local bg_close = GUI:Image_Create(_parent, "bg_close", 0, 0, "res/01/010010.png")
        if bg_close then
            GUI:setContentSize(bg_close, {width = w, height = h})
            GUI:setTouchEnabled(bg_close, true)
            GUI:addOnClickEvent(bg_close, function()
                GUI:Win_Close(_parent)
            end)
        end

        local bg_kuang = GUI:Image_Create(_parent, "bg_kuang", 142, 45, "res/01/010000.png")
        if bg_kuang then
            GUI:setContentSize(bg_kuang,{width = 815, height = 575})
            GUI:setTouchEnabled(bg_kuang, true)
        end

        local bg_di = GUI:Image_Create(_parent, "bg_bagua", 203, 66, "res/01/010024.jpg")
        if bg_di then
            GUI:setContentSize(bg_di,{width = 692, height = 446})
        end

        local btn_close = GUI:Button_Create(_parent, "btn_close", 870, 515, "res/01/010008.png")
        if btn_close then
            GUI:Button_loadTexturePressed(btn_close, "res/01/010009.png")
            GUI:addOnClickEvent(btn_close, function()
                GUI:Win_Close(_parent)
            end)
        end
            GUI:Image_Create(_parent, "bg_bagua22", 455, 528, "res/01/005032.png")
       -- GUI:Text_Create(_parent, "title", 505, 558, 20, "#D6C6AD", "世界BOSS")

----------右侧边模板act-----------------
        GUI:ListView_Create(_parent, "LV_type", 905, 65, 40, 450, 1)


----------左侧边模板act-----------------
        local tiao = GUI:ListView_Create(_parent, "LV_tiao", 205, 60, 250, 450, 1)
        if tiao then
            --GUI:ListView_setBounceEnabled(tiao,true)
            GUI:ListView_setClippingEnabled(tiao,true)
        end


---------展示面按钮act-----------------
        GUI:Image_Create(_parent, "img_jiping", 440, 200, "res/01/010018.png")

        local btn_move = GUI:Button_Create(_parent, "btn_move", 620, 80, "res/01/010005.png")
        if btn_move then
            local tx_btn_move = GUI:Text_Create(btn_move, "tx_btn_zs", 55, 20, 18, "#D6C6AD", "传  送") --给按钮添加文字
            GUI:setAnchorPoint(tx_btn_move, 0.5, 0.5) ---设置居中
            GUI:Button_loadTexturePressed(btn_move, "res/01/010006.png")
            GUI:addOnClickEvent(btn_move, function()
                --GUI:Win_Close(_parent)
            end)
        end
        
        local itemdata = {}
        itemdata.index = 4
        itemdata.look  = true
        itemdata.bgVisible = true
        itemdata.count = 1
        itemdata.color = 225
        local item_ = GUI:ItemShow_Create(_parent, "item_",650, 135, itemdata)
        if item_ then
            GUI:setScale(item_, 0.9)
        end

    end
    boss.initUI()
end


local type_tab = {"初\n级","中\n级","高\n级","地\n狱"}
local tiao_tab = {
                    {"1","2","3","4","5","6","7","8"},
                    {"11","12","13","14","15","16","17","18"},
                    {"21","22","23","24","25","26","27","28"},
                    {"31","32","33","34","35","36","37","38"},
                }

local hand_tab = {
    {"005000","005001","005002","005003","005004","005005","005006","005007"},
    {"005008","005009","005010","005011","005012","005013","005014","005015"},
    {"005016","005017","005018","005019","005020","005021","005022","005023"},
    {"005024","005025","005026","005027","005028","005029","005030","005031"},
}

local type_page1 = 0
local type_page2 = 0
--    local LV_type = GUI:GetWindow(nil,"QSQ_challengeboss/LV_type")   写法1

--    local LV_type = GUI:GetWindow(_parent,"QSQ_challengeboss/LV_type")   写法2

--    local LV_type = GUI:GetWindow(_parent,"LV_type")   写法3


function boss.initUI()
    local LV_type = GUI:GetWindow(nil,"QSQ_challengeboss/LV_type")   --根据位置循环创建控件
    if LV_type then
        for i,cfg in ipairs(type_tab) do
            local template = GUI:Layout_Create(LV_type, "template"..i, 0, 0, 40, 100)
            if template then
                local btn_switch = GUI:Button_Create(template, "btn_switch", 0,0, "res/01/010022.png")
                if btn_switch then
                    GUI:setContentSize(btn_switch,{width = 36, height = 99})
                    GUI:Button_loadTexturePressed(btn_switch, "res/01/010023.png")
                    GUI:Button_loadTextureDisabled(btn_switch, "res/01/010023.png")
                    GUI:addOnClickEvent(btn_switch, function()
                        boss.updatePageBtn1(i)
                    end)
                    local tx_switch = GUI:Text_Create(btn_switch, "tx_switch", 16, 53, 16, "#747071", cfg)
                    if tx_switch then
                        GUI:setAnchorPoint(tx_switch, 0.5, 0.5)
                    end
                    if i == 1 then          --设置默认
                        boss.updatePageBtn1(i)
                    end
                end
            end
        end
    end
end

function boss.updatePageBtn1(btn)
    SL:Print("btn="..btn)
    if type_page1 ~= 0 then --恢复上次按钮禁用状态
        local template = GUI:GetWindow(nil,"QSQ_challengeboss/LV_type/template"..type_page1)   --第几个容器
        local btn_switch = GUI:GetWindow(template, "btn_switch")                        --获取容器中的按钮
        if btn_switch then
            GUI:Button_setBright(btn_switch,true)
        end
        local tx_switch = GUI:GetWindow(btn_switch, "tx_switch")
        if tx_switch then
            GUI:Text_setTextColor(tx_switch, "#747071")
        end
    end
    --这次选择的按钮
    if type_page1 == btn then return end

    local template = GUI:GetWindow(nil,"QSQ_challengeboss/LV_type/template"..btn)
    local btn_switch = GUI:GetWindow(template, "btn_switch")
    if btn_switch then
        GUI:Button_setBright(btn_switch,false)
    end
    local tx_switch = GUI:GetWindow(btn_switch, "tx_switch")
    if tx_switch then
        GUI:Text_setTextColor(tx_switch, "#DEBA6C")
    end
    type_page1 = btn
-------------右侧按钮逻辑end---------------


-------------左侧按钮逻辑act---------------
    local LV_tiao = GUI:GetWindow(nil,"QSQ_challengeboss/LV_tiao")   --因为会重复创建所以需要清除
    local tab = tiao_tab[type_page1]
    local aaa = hand_tab[type_page1]
    GUI:removeAllChildren(LV_tiao)
    if LV_tiao then
        for i,cfg in ipairs(tab) do
            local aa = aaa[i]
            local btn_mb = GUI:Button_Create(LV_tiao, "btn_mb"..i, 0, 0, "")
            if btn_mb then
                GUI:setContentSize(btn_mb,{width = 250, height = 220})
                GUI:addOnClickEvent(btn_mb, function()
                    boss.updatePageBtn2(i)
                end)
                local img_kuang = GUI:Image_Create(btn_mb, "img_kuang", -2, 0, "res/01/010020.png") --点击框
                if img_kuang then
                    GUI:setContentSize(img_kuang,{width = 160, height = 220})
                    GUI:setVisible(img_kuang, false)
                end

                local img_hand = GUI:Image_Create(btn_mb, "img_hand", 10, 20, "res/01/"..aa..".png") --头像
                SL:Print(aa)
                if img_hand then
                    GUI:setContentSize(img_hand,{width = 135, height = 179})
                end

                GUI:Image_Create(btn_mb, "img_tx_di", 35, 12, "res/01/010021.png") --数量图
                local tx_btn_life = GUI:Text_Create(btn_mb, "tx_btn_life", 73, 22, 16, "#FFFF00", "说明") --说明
                if tx_btn_life then
                    GUI:setAnchorPoint(tx_btn_life, 0.5, 0.5)
                end
            end
        end
        GUI:ListView_jumpToItem(LV_tiao, 1)
    end

    type_page2 = 0
    boss.updatePageBtn2(1)
end


function boss.updatePageBtn2(btn2)
    if type_page2 ~= 0 then
        local btn_mb = GUI:GetWindow(nil,"QSQ_challengeboss/LV_tiao/btn_mb"..type_page2)
        if btn_mb then
            GUI:Button_setBright(btn_mb,true)
            local img_kuang = GUI:GetWindow(btn_mb, "img_kuang")
            if img_kuang then
                GUI:setVisible(img_kuang, false)
            end
        end
    end

    if type_page2 == btn2 then return end

    local btn_mb = GUI:GetWindow(nil,"QSQ_challengeboss/LV_tiao/btn_mb"..btn2)
    if btn_mb then
        GUI:Button_setBright(btn_mb,false)
        local img_kuang = GUI:GetWindow(btn_mb, "img_kuang")
        if img_kuang then
            GUI:setVisible(img_kuang, true)
        end
    end
    type_page2 = btn2
    boss.updateUI()
end


function boss.updateUI()
    local cfg = tiao_tab[type_page1][type_page2]

    local bg_di = GUI:GetWindow(nil,"QSQ_challengeboss/bg_bagua")
    GUI:removeAllChildren(bg_di)
    local Effhanld = GUI:Effect_Create(bg_di, "monster", 400, 300, 0, cfg, 0, 0, 3, 1)
    
end

boss.main()