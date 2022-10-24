LZYDonate = {}

local cfg = cfg_sj
local GUIparent = ""

function LZYDonate.main()
    local _parent = GUI:Win_Create("LZY_juanzeng", 0, 0, 0, 0, false, false, true, false)
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
        local pic_bg = GUI:Image_Create(_parent, "pic_bg", 142, 45, "res/01/010000.png")
        if pic_bg then
            if pic_bg then
                GUI:setContentSize(pic_bg, {
                    width = 815,
                    height = 575
                })
                GUI:setTouchEnabled(pic_bg, true)
            end
        end

        -- 界面标题
        local tx_title = GUI:Text_Create(_parent, "tx_title", 520, 558, 20, "#D6C6AD", "沙城捐献")

        -- 关闭按钮
        local btn_close = GUI:Button_Create(_parent, "btn_close", 920, 540, "res/01/010033.png")
        if btn_close then
            GUI:Button_loadTexturePressed(btn_close, "res/01/010034.png")
            GUI:addOnClickEvent(btn_close, function()
                GUI:Win_Close(_parent)
            end)
        end

        -- top横条
        local lyt_top = GUI:Layout_Create(_parent, "lyt_top", 200, 480, 700, 40)
        if lyt_top then
            GUI:Layout_setBackGroundColor(lyt_top, "#8B2323")
            GUI:Layout_setBackGroundColorType(lyt_top, 1)
            GUI:Layout_setBackGroundColorOpacity(lyt_top, 255)
            GUI:Text_Create(lyt_top, "paiming", 80, 5, 18, "#FFA500", "排名")
            GUI:Text_Create(lyt_top, "mingzi", 220, 5, 18, "#FFA500", "名字")
            GUI:Text_Create(lyt_top, "lingfu", 360, 5, 18, "#FFA500", "捐献灵符")
            GUI:Text_Create(lyt_top, "shuxing", 540, 5, 18, "#FFA500", "属性")
            local btn_xiang = GUI:Button_Create(lyt_top, "btn_xiang", 670, 5, "res/02/020039.png")
            -- GUI:Image_Create(lyt_top, "xiang", 670, 5, "res/02/020039.png")
            if btn_xiang then
                GUI:addOnClickEvent(btn_xiang, function() -- 详情点击按钮
                    LZYDonate.btnxiang()
                end)
            end
            GUI:Text_Create(lyt_top, "lab_xiang", 673, 7, 16, "#FFA500", "详")
        end

        -- bottom横条
        local lyt_bottom = GUI:Layout_Create(_parent, "lyt_bottom", 200, 70, 700, 40)
        if lyt_bottom then
            GUI:Layout_setBackGroundColor(lyt_bottom, "#CD853F")
            GUI:Layout_setBackGroundColorType(lyt_bottom, 1)
            GUI:Layout_setBackGroundColorOpacity(lyt_bottom, 255)
            GUI:Text_Create(lyt_bottom, "jiangchi", 80, 7, 18, "#FFFAFA", "当前奖池：")
            local jc_number = GUI:Text_Create(lyt_bottom, "jc_number", 170, 7, 18, "#00868B", "999999")
            GUI:Text_Create(lyt_bottom, "juanxian", 320, 7, 18, "#FFFAFA", "当前捐献：")
            local jx_number = GUI:Text_Create(lyt_bottom, "jx_number", 410, 7, 18, "#00868B", "999")
            local btn_donate = GUI:Button_Create(lyt_bottom, "btn_donate", 570, 2, "res/01/010006.png")
            if btn_donate then
                GUI:Button_loadTexturePressed(btn_donate, "res/01/010005.png")
                GUI:addOnClickEvent(btn_donate, function()
                    -- SL:OpenStoreUI(5)
                    GUI:Win_Open("C/Btndonate")
                end)
                GUI:Text_Create(btn_donate, "text_juan", 32, 5, 18, "#FFDEAD", "捐   献")
            end
        end

        -- 捐献排行
        local data_num = {2000, 1800, 1752, 1723, 1620, 1520, 1480, 1460, 1432, 1350}
        local rank = GUI:ListView_Create(_parent, "LV_rank", 225, 150, 650, 300, 1)
        if rank then
            GUI:Layout_setBackGroundColor(rank, "#BEBEBE")
            GUI:Layout_setBackGroundColorType(rank, 1)
            GUI:Layout_setBackGroundColorOpacity(rank, 255)
            GUI:ListView_setClippingEnabled(rank, true)
            local lyt_rank = GUI:Layout_Create(rank, "lyt_rank", 0, 0, 650, 600)
            if lyt_rank then
                for i = 1, 10 do
                    GUI:Text_Create(lyt_rank, "text_pai" .. i, 68, 580 - i * 40, 18, "#FFFAFA", i)
                    GUI:Text_Create(lyt_rank, "text_ming" .. i, 185, 580 - i * 40, 18, "#FFFAFA", "name" .. i)
                    GUI:Text_Create(lyt_rank, "text_num" .. i, 348, 580 - i * 40, 18, "#FFFAFA", data_num[i])
                end
                -- GUI:Image_Create(lyt_rank, "img_1", 200, 200, "res/02/020039.png")
            end
        end

    end
end

function LZYDonate.updateLank()

end

function LZYDonate.btnxiang()
    local _parent = GUI:Win_Create("LZY_btnxiang", 0, 0, 300, 300, false, false, true, false)
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

        -- 界面
        local pic_bg = GUI:Image_Create(_parent, "pic_bg", 200, 100, "res/01/010015.png") -- 背景
        if pic_bg then
            GUI:setContentSize(pic_bg, {
                width = 700,
                height = 440
            })
            GUI:setTouchEnabled(pic_bg, true)
            GUI:Text_Create(pic_bg, "title", 340, 400, 25, "#CD853F", "属性")
            GUI:Text_Create(pic_bg, "act_name", 70, 350, 23, "#CD853F", "名字")
            for i = 1, 4 do
                GUI:Text_Create(pic_bg, "title" .. i, 100 + (i * 120), 350, 23, "#CD853F", i)
            end
            local lyt_bg = GUI:ListView_Create(pic_bg, "lyt_bg", 0, 30, 700, 320, 1) -- 下拉列表
            if lyt_bg then
                -- GUI:Layout_setBackGroundColor(lyt_bg, "#BEBEBE")
                -- GUI:Layout_setBackGroundColorType(lyt_bg, 1)              --背景色
                -- GUI:Layout_setBackGroundColorOpacity(lyt_bg, 255)
                local lyt_nature = GUI:Layout_Create(lyt_bg, "lyt_nature", 0, 300, 700, 800)
                if lyt_nature then
                    for i = 1, 10 do
                        GUI:Text_Create(lyt_nature, "name" .. i, 60, 820 - (i * 60), 28, "#CD853F", "name" .. i)
                    end
                    -- GUI:Layout_setBackGroundColor(lyt_nature, "#BEBEBE")
                    -- GUI:Layout_setBackGroundColorType(lyt_nature, 1)
                    -- GUI:Layout_setBackGroundColorOpacity(lyt_nature, 255)
                end

            end
        end

    end
end
LZYDonate.main()
