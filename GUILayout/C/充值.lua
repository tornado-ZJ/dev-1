chongzhi = {}

local configs = {
    [1] = {productID = 1, price = 10, desc = "10元宝", icon = "res/chongzhi/bg_czicon_01.png", items = {1, 1, 1, 2}},
    [2] = {productID = 2, price = 30, desc = "30元宝", icon = "res/chongzhi/bg_czicon_02.png", items = {1, 1, 1, 2}},
    [3] = {productID = 3, price = 50, desc = "50元宝", icon = "res/chongzhi/bg_czicon_03.png", items = {1, 1, 1, 2}},
    [4] = {productID = 4, price = 100, desc = "100元宝", icon = "res/chongzhi/bg_czicon_04.png", items = {1, 1, 1, 2}},
    [5] = {productID = 5, price = 300, desc = "300元宝", icon = "res/chongzhi/bg_czicon_05.png", items = {1, 1, 1, 2}},
    [6] = {productID = 6, price = 500, desc = "500元宝", icon = "res/chongzhi/bg_czicon_06.png", items = {1, 1, 1, 2}},
    [7] = {productID = 7, price = 1000, desc = "1000元宝", icon = "res/chongzhi/bg_czicon_07.png", items = {1, 1, 1, 2}},
    [8] = {productID = 8, price = 3000, desc = "3000元宝", icon = "res/chongzhi/bg_czicon_08.png", items = {1, 1, 1, 2}},
}

chongzhi.main = function()
    local _parent = GUI:Win_Create("chongzhi", 0, 0, 0, 0, false, false, true, false)
    local winSize = SL:GetScreenSize()
    local x = winSize.width / 2
    local y = winSize.height / 2
    local w = winSize.width
    local h = winSize.height

     -- 背景图关闭
     local bg_close = GUI:Image_Create(_parent, "bg_close", 0, 0, "res/01/010010.png")
     if bg_close then
         GUI:setContentSize(bg_close, {width = w, height = h})
         GUI:setTouchEnabled(bg_close, true)
         GUI:addOnClickEvent(bg_close, function()
             GUI:Win_Close(_parent)
         end)
     end

    local contentW = 820
    local contentH = 570

    -- 内部容器，内容全部放到容器中，方便适配
    local layout = GUI:Layout_Create(_parent, "content", x, y, contentW, contentH)
    if layout then
        GUI:setAnchorPoint(layout, 0.5, 0.5)
        GUI:setPosition(layout, x, y)
    end

    -- 背景图
    local bg_kuang = GUI:Image_Create(layout, "bg_kuang", contentW/2, contentH/2, "res/01/010000.png")
    if bg_kuang then
        GUI:setAnchorPoint(bg_kuang, 0.5, 0.5)
        GUI:setContentSize(bg_kuang,{width = 864, height = 576})
        GUI:setTouchEnabled(bg_kuang, true)
    end

    -- 装饰图
    local bg2 = GUI:Image_Create(layout, "bg2", contentW/2, contentH/2-42, "res/chongzhi/bg_czicon_09.jpg")
    if bg2 then
        GUI:setAnchorPoint(bg2, 0.5, 0.5)
        GUI:setContentSize(bg2, {width = 732, height = 445})
    end

    -- 关闭按钮
    local btn_close = GUI:Button_Create(layout, "btn_close", 720, 480, "res/01/010008.png")
    if btn_close then
        GUI:Button_loadTexturePressed(btn_close, "res/01/010009.png")
        GUI:addOnClickEvent(btn_close, function()
            GUI:Win_Close(_parent)
        end)
    end

    -- 充值 标题
    GUI:Text_Create(layout, "title", contentW/2-20, 508, 20, "#D6C6AD", "充值")

    -- 计算坐标
    local items = GUI:Layout_Create(layout, "items", contentW/2, contentH/2-85, 182*4, 180*2)
    GUI:setAnchorPoint(items, 0.5, 0.5)
    GUI:Layout_debug(items)

    -- 创建单条充值
    local function createItem(index, data)
        local itemX = ((index-1) % 4 + 0.5) * 182
        local itemY = 360 - (math.floor((index-1) / 4) + 0.5) * 180
        local item = GUI:Image_Create(items, "item" .. index, itemX, itemY, "res/chongzhi/bg_czicon_10.png")
        GUI:setAnchorPoint(item, 0.5, 0.5)
        GUI:setTouchEnabled(item, true)
        GUI:setContentSize(item, {width = 180, height = 174})
        GUI:addOnClickEvent(item, function()
            -- param1 支付渠道 1=支付宝 2=花呗 3=微信，-1不选择(手机端接入SDK不选择支付渠道)
            -- param2 货币ID
            -- param3 金额
            -- param4 商品ID
            SL:RequestPay(-1, 1, data.price, data.productID)
        end)

        -- 金额
        local itemPrice = GUI:Text_Create(item, "item_pirce" .. index, 180/2, 160, 20, "#D6C6AD", string.format("￥ %s", data.price))
        GUI:setAnchorPoint(itemPrice, 0.5, 0.5)
        
        -- 图标
        local itemIcon = GUI:Image_Create(item, "item_icon" .. index, 180/2, 100, data.icon)
        GUI:setAnchorPoint(itemIcon, 0.5, 0.5)
        
        -- 元宝详情
        local itemDesc = GUI:Text_Create(item, "item_desc" .. index, 180/2, 70, 20, "#D6C6AD", data.desc)
        GUI:setAnchorPoint(itemDesc, 0.5, 0.5)

        -- 赠送道具
        local listviewGift = GUI:ListView_Create(item, "listviewGift_"..index, 10, 10, 160, 40, 2)
        for i, v in ipairs(data.items) do
            local layoutGift = GUI:Layout_Create(listviewGift, "layoutGift_"..index..i, 0, 0, 40, 40)

            local itemdata = {}
            itemdata.index = v
            itemdata.look  = true
            itemdata.bgVisible = true
            itemdata.count = 1
            itemdata.color = 225
            local gift = GUI:ItemShow_Create(layoutGift, "gift_"..index..i, 0, 0, itemdata)
            GUI:setScale(gift, 0.6)
        end
    end

    for i, v in ipairs(configs) do
        createItem(i, v)
    end
end

chongzhi.main()