Kuangbao = {}

local cfg_kuangbao = cfg_kuangbao

if cfg_kuangbao then
    print("读取配置文件cfg_kuangbao成功")
else
    print("读取配置文件cfg_kuangbao失败")
end

local GUIparent = ""
local Btn_lingfu = nil
Kuangbao.main = function()
    local _parent = GUI:Win_Create("kuangbao", 0, 0, 0, 0, false, false, true, false)
    if _parent then
        GUIparent = _parent
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
        --设置容器
        local layout = GUI:Layout_Create(_parent, "diban", x, y, 820, 570)
        if layout then
            GUI:setAnchorPoint(layout, 0.5, 0.5)
            GUI:setPosition(layout, x, y)
        end

        --设置面板框图片
        local bg_Mbkuang = GUI:Image_Create(layout, "bg_Mbkuang", 0, 0, "dev/res/01/010000.png")
        if bg_Mbkuang then
            GUI:setContentSize(bg_Mbkuang, {width = 815, height = 575})
            GUI:setTouchEnabled(bg_Mbkuang, true)
        end

        --设置背景图
        local bg_kuangbao = GUI:Image_Create(layout, "bg_kuangbao", 410, 260, "dev/res/custom/painting/img_bg_000.jpg")
        if bg_kuangbao then
            GUI:setAnchorPoint(bg_kuangbao, 0.5, 0.5)
            GUI:setContentSize(bg_kuangbao, {width = 687, height = 470})
        end

        --设置关闭按钮
        local btn_close = GUI:Button_Create(layout, "btn_close", 725, 475, "dev/res/01/010008.png")
        if btn_close then
            GUI:Button_loadTexturePressed(btn_close, "dev/res/01/010009.png")
            GUI:addOnClickEvent(btn_close, function()
                GUI:Win_Close(_parent)
            end)
        end

        --设置标题
        local text_title = GUI:Text_Create(layout, "text_title", 370, 510, 20, "#D6C6AD", "狂暴之力")

        --介绍
        local str_list = cfg_kuangbao[1].desce
        local str = SL:Split(str_list, "<br>")
        for i =1, #str do
            local str1 = string.gsub(str[i], "\n","")
            local star = GUI:Image_Create(layout, "star"..i, 420, 420 - 35*(i-1),"dev/res/custom/mapmove/mapmove5.png")
            local bg_intro = GUI:Image_Create( layout, "bg_intro"..i, 420, 418 - 35*(i-1), "dev/res/custom/common/11.png")
            local intro = GUI:RichText_Create(layout, "intro"..i, 450, 420 - 35*(i-1), str1, 300, 16, nil, nil)
        end
        
        --灵符激活
        local btn_lingfu = GUI:Button_Create(layout, "btn_lingfu", 500, 70, "dev/res/01/010005.png")
        if btn_lingfu then
            Btn_lingfu = btn_lingfu
            local text_btn_lingfu
            text_btn_lingfu = GUI:Text_Create(btn_lingfu, "text_btn_lingfu", 53, 20, 16, "#D6C6AD", "灵符激活")
            GUI:setAnchorPoint(text_btn_lingfu, 0.5, 0.5)
            GUI:Button_loadTexturePressed(btn_lingfu, "dev/res/01/010006.png")
            GUI:addOnClickEvent(btn_lingfu, function()
                Kuangbao.Active()
            end)
        end
    end
end

Kuangbao.Active = function()
    SL:SubmitForm("G/狂暴", "Active")
end

Kuangbao.main()