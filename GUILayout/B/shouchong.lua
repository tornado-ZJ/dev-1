shouchong = {}

local cfg = cfg_shouchong
local data = SL.FormParam[1]

local last = nil
shouchong.main = function()
    last = nil
    local _parent = GUI:Win_Create("QSQ_shouchong")
    if _parent then
        --data = string.gsub(data, "'","")
        data = SL:JsonDecode(data)

        dump(data,"data")

        local winSize = SL:GetScreenSize() --- 获取屏幕宽高
        local x = winSize.width / 2
        local y = winSize.height / 2
        local w = winSize.width
        local h = winSize.height

        local layout = GUI:Layout_Create(_parent, "diban", x, y, w, h)
        if layout then
            GUI:setAnchorPoint(layout, 0.5, 0.5)
        end

        --- 全屏关闭
        local bg_close = GUI:Image_Create(_parent, "bg_close", 0, 0, "res/01/010010.png")
        if bg_close then
            GUI:setContentSize(bg_close, {width = w, height = h})
            GUI:setTouchEnabled(bg_close, true)
            GUI:addOnClickEvent(bg_close, function()
                GUI:Win_Close(_parent)
            end)
        end


        --- 界面框背景
        local bg_kuang = GUI:Image_Create(_parent, "jm_kuang", 40, 30, "res/custom/shouchong/shuchong.png")
        if bg_kuang then
            GUI:setContentSize(bg_kuang, {
                width = 1100,
                height = 550
            })  ---设置背景大小
            GUI:setTouchEnabled(bg_kuang, true) -- 防止点击穿透
        end

        --- 界面关闭按钮
        local btn_close = GUI:Button_Create(_parent, "btn_close", 925, 475, "res/custom/shouchong/z_guanbianniu.png")
        if btn_close then
            GUI:Button_loadTexturePressed(btn_close, "res/custom/shouchong/z_guanbianniu.png1.png")
            GUI:addOnClickEvent(btn_close, function()
                GUI:Win_Close(_parent)
            end)
        end

        
        --- 按钮
        local btn_close2 = GUI:Button_Create(_parent, "btn_close2", 700, 160,"res/custom/shouchong/btn_shouchong_04.png")
        if btn_close2 then
            GUI:setAnchorPoint(btn_close2, 0.5, 0.5) ---设置中心点
            GUI:Button_loadTexturePressed(btn_close2, "res/custom/shouchong/btn_shouchong_04_1.png")
            GUI:addOnClickEvent(btn_close2, function()
                SL:OpenStoreUI()
            end)
        end

        --- 三天按钮
        local btn_close3 = GUI:Button_Create(_parent, "btn_close3", 880, 420, "res/custom/shouchong/btn_day_1_1.png")
        if btn_close3 then
            GUI:setAnchorPoint(btn_close3, 0.5, 0.5)
            GUI:Button_loadTexturePressed(btn_close3, "res/custom/shouchong/btn_day_1_2.png")
            GUI:addOnClickEvent(btn_close3, function()
                --- GUI:Win_Close(_parent)
                shouchong.test(1)
            end)
        end

        local btn_close4 = GUI:Button_Create(_parent, "btn_close4", 880, 360, "res/custom/shouchong/btn_day_2_1.png")
        if btn_close4 then
            GUI:setAnchorPoint(btn_close4, 0.5, 0.5)
            GUI:Button_loadTexturePressed(btn_close4, "res/custom/shouchong/btn_day_2_2.png")
            GUI:addOnClickEvent(btn_close4, function()
                shouchong.test(2)
            end)
        end
        
        local btn_close5 = GUI:Button_Create(_parent, "btn_close5", 880, 300, "res/custom/shouchong/btn_day_3_1.png")
        if btn_close5 then
            GUI:setAnchorPoint(btn_close5, 0.5, 0.5)
            GUI:Button_loadTexturePressed(btn_close5, "res/custom/shouchong/btn_day_3_2.png")
            GUI:addOnClickEvent(btn_close5, function()
                shouchong.test(3)
            end)
        end

        --- 内部容器，内容全部放到容器中
        local layout = GUI:ListView_Create(_parent, "listview", 630, 280, 350, 80, 2)
        if layout then
            GUI:setAnchorPoint(layout, 0.5, 0.5)
        end
    end
    shouchong.test(1)

    --SL:SubmitForm("B/首充福利", SyncResponse)

end

function shouchong.test(num)
    SL:print("num", num)

    SL:dump(cfg)

    --- 上一个button
    if last then
        local button = GUI:GetWindow(nil, "QSQ_shouchong/btn_close" .. (last + 2))
        if button then
            GUI:Button_loadTextureNormal(button, string.format("res/custom/shouchong/btn_day_%s_1.png", last))
        end
    end


    --- 当前选择的button
    local button = GUI:GetWindow(nil, "QSQ_shouchong/btn_close" .. (num + 2))
    if button then
        GUI:Button_loadTextureNormal(button, string.format("res/custom/shouchong/btn_day_%s_2.png", num))
    end

    last = num




    if data[num] == 1 then

    --- 当前选择的button
        local button = GUI:GetWindow(nil, "QSQ_shouchong/btn_close2")
        if button then
            GUI:Button_loadTextureNormal(button, "res/custom/shouchong/btn_shouchong_05.png")
            GUI:Button_loadTexturePressed(button, "res/custom/shouchong/btn_shouchong_05_1.png")
            GUI:addOnClickEvent(button, function()
                SL:SubmitForm("B/首充福利", "LingQu",1)
            end)
        end

end



    if data[num] == 2 then

    --- 当前选择的button
        local button = GUI:GetWindow(nil, "QSQ_shouchong/btn_close2")
        if button then
            GUI:Button_loadTextureNormal(button,"res/custom/common/backinvest_btn1.png")
            GUI:Button_loadTexturePressed(button, "res/custom/common/backinvest_btn.png")
            GUI:Text_Create(button, "title", 40, 9, 25, "#D6C6AD", "已领取")
        end

end


    --- listview
    local listview = GUI:GetWindow(nil, "QSQ_shouchong/listview")
    if listview then
        --- 清空
        -- GUI:ListView_removeAllItems(listview)
        GUI:removeAllChildren(listview)
        
        --- 根据首充表添加道具图标
        for i, v in ipairs(cfg[num].reward) do
            local layout = GUI:Layout_Create(listview, "item_l_" .. i, 0, 0, 70, 80)
            GUI:ItemShow_Create(layout, "item_" .. i, 0, 0, {index = v[1], count = v[2], bgVisible = true, look = true})
        end
    end
end



shouchong.main()