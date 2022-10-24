ActivityMain = {}

local cfg_page = {
    Form_File       =   {"每日充值表单",    "每日限购表单",     "行会竞技表单",     "装备首爆表单",},
    Button_Name     =   {"每日充值",        "每日限购",         "行会竞技",        "装备首爆",},
}

local _color = {[true] = "#787974",[false] = "#FFFFB7"}

ActivityMainPage = nil

local GUIparent = nil

local wnd_w,wnd_h = 815,575                         --大背景图宽高

function ActivityMain.main()
    local _parent = GUI:Win_Create("ActivityMain", 0, 0, 0, 0, false, false, true, false)
    local winSize = SL:GetScreenSize()              --获取屏幕宽高
    local x = winSize.width / 2
    local y = winSize.height / 2
    local w = winSize.width
    local h = winSize.height

    GUIparent = _parent

    local handle = GUI:Layout_Create(_parent, "layout_close", x, y, w, h)
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

        handle = GUI:Text_Create(_fahandle, "txt_title", wnd_w / 2,wnd_h - 35, 20, "#D6C6AD", "福利大厅")
        if handle then
            GUI:setAnchorPoint(handle, 0.5,1)
        end

        --子窗口创建于此
        handle = GUI:Layout_Create(_parent, "layout_main", 374,53, 540,450)
        if handle then
            GUI:ListView_setClippingEnabled(handle,true)
        end

        --左侧页签
        local btn_x,btn_y = 0,0
        local list_handle = GUI:ListView_Create(_fahandle, "ListView_1", 138, 0, 116, wnd_h - 120, 1)
        if list_handle then
            GUI:setAnchorPoint(list_handle, 0.5,0)
            GUI:ListView_setClippingEnabled(list_handle,true)
            GUI:ListView_setItemsMargin(list_handle, 10)

            for i, v in ipairs(cfg_page.Button_Name) do
                handle = GUI:Button_Create(list_handle, "page1_"..i, btn_x,btn_y, "res/01/010005.png")
                if handle then
                    local txt_handle = GUI:Text_Create(handle, "title", 55,5, 18, _color[true], v)
                    GUI:setAnchorPoint(txt_handle, 0.5, 0)

                    GUI:Button_loadTexturePressed(handle, "res/01/010006.png")
                    GUI:Button_loadTextureDisabled(handle, "res/01/010006.png")
                    GUI:addOnClickEvent(handle, function()
                        ActivityMain.updataPage(i)
                    end)
                    if ActivityMainPage and ActivityMainPage == i then
                        ActivityMain.updataPage(i,true)
                    elseif i == 1 then
                        ActivityMain.updataPage(i,true)
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

function ActivityMain.updataPage(index,isFirst)  --参数(页签id,是否首次打开面板
    if not cfg_page.Button_Name[index] then return end

    --上一次选择按钮
    if ActivityMainPage and not isFirst then
        local handle = GUI:GetWindow(GUIparent, "img_bg/ListView_1/page1_"..ActivityMainPage)
        GUI:Button_setBrightEx(handle, true)
        local txt_handle = GUI:GetWindow(handle, "title")
        GUI:Text_setTextColor(txt_handle, _color[true])
    end
    if index == ActivityMainPage then return end

    local mainWnd = GUI:GetWindow(GUIparent,"layout_main")
    GUI:removeAllChildren(mainWnd)

    ActivityMainPage = index
    local handle = GUI:GetWindow(GUIparent, "img_bg/ListView_1/page1_"..ActivityMainPage)
    GUI:Button_setBrightEx(handle,false)
    local txt_handle = GUI:GetWindow(handle, "title")
    GUI:Text_setTextColor(txt_handle, _color[false])

    -- GUI:Win_Open("F/"..cfg_page.OBJ_File[index])
    SL:SubmitForm("F/"..cfg_page.Form_File[index],"SyncResponse")
end

ActivityMain.main()