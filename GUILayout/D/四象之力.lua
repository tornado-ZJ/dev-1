Fourelephants = {}
local cfg = cfg_sixiang
local GUIparent = ""

local FourData = {}
local Choose_Index = 0 --第几页
local RightControl = {"青\n龙","白\n虎","朱\n雀","玄\n武"}
local cfg_effect = {2002,2001,2004,2003}
local add_List = {0,20,40,88}

local Fourelephants_data = {}

Fourelephants.main = function()
    SL:SubmitForm("D/四象之力","SyncResponse")
end 
Fourelephants.main()

--同步信息
function Fourelephants.SyncResponse(data)
    if not data then return end
    local data = string.gsub(data, "'","")
    Fourelephants_data = SL:JsonDecode(data)
    if not GUI:GetWindow(nil,"QSQ_Fourelephants") then
        Fourelephants.createUI()
    else
        Fourelephants.updateUI()
    end
end

Fourelephants.createUI = function()
    local _parent = GUI:Win_Create("QSQ_Fourelephants", 0, 0, 0, 0, false, false, true, false)
    if _parent then
        GUIparent = _parent
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
        local bg_close = GUI:Image_Create(_parent, "bg_close", 0, 0, "res/01/010010.png")
        if bg_close then
            GUI:setContentSize(bg_close, {width = w, height = h})
            GUI:setTouchEnabled(bg_close, true)
            GUI:addOnClickEvent(bg_close, function()
                GUI:Win_Close(_parent)
            end)
        end

        --界面框背景
        local bg_kuang = GUI:Image_Create(_parent, "bg_kuang", 142, 45, "res/01/010000.png")
        if bg_kuang then
            GUI:setContentSize(bg_kuang,{width = 815, height = 575})
            GUI:setTouchEnabled(bg_kuang, true)
        end       

        --创建关闭按钮
        local btn_close = GUI:Button_Create(_parent, "btn_close", 870, 515, "res/01/010008.png")
        if btn_close then
            GUI:Button_loadTexturePressed(btn_close, "res/01/010009.png")   
            GUI:addOnClickEvent(btn_close, function()
                GUI:Win_Close(_parent)
            end)
        end

        --界面标题
        local title = GUI:Text_Create(_parent, "title", 510, 558, 20, "#D6C6AD", "四象之力")


        --背景图
        local bg_img= GUI:Image_Create(_parent, "bg_img", 202, 60, "res/custom/shenshouzhili/serviceactivity_bg4.png")
        if bg_img then
            GUI:setContentSize(bg_img,{width = 695, height = 455})
        end  

        --当前属性背景图
        GUI:Image_Create(_parent, "bg_nowattrimg", 620, 330, "res/custom/shenshouzhili/a_img.png")
        GUI:Image_Create(_parent, "img_nowattrtitle", 700, 445, "res/01/010002.png")

        --下阶属性背景图
        GUI:Image_Create(_parent, "bg_nextattrimg", 620, 180, "res/custom/shenshouzhili/a_img.png")
        GUI:Image_Create(_parent, "img_nextattrtitle", 700, 295, "res/01/010003.png")

        --成功率 
        local text_rate = GUI:Text_Create(_parent, "text_rate", 700, 165, 16, "#D6C6AD", "成功率：75")

        --所需方式一
        local text_yuanbao = GUI:Text_Create(_parent, "text_yuanbao", 630, 130, 16, "#00FF00", "15万/300万")

        ---所需方式二
        local text_lingfu = GUI:Text_Create(_parent, "text_lingfu", 780, 130, 16, "#00FF00", "15万/300万")

        --方式一升级按钮
        local btn_yuanbao = GUI:Button_Create(_parent, "btn_yuanbao", 630, 80, "res/01/010005.png")
        if btn_yuanbao then
            local tx_btn_yuanbao = GUI:Text_Create(btn_yuanbao, "tx_btn_yuanbao", 55, 20, 16, "#FF0033", "升级方式一")
            GUI:setAnchorPoint(tx_btn_yuanbao, 0.5, 0.5)
            GUI:Button_loadTexturePressed(btn_yuanbao, "res/01/010006.png")   
            GUI:addOnClickEvent(btn_yuanbao, function()
                Fourelephants.Shengji(1)
            end)
        end

        --方式二升级按钮
        local btn_lingfu = GUI:Button_Create(_parent, "btn_lingfu", 750, 80, "res/01/010005.png")
        if btn_lingfu then
            local tx_tx_btn_lingfu = GUI:Text_Create(btn_lingfu, "tx_btn_lingfu", 55, 20, 16, "#FF0033", "升级方式二")
            GUI:setAnchorPoint(tx_tx_btn_lingfu, 0.5, 0.5)
            GUI:Button_loadTexturePressed(btn_lingfu, "res/01/010006.png")   
            GUI:addOnClickEvent(btn_lingfu, function()
                Fourelephants.Shengji(2)
            end)
        end

        --左上角艺术字阶数
        local lv_now = GUI:TextAtlas_Create(_parent, "lv_now", 280, 470, 30, "res/01/010007.png", 19, 25, 0)
        if lv_now then
            GUI:setAnchorPoint(lv_now, 0.5, 0.5)
        end
        local text_lv_now = GUI:Text_Create(_parent, "text_lv_now", 320, 453, 26, "#FFFF66", "阶")
      
        --当前属性
        for i = 1,4 do
            GUI:Text_Create(_parent, "text_attr_title"..i, 640, 420 - 30*(i-1), 16, "#999999", "对怪伤害：")
            GUI:Text_Create(_parent, "text_attr"..i, 730, 420 - 30*(i-1), 16, "#00ff00", "20%")
        end
        --下阶属性
        for i = 1,4 do
            GUI:Text_Create(_parent, "text_nextattr_title"..i, 640, 270 - 30*(i-1), 16, "#999999", "对怪伤害：")
            GUI:Text_Create(_parent, "text_nextattr"..i, 730, 270 - 30*(i-1), 16, "#00ff00", "20%")
        end
        --特效
        GUI:Effect_Create(_parent, "effect_four", 375, 260, 0, 2002)
        --已满级
        GUI:Image_Create(_parent, "img_maxlv", 490, 370, "res/custom/shenshouzhili/60_png.hiddenWeapon.img_anqi_B23.png")

        --右侧选择
        local RightLV = GUI:ListView_Create(_parent, "Right_LV", 905, 65, 40, 450, 1)
        Fourelephants.InitUI()
        --SL:RegisterLUAEvent("LUA_EVENT_LEVELCHANGE", "FirsetDemo", Fourelephants.updateUI)
    end
end

function Fourelephants.InitUI() --初始化
    local Right_LV = GUI:GetWindow(nil,"QSQ_Fourelephants/Right_LV")
    if Right_LV then
        for i,j in ipairs(RightControl) do
            local btn_right = GUI:Button_Create(Right_LV, "btn_right"..i, 0, 0, "res/01/010022.png")
            if btn_right then
                GUI:setContentSize(btn_right,{width = 36, height = 99})
                GUI:Button_loadTexturePressed(btn_right, "res/01/010023.png")
                GUI:Button_loadTextureDisabled(btn_right, "res/01/010023.png")
                GUI:addOnClickEvent(btn_right, function()
                    Fourelephants.ChoosePage(i)
                end)
                local btn_right_text = GUI:Text_Create(btn_right, "btn_right_text", 16, 53, 20, "#D6C6AD", j)
                if btn_right_text then
                   GUI:setAnchorPoint(btn_right_text, 0.5, 0.5)
                end
                if i == 1 then
                    Fourelephants.ChoosePage(i)
                end
            end
        end
    end

end

--选择第几页
function Fourelephants.ChoosePage(param)
    if not param then return end
    if Choose_Index == param then return end
    local btn_right = GUI:GetWindow(nil,"QSQ_Fourelephants/Right_LV/btn_right"..Choose_Index)
    if btn_right then
        GUI:Button_setBright(btn_right,true)
    end
    local btn_right = GUI:GetWindow(nil,"QSQ_Fourelephants/Right_LV/btn_right"..param)
    if btn_right then
        GUI:Button_setBright(btn_right,false)
    end
    Choose_Index = param
    Fourelephants.updateUI()
end

--更新信息
function Fourelephants.updateUI()
    local ShowLevel = tonumber(Fourelephants_data[Choose_Index])--阶数
    local Now_Index = add_List[Choose_Index] + ShowLevel --表中数据下标

    --显示的阶数
    local lv_now = GUI:GetWindow(nil,"QSQ_Fourelephants/lv_now")
    if lv_now then
        GUI:TextAtlas_setString(lv_now, ShowLevel)
    end

   --特效
   local effect_four = GUI:GetWindow(nil,"QSQ_Fourelephants/effect_four")
   if effect_four then
        GUI:removeFromParent(effect_four)
        GUI:Effect_Create(GUIparent, "effect_four", 375, 260, 0, cfg_effect[Choose_Index])
   end
  

    --所需方式一
    local text_yuanbao = GUI:GetWindow(nil,"QSQ_Fourelephants/text_yuanbao")
    if text_yuanbao then
        if cfg[Now_Index+1] ~= nil and cfg[Now_Index+1].type == Choose_Index then
            local str =SL:GetItemNameByIndex(cfg[Now_Index+1].cost[1][1])
            if cfg[Now_Index+1].cost[1][1] <= 100 then
                 GUI:Text_setString(text_yuanbao,str..":"..cfg[Now_Index+1].cost[1][2]/10000 .. "万")
            else
                GUI:Text_setString(text_yuanbao,str..":"..cfg[Now_Index+1].cost[1][2])
            end
        else
            GUI:Text_setString(text_yuanbao,"")   
        end
    end

    --所需方式二
    local text_lingfu = GUI:GetWindow(nil,"QSQ_Fourelephants/text_lingfu")
    if text_lingfu then
        if cfg[Now_Index+1] ~= nil and cfg[Now_Index+1].type == Choose_Index then
            local str =SL:GetItemNameByIndex(cfg[Now_Index+1].cost[2][1])
            GUI:Text_setString(text_lingfu,str..":"..cfg[Now_Index+1].cost[2][2])
        else
            GUI:Text_setString(text_lingfu,"")   
        end
    end

    --成功几率
    local text_rate = GUI:GetWindow(nil,"QSQ_Fourelephants/text_rate")
    if text_rate then
        if cfg[Now_Index+1] ~= nil and cfg[Now_Index+1].type == Choose_Index then
            GUI:Text_setString(text_rate,"成功率："..(cfg[Now_Index+1].cgjl/100).."%")
        else
            GUI:Text_setString(text_rate,"")   
        end
    end

    --满级图片
    local img_maxlv = GUI:GetWindow(nil,"QSQ_Fourelephants/img_maxlv")
    if cfg[Now_Index+1] == nil or cfg[Now_Index+1].type ~= Choose_Index then
        GUI:setVisible(img_maxlv,true)
    else
        GUI:setVisible(img_maxlv,false)
    end

    local Next_Index = Now_Index +  1
    local tab = cfg[Now_Index]
    local Ntab = cfg[Next_Index]
    for i = 1,4 do
        local text_attr_title = GUI:GetWindow(nil,"QSQ_Fourelephants/text_attr_title"..i)
        local text_attr = GUI:GetWindow(nil,"QSQ_Fourelephants/text_attr"..i)
        
        if ShowLevel == 0 then
            GUI:setVisible(text_attr_title,false)
            GUI:setVisible(text_attr,false)  
        else
            local Atr = tab.attribute
            if #Atr == 4 then
                GUI:setPosition(text_attr_title,640, 420- 24*(i-1))
                GUI:setPosition(text_attr,730, 420- 24*(i-1))
            else
                GUI:setPosition(text_attr_title,640, 420- 30*(i-1))    
                GUI:setPosition(text_attr,730, 420- 30*(i-1))    
            end    
            SLUpdateAttrShow(Atr,4,GUIparent,"text_attr_title","text_attr",1)   
        end

        local text_nextattr_title = GUI:GetWindow(nil,"QSQ_Fourelephants/text_nextattr_title"..i)
        local text_nextattr = GUI:GetWindow(nil,"QSQ_Fourelephants/text_nextattr"..i)
        if Ntab and Ntab.type == Choose_Index then
            local Nextatr = Ntab.attribute
            if #Nextatr == 4 then
                GUI:setPosition(text_nextattr_title,640, 270 - 24*(i-1))
                GUI:setPosition(text_nextattr,730, 270- 24*(i-1))
            else
                GUI:setPosition(text_nextattr_title,640, 270- 30*(i-1))    
                GUI:setPosition(text_nextattr,730, 270- 30*(i-1))    
            end    
            SLUpdateAttrShow(Nextatr,4,GUIparent,"text_nextattr_title","text_nextattr",1)
        else    
            GUI:setVisible(text_nextattr_title,false)
            GUI:setVisible(text_nextattr,false)    
        end
    end
end

--升级按钮
function Fourelephants.Shengji(param)
    SL:SubmitForm("D/四象之力","ShengjiFun",param.."#"..Choose_Index)
end



