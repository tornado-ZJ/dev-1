WeaponForging = {}
local cfg = cfg_Simplecompound
local GUIparent = ""


local WeaponForging_data = {}
local Choose_Index = 1
local pos_y = -2
local itemdata = {
    [1] = {
        index = 4,                    --物品模板id
        look  = true,                --是否显示tips
        bgVisible = true,            --是否显示背景框
        count = 1,                    --物品数量
        color = 225,                --颜色
        -- checkPower=true             --是否检查战力从而显示提升小箭头
        -- showModelEffect=true        --只显示内观特效不显示背包特效
        -- onlyShowSFX=true            --只显示道具特效其它都不显示
        -- noMouseTips=true            --鼠标移入不显示tips
    },
    [2] = {
        index = 4,                    --物品模板id
        look  = true,                --是否显示tips
        bgVisible = true,            --是否显示背景框
        count = 1,                    --物品数量
        color = 225,                --颜色
        -- checkPower=true             --是否检查战力从而显示提升小箭头
        -- showModelEffect=true        --只显示内观特效不显示背包特效
        -- onlyShowSFX=true            --只显示道具特效其它都不显示
        -- noMouseTips=true            --鼠标移入不显示tips
    },
    [3] = { 
        index = 4,                    --物品模板id
        look  = true,                --是否显示tips
        bgVisible = true,            --是否显示背景框
        count = 1,                    --物品数量
        color = 225,                --颜色
        -- checkPower=true             --是否检查战力从而显示提升小箭头
        -- showModelEffect=true        --只显示内观特效不显示背包特效
        -- onlyShowSFX=true            --只显示道具特效其它都不显示
        -- noMouseTips=true            --鼠标移入不显示tips
    },
}



WeaponForging.main = function()
    SL:SubmitForm("D/神兵锻造","SyncResponse")
end 
WeaponForging.main()

--同步信息
function WeaponForging.SyncResponse()
    -- if not data then return end
    -- local data = string.gsub(data, "'","")
    -- WeaponForging_data = SL:JsonDecode(data)
    if not GUI:GetWindow(nil,"QSQ_WeaponForging") then
        WeaponForging.createUI()
    else
        WeaponForging.updateUI()
    end
end

WeaponForging.createUI = function()
    local _parent = GUI:Win_Create("QSQ_WeaponForging", 0, 0, 0, 0, false, false, true, false)
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
        local title = GUI:Text_Create(_parent, "title", 510, 558, 20, "#D6C6AD", "神兵锻造")

        --合成背景图
        local img_hecheng_left = GUI:Image_Create(_parent, "img_hecheng_left", 322, 66, "res/custom/hecheng/door_left_img.jpg")
        if img_hecheng_left then
            GUI:setContentSize(img_hecheng_left,{width = 288, height = 446})
        end  
        local img_hecheng_right = GUI:Image_Create(_parent, "img_hecheng_right", 610, 66, "res/custom/hecheng/door_right_img.jpg")
        if img_hecheng_right then
            GUI:setContentSize(img_hecheng_right,{width = 288, height = 446})
        end 


        --左边列表
        local Left_list = GUI:ListView_Create(_parent, "Left_list", 210, 65, 200, 446, 1)
        if Left_list then
            GUI:ListView_setItemsMargin(Left_list, 1)
        end
        for i,data in ipairs(cfg) do
            local btn_liftlist = GUI:Button_Create(Left_list, "btn_liftlist"..i, 0, 0, "res/01/010005.png")
            if btn_liftlist then
                GUI:setContentSize(btn_liftlist,{width = 110, height = 36})
                GUI:Button_loadTexturePressed(btn_liftlist, "res/01/010006.png")   
                GUI:addOnClickEvent(btn_liftlist, function()
                    Choose_Index = i
                    WeaponForging.updateUI()
                end)
                local text_liftlist_btn = GUI:Text_Create(btn_liftlist, "text_liftlist_btn", 55, 18, 18, "#666666", data.title)
                if text_liftlist_btn then
                    GUI:setAnchorPoint(text_liftlist_btn, 0.5, 0.5)
                end
            end
        end


        --材料消耗
        GUI:Image_Create(_parent, "img_text1", 570, 465+pos_y, "res/custom/hecheng/comp_5.png")
        --获得预览
        GUI:Image_Create(_parent, "img_text2", 570, 300+pos_y, "res/custom/hecheng/comp_4.png")
        --分支
        local img_branch = GUI:Image_Create(_parent, "img_branch", 612, 340+pos_y, "res/custom/hecheng/comp_2.png")
        if img_branch then
            GUI:setAnchorPoint(img_branch, 0.5, 0.5)
        end
        --物品框背景
        for i = 1,2 do
            local img_equal = GUI:Image_Create(_parent, "img_equal"..i, 545+135*(i-1), 422+pos_y, "res/custom/hecheng/equip_gridBg2.png")
            if img_equal then
                GUI:setAnchorPoint(img_equal, 0.5, 0.5)
            end
            local img_equal_frame = GUI:Image_Create(_parent, "img_equal_frame"..i, 545+135*(i-1), 422+pos_y, "res/custom/hecheng/equip_gridBg2_s.png")
            if img_equal_frame then
                GUI:setAnchorPoint(img_equal_frame, 0.5, 0.5)
            end
            local item_ = GUI:ItemShow_Create(_parent, "item_"..i,545+135*(i-1), 422+pos_y, itemdata[i])
            if item_ then
                GUI:setScale(item_, 0.9)
                GUI:setAnchorPoint(item_, 0.5, 0.5)
                GUI:Text_Create(item_, "text_num", 0, 0, 16, "#ff0000", "0/1")
            end
        end

        local img_equal_get = GUI:Image_Create(_parent, "img_equal_get", 612, 240+pos_y, "res/custom/hecheng/equip_gridBg1.png")
        if img_equal_get then
            GUI:setAnchorPoint(img_equal_get, 0.5, 0.5)
        end
        local img_equal_frame_get = GUI:Image_Create(_parent, "img_equal_frame_get",612, 240+pos_y, "res/custom/hecheng/equip_gridBg1_s.png")
        if img_equal_frame_get then
            GUI:setAnchorPoint(img_equal_frame_get, 0.5, 0.5)
        end
        local item_get = GUI:ItemShow_Create(_parent, "item_get",612, 240+pos_y, itemdata[3])
        if item_get then
            GUI:setScale(item_get, 0.9)
            GUI:setAnchorPoint(item_get, 0.5, 0.5)
        end

        --货币消耗 
        local str ="<font color='#ffffff' size='18'>元宝：</font><font color='#4AE74A' size='18'>155万</font>" 
        local text_money = GUI:RichText_Create(_parent, "text_money", 610, 180, str, 500, nil, nil, nil)
        if text_money then
            GUI:setAnchorPoint(text_money, 0.5, 0.5)
        end
 
        --成功率 
        local text_rate = GUI:Text_Create(_parent, "text_rate", 610, 145, 16, "#00ff00", "成功率：75%")
        if text_rate then
            GUI:setAnchorPoint(text_rate, 0.5, 0.5)
        end

        --合成按钮
        local btn_hecheng = GUI:Button_Create(_parent, "btn_hecheng", 560, 85, "res/01/010005.png")
        if btn_hecheng then
            local tx_tx_btn_hecheng = GUI:Text_Create(btn_hecheng, "tx_btn_hecheng", 54, 20, 16, "#FFFF66", "合 成")
            GUI:setAnchorPoint(tx_tx_btn_hecheng, 0.5, 0.5)
            GUI:Button_loadTexturePressed(btn_hecheng, "res/01/010006.png")   
            GUI:addOnClickEvent(btn_hecheng, function()
                WeaponForging.Hecheng(Choose_Index)
            end)
        end

        WeaponForging.updateUI()
        SL:RegisterLUAEvent("LUA_EVENT_MONEYCHANGE", "神兵锻造", WeaponForging.updateText) --货币变化时触发
    end
end

--更新
function WeaponForging.updateUI()
    local Left_list = GUI:GetWindow(nil,"QSQ_WeaponForging/Left_list")
    if Left_list then
        for i,data in ipairs(cfg) do
            local text_liftlist_btn = GUI:GetWindow(nil,"QSQ_WeaponForging/Left_list/btn_liftlist"..i.."/text_liftlist_btn")
            if text_liftlist_btn then
                if i == Choose_Index then
                    GUI:Text_setTextColor(text_liftlist_btn, "#FFFF66")
                else
                    GUI:Text_setTextColor(text_liftlist_btn, "#666666")
                end
            end      
        end
        for i = 1,2 do
            local item_ = GUI:GetWindow(nil,"QSQ_WeaponForging/item_"..i) 
            if item_ then
                GUI:removeFromParent(item_)
                itemdata[i].index = cfg[Choose_Index].itemid[i][1]
                local item_ = GUI:ItemShow_Create(GUIparent, "item_"..i,545+135*(i-1), 422+pos_y, itemdata[i])
                if item_ then
                    GUI:setScale(item_, 0.9)
                    GUI:setAnchorPoint(item_, 0.5, 0.5)
                    local bag_num = SL:GetItemNumberByIndex(itemdata[i].index)
                    GUI:Text_Create(item_, "text_num", 16, 0, 18, "#ff0000", bag_num.."/"..cfg[Choose_Index].itemid[i][2])
                end
            end
        end
        local item_get = GUI:GetWindow(nil,"QSQ_WeaponForging/item_get") 
        if item_get then
            GUI:removeFromParent(item_get)
            itemdata[3].index = cfg[Choose_Index].product[1][1]
            itemdata[3].count =  cfg[Choose_Index].product[1][2]
            local item_get = GUI:ItemShow_Create(GUIparent, "item_get",612, 240+pos_y, itemdata[3])
            if item_get then
                GUI:setScale(item_get, 0.9)
                GUI:setAnchorPoint(item_get, 0.5, 0.5)
            end
        end
        --货币消耗
        local text_money = GUI:GetWindow(nil,"QSQ_WeaponForging/text_money") 
        if text_money then
            GUI:removeFromParent(text_money)
            local cost_name = SL:GetItemNameByIndex(cfg[Choose_Index].itemid[3][1])--获取名字
			local cost_num = cfg[Choose_Index].itemid[3][2]						--消耗数量
			local bag_num = SL:GetItemNumberByIndex(cfg[Choose_Index].itemid[3][1]) --背包数量
			local cost_str = SLChangeColour(bag_num,cost_num,cost_name)
            --local name = SL:GetItemNameByIndex(cfg[Choose_Index].itemid[3][1])
           -- local str ="<font color='#ffffff' size='18'>"..name.."：</font><font color='#4AE74A' size='18'>"..(cfg[Choose_Index].itemid[3][2])/10000 .."万".."</font>" 
            local text_money = GUI:RichText_Create(GUIparent, "text_money", 612, 180, cost_str, 250, nil, nil, nil)
            if text_money then
                GUI:setAnchorPoint(text_money, 0.5, 0.5)
            end
        end
        --成功率 
        local text_rate = GUI:GetWindow(nil,"QSQ_WeaponForging/text_rate") 
        if text_rate then
            GUI:Text_setString(text_rate, "成功率："..cfg[Choose_Index].probability/100 .. "%")
        end
    end
end

function WeaponForging.updateText()
    local _parent = GUI:GetWindow(nil,"QSQ_WeaponForging")
    if not _parent then return end
    --货币消耗
    local text_money = GUI:GetWindow(nil,"QSQ_WeaponForging/text_money") 
    if text_money then
        GUI:removeFromParent(text_money)
        local cost_name = SL:GetItemNameByIndex(cfg[Choose_Index].itemid[3][1])--获取名字
        local cost_num = cfg[Choose_Index].itemid[3][2]						--消耗数量
        local bag_num = SL:GetItemNumberByIndex(cfg[Choose_Index].itemid[3][1]) --背包数量
        local cost_str = SLChangeColour(bag_num,cost_num,cost_name)
        local text_money = GUI:RichText_Create(GUIparent, "text_money", 612, 180, cost_str, 250, nil, nil, nil)
        if text_money then
            GUI:setAnchorPoint(text_money, 0.5, 0.5)
        end
    end
end

function WeaponForging.Hecheng(param)
    SL:SubmitForm("D/神兵锻造","Hecheng",param)
end    

