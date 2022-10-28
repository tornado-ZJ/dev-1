KuangBao = {}
local GUIparent = ""
local Win_W, Win_H = 815, 575
local cur_chenghao = 0
local lastPage = 1
local cfg_kuangbao = {
    [1] = {
        name = "狂暴之王",
        effectid = 30000,
    },
    [2] = {
        name = "狂暴之尊",
        effectid = 30001,
    },
    [3] = {
        name = "狂暴之神",
        effectid = 30002,
    },
}

function KuangBao.main()
    SL:SubmitForm("A/狂暴", "SyncResponse")
end

KuangBao.main()
KuangBao.SyncResponse = function(data)
    if not data then
        return
    end
    local sendList = SL:JsonDecode(data)
    --当前称号 0 未开启 1 狂暴之王 2 狂暴之尊 3 狂暴之神
    cur_chenghao = sendList[1]
    if not GUI:GetWindow(nil, "kuangbao") then
        KuangBao.createUI()
    else
        KuangBao.updateUI()
    end
end

KuangBao.createUI = function()
    local parent = GUI:Win_Create("kuangbao", 0, 0, 0, 0, false, false, true, false)
    GUIparent = parent
    local screenW = SL:GetScreenWidth()
    local screenH = SL:GetScreenHeight()
    local layoutW = GUIShare.WinView.LayWidth
    local layoutH = GUIShare.WinView.LayHeight

    -- 全屏关闭
    local CloseLayout = GUI:Layout_Create(parent, "CloseLayout", 0, 0, screenW, screenH)
    GUI:Layout_setBackGroundColorType(CloseLayout, 1)
    GUI:Layout_setBackGroundColor(CloseLayout, "#000000")
    GUI:Layout_setBackGroundColorOpacity(CloseLayout, 150)
    GUI:setTouchEnabled(CloseLayout, true)
    GUI:addOnClickEvent(CloseLayout, function()
        GUI:Win_Close(parent)
    end)
    -- 容器
    local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", screenW / 2, screenH / 2, layoutW, layoutH)
    GUI:setAnchorPoint(FrameLayout, { x = 0.5, y = 0.5 })
    -- 背景图
    local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/ui/kuang/1.png")
    GUI:setTouchEnabled(FrameBG, true)
    -- 龙头
    local DressIMG = GUI:Image_Create(FrameLayout, "DressIMG", -14, 474, "res/ui/kuang/1-1.png")
    -- 标题
    local TitleText = GUI:Text_Create(FrameLayout, "TitleText", 32, 498, 18, "#ffffff", "狂暴之力")
    -- 关闭按钮
    local CloseButton = GUI:Button_Create(FrameLayout, "CloseButton", 780, 492, "res/ui/kuang/2.png")
    GUI:Button_loadTexturePressed(CloseButton, "res/ui/kuang/2-1.png")
    GUI:setTouchEnabled(CloseButton, true)
    GUI:addOnClickEvent(CloseButton, function()
        GUI:Win_Close(parent)
    end)
    --左侧背景
    local ImageView_1 = GUI:Image_Create(FrameLayout, "ImageView_1", 25.00, 39.00, "res/ui/kuang/3.png")
    GUI:Image_setScale9Slice(ImageView_1, 10, 10, 10, 10)
    GUI:setContentSize(ImageView_1, 112, 450)
    GUI:setIgnoreContentAdaptWithSize(ImageView_1, false)
    GUI:setTouchEnabled(ImageView_1, false)
    GUI:setTag(ImageView_1, -1)
    -- 列表容器
    local ListView_1 = GUI:ListView_Create(FrameLayout, "ListView_1", 29.00, 43.00, 105.00, 440.00, 1)
    GUI:ListView_setBackGroundColorType(ListView_1, 1)
    GUI:ListView_setBackGroundColor(ListView_1, "#ffffff")
    GUI:ListView_setItemsMargin(ListView_1, 1)
    GUI:ListView_setBackGroundColorOpacity(ListView_1, 0)
    GUI:setTouchEnabled(ListView_1, true)
    GUI:setTag(ListView_1, -1)

    -- 切换按钮
    for i = 1, #cfg_kuangbao do
        local Button = GUI:Button_Create(ListView_1, "Button_"..i, 0.00, 414.00, "res/ui/button/5-1.png")
        GUI:Button_loadTextureDisabled(Button, "res/ui/button/5.png")
        GUI:Button_setTitleColor(Button, color[1])
        GUI:Button_setTitleFontSize(Button, 14)
        GUI:Button_setTitleText(Button, cfg_kuangbao[i].name)
        GUI:setTouchEnabled(Button, true)
        GUI:setTag(Button, -1)
        GUI:Button_setScale9Slice(Button, 10, 8, 10, 10)
        GUI:setContentSize(Button, 105, 33)
        GUI:setIgnoreContentAdaptWithSize(Button, false)
        GUI:addOnClickEvent(Button, function()
            KuangBao.page(i)
        end)
    end
    --特效标题
    GUI:Effect_Create(parent, "Effect_kuangbao", 500,400,0,cfg_kuangbao[1].effectid, 0,0,0,1)
    -- 开启按钮
    local Button_1 = GUI:Button_Create(parent, "Button_1", 642.00, 145.00, "res/ui/button/3.png")
    GUI:Button_loadTexturePressed(Button_1, "res/ui/button/3-1.png")
    GUI:Button_setTitleColor(Button_1, "#ffffff")
    GUI:Button_setTitleFontSize(Button_1, 14)
    GUI:Button_setTitleText(Button_1, "开启狂暴")
    GUI:setTouchEnabled(Button_1, true)
    GUI:setTag(Button_1, -1)
    GUI:addOnClickEvent(Button_1, function()
        if cur_chenghao >= 3 then
            SL:ShowSystemTips("狂暴已满级，无法继续升级")
            return
        end
        if cur_chenghao + 1 > lastPage then
            SL:ShowSystemTips("已开启"..cfg_kuangbao[lastPage].name.."，请按顺序开启")
            KuangBao.page(cur_chenghao + 1)
            return
        end
        if cur_chenghao + 1 < lastPage then
            SL:ShowSystemTips("还未开启"..cfg_kuangbao[cur_chenghao + 1].name.."，请按顺序开启!")
            KuangBao.page(cur_chenghao + 1)
            return
        end
        SL:SubmitForm("A/狂暴", "kaiqikuangbao", cur_chenghao)
    end)

    KuangBao.updateUI()

end

KuangBao.updateUI = function()
    KuangBao.page(cur_chenghao % 3 + 1)
end

KuangBao.page = function(index)
    local parent = GUIparent
    --左侧按钮切换
    local ListView_1 = GUI:GetWindow(parent, "FrameLayout/ListView_1")
    local last_Button = GUI:GetWindow(ListView_1, "Button_"..lastPage)
    GUI:Button_setBrightEx(last_Button, true)
    GUI:Button_setTitleColor(last_Button, color[1])
    local cur_Button = GUI:GetWindow(ListView_1, "Button_"..index)
    GUI:Button_setBrightEx(cur_Button, false)
    GUI:Button_setTitleColor(cur_Button, color[2])
    lastPage = index
--    切换特效
    GUI:removeFromParent(GUI:GetWindow(parent, "Effect_kuangbao"))
    GUI:Effect_Create(parent, "Effect_kuangbao", 500,400,0,cfg_kuangbao[index].effectid, 0,0,0,1)


end