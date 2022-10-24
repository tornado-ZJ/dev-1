LZYSign = {}

local cfg = cfg_qiandao
-- local GUIparent = ""

local _state = {
    no_receive = 0, -- 不可领取
    can_receive = 1, --可领取
    has_receive = 2 --已领取
}
local status = {}
local currentIndex = nil

function LZYSign.main()
    -- local data = string.gsub(SL.FormParam[1], "'","")
    -- status = SL:JsonDecode(data)

    -- -- SL:dump(SL.FormParam)
    -- -- FormParam = string.gsub(SL.FormParam[1], "'","")
    -- -- for i = 1, 7 do
    -- --     status[i] = tonumber(SL.FormParam[1][i]) or 0
    -- -- end
    -- SL:Dump(status)


    local _parent = GUI:Win_Create("LZY_qiandao", 0, 0, 0, 0, false, false, true, false)
    if _parent then
        GUIparent = _parent
        local winSize = SL:GetScreenSize() -- 获取屏幕宽高
        local x = winSize.width / 2
        local y = winSize.height / 2
        local w = winSize.width
        local h = winSize.height

        local layout = GUI:Layout_Create(_parent, "diban", x, y, w, h)
        if layout then
            GUI:setAnchorPoint(layout, 0.5, 0.5)
        end

        ----------关闭背景act-----------------
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

        ----------界面框背景act-----------------
        local bg_kuang = GUI:Image_Create(_parent, "bg_kuang", 142, 45, "res/01/010000.png")
        if bg_kuang then
            GUI:setContentSize(bg_kuang, {
                width = 815,
                height = 575
            })
            GUI:setTouchEnabled(bg_kuang, true)
        end

        -- title
        local tx_title = GUI:Text_Create(_parent, "tx_title", 520, 558, 20, "#D6C6AD", "开服活动")

        -- 关闭按钮
        local btn_close = GUI:Button_Create(_parent, "btn_close", 920, 540, "res/01/010033.png")
        if btn_close then
            GUI:Button_loadTexturePressed(btn_close, "res/01/010034.png")
            GUI:addOnClickEvent(btn_close, function()
                GUI:Win_Close(_parent)
            end)
        end

        -- left容器
        local img_left = GUI:Image_Create(_parent, "img_left", 200, 46, "res/custom/zhigou/7.jpg")
        if img_left then
            GUI:setContentSize(img_left, {
                width = 700,
                height = 500
            })
            local lyt_left = GUI:Layout_Create(img_left, "lyt_left", 0, 0, 140, 500)
            -- if lyt_left then
            --     local btn1 = GUI:Button_Create(lyt_left, "btn1", 18, 450, "res/01/010005.png") -- 按钮位置
            --     if btn1 then
            --         GUI:Button_loadTexturePressed(btn1, "res/01/010006.png")
            --         GUI:Image_Create(btn1, "dian", 96, 18, "res/02/020039.png")
            --         GUI:Text_Create(btn1, "text1", 20, 5, 18, "#D6C6AD", "每日充值")
            --     end

            --     local btn2 = GUI:Button_Create(lyt_left, "btn2", 18, 400, "res/01/010005.png") -- 按钮位置
            --     if btn2 then
            --         GUI:Button_loadTexturePressed(btn2, "res/01/010006.png")
            --         GUI:Image_Create(btn2, "dian", 96, 18, "res/02/020039.png")
            --         GUI:Text_Create(btn2, "text2", 20, 5, 18, "#D6C6AD", "七日登录")
            --     end

            --     local btn3 = GUI:Button_Create(lyt_left, "btn3", 18, 350, "res/01/010005.png") -- 按钮位置
            --     if btn3 then
            --         GUI:Button_loadTexturePressed(btn3, "res/01/010006.png")
            --         GUI:Image_Create(btn3, "dian", 96, 18, "res/02/020039.png")
            --         GUI:Text_Create(btn3, "text3", 20, 5, 18, "#D6C6AD", "限时直购")
            --     end
            -- end
        end

        -- 背景图片
        local pic_bg = GUI:Image_Create(_parent, "pic_bg", 350, 46, "res/custom/qiandao/img_bg.png")
        if pic_bg then
            GUI:setContentSize(pic_bg, {
                width = 560,
                height = 500
            })
        end

        -- top容器
        local tab_tian = { "第一天", "第二天", "第三天", "第四天", "第五天", "第六天", "第七天" }
        local lyt_top = GUI:Layout_Create(_parent, "lyt_top", 350, 380, 560, 165)
        if lyt_top then
            -- GUI:Layout_setBackGroundColor(lyt_top, "#BEBEBE")
            -- GUI:Layout_setBackGroundColorType(lyt_top, 1) -- 背景色
            -- GUI:Layout_setBackGroundColorOpacity(lyt_top, 100)
            for i = 1, 7 do
                local text = GUI:Text_Create(lyt_top, "text" .. i, -62 + (i * 80), 125, 15, "#FFFFFF", tab_tian[i]) -- 天数
            end

            for i = 1, 6 do
                local pic_hei = GUI:Image_Create(lyt_top, "pic_hei" .. i, -20 + (i * 80), 77,
                "res/custom/qiandao/img_xian_1.png") -- 黑横条
                if pic_hei then
                    GUI:setLocalZOrder(pic_hei, -2)
                end
            end

            -- for i = 2, 7 do
            --     local pic_lv = GUI:Image_Create(lyt_top, "pic_lv" .. i, -100 + (i * 80), 77,
            --     "res/custom/qiandao/img_xian.png") -- 绿横条
            -- end

            for i, v in ipairs(cfg) do
                local btn_jin = GUI:Button_Create(lyt_top, "btn_jin" .. i, -75 + (i * 80), 53,
                "res/custom/qiandao/img_sgined.png") -- 金色按钮
                if btn_jin then
                    GUI:setScale(btn_jin, 0.8)
                    GUI:addOnClickEvent(btn_jin, function()
                        LZYSign.tianshu(i) -- 打开天数图片
                    end)
                end
            end

            local lyt_yiling = GUI:Layout_Create(lyt_top, "lyt_yiling", 0, 0, 560, 165) -- 已领取父节点
            local lyt_guang = GUI:Layout_Create(lyt_top, "lyt_guang", 0, 0, 560, 165) -- 光父节点

        end

        -- bottom容器
        local lyt_bottom = GUI:Layout_Create(_parent, "lyt_bottom", 350, 48, 560, 336)
        if lyt_bottom then
            -- GUI:Layout_setBackGroundColor(lyt_bottom, "#BEBEBE")
            -- GUI:Layout_setBackGroundColorType(lyt_bottom, 1) -- 背景色
            -- GUI:Layout_setBackGroundColorOpacity(lyt_bottom, 100)
        end
        local pic_kuang = GUI:Image_Create(_parent, "pic_kuang", 345, 310, "res/custom/qiandao/img_ch_di.png") -- 稀有框
        if pic_kuang then
            GUI:setScale(pic_kuang, 0.8)
            -- dump(cfg[1])
            -- print("ASDASD222",cfg[1]["名字"])
        end

    end

    LZYSign.autoSelect()
end

function LZYSign.receive(i)
    local state = status[i]
    if state ~= _state.has_receive then
        return
    end
    local img_yiling = GUI:GetWindow(nil, "LZY_qiandao/lyt_top/lyt_yiling")
    if img_yiling then
        local pic_receive = GUI:Image_Create(img_yiling, "pic_receive" .. i, -68 + (i * 80), 25,
        "res/custom/qiandao/img_alarey_get.png") -- 已领取
        if pic_receive then
            GUI:setScale(pic_receive, 0.8)
            GUI:setVisible(pic_receive, state == _state.has_receive)
        end

        local btn_yin = GUI:Button_Create(img_yiling, "btn_yin" .. i, -75 + (i * 80), 53,
        "res/custom/qiandao/img_sgined_1.png") -- 银色按钮
        if btn_yin then
            GUI:setScale(btn_yin, 0.8)
            GUI:addOnClickEvent(btn_yin, function()
                LZYSign.tianshu(i) -- 打开天数图片
            end)
        end

    end
end

function LZYSign.autoSelect()
    local data = string.gsub(SL.FormParam[1], "'", "")
    status = SL:JsonDecode(data)
    SL:Dump(status)
    local index = 0
    for i, v in ipairs(status) do
        if v == 2 then
            index = i
        end
    end

    local img_yiling = GUI:GetWindow(nil, "LZY_qiandao/lyt_top/lyt_yiling")
    if img_yiling then
        for i = 1, index do
            local pic_receive = GUI:Image_Create(img_yiling, "pic_receive" .. i, -68 + (i * 80), 25,
            "res/custom/qiandao/img_alarey_get.png") -- 已领取
            if pic_receive then
                GUI:setScale(pic_receive, 0.8)
                --GUI:setVisible(pic_receive, state == _state.has_receive)
            end

            local btn_yin = GUI:Button_Create(img_yiling, "btn_yin" .. i, -75 + (i * 80), 53,
            "res/custom/qiandao/img_sgined_1.png") -- 银色按钮
            if btn_yin then
                GUI:setScale(btn_yin, 0.8)
                GUI:addOnClickEvent(btn_yin, function()
                    LZYSign.tianshu(i) -- 打开天数图片
                end)
            end
        end
    end
    index = index + 1
    index = math.min(index, 7)

    --local lyt_top = GUI:Layout_Create(_parent, "lyt_top", 350, 380, 560, 165)
    local lyt_to = GUI:GetWindow(nil, "LZY_qiandao/lyt_top")
    if lyt_to then
        --for i, v in ipairs(status) do
        for i = 2, index do
            local pic_lv = GUI:Image_Create(lyt_to, "pic_lv" .. i, -100 + (i * 80), 77,
            "res/custom/qiandao/img_xian.png") -- 绿横条
            if pic_lv then
                GUI:setLocalZOrder(pic_lv, -1)
            end
        end
    end

    -- local img_yiling = GUI:GetWindow(nil, "LZY_qiandao/lyt_top/lyt_yiling")
    -- if img_yiling then
    --     for i = 1, index do
    --         local pic_receive = GUI:Image_Create(img_yiling, "pic_receive" .. i, -68 + (i * 80), 25,
    --         "res/custom/qiandao/img_alarey_get.png") -- 已领取
    --         if pic_receive then
    --             GUI:setScale(pic_receive, 0.8)
    --             --GUI:setVisible(pic_receive, state == _state.has_receive)
    --         end

    --         local btn_yin = GUI:Button_Create(img_yiling, "btn_yin" .. i, -75 + (i * 80), 53,
    --         "res/custom/qiandao/img_sgined_1.png") -- 银色按钮
    --         if btn_yin then
    --             GUI:setScale(btn_yin, 0.8)
    --             GUI:addOnClickEvent(btn_yin, function()
    --                 LZYSign.tianshu(i) -- 打开天数图片
    --             end)
    --         end
    --     end
    -- end
    LZYSign.tianshu(index)
end

function LZYSign.tianshu(num)
    --currentIndex = num

    local tab_tain = { "res/custom/qiandao/img_desc/img_desc_1.png", "res/custom/qiandao/img_desc/img_desc_2.png",
    "res/custom/qiandao/img_desc/img_desc_3.png", "res/custom/qiandao/img_desc/img_desc_4.png",
    "res/custom/qiandao/img_desc/img_desc_5.png", "res/custom/qiandao/img_desc/img_desc_6.png",
    "res/custom/qiandao/img_desc/img_desc_7.png" }

    local tab_texiao = {5,6,8,10,13,15,21}

    local lyt_wenzi = GUI:GetWindow(nil, "LZY_qiandao/lyt_bottom")
    GUI:removeAllChildren(lyt_wenzi)
    if lyt_wenzi then
        -- 天数图片
        local tian = GUI:Image_Create(lyt_wenzi, "tian", 245, 220, tab_tain[num])
        if tian then
            GUI:setScale(tian, 0.8)
        end

        -- 领取按钮
        local btn_receive = GUI:Button_Create(lyt_wenzi, "btn_receive" .. num, 330, 35, "res/01/010005.png")
        if btn_receive then
            GUI:Button_loadTexturePressed(btn_receive, "res/01/010006.png")
            GUI:Text_Create(btn_receive, "tex_receive" .. num, 20, 5, 18, "#FFE4B5", "领取奖励")

            local state = status[num]
            GUI:Button_setBright(btn_receive, state ~= _state.has_receive)
            GUI:setTouchEnabled(btn_receive, state ~= _state.has_receive)

            GUI:addOnClickEvent(btn_receive, function()
                LZYSign.receive(num)
                SL:SubmitForm("C/Sign", "receive", num)
                --GUI:Button_setBright(btn_receive, false)
                GUI:setTouchEnabled(btn_receive, false)
            end)
        end

        -- 特效
        local texiao = GUI:Effect_Create(lyt_wenzi, "texiao", 90, 100, 0, tab_texiao[num])

        -- 奖品
        local img_di = GUI:Image_Create(lyt_wenzi, "img_di", 150, 123, "res/custom/qiandao/img_reward_di.png")
        for i = 1, #cfg[num].pet do
            local itemdata = {}
            itemdata.index = cfg[num].pet[i][1] -- 物品模板id
            itemdata.look = true -- 是否显示tips
            itemdata.bgVisible = true -- 是否显示背景框
            itemdata.count = cfg[num].pet[i][2] -- 物品数量
            itemdata.color = 225
            local item_gift = GUI:ItemShow_Create(lyt_wenzi, "item_gift" .. i, 150 + (i * 55), 140, itemdata)
            if item_gift then
                GUI:setScale(item_gift, 0.8)
            end
        end

    end
    -- 框内文字
    local text_kuang = GUI:GetWindow(nil, "LZY_qiandao/pic_kuang")
    GUI:removeAllChildren(text_kuang)
    if text_kuang then
        GUI:Text_Create(text_kuang, "xiyou_cailiao", 95, 16, 25, "#00BFFF", cfg[num].name)
    end

    -- 光
    local img_guang = GUI:GetWindow(nil, "LZY_qiandao/lyt_top/lyt_guang")
    GUI:removeAllChildren(img_guang)
    if img_guang then
        local pic_guang = GUI:Image_Create(img_guang, "pic_guang", -61 + (num * 80), 61,
        "res/custom/qiandao/img_sgin_select.png") -- 光环
        if pic_guang then
            GUI:setScale(pic_guang, 0.8)
        end

    end

end

LZYSign.main()