PayVip = {}
local cfg = cfg_vip
local GUIparent = ""


local PayVip_data = {}
local Select_index = 0


local tequan_data = {}
local Win_W,Win_H = 815,575
local pro_x,pro_y = 300,400
PayVip.main = function()
    SL:SubmitForm("D/至尊王权","SyncResponse")
end 
PayVip.main()

--同步信息
function PayVip.SyncResponse(data)
    if not data then return end
    local data = string.gsub(data, "'","")
    PayVip_data = SL:JsonDecode(data)
    Select_index = PayVip_data.level + 1
    Select_index = Select_index > #cfg and #cfg or Select_index
    GetTuquanData()
    if not GUI:GetWindow(nil,"QSQ_PayVip") then
        PayVip.createUI()
    else
        PayVip.updateUI()
    end
end

PayVip.createUI = function()
    local _parent = GUI:Win_Create("QSQ_PayVip", 0, 0, 0, 0, false, false, true, false)
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
        local handle = GUI:Image_Create(_parent, "bg_kuang", 142, 45, "res/01/010000.png")
        if handle then
            GUI:setContentSize(handle,{width = Win_W, height = Win_H})
            GUI:setTouchEnabled(handle, true)

            --背景图
            local _handle = GUI:Image_Create(handle, "img_bg", 61, 21, "res/custom/vip/vip_1.jpg")
            if _handle then
                GUI:setContentSize(_handle,{width = 692, height = 446})

            end

            
            --会员列表
            local Vip_ListView = GUI:ListView_Create(handle, "Vip_ListView", 61, 18, 115, 350, 1)
            if Vip_ListView then
                --GUI:ListView_setItemsMargin(Vip_ListView, 1)
                for i,v in ipairs(cfg) do
                    local _handle = GUI:Layout_Create(Vip_ListView, "layout_lv" .. i, 0, 0, 115, 43)
                    if _handle then
                        local img = GUI:Image_Create(_handle, "img_lv", 0, 8, "res/custom/vip/vip_8.png")
                        if img then
                            GUI:setTouchEnabled(img, true)
                            GUI:addOnClickEvent(img, function()
                                PayVip.SelectVip(i)
                            end)
                        end
                        local img = GUI:Image_Create(_handle, "img_lv_frame", 0, 8, "res/custom/vip/vip_7.png")
                        if img then
                            GUI:setVisible(img,false)
                        end
                    
                        --vip名字
                        local text = GUI:Text_Create(_handle, "text_name", 60, 26, 16, "#D6C6AD", v.Txt)
                        if text then
                            GUI:setAnchorPoint(text, 0.5, 0.5) 
                        end

                        -- GUI:Layout_setBackGroundColor(_handle, "#4AE74A")
                        -- GUI:Layout_setBackGroundColorType(_handle, 1)
                        -- GUI:Layout_setBackGroundColorOpacity(_handle, 155)
                    end
                end
            end




            --进度条
            local bar_di =  GUI:Image_Create(handle, "bar_di", pro_x, pro_y, "res/custom/vip/vip_3.png")
            local bar =  GUI:LoadingBar_Create(handle, "bar", pro_x, pro_y, "res/custom/vip/vip_2.png", 0)
            local bar_kuang =  GUI:Image_Create(handle, "bar_kuang", pro_x, pro_y, "res/custom/vip/vip_4.png")
            local text = GUI:Text_Create(handle, "bar_text", pro_x, pro_y, 16, "#ffffff", "")
            GUI:setAnchorPoint(text, 0.5, 0.5)
            GUI:setAnchorPoint(bar_di, 0.5, 0.5)
            GUI:setAnchorPoint(bar, 0.5, 0.5)
            GUI:setAnchorPoint(bar_kuang, 0.5, 0.5)
            GUI:setContentSize(bar,{width = 370, height = 13})
            GUI:setContentSize(bar_di,{width = 370, height = 13})
 
            
            --需要多少灵符
            local str = "<font color='#ffffff' size='18'></font>"
            local richtext = GUI:RichText_Create(handle, "richtext_needmoney", pro_x - 180, pro_y + 30, str, 350, nil, nil, nil)
            if richtext then
                GUI:setAnchorPoint(richtext, 0.5, 0.5)
            end


            --充值按钮
            local btn = GUI:Button_Create(handle, "btn_recharge", 600, 400, "res/custom/vip/vip_5.png")
            if btn then
                local text = GUI:Text_Create(btn, "text_btn", 54, 22, 16, "#FFFF66", "立即充值")
                GUI:setAnchorPoint(text, 0.5, 0.5)
                GUI:Button_loadTexturePressed(btn, "res/custom/vip/vip_6.png")   
                GUI:addOnClickEvent(btn, function()
                    PayVip.LijiRecharge()
                end)
            end

            --特权
            local img = GUI:Image_Create(handle, "img_tequanbg", 180, 162, "res/custom/vip/vip_9.png")
            if img then
                GUI:Image_setScale9Slice(img, 10, 10, 10, 10)
                GUI:setContentSize(img,{width = 575/2, height = 207})
            end
            GUI:Image_Create(handle, "img_tequanbgimg", 193, 330, "res/custom/vip/txt_tequan.png")

            for i,v in ipairs(tequan_data) do
                local img = GUI:Image_Create(handle, "img_tequantextbg" .. i,250, 318 - 35 * (i - 1), "res/custom/zhigou/1.png")
                if img then
                    GUI:Image_setScale9Slice(img, 10, 10, 10, 10)
                    GUI:setContentSize(img,{width = 200, height = 30})
                end
                local text = GUI:Text_Create(handle, "text_tequan_desc" .. i, 290, 322 - 35 * (i - 1), 16, "#D6C6AD", "锁定："..v.name)
            end


            --属性
            local img = GUI:Image_Create(handle, "img_attr", 180 + 575/2, 162, "res/custom/vip/vip_9.png")
            if img then
                GUI:Image_setScale9Slice(img, 10, 10, 10, 10)
                GUI:setContentSize(img,{width = 575/2, height = 207})
            end
            GUI:Image_Create(handle, "img_attrimg", 193 + 575/2, 330, "res/custom/vip/txt_VIP.png")

            local layout = GUI:Layout_Create(handle, "layout_attr",180 + 575/2, 162, 575/2, 207)



            --激活按钮
            local btn = GUI:Button_Create(handle, "btn_activation", 415, 30, "res/custom/vip/vip_5.png")
            if btn then
                local text = GUI:Text_Create(btn, "text_btn_activation", 54, 22, 16, "#ffffff", "激活")
                GUI:setAnchorPoint(text, 0.5, 0.5)
                GUI:Button_loadTexturePressed(btn, "res/custom/vip/vip_6.png")   
                GUI:addOnClickEvent(btn, function()
                    PayVip.Activation()
                end)
            end

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
        local title = GUI:Text_Create(_parent, "title", 510, 558, 20, "#D6C6AD", "至尊王权")

        PayVip.updateUI()
        --SL:RegisterLUAEvent("LUA_EVENT_MONEYCHANGE", "FirsetDemo", Fourelephants.updateUI)
    end
end

--更新
function PayVip.updateUI()
    PayVip.SelectVip(Select_index)
end

function PayVip.SelectVip(param)
    Select_index = param
    local handle =  GUI:GetWindow(nil,"QSQ_PayVip/bg_kuang")
    if handle then
        local Vip_ListView = GUI:GetWindow(handle,"Vip_ListView") 
        if Vip_ListView then 
            for i,v in ipairs(cfg) do
                local _handle = GUI:GetWindow(Vip_ListView,"layout_lv" .. i)
                if _handle then
                    local img = GUI:GetWindow(_handle,"img_lv_frame")
                    local state = Select_index == i
                    GUI:setVisible(img,state)
                    local text = GUI:GetWindow(_handle,"text_name")
                    if state then --名字颜色
                        GUI:Text_setTextColor(text, "#D6C6AD")
                    else
                        GUI:Text_setTextColor(text, "#666666")
                    end
                    
                end
            end
        end

        --进度条里文本
        local bar_text = GUI:GetWindow(handle,"bar_text")
        local bag_num = SL:GetItemNumberByIndex(7) --灵符数量
        if bar_text then
            GUI:Text_setString(bar_text,bag_num.."/"..cfg[Select_index].NeedExp)
        end
        --进度条
        local bar = GUI:GetWindow(handle,"bar")
        if bar then
            GUI:LoadingBar_setPercent(bar,bag_num / cfg[Select_index].NeedExp * 100)
        end

        --需要多少灵符
        local str = "<font color='#ffffff' size='18'>需要   </font><font color='#00ff00' size='18'>"..cfg[Select_index].NeedExp.."灵符</font><font color='#ffffff' size='18'>   即可激活</font>"
        local richtext = GUI:GetWindow(handle,"richtext_needmoney")
        if richtext then GUI:removeFromParent(richtext) end
        richtext = GUI:RichText_Create(handle, "richtext_needmoney", pro_x - 180, pro_y + 30, str, 350, nil, nil, nil)
        if richtext then
            GUI:setAnchorPoint(richtext, 0, 0.5)
        end

        GetTuquanData()
        --特权
        for i,v in ipairs(tequan_data) do
            local text =  GUI:GetWindow(handle,"text_tequan_desc" .. i)
            local str = v.lock == 1 and "解锁" or "锁定"
            local color = v.lock == 1 and "#ffff00" or "#D6C6AD"
            GUI:Text_setString(text, str .. "：".. v.name)
            GUI:Text_setTextColor(text, color)
        end

        --属性       
        local layout = GUI:GetWindow(handle,"layout_attr")
        if layout then
            GUI:removeAllChildren(layout)
            for i,v in ipairs(cfg[Select_index].zhanshi) do
                local pos_x = #cfg[Select_index].zhanshi < 5 and 80 or 20 + 130 * (math.ceil(i/ 4) - 1)
                local pos_y =  140 - 40 * ((i - 1) % 4)
                if #cfg[Select_index].zhanshi > 4 then
                    if i <= 4 then
                        local img = GUI:Image_Create(layout, "img_attrtbg" .. i,pos_x - 25, pos_y - 5, "res/custom/zhigou/1.png")
                        if img then
                            GUI:Image_setScale9Slice(img, 10, 10, 10, 10)
                            GUI:setContentSize(img,{width = 290, height = 30})
                        end
                    end
                    
                else
                    local img = GUI:Image_Create(layout, "img_attrtbg" .. i,pos_x - 50, pos_y - 5, "res/custom/zhigou/1.png")
                    if img then
                        GUI:Image_setScale9Slice(img, 10, 10, 10, 10)
                        GUI:setContentSize(img,{width = 200, height = 30})
                    end
                end

                local text_attr_title = GUI:Text_Create(layout, "text_attr_title" .. i,pos_x, pos_y, 16, "#D6C6AD", "")
                local text_attr_value = GUI:Text_Create(layout, "text_attr_value" .. i,pos_x + 80 , pos_y, 16, "#00ff00", "")
            end
            for i,v in ipairs(cfg[Select_index].zhanshi) do
                SLUpdateAttrShow(cfg[Select_index].zhanshi,#cfg[Select_index].zhanshi,layout,"text_attr_title","text_attr_value",1)
            end
        end


       
        --物品框 礼包
        for i,v in ipairs(cfg[Select_index].Gift) do
            local item = GUI:GetWindow(handle,"item_gift_" .. i)
            if item then GUI:removeFromParent(item) end
            item = GUI:ItemShow_Create(handle, "item_gift_" .. i,220 + 80 * (i - 1),93, {index = v[1], look = true, bgVisible = true, count = v[2]})
        end


        --激活按钮
        local btn =  GUI:GetWindow(handle,"btn_activation")
        if btn then
            local text = GUI:GetWindow(btn,"text_btn_activation")
            local str = Select_index > PayVip_data.level and "未激活" or "已激活"
            GUI:Text_setString(text, str)
        end

        --称号特效
        local effect = GUI:GetWindow(handle,"effect_title")
        if effect then GUI:removeFromParent(effect) end
        GUI:Effect_Create(handle, "effect_title", 450, 425, 0, cfg_zhanshi[Select_index].id)

    end
end

--立即充值
function PayVip.LijiRecharge()
    SL:OpenStoreUI(5)
end


function GetTuquanData() --特效信息表
    tequan_data = {}
    tequan_data[1] =  {name = "拾取使用",lock = cfg[Select_index].use}
    tequan_data[2] =  {name = "打金特权",lock = cfg[Select_index].dajin}
    tequan_data[3] =  {name = "自动回收",lock = cfg[Select_index].Pet}
    tequan_data[4] =  {name = "一键拾取",lock = cfg[Select_index].DropToMap}
    tequan_data[5] =  {name = "自动熔炼",lock = cfg[Select_index].ronglian}
    return tequan_data
end

--激活
function PayVip.Activation()
    SL:SubmitForm("D/至尊王权","Activation",Select_index)
end