LZYBtndonate = {}

function LZYBtndonate.main()
    local _parent = GUI:Win_Create("LZY_jzbtn", 0, 0, 0, 0, false, false, true, false)
    if _parent then
        GUIparent = _parent
        local winSize = SL:GetScreenSize() -- 获取屏幕宽高
        local x = winSize.width / 2
        local y = winSize.height / 2
        local w = winSize.width
        local h = winSize.height

        local layout = GUI:Layout_Create(_parent, "bottom", x, y, w, h)
        if layout then
            GUI:setAnchorPoint(layout, 0.5, 0.5)
        end

        -- 关闭背景
        local bg_close = GUI:Image_Create(_parent, "bg_close", 0, 0, "res/01/010010.png")
        if bg_close then
            GUI:setContentSize(bg_close, {
                width = w,
                height = h
            })
            GUI:setTouchEnabled(bg_close, true)
            GUI:addOnClickEvent(bg_close, function()
                GUI:Win_Close(_parent)
            end)
        end

        -- 界面背景
        local pic_bg = GUI:Image_Create(_parent, "pic_bg", 0, 0, "res/custom/common/25.png")
        if pic_bg then
            if pic_bg then
                GUI:setContentSize(pic_bg, {
                    width = 300,
                    height = 600
                })
                GUI:setTouchEnabled(pic_bg, true)
            end
        end

        -- 关闭按钮
        local btn_close = GUI:Button_Create(_parent, "btn_close", 240, 550, "res/01/010033.png")
        if btn_close then
            GUI:Button_loadTexturePressed(btn_close, "res/01/010034.png")
            GUI:addOnClickEvent(btn_close, function()
                GUI:Win_Close(_parent)
            end)
        end

        -- 捐献数量
        for i = 1, 10 do
            local btn_count = GUI:Button_Create(_parent, "btn_count" .. i, 90, 560 - (i * 50), "res/01/010006.png")
            if btn_count then
                GUI:addOnClickEvent(btn_count, function()
                    SL:Print("2222222222")
                    SL:SubmitForm("C/Donate", "DonateCount", "20"*i)  --打开服务端
                end)
                GUI:Text_Create(btn_count, "text_juan" .. i, 40, 5, 18, "#FFDEAD", "0" + (i * 20))
            end
        end

        -- local btn_count = GUI:Button_Create(_parent, "btn_count", 90, 560, "res/01/010006.png")
        -- if btn_count then
        --     GUI:addOnClickEvent(btn_count, function()
        --         SL:SubmitForm("C/Donate", "DonateCount", "1000#200")
        --     end)
        -- end

    end
end
LZYBtndonate.main()
