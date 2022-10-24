WorldBoss = {}
local cfg = cfg_boss_tiaozhan
local GUIparent = ""


local WorldBoss_data = {}
local ChoosePage_Index = 0
local tab_index = 0
local RightPage = {"创\n世",}
local Win_W,Win_H = 815,575
WorldBoss.main = function()
    SL:SubmitForm("D/世界BOSS","SyncResponse")
end 
WorldBoss.main()

--同步信息
function WorldBoss.SyncResponse(data)
    if not data then return end
    local data = string.gsub(data, "'","")
    WorldBoss_data = SL:JsonDecode(data)
    if not GUI:GetWindow(nil,"QSQ_WorldBoss") then
        WorldBoss.createUI()
    else
        WorldBoss.updateUI()
    end
end

WorldBoss.createUI = function()
    local _parent = GUI:Win_Create("QSQ_WorldBoss", 0, 0, 0, 0, false, false, true, false)
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
        local title = GUI:Text_Create(_parent, "title", 510, 558, 20, "#D6C6AD", "世界BOSS")

       
        --右侧列表
        local Right_List = GUI:ListView_Create(_parent, "Right_List", 905, 45, 40, 450, 1)
        if Right_List then
            GUI:ListView_setItemsMargin(Right_List, 15)
            for i,data in ipairs(RightPage) do
                local btn_rightlist = GUI:Button_Create(Right_List, "btn_rightlist"..i, 0, 0, "res/01/010022.png")
                if btn_rightlist then
                    GUI:setContentSize(btn_rightlist,{width = 36, height = 99})
                    GUI:Button_loadTexturePressed(btn_rightlist, "res/01/010023.png")
                    GUI:Button_loadTextureDisabled(btn_rightlist, "res/01/010023.png")
                    GUI:addOnClickEvent(btn_rightlist, function()
                        WorldBoss.ChoosePage(i)
                    end)
                    local text_rightlist_btn = GUI:Text_Create(btn_rightlist, "text_rightlist_btn", 16, 53, 20, "#D6C6AD", data)
                    if text_rightlist_btn then
                        GUI:setAnchorPoint(text_rightlist_btn, 0.5, 0.5)
                    end
                end
            end
        end

        local box_w,box_h = 240,110
        local handle = GUI:Layout_Create(_parent, "Bgimg", 142, 45, Win_W, Win_H)
        if handle then
            local Left_List = GUI:ListView_Create(handle, "Left_List", 62, 21, 240, 446, 1)
            if Left_List then
               -- GUI:ListView_setItemsMargin(Left_List, 1)
                for i,data in ipairs(cfg) do
                    local _handle = GUI:Layout_Create(Left_List, "layout_leftlist"..i, 0, 0, box_w, box_h)
                    GUI:setTouchEnabled(_handle, true)
                    GUI:addOnClickEvent(_handle, function()
                        WorldBoss.ChooseBoss(i)
                    end)

                    --背景框
                    local img = GUI:Image_Create(_handle, "img_frame", 0, 0, "res/custom/bossyd/tg_btan.png")
                    GUI:Image_setScale9Slice(img, 10, 10, 10, 10)
                    GUI:setContentSize(img,{width = box_w, height = box_h})

                    local frame_x,frame_y = 53,53
                    --头像底图  
                    local img = GUI:Image_Create(_handle, "img_frame_bg", frame_x, frame_y, "res/custom/bossyd/bossyd_2.png")
                    GUI:setContentSize(img,{width = 86, height = 86})
                    GUI:setAnchorPoint(img, 0.5, 0.5)
                    -- 头像圈框
                    local img = GUI:Image_Create(_handle, "img_frame_yuan", frame_x, frame_y, "res/custom/bossyd/bossyd_0.png")
                    GUI:setContentSize(img,{width = 100, height = 100})
                    GUI:setAnchorPoint(img, 0.5, 0.5)
                    --头像
                    local img = GUI:Image_Create(_handle, "img_frame_hand", frame_x - 3, frame_y + 5, "res/custom/hand/".. data.hand..".png") 
                    GUI:setContentSize(img,{width = 120, height = 120})
                    GUI:setAnchorPoint(img, 0.5, 0.5)
                    --数量
                    local img = GUI:Image_Create(_handle, "img_frame_numbg", frame_x, frame_y - 30, "res/custom/bossyd/bossyd_11.png") 
                    --GUI:setContentSize(img,{width = 120, height = 120})
                    GUI:setAnchorPoint(img, 0.5, 0.5)
                    local text = GUI:Text_Create(_handle, "text_monster_num", frame_x, frame_y - 30, 18, "#D6C6AD", "2/2")
                    GUI:setAnchorPoint(text, 0.5, 0.5)

                    --怪物名字
                    local name_i,name_j = string.find(data.monster,"★")  
                    local star_i,star_j = string.find(data.monster,"\n\n")
                    local text = GUI:Text_Create(_handle, "text_monstername", 160, 70, 18, data.color, string.sub(data.monster,1,name_i - 1))
                    GUI:setAnchorPoint(text, 0.5, 0)
                    local text = GUI:Text_Create(_handle, "text_monsterstar", 160, 70 - 25, 18, data.color, string.sub(data.monster,name_i,star_i - 1))
                    GUI:setAnchorPoint(text, 0.5, 0)
                    local text = GUI:Text_Create(_handle, "text_monsterlevel", 160, 70 - 60, 18, data.color, string.sub(data.monster,star_j + 1,#data.monster))
                    GUI:setAnchorPoint(text, 0.5, 0)

                    --选中框
                    local img = GUI:Image_Create(_handle, "img_frame_frame", 0, 0, "res/custom/bossyd/bossyd_8.png")
                    GUI:Image_setScale9Slice(img, 10, 10, 10, 10)
                    GUI:setContentSize(img,{width = box_w, height = box_h})
                    GUI:setVisible(img,false)

                end
            end

            --极品掉落
            local img = GUI:Image_Create(handle, "img_drop",290 ,185 , "res/custom/bossyd/bossyd_5.png")

            --怪物模型
            GUI:Effect_Create(handle, "effect_monster", 500, 330, 2, 1)

        end




        if ChoosePage_Index == 0 then
            WorldBoss.ChoosePage(1)
        else
            WorldBoss.updateUI()
        end
       -- SL:RegisterLUAEvent("LUA_EVENT_MONEYCHANGE", "神兵锻造", WorldBoss.updateText) --货币变化时触发
    end
end
--选择页签
function WorldBoss.ChoosePage(param)
    if not param then return end
    if ChoosePage_Index == param then return end
    local handle = GUI:GetWindow(nil,"QSQ_WorldBoss/Right_List/btn_rightlist"..ChoosePage_Index)
    if handle then
        GUI:Button_setBright(handle,true)
    end
    local handle = GUI:GetWindow(nil,"QSQ_WorldBoss/Right_List/btn_rightlist"..param)
    if handle then
        GUI:Button_setBright(handle,false)
    end
    if ChoosePage_Index == 0 then tab_index = 1 end
    ChoosePage_Index = param
    WorldBoss.updateUI()
end
--更新
function WorldBoss.updateUI()
    local handle =  GUI:GetWindow(nil,"QSQ_WorldBoss/Bgimg")
    local Left_List = GUI:GetWindow(handle,"Left_List")
    if Left_List then
        for i,data in ipairs(cfg) do
            local _handle =  GUI:GetWindow(Left_List,"layout_leftlist"..i)
            local text = GUI:GetWindow(_handle,"text_monster_num")
            local num = 0
            for j,_data in ipairs(WorldBoss_data[i]) do
                num = _data + num
            end
            GUI:Text_setString(text, "("..num.."/2)")
        end
    end
    WorldBoss.ChooseBoss(tab_index)
end

function WorldBoss.ChooseBoss(param)
    tab_index = param
    local handle =  GUI:GetWindow(nil,"QSQ_WorldBoss/Bgimg")
    local Left_List = GUI:GetWindow(handle,"Left_List")
    if Left_List then
        for i,data in ipairs(cfg) do
            local _handle =  GUI:GetWindow(Left_List,"layout_leftlist"..i)
            local img = GUI:GetWindow(_handle,"img_frame_frame")
            if i == tab_index then
                GUI:setVisible(img,true)
            else
                GUI:setVisible(img,false)
            end          
        end
    end
    
    --怪物模型
    local effect = GUI:GetWindow(handle,"effect_monster")
    if effect then GUI:removeFromParent(effect) end
    --cfg[tab_index].img
    GUI:Effect_Create(handle, "effect_monster", 500, 330, 2, 20 + tab_index,1,0,4)

    --物品框掉落
    for i,data in ipairs(cfg[tab_index].yulan[1]) do
        local item = GUI:GetWindow(handle,"item_drop" .. i)
        if item then
            GUI:removeFromParent(item)
        end
        item = GUI:ItemShow_Create(handle, "item_drop"..i,325 + 68 * (i - 1),115, {index = data, look = true, bgVisible = true, count = 1})
        -- GUI:setScale(item, 0.9)
    end
    --地图
    for i,data in ipairs(cfg[tab_index].toMapId) do
        local richtext =  GUI:GetWindow(handle,"richtext_map"..i)
        if richtext then GUI:removeFromParent(richtext) end
        local str ="<a href='1'><font color='#FFFFCC' size='16'>"..data[3].."<br>("..WorldBoss_data[tab_index][i].."/1)</font></a>" 
        local richtext = GUI:RichText_Create(handle, "richtext_map"..i, 360 + 190 * (i - 1) , 50, str, 500, nil, nil, nil, function (tstr, rt)
            WorldBoss.GotoMap(i)
        end)
    end

end

function WorldBoss.GotoMap(param)
    SL:SubmitForm("D/世界BOSS","GotoMap",tab_index.."#"..param)
end


function WorldBoss.CloseUI()
    GUI:Win_Close(GUIparent)
end
