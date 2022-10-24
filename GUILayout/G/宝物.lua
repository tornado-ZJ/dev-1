baowu = {}
local cfg = cfg_baowu
if cfg then
    print("读取配置文件成功")
else
    print("读取配置文件失败")
end
local GUIparent = ""

local Choose_Index = 0--当前页面
local RightTab = {"天\n煞\n芦","青\n冥\n令","炎\n火\n塔","鬼\n灭\n印"}
local cfg_effect = {2001,2002,2003,2004}
local add_List = {0, 50, 100, 130}

local Baowu_data = {}

baowu.main = function()
    SL:SubmitForm("G/宝物","SyncResponse")
end
baowu.main()
--同步信息
function baowu.SyncResponse(data)
    if not data then return end
    local data = string.gsub(data,"'","")
    Baowu_data = SL:JsonDecode(data)
    if not GUI:GetWindow(nil,"baowu") then
        baowu.createUI()
    else
        baowu.updateUI()
    end
end
baowu.createUI = function()
    --创建窗口
    local _parent = GUI:Win_Create("baowu", 0, 0, 0, 0, false, false, true, false)
    if _parent then
        GUIparent = _parent
        local winSize = SL:GetScreenSize()
        local x = winSize.width / 2
        local y = winSize.height / 2
        local w = winSize.width
        local h = winSize.height
        --创建容器
        local layout = GUI:Layout_Create(_parent, "diban", x, y, w, h)
        if layout then
            GUI:setAnchorPoint(layout, 0.5, 0.5)
        end

        --点击面板以外区域关闭面板
        local bg_close = GUI:Image_Create(_parent, "bg_close", 0, 0, "res/01/010010.png")
        if bg_close then
            GUI:setContentSize(bg_close, {width = w, height = h})
            GUI:setTouchEnabled(bg_close, true)
            GUI:addOnClickEvent(bg_close, function()
                GUI:Win_Close(_parent)
            end)
        end

        --设置面板框图片
        local bg_Mbkuang = GUI:Image_Create(_parent, "bg_Mbkuang", 145, 45, "res/01/010000.png")
        if bg_Mbkuang then
            GUI:setContentSize(bg_Mbkuang, {width = 815, height = 575})
            GUI:setTouchEnabled(bg_Mbkuang, true)
        end

        --设置关闭按钮
        local btn_close = GUI:Button_Create(_parent, "btn_close", 870, 515, "res/01/010008.png")
        if btn_close then
            GUI:Button_loadTexturePressed(btn_close, "res/01/010009.png")
            GUI:addOnClickEvent(btn_close, function()
                GUI:Win_Close(_parent)
            end)
        end
        --设置宝物背景
        local bg_baowu = GUI:Image_Create(_parent, "bg_baowu", 200, 66, "res/custom/painting/lunhuiequip_bg.png")
        if bg_baowu then
            GUI:setContentSize(bg_baowu,{width = 700, height = 470})
        end  

        --设置界面标题
        local title = GUI:Text_Create(_parent, "title", 520,555,20,"#D6C6AD","法宝使者")

        --当前属性背景图
        GUI:Image_Create(_parent, "bg_nowattrimg",620,350,"res/custom/shenshouzhili/a_img.png")
        GUI:Image_Create(_parent, "img_nowattrtitle", 700, 465, "res/01/010002.png")

        --下阶属性背景图
        GUI:Image_Create(_parent, "bg_nextattrimg",620,200,"res/custom/shenshouzhili/a_img.png")
        GUI:Image_Create(_parent, "img_nextattrtitle", 700, 315, "res/01/010003.png")

        --天煞子材
        local text_tiansha = GUI:Text_Create(_parent, "text_tiansha", 690, 170, 16, "#00FF00", "天煞子材：24/35")

        --元宝
        local text_yuanbao = GUI:Text_Create(_parent, "text_yuanbao", 690, 140, 16, "#00FF00", "元宝：100000")

        --升级按钮
        local btn_shengji = GUI:Button_Create(_parent, "btn_shengji", 690, 100, "res/01/010005.png")
        if btn_shengji then
            local text_btn_shengji =GUI:Text_Create(btn_shengji, "text_btn_shengji", 55,20,16, "#D6C6AD", "升  级")
            GUI:setAnchorPoint(text_btn_shengji, 0.5, 0.5)
            GUI:Button_loadTexturePressed(btn_shengji, "res/01/010006.png")
            GUI:addOnClickEvent(btn_shengji, function()
                baowu.Shengji()
            end)
        end

        --左上角艺术字阶数
        local lv_now = GUI:TextAtlas_Create(_parent, "lv_now", 250, 470, 6, "res/custom/baowu/11.png", 21, 20, 0)
        if lv_now then
            GUI:setAnchorPoint(lv_now, 0.5, 0.5)
        end
        local text_lv_now = GUI:Text_Create(_parent, "text_lv_now", 280, 453, 26, "#FFFF66", "阶")

        --当前属性
        for i = 1, 3 do
            GUI:Text_Create(_parent, "text_attr_title"..i, 670, 430 - 30 * (i - 1), 16, "#999999","生  命：")
            GUI:Text_Create(_parent, "text_attr"..i, 760, 430 -30 * (i - 1), 16, "#999999", 1000)
        end

        --下阶属性
        for i = 1, 3 do
            GUI:Text_Create(_parent, "text_nextattr_title"..i, 670, 280 - 30 * (i - 1), 16, "#999999","生  命：")
            GUI:Text_Create(_parent, "text_nextattr"..i, 760, 280 -30 * (i - 1), 16, "#999999", 1000)
        end

        --特效
        GUI:Effect_Create(_parent, "effect_baowu", 0, 0, 0, 2001)

        
        --满级
        GUI:Image_Create(_parent, "img_maxlv", 490, 370, "res/custom/shenshouzhili/60_png.hiddenWeapon.img_anqi_B23.png")

        --右侧选择
        local RightTab = GUI:ListView_Create(_parent, "Right_LV", 900, 30, 50, 500, 1)
        baowu.InitUI()
        SL:RegisterLUAEvent("LUA_EVENT_LEVELCHANGE", "宝物升级", baowu.updateUI)
    end        

end

function baowu.InitUI()
    local Right_LV = GUI:GetWindow(nil, "baowu/Right_LV")
    if Right_LV then
        for i, j in ipairs(RightTab) do
            local btn_right = GUI:Button_Create(Right_LV, "btn_right"..i, 0, 0, "res/01/010038.png")
            if btn_right then
                GUI:setContentSize(btn_right, {width = 30, height = 100})
                GUI:Button_loadTexturePressed(btn_right, "res/01/010039.png")
                GUI:Button_loadTextureDisabled(btn_right, "res/01/010039.png")
                GUI:addOnClickEvent(btn_right, function()
                    baowu.ChoosePage(i)
                end)

                local text_btn_right = GUI:Text_Create(btn_right, "text_btn_right", 15, 50, 20, "#D6C6AD",j)
                if text_btn_right then
                    GUI:setAnchorPoint(text_btn_right, 0.5, 0.5)
                end
                if i == 1 then
                    baowu.ChoosePage(i)
                end

            end
        end
    end
end

--选择页
function baowu.ChoosePage(index)
    if not index then return end
    if Choose_Index == index then return end
    local btn_right = GUI:GetWindow(nil, "baowu/Right_LV/btn_right"..Choose_Index)
    if btn_right then
        GUI:Button_setBright(btn_right, true)
    end
    local btn_right = GUI:GetWindow(nil, "baowu/Right_LV/btn_right"..index)
    if btn_right then
        GUI:Button_setBright(btn_right, false)
    end
    Choose_Index = index
    baowu.updateUI()
end

--更新UI信息
function baowu.updateUI()
    local ShowLevel = tonumber(Baowu_data[Choose_Index])--阶数
    local Now_Index = add_List[Choose_Index] + ShowLevel----表中数据下标

    --显示的阶数
    local lv_now = GUI:GetWindow(nil, "baowu/lv_now")
    if lv_now then
        GUI:TextAtlas_setString(lv_now, ShowLevel)
    end

    for i =1, 3 do
        --当前属性
        local text_attr_title = GUI:GetWindow(nil,"baowu/text_attr_title"..i)
        local text_attr = GUI:GetWindow(nil,"baowu/text_attr"..i)

        if ShowLevel == 0 then
            GUI:setVisible(text_attr_title,false)
            GUI:setVisible(text_attr,false)
        else
            local Attr = cfg[Now_Index].attribute
            if #Attr == 3 then
                GUI:setPosition(text_attr_title,670, 430 - 30*(i - 1))
                GUI:setPosition(text_attr, 760, 430 - 30*(i - 1))
            else
                GUI:setPosition(text_attr_title,670, 430 - 40*(i - 1))
                GUI:setPosition(text_attr, 760, 430 - 40*(i - 1))
            end
            SLUpdateAttrShow(Attr, 3, GUIparent, "text_attr_title", "text_attr", 1)
        end
        --下阶属性
        local text_nextattr_title = GUI:GetWindow(nil,"baowu/text_nextattr_title"..i)
        local text_nextattr = GUI:GetWindow(nil,"baowu/text_nextattr"..i)
        local Next_Index = Now_Index + 1
        local Ntab = cfg[Next_Index]
        if Ntab and Ntab.type ==Choose_Index then
            local Nextattr = Ntab.attribute
            if #Nextattr ==3 then
                GUI:setPosition(text_nextattr_title,670, 280 - 30*(i-1))
                GUI:setPosition(text_nextattr, 760, 280 - 30*(i - 1))
            else
                GUI:setPosition(text_nextattr_title,670, 280 - 40*(i-1))
                GUI:setPosition(text_nextattr, 760, 280 - 40*(i - 1))
            end
            SLUpdateAttrShow(Nextattr, 3, GUIparent, "text_nextattr_title", "text_nextattr", 1)
        else
            GUI:setVisible(text_nextattr_title, false)
            GUI:setVisible(text_nextattr, false)
        end
    end

    --特效
    local effect_baowu = GUI:GetWindow(nil, "baowu/effect_baowu")
    if effect_baowu then
        GUI:removeFromParent(effect_baowu)
        GUI:Effect_Create(GUIparent, "effect_baowu", 430,200, 0, cfg_effect[Choose_Index])
    end


    --升级
    local num_tiansha = SL:GetItemNumberByIndex(cfg[Now_Index+1].cost[1][1])--拥有的天煞子材数量
    local num_yuanbao = SL:GetItemNumberByIndex(cfg[Now_Index+1].cost[2][1])--拥有的元宝数量
    local A = SLUnitBase(num_tiansha)
    local B = SLUnitBase(num_yuanbao)
    local text_tiansha = GUI:GetWindow(nil, "baowu/text_tiansha")
    local text_yuanbao = GUI:GetWindow(nil, "baowu/text_yuanbao")
    if text_tiansha and text_yuanbao then
        if cfg[Now_Index+1] ~= nil and cfg[Now_Index+1].type == Choose_Index then
            local str1 = SL:GetItemNameByIndex(cfg[Now_Index+1].cost[1][1])
            local str2 = SL:GetItemNameByIndex(cfg[Now_Index+1].cost[2][1])
            GUI:Text_setString(text_tiansha, str1..":"..A.."/"..cfg[Now_Index+1].cost[1][2])
            GUI:Text_setString(text_yuanbao, str2..":"..B.."/"..cfg[Now_Index+1].cost[2][2])
        else
            GUI:Text_setString(text_tiansha, "")
            GUI:Text_setString(text_yuanbao, "")
        end
    end

    --满级
    local img_maxlv = GUI:GetWindow(nil, "baowu/img_maxlv")
    if cfg[Now_Index+1] == nil or cfg[Now_Index+1].type ~= Choose_Index then
        GUI:setVisible(img_maxlv, true)
    else
        GUI:setVisible(img_maxlv,false)
    end
end


--升级按钮
function baowu.Shengji()
    SL:SubmitForm("G/宝物", "Shengji", Choose_Index)
end