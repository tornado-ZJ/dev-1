GongLue = {}

local _color = {[true] = "#787974",[false] = "#FFFFB7"}

local GUIparent,handle,GongLuePage

local wnd_w,wnd_h = 815,575                         --大背景图宽高

local _cfg = cfg_gonglue
--------------------------------------------↓↓↓ 本地方法 ↓↓↓--------------------------------------------
--替换item_tips
local function item_tips_gsub(str,s_begin,s_end)
    local s_begin_Len = string.len(s_begin)
    while string.find(str, s_begin, 1) do
        local s_begin_x = string.find(str, s_begin, 1)
        local s_end_x = string.find(str, s_end, s_begin_x + 1)
        local itemidx = (string.sub(str, s_begin_x + s_begin_Len, s_end_x - 1))

        local item_name = SL:GetItemNameByIndex(itemidx)
        local item_tips = string.format("<a enableUnderline ='false' href = 'jump#item_tips#%s'><u><font color = '#ff0000'>%s</font></u></a>", itemidx,item_name)

        local temp_tips = string.format("itemID:%s&item", itemidx)
        str = string.gsub(str, temp_tips, item_tips)
    end
    return str
end
--------------------------------------------↓↓↓ UI创建 ↓↓↓--------------------------------------------
function GongLue.main()
    local _parent = GUI:Win_Create("GongLue", 0, 0, 0, 0, false, false, true, false)
    local winSize = SL:GetScreenSize()              --获取屏幕宽高
    local x = winSize.width / 2
    local y = winSize.height / 2
    local w = winSize.width
    local h = winSize.height

    GUIparent = _parent

    handle = GUI:Layout_Create(_parent, "layout_close", x, y, w, h)
    if handle then
        GUI:Layout_setBackGroundColor(handle, "#000000")
        GUI:Layout_setBackGroundColorType(handle, 1)
        GUI:Layout_setBackGroundColorOpacity(handle, 100)
        GUI:setAnchorPoint(handle, 0.5, 0.5)
        GUI:setTouchEnabled(handle, true)
        GUI:addOnClickEvent(handle, function()
            GUI:Win_Close(_parent)
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
                GUI:Win_Close(_parent)
            end)
        end

        handle = GUI:Image_Create(_fahandle, "img_bg1", 62,21, "res/custom/zhigou/7.jpg")
        if handle then
            GUI:setContentSize(handle,{width = 734 - 42, height = 447})
        end

        handle = GUI:Text_Create(_fahandle, "txt_title", wnd_w / 2,wnd_h - 35, 20, "#D6C6AD", "游戏攻略")
        if handle then
            GUI:setAnchorPoint(handle, 0.5,1)
        end

        --子窗口创建于此
        local list_handle = GUI:ListView_Create(_fahandle, "layout_main", 374 + 110,53 - 31, 537,445, 1)
        if list_handle then
            GUI:setAnchorPoint(list_handle, 0.5,0)
            GUI:ListView_setClippingEnabled(list_handle,true)
            GUI:ListView_setItemsMargin(list_handle, 10)
        end

        --左侧页签
        local btn_x,btn_y = 0,0
        list_handle = GUI:ListView_Create(_fahandle, "ListView_1", 138, 0, 116, wnd_h - 120, 1)
        if list_handle then
            GUI:setAnchorPoint(list_handle, 0.5,0)
            GUI:ListView_setClippingEnabled(list_handle,true)
            GUI:ListView_setItemsMargin(list_handle, 10)

            for i, v in ipairs(_cfg) do
                handle = GUI:Button_Create(list_handle, "page1_"..i, btn_x,btn_y, "res/01/010005.png")
                if handle then
                    local txt_handle = GUI:Text_Create(handle, "title", 55,5, 18, _color[true], v.typeName)
                    GUI:setAnchorPoint(txt_handle, 0.5, 0)
                    GUI:Button_loadTexturePressed(handle, "res/01/010006.png")
                    GUI:Button_loadTextureDisabled(handle, "res/01/010006.png")
                    GUI:addOnClickEvent(handle, function()
                        GongLue.updataPage(i)
                    end)
                    if i == 1 then
                        GongLue.updataPage(i)
                    end
                end
            end
        end
    end

    handle = GUI:Image_Create(_parent, "img_b2", 58 + 160,18 + 31, "res/custom/painting/vip_welfare_item_frame.png")
    if handle then
        GUI:Image_setScale9Slice(handle, 10, 10, 10, 10)
        GUI:setContentSize(handle,{width = 734 - 35, height = 455})
        GUI:setLocalZOrder(handle,99)
    end
end

function GongLue.updataPage(index)
    if not _cfg[index] then return end

    --上一次选择按钮
    if GongLuePage then
        local handle = GUI:GetWindow(GUIparent, "img_bg/ListView_1/page1_"..GongLuePage)
        GUI:Button_setBrightEx(handle, true)
        local txt_handle = GUI:GetWindow(handle, "title")
        GUI:Text_setTextColor(txt_handle, _color[true])
        local mainWnd = GUI:GetWindow(GUIparent,"img_bg/layout_main")
        if mainWnd then
            GUI:removeAllChildren(mainWnd)
        end
    end

    if index == GongLuePage then return end

    GongLuePage = index
    local handle = GUI:GetWindow(GUIparent, "img_bg/ListView_1/page1_"..GongLuePage)
    GUI:Button_setBrightEx(handle,false)
    local txt_handle = GUI:GetWindow(handle, "title")
    GUI:Text_setTextColor(txt_handle, _color[false])

    GongLue.updateDescUI()
end

function GongLue.updateDescUI()
    local item_page = 0

    local neirong = _cfg[GongLuePage].text

    neirong = item_tips_gsub(neirong,"itemID:","&item")

    local _parent = GUI:GetWindow(GUIparent,"img_bg/layout_main")
    local cfg_itemshow = _cfg[GongLuePage].show
    if string.find(neirong, "<br>") then
        local jiushangquan = string.split(neirong, "<br>")
        for i, value in ipairs(jiushangquan) do

            handle = GUI:Layout_Create(_parent, "layout_item_"..i, 0,0, 535, 20)
            if handle then
                -- GUI:Layout_setBackGroundColor(handle, "#FFB6C1")
                -- GUI:Layout_setBackGroundColorType(handle, 1)
                -- GUI:Layout_setBackGroundColorOpacity(handle, 100)

                GUI:setAnchorPoint(handle, 0.5, 0.5)
                GUI:setTouchEnabled(handle, true)

                GUI:RichText_Create(handle, "rich_text", 0, 0, value, 9999,16,nilnil, nil, function (tstr, rt)
                    local slices = string.split(tstr, "#")
                    if slices[1] == "openwin" then
                        print(slices[2])
                        GUI:Win_Open(slices[2])
                    end
                end)

                if value ~= "" then
                    item_page = item_page + 1
                    if cfg_itemshow and cfg_itemshow[item_page] then
                        for j, itemidx in ipairs(cfg_itemshow[item_page]) do
                            local itemshow = GUI:ItemShow_Create(handle, "itemshow"..i.."_"..j,30 + (j - 1) * 60,-75, {index = itemidx, look = true,bgVisible = true})
                            GUI:setScale(itemshow, 0.9)
                        end
                    end
                end
            end
        end
    end
end

GongLue.main()