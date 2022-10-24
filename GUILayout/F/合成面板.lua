Hecheng = {}

local _cfg = cfg_compound

local GUIparent = ""

local page1

local _color = {
    [true] = "#787974",[false] = "#DEBA6C"
}

local wnd_w,wnd_h = 815,575                         --大背景图宽高

function Hecheng.main()
    local _parent = GUI:Win_Create("Hecheng", 0, 0, 0, 0, false, false, true, false)
    GUIparent = _parent
    local winSize = SL:GetScreenSize()              --获取屏幕宽高
    local x = winSize.width / 2
    local y = winSize.height / 2
    local w = winSize.width
    local h = winSize.height


    local handle = GUI:Layout_Create(_parent, "layout_close", x, y, w, h)
    if handle then
        GUI:Layout_setBackGroundColor(handle, "#000000")
        GUI:Layout_setBackGroundColorType(handle, 1)
        GUI:Layout_setBackGroundColorOpacity(handle, 100)
        GUI:setAnchorPoint(handle, 0.5, 0.5)
        GUI:setTouchEnabled(handle, true)
        GUI:addOnClickEvent(handle, function()
            GUI:Win_Close(GUIparent)
        end)
    end

    handle = GUI:Image_Create(_parent, "img_bg", x, y, "res/01/010000.png")
    if handle then
        GUI:setAnchorPoint(handle, 0.5, 0.5)
        GUI:setContentSize(handle,{width = wnd_w, height = wnd_h})
        GUI:setTouchEnabled(handle, true)

        local _fahandle = handle
        handle = GUI:Button_Create(_fahandle, "btn_close", wnd_w - 25,wnd_h - 20, "res/01/010008.png")
        if handle then
            GUI:setAnchorPoint(handle, 1,1)
            GUI:Button_loadTexturePressed(handle, "res/01/010009.png")
            GUI:addOnClickEvent(handle, function()
                GUI:Win_Close(GUIparent)
            end)
        end

        handle = GUI:Image_Create(_fahandle, "img_line", 190,21, "res/custom/common/img_line_1.png")

        handle = GUI:Text_Create(_fahandle, "txt_title", wnd_w / 2,wnd_h - 35, 20, "#D6C6AD", "合    成")
        if handle then
            GUI:setAnchorPoint(handle, 0.5,1)
        end

        --左侧页签
        local btn_x,btn_y = 0,0
        local list_handle = GUI:ListView_Create(_fahandle, "ListView_1", 130, 0, 116, wnd_h - 120, 1)
        if list_handle then
            GUI:setAnchorPoint(list_handle, 0.5,0)
            GUI:ListView_setClippingEnabled(list_handle,true)
            GUI:ListView_setItemsMargin(list_handle, 10)

            for i, v in ipairs(_cfg) do
                handle = GUI:Button_Create(list_handle, "page1_"..i, btn_x,btn_y, "res/01/010005.png")
                if handle then
                    local txt_handle = GUI:Text_Create(handle, "title", 55,5, 18, _color[true], v.title)
                    GUI:setAnchorPoint(txt_handle, 0.5, 0)

                    GUI:Button_loadTexturePressed(handle, "res/01/010006.png")
                    GUI:Button_loadTextureDisabled(handle, "res/01/010006.png")
                    GUI:addOnClickEvent(handle, function()
                        Hecheng.updataPage1(i)
                    end)
                    if i == 1 then
                        Hecheng.updataPage1(i)
                    end
                end
            end
        end
    end
    SL:RegisterLUAEvent("LUA_EVENT_MONEYCHANGE", "合成", Hecheng.updateText) --货币变化时触发
end

function Hecheng.updataPage1(index)
    --上一次选择按钮
    if page1 then
        local handle = GUI:GetWindow(GUIparent, "img_bg/ListView_1/page1_"..page1)
        GUI:Button_setBrightEx(handle, true)
        local txt_handle = GUI:GetWindow(handle, "title")
        GUI:Text_setTextColor(txt_handle, _color[true])
    end
    if index == page1 then return end
    page1 = index
    local handle = GUI:GetWindow(GUIparent, "img_bg/ListView_1/page1_"..page1)
    GUI:Button_setBrightEx(handle,false)
    local txt_handle = GUI:GetWindow(handle, "title")
    GUI:Text_setTextColor(txt_handle, _color[false])
    Hecheng.updateUI()
end

local imgUI = {}
function Hecheng.updateUI()
    local _parent = GUI:GetWindow(GUIparent, "img_bg")
    local list_handle = GUI:GetWindow(_parent, "ListView_2")
    if not list_handle then
        list_handle = GUI:ListView_Create(_parent, "ListView_2", 195, 445 / 2 + 20, 560,445, 1)
        GUI:setAnchorPoint(list_handle, 0,0.5)
        GUI:ListView_setClippingEnabled(list_handle,true)
        GUI:ListView_setItemsMargin(list_handle, 15)
    end
    GUI:removeAllChildren(list_handle)
    local cfg = _cfg[page1]
    local max = #cfg
    local limit = 2
    local num = math.ceil(max/limit)

    local item_w,item_h = 270,190

    local idx = 0
    for i = 1, num do
        local handle = GUI:Layout_Create(list_handle, "layout_item_"..i, 0,0, item_w * limit + 10, item_h + 10)
        if handle then
            GUI:setAnchorPoint(handle, 0.5, 0.5)
            GUI:setTouchEnabled(handle, true)

            for j = 1, limit do
                idx = idx + 1
                if idx <= max then
                    local _handle = GUI:Image_Create(handle, "item_"..j, (j - 1) * (item_w + 7) + 5, 5, "res/custom/common/bg_hhdb_02.jpg")
                    GUI:Image_setScale9Slice(_handle, 10, 10, 10, 10)
                    GUI:setAnchorPoint(_handle, 0,0)
                    GUI:setContentSize(_handle,{width = item_w, height = item_h})
                    GUI:setTouchEnabled(_handle, true)
                    imgUI["item_"..idx] = _handle
                end
            end
        end
    end

    for i, v in ipairs(cfg) do
        local _fahandle = imgUI["item_"..i]
        local itemName = SL:GetItemNameByIndex(v.product[1][1])
        local handle = GUI:Text_Create(_fahandle, "txt_title", item_w / 2,item_h - 20, 18, "#D6C6AD", itemName)
        if handle then
            GUI:setAnchorPoint(handle, 0.5,0.5)
        end
        handle = GUI:Image_Create(_fahandle, "item_bg", 30,70, "res/custom/common/object_di_1.png")
        if handle then
            GUI:setScale(handle, 0.9)
        end
        GUI:ItemShow_Create(_fahandle, "item_",30,70, {index = v.product[1][1], look = true})
        GUI:RichText_Create(_fahandle, "txt_pro", 10,30, "成功率："..v.probability/100 .."%", 200, 16, "#D6C6AD")

        handle = GUI:Button_Create(_fahandle, "page1_"..i, 130,20, "res/01/010005.png")
        if handle then
            local txt_handle = GUI:Text_Create(handle, "Go", 55,5, 18, "#FFFFB7", "合   成")
            GUI:setAnchorPoint(txt_handle, 0.5, 0)
            GUI:addOnClickEvent(handle, function()
                Hecheng.Go(v.idx)
            end)
        end

        local x,y = 185,120
        for j, var in ipairs(v.itemid1) do
            local bag_num = SL:GetItemNumberByIndex(var[1])
            local cost_num = var[2]
            local cost_name = SL:GetItemNameByIndex(var[1])
            local str = SLChangeColour(bag_num,cost_num,cost_name)
            local _handle = GUI:RichText_Create(_fahandle, "tx_need_"..j, x,y, str, 265)
            GUI:setAnchorPoint(_handle, 0.5,0.5)
            y = y - 30
        end
    end
end

function Hecheng.updateText()
    local _parent = GUI:GetWindow(nil,"Hecheng")
    if not _parent then return end

    local cfg = _cfg[page1]
    for i, v in ipairs(cfg) do
        local _fahandle = imgUI["item_"..i]
        local x,y = 185,120

        for j, var in ipairs(v.itemid1) do
            local handle = GUI:GetWindow(_fahandle,"tx_need_"..j)
            if handle then
                GUI:Win_Close(handle)
                GUI:removeFromParent(handle)
            end
            local bag_num = SL:GetItemNumberByIndex(var[1])
            local cost_num = var[2]
            local cost_name = SL:GetItemNameByIndex(var[1])
            local str = SLChangeColour(bag_num,cost_num,cost_name)
            handle = GUI:RichText_Create(_fahandle, "tx_need_"..j, x,y, str, 265)
            GUI:setAnchorPoint(handle, 0.5,0.5)
            y = y - 30
        end
    end
end

function Hecheng.Go(index)
    SL:SubmitForm("F/合成表单","main",index)
end

function Hecheng.test(index)
end

Hecheng.main()
















