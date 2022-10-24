Shouchong = {}

local cfg = cfg_shouchong
local reward_list = {}


Shouchong.main = function()
    local _parent = GUI:Win_Create("QSQ_shouchong", 0, 0, 0, 0, false, false, true, false)
    if _parent then
        local winSize = SL:GetScreenSize()
        local x = winSize.width / 2
        local y = winSize.height / 2
        local w = winSize.width
        local h = winSize.height

        --点击面板以外区域关闭面板
        local bg_close = GUI:Image_Create(_parent, "bg_close", 0, 0, "dev/res/01/010010.png")
        if bg_close then
            GUI:setContentSize(bg_close, {width = w, height = h})
            GUI:setTouchEnabled(bg_close, true)
            GUI:addOnClickEvent(bg_close, function()
                GUI:Win_Close(_parent)
            end)
        end

        --设置面板框图片
        local bg_Mbkuang = GUI:Image_Create(_parent, "bg_Mbkuang", 40, 40, "dev/res/custom/shouchong/shuchong.png")
        if bg_Mbkuang then
            GUI:setContentSize(bg_Mbkuang, {width = 1100, height = 550})
            GUI:setTouchEnabled(bg_Mbkuang, true)
        end

        --- 界面关闭按钮
        local btn_close = GUI:Button_Create(_parent, "btn_close", 900, 480, "dev/res/custom/shouchong/z_guanbianniu.png")
        if btn_close then
            GUI:Button_loadTexturePressed(btn_close, "res/custom/shouchong/z_guanbianniu.png1.png")
            GUI:addOnClickEvent(btn_close, function()
                GUI:Win_Close(_parent)
            end)
        end


        --第一天按钮
        local btn_day1 = GUI:Button_Create(_parent, "btn_day1", 885, 400, "dev/res/custom/shouchong/btn_day_1_1.png")
        if btn_day1 then
            GUI:setAnchorPoint(btn_day1, 0.5, 0.5)
            GUI:Button_loadTexturePressed(btn_day1, "dev/res/custom/shouchong/btn_day_1_2.png")
            GUI:addOnClickEvent(btn_day1, function()
                Shouchong.updateUI(1)
            end)
        end

        --第二天按钮
        local btn_day2 = GUI:Button_Create(_parent, "btn_day2", 885, 350, "dev/res/custom/shouchong/btn_day_2_1.png")
        if btn_day1 then
            GUI:setAnchorPoint(btn_day2, 0.5, 0.5)
            GUI:Button_loadTexturePressed(btn_day2, "dev/res/custom/shouchong/btn_day_2_2.png")
            GUI:addOnClickEvent(btn_day2, function()
                Shouchong.updateUI(2)
            end)
        end

        --第三天按钮
        local btn_day3 = GUI:Button_Create(_parent, "btn_day3", 885, 300, "dev/res/custom/shouchong/btn_day_3_1.png")
        if btn_day1 then
            GUI:setAnchorPoint(btn_day3, 0.5, 0.5)
            GUI:Button_loadTexturePressed(btn_day3, "dev/res/custom/shouchong/btn_day_3_2.png")
            GUI:addOnClickEvent(btn_day3, function()
                Shouchong.updateUI(3)
            end)
        end

        --充值按钮
        local btn_chongzhi = GUI:Button_Create(_parent, "btn_chongzhi", 600, 180, "dev/res/custom/shouchong/btn_shouchong_04.png")
        if btn_chongzhi then
            GUI:setAnchorPoint(btn_chongzhi, 0.5, 0.5)
            GUI:Button_loadTexturePressed(btn_chongzhi, "dev/res/custom/shouchong/btn_shouchong_04_1.png")
            GUI:addOnClickEvent(btn_chongzhi, function()
                 Shouchong.submit()
                --Shouchong.test()
            end)
        end

        --- 首充奖励
        local layout = GUI:Layout_Create(_parent, "layout", 450, 220, 350, 80, false)
        if layout then
            reward_list = Shouchong.getData(1)
            if reward_list then
                for i, reward in ipairs(reward_list) do

                    ---@type itemdata
                    local itemdata = {}
                    itemdata.index = reward[1] --奖励道具id
                    itemdata.look = true
                    itemdata.bgVisible = true
                    itemdata.count = reward[2] --奖励道具数量
                    itemdata.showModelEffect = true
                    local item_reward = GUI:ItemShow_Create(layout, "item_reward"..i, 50+60*(i-1), 50, itemdata)
                    if item_reward then
                        GUI:setAnchorPoint(item_reward, 0.5, 0.5)
                        GUI:setScale(item_reward, 0.8)
                    end
                end
            end
        end

    end

end

Shouchong.test = function()
    SL:SubmitForm("G/首充", "PlayerRecharge")
end

Shouchong.updateBtn = function(days, state, idx)
    print(days,state, idx)
    if state ~= 1 then return end

    local btn_chongzhi = GUI:GetWindow(nil, "QSQ_shouchong/btn_chongzhi")

    if not days or days < 0 then return end --未首充

    if idx == 1 then
        if days >= 0 then
            GUI:Button_loadTextureNormal(btn_chongzhi, "dev/res/custom/shouchong/btn_shouchong_05.png")
            GUI:Button_loadTexturePressed(btn_chongzhi, "dev/res/custom/shouchong/btn_shouchong_05_1.png")
            GUI:Button_setBright(btn_chongzhi,true)

            GUI:addOnClickEvent(btn_chongzhi, function()
                SL:SubmitForm("G/首充","Lingqv", idx)
            end) 

        end
    end
    if idx == 2 then
        if days >= 1 then
            GUI:Button_loadTextureNormal(btn_chongzhi, "dev/res/custom/shouchong/btn_shouchong_05.png")
            GUI:Button_loadTexturePressed(btn_chongzhi, "dev/res/custom/shouchong/btn_shouchong_05_1.png")
            GUI:Button_setBright(btn_chongzhi,true)

            GUI:addOnClickEvent(btn_chongzhi, function()
                SL:SubmitForm("G/首充","Lingqv", idx)

            end)
        else 
            GUI:Button_loadTextureNormal(btn_chongzhi, "dev/res/custom/shouchong/btn_shouchong_05.png")
            GUI:Button_loadTexturePressed(btn_chongzhi, "dev/res/custom/shouchong/btn_shouchong_05_1.png")
            GUI:Button_setBright(btn_chongzhi,false)
            GUI:addOnClickEvent(btn_chongzhi, function()
                GUI:Button_setBright(btn_chongzhi,false)
                SL:ShowSystemTips("未到领取时间")
            end)
        end
    end
    if idx == 3 then
        if days >= 2 then
            GUI:Button_loadTextureNormal(btn_chongzhi, "dev/res/custom/shouchong/btn_shouchong_05.png")
            GUI:Button_loadTexturePressed(btn_chongzhi, "dev/res/custom/shouchong/btn_shouchong_05_1.png")
            GUI:Button_setBright(btn_chongzhi,true)

            GUI:addOnClickEvent(btn_chongzhi, function()
                SL:SubmitForm("G/首充","Lingqv", idx)

            end)
        else
            GUI:Button_loadTextureNormal(btn_chongzhi, "dev/res/custom/shouchong/btn_shouchong_05.png")
            GUI:Button_loadTexturePressed(btn_chongzhi, "dev/res/custom/shouchong/btn_shouchong_05_1.png")
            GUI:Button_setBright(btn_chongzhi,false)
            GUI:addOnClickEvent(btn_chongzhi, function()
                SL:ShowSystemTips("未到领取时间")
            end)
        end
    end
end

--提交充值
Shouchong.submit = function()
    SL:RequestPay()
end

--更新信息
Shouchong.updateUI = function(idx)
    if not idx then return end
    --更新奖励道具
    reward_list = Shouchong.getData(idx)
    SL:print(serialize(reward_list))
    local reward_layout = GUI:GetWindow(nil, "QSQ_shouchong/layout")
    GUI:removeAllChildren(reward_layout)     --清空layout下所有子对象
    for i, reward in ipairs(reward_list) do
        SL:print(serialize(reward))
        SL:print(reward[1])
        ---@type itemdata
        local itemdata = {}
        itemdata.index = reward[1] --奖励道具id
        itemdata.look = true
        itemdata.bgVisible = true
        itemdata.count = reward[2] --奖励道具数量
        itemdata.showModelEffect = true

        local item_reward = GUI:ItemShow_Create(reward_layout, "item_reward"..i, 50+60*(i-1), 50, itemdata)
        if item_reward then
            GUI:setAnchorPoint(item_reward, 0.5, 0.5)
            GUI:setScale(item_reward, 0.8)
        end
    end

    SL:SubmitForm("G/首充", "SyncResponse", idx) --同步按钮状态

end

--获取奖励道具的信息
Shouchong.getData = function(idx)
    local reward_info = {}
    if idx then
        for i, data in ipairs(cfg[idx].reward) do
            table.insert(reward_info, data)
        end
        return reward_info
    end
end
Shouchong.main()
