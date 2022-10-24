zhuanpan = {}

zhuanpan.main = function()

    local _parent = GUI:Win_Create("zhuanpan")
    if not _parent then
        return 
    end

    local winSize = SL:GetScreenSize()
    local x = winSize.width / 2
    local y = winSize.height / 2
    local w = winSize.width
    local h = winSize.height

    local contentW = 900
    local contentH = 500

    -- 全屏关闭
    local bg_close = GUI:Layout_Create(_parent, "bgclose", 0, 0, w, h)
    if bg_close then
        GUI:setAnchorPoint(bg_close, 0, 0)
        GUI:setTouchEnabled(bg_close, true)
        GUI:addOnClickEvent(bg_close, function()
            GUI:Win_Close(_parent)
        end)
    end
    
    -- 放内容的容器
    local layout = GUI:Layout_Create(_parent, "layout", x, y, contentW, contentH)
    if layout then
        GUI:setAnchorPoint(layout, 0.5, 0.5)
        GUI:setTouchEnabled(layout, true)
    end

    -- 背景图
    local bg_kuang = GUI:Image_Create(layout, "bg_kuang", contentW/2, contentH/2, "res/01/010011.jpg")
    if bg_kuang then
        GUI:setAnchorPoint(bg_kuang, 0.5, 0.5)
        GUI:setContentSize(bg_kuang,{width = contentW, height = contentH})
    end

    -- 创建20个道具图标
    local pos = 
    {
        {x=100, y=400}, {x=200, y=400}, {x=300, y=400}, {x=400, y=400}, {x=500, y=400}, {x=600, y=400},  {x=700, y=400},  {x=800, y=400},
        {x=800, y=300},
        {x=800, y=200},
        {x=800, y=100}, {x=700, y=100}, {x=600, y=100}, {x=500, y=100}, {x=400, y=100}, {x=300, y=100}, {x=200, y=100}, {x=100, y=100}, 
        {x=100, y=200},
        {x=100, y=300},
    }

    local lights = {}
    for i, v in ipairs(pos) do
        local imageItem = GUI:Image_Create(layout, "itembg"..i, v.x,v.y, "res/01/010031.png")
        GUI:setAnchorPoint(imageItem, 0.5, 0.5)
        GUI:setContentSize(imageItem, {width=80, height=80})

        local itemdata = {}
        itemdata.index = 1
        itemdata.look = true
        local ItemShow = GUI:ItemShow_Create(imageItem, "ItemShow"..i, 40, 40, itemdata)
        GUI:setAnchorPoint(ItemShow, 0.5, 0.5)

        local imagelight = GUI:Image_Create(imageItem, "imagelight"..i, 40, 40, "res/01/010020.png")
        GUI:setAnchorPoint(imagelight, 0.5, 0.5)
        GUI:setContentSize(imagelight, {width=80, height=80})
        GUI:setOpacity(imagelight, 0)

        table.insert(lights, imagelight)
    end

    local wating = false
    local function start()
        if wating then
            SL:ShowSystemTips("摇奖中")
            return
        end

        wating = true
        for i, v in ipairs(lights) do
            GUI:setOpacity(v, 0)
            GUI:Timeline_StopAll(v)
        end

        -- 总数量
        local count  = #lights

        -- 随机一个目标
        local target = math.random(1, count)

        -- 循环次数
        local loop      = math.random(2, 4)
        local index     = 1
        local time      = 0.5
        local loopCount = 0
        local function show()
            local imagelight = lights[index]
            GUI:setOpacity(imagelight, 255)
            GUI:Timeline_FadeOut(imagelight, time, function()
                if loopCount >= loop and index == target then
                    wating = false

                    local fadeIn = nil
                    local fadeOut = nil
                    fadeIn = function()
                        GUI:Timeline_FadeIn(imagelight, 0.2, fadeOut)
                    end
                    fadeOut = function()
                        GUI:Timeline_FadeOut(imagelight, 0.2, fadeIn)
                    end
                    fadeIn()
                else
                    show()
                end
            end)

            time = time - 0.1
            time = math.max(time, 0.03)

            index = index + 1
            if index > count then
                index = 1
                loopCount = loopCount + 1
            end
        end
        show()
    end

    -- 开始转盘
    local buttonStart = GUI:Button_Create(layout, "buttonStart", contentW/2, contentH/2, "res/01/010006.png")
    if buttonStart then
        GUI:setAnchorPoint(buttonStart, 0.5, 0.5)
        GUI:Button_loadTexturePressed(buttonStart, "res/01/010005.png")
        GUI:addOnClickEvent(buttonStart, function()
            start()
        end)
    end
end


zhuanpan.main()

