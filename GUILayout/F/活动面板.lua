ActivitySystem = {}

local _color = {[true] = "#787974",[false] = "#FFFFB7"}

ActivitySystemPage = nil

local _cfg = cfg_gameactive

local GUIparent = nil

local handle

local wnd_w,wnd_h = 815,575                         --大背景图宽高

local richText = {
    "<font color='#FFFFFF'>积分达到 </font><font color='#7FFF00'>%d</font><font color='#FFFFFF'> 将获得</font>",
    "<font color='#FFFFFF'>击杀榜 </font><font color='#FFD700'>No.%d</font><font color='#FFFFFF'> 将获得</font>",
    "<font color='#FFFFFF'> </font><font color='#7FFF00'>No.%d ~ No.%d</font><font color='#FFFFFF'> 将获得</font>",
    [true]  = "<font color='#00FF00'>今日%s次数：</font><font color='#00FF00'>%s</font>",
    [false] = "<font color='#FF0000'>今日%s次数：</font><font color='#FF0000'>%s</font>",
}

local winSize = SL:GetScreenSize()              --获取屏幕宽高
local x = winSize.width / 2
local y = winSize.height / 2
local w = winSize.width
local h = winSize.height

local data = SL.FormParam[1]
data = string.gsub(data, "'","")
data = SL:JsonDecode(data)

local data_max = {}
data_max[1] = cfg_caiji[1].items
data_max[2] = cfg_biaoche[1].cishu
data_max[3] = cfg_biaoche[1].cishu2

function ActivitySystem.RequestEnter()
    local idx = _cfg[ActivitySystemPage] and _cfg[ActivitySystemPage].id or 0

    if idx == 1 then
        SL:SubmitForm("F/大乱斗表单","RequestEnter")
    elseif idx == 2 then
        SL:SubmitForm("F/勇闯魔域表单","RequestEnter")
    elseif idx == 3 then
        SL:SubmitForm("F/押镖表单","RequestEnter")
    elseif idx == 4 then
        SL:SubmitForm("F/采集表单","RequestEnter")
    elseif idx == 6 then
        SL:SubmitForm("F/沙城争霸表单","RequestEnter")
    end

    GUI:Win_Close(GUIparent)
end

function ActivitySystem.main()
    local _parent = GUI:Win_Create("ActivitySystem", 0, 0, 0, 0, false, false, true, false)

    GUIparent = _parent

    handle = GUI:Layout_Create(_parent, "layout_close", x, y, w, h)
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

        handle = GUI:Image_Create(_fahandle, "img_bg1", 62,21, "res/custom/painting/bg_limit_task.jpg")
        GUI:Image_setScale9Slice(handle, 10, 10, 10, 10)
        GUI:setContentSize(handle,{width = 734 - 42, height = 447})

        handle = GUI:Image_Create(_fahandle, "img_line", 520,20, "res/custom/common/img_line_1.png")

        handle = GUI:Image_Create(_fahandle, "img_bg2", 545,410, "res/custom/common2/191.png")
        handle = GUI:Text_Create(handle, "txt_title", 189 / 2,46 / 2, 19, "#D6C6AD", "玩法说明")
        GUI:setAnchorPoint(handle, 0.5,0.5)

        handle = GUI:Text_Create(_fahandle, "txt_title", wnd_w / 2,wnd_h - 35, 20, "#D6C6AD", "活动大厅")
        GUI:setAnchorPoint(handle, 0.5,1)

        handle = GUI:Button_Create(_fahandle, "btn_goto", 567,50, "res/01/010005.png")
        local txt_handle = GUI:Text_Create(handle, "title", 140 / 2,48 / 2, 20, _color[false], "立即前往")
        GUI:setAnchorPoint(txt_handle, 0.5, 0.5)
        GUI:Button_loadTexturePressed(handle, "res/01/010006.png")
        GUI:Button_loadTextureDisabled(handle, "res/01/010006.png")
        GUI:setContentSize(handle,{width = 140, height = 45})
        GUI:addOnClickEvent(handle, function()
            ActivitySystem.RequestEnter()
        end)

        --奖励/排行按钮创建于此
        handle = GUI:Layout_Create(_parent, "layout_btn_main", 680,140, 230,60)

        --左侧页签
        local list_handle = GUI:ListView_Create(_fahandle, "ListView_1", 65, 20, 455, wnd_h - 125, 1)
        if list_handle then
            GUI:ListView_setClippingEnabled(list_handle,true)

            for i, v in ipairs(_cfg) do
                local layout = GUI:Layout_Create(list_handle, "layout_page_"..i,0,0, 455,125)
                -- GUI:Layout_setBackGroundColor(layout, "#FFB6C1")
                -- GUI:Layout_setBackGroundColorType(layout, 1)
                -- GUI:Layout_setBackGroundColorOpacity(layout, 100)

                handle = GUI:Image_Create(layout, "img_bg0", 5,-0, "res/custom/painting/14_png.oldserver.img_oldserver_A8.png")
                GUI:Image_setScale9Slice(handle, 20, 20, 20, 20)
                GUI:setContentSize(handle,{width = 445, height = 115})

                handle = GUI:Image_Create(layout, "img_bg1", 20,100, "res/custom/common2/328.png")
                GUI:setFlippedY(handle, true)

                local item_x,item_y = 25,20
                if i == 1 then
                    item_x,item_y = 15,30
                end
                handle = GUI:Image_Create(layout, "img_activity", item_x,item_y, "res/custom/activitySystem/"..v.iconid..".png")

                handle = GUI:RichText_Create(layout, "txt_title", 143,70, v.Name, 265,17,"#FFD700")
                GUI:setAnchorPoint(handle, 0.5,0)

                local timeStr = string.gsub(v.BTime, "%$", ":") .. " - " .. string.gsub(v.OTime, "%$", ":")
                handle = GUI:RichText_Create(layout, "txt_timeStr", 245,73,"活动时间："..timeStr, 265,15)

                ActivitySystem.setActivityState(i)

                handle = GUI:Effect_Create(layout, "effect", 60, 52, 0, 4004)
                handle:hide()

                handle = GUI:Layout_Create(layout, "layout_click",0,0, 455,125)
                GUI:setTouchEnabled(handle,true)
                GUI:addOnClickEvent(handle, function()
                    ActivitySystem.updataPage(i)
                end)

                if ActivitySystemPage and ActivitySystemPage == i then
                    ActivitySystem.updataPage(i,true)
                elseif i == 1 then
                    ActivitySystem.updataPage(i,true)
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

local function getTodayTimeStamp(hour,min,sec)
    local cDateCurrectTime = os.date("*t")
    local cDateTodayTime = os.time({year=cDateCurrectTime.year, month=cDateCurrectTime.month, day=cDateCurrectTime.day, hour=hour,min=min,sec=sec})
    return cDateTodayTime
end

function ActivitySystem.setActivityState(idx)
    local cfg = _cfg[idx]
    local weekTime = tonumber(os.date("%w", os.time()))
    if weekTime == 0 then
        weekTime = 7
    end
    local dayStr = {
        "一", "二", "三", "四", "五", "六", "日",
    }
    local _parent = GUI:GetWindow(GUIparent, "img_bg/ListView_1/layout_page_"..idx)
    if not _parent then return end

    local istoday = true
    local str = ""
    if cfg.Time1 then
        if type(cfg.Time1) == "number" and dayStr[cfg.Time1] then
            istoday = cfg.Time1 == weekTime
            str = "每周"..dayStr[cfg.Time1].."开启!"
        end
        if type(cfg.Time1) == "table" then
            local isall = #cfg.Time1 == 7 and true or false
            if isall then
                istoday = true
                str = "每日开启!"
            else
                str = "每周"
                for j,day in ipairs(cfg.Time1) do
                    str = str .."星期"..dayStr[day]
                    if day == weekTime then
                        istoday = true
                    end
                    if j ~= #cfg.Time1 then
                        str = str .."、"
                    end
                end
                str = str .."开启!"
            end
        end
    end

    GUI:RichText_Create(_parent, "img_dayBill", 110,30, str, 265,16,"#00FF00")

    local img_load = nil
    local state_x ,state_y = 400,62
    if istoday then
        local now = os.time()
        local BTime = string.split(cfg.BTime,"$")
        local OTime = string.split(cfg.OTime,"$")
        if now >= getTodayTimeStamp(BTime[1],BTime[2],0) and now < getTodayTimeStamp(OTime[1],OTime[2],0) then
            --活动进行中
            state_x ,state_y = 415,50
            img_load = "res/custom/huodong/bg_riczy_01.png"

            local rp = true
            if cfg.id == 3 then
                rp = data[2] > 0
            elseif cfg.id == 4 then
                rp = data[1] > 0
            end
            if rp then
                GUI:Image_Create(_parent, "img_redPonit", 430,95, "res/custom/common/img_2.png")
            end
        elseif now >= getTodayTimeStamp(OTime[1],OTime[2],0) then
            --活动已结束
            state_x ,state_y = 300,15
            img_load = "res/custom/huodong/bg_riczy_02.png"
        end
    end

    if img_load then
        handle = GUI:Image_Create(_parent, "img_state", state_x ,state_y, img_load)
    end
end

function ActivitySystem.updataPage(idx,isFirst)  --参数(页签id,是否首次打开面板
    local cfg = _cfg[idx]
    if not cfg then return end

    if not isFirst then
        handle = GUI:GetWindow(GUIparent,"img_bg/ListView_1/layout_page_"..idx.."/img_redPonit")
        if handle then
            GUI:removeFromParent(handle)
        end
    end

    if idx == ActivitySystemPage then return end

    local _parent = GUI:GetWindow(GUIparent, "img_bg")
    if not _parent then return end
    --上一次选择按钮
    if ActivitySystemPage and not isFirst then
        handle = GUI:GetWindow(_parent, "ListView_1/layout_page_"..ActivitySystemPage.."/effect")
        GUI:setVisible(handle,false)
    end

    ActivitySystemPage = idx
    handle = GUI:GetWindow(_parent, "ListView_1/layout_page_"..ActivitySystemPage.."/effect")
    GUI:setVisible(handle,true)

    handle = GUI:GetWindow(_parent, "richtext_info")
    if handle then
        GUI:removeFromParent(handle)
    end

    handle = GUI:RichText_Create(_parent, "richtext_info", 530,400, cfg.Text, 220,16)
    GUI:setAnchorPoint(handle, 0,1)

    _parent = GUI:GetWindow(GUIparent, "layout_btn_main")
    if _parent then
        GUI:removeAllChildren(_parent)

        print(cfg.id)
        if cfg.id == 1 then
            --决战紫禁之巅/大乱斗 按钮
            handle = GUI:Button_Create(_parent, "btn_open_wnd_1", 37,0, "res/custom/activitySystem/5.png")
            GUI:addOnClickEvent(handle, function()  ActivitySystem.openMiniWnd(1) end)
            handle = GUI:Button_Create(_parent, "btn_open_wnd_2", 137,0, "res/custom/activitySystem/3.png")
            GUI:addOnClickEvent(handle, function()  ActivitySystem.openMiniWnd(2) end)
        elseif cfg.id == 3 then
            --押镖
            local str = string.format(richText[data[2] > 0],"押镖", data[2].."/"..data_max[2])
            handle = GUI:RichText_Create(_parent, "txt_title_1", 115,100, str, 200,17)
            GUI:setAnchorPoint(handle, 0.5,0)

            str = string.format(richText[data[3] > 0],"劫镖", data[3].."/"..data_max[3])
            handle = GUI:RichText_Create(_parent, "txt_title_2", 115,70, str, 200,17)
            GUI:setAnchorPoint(handle, 0.5,0)
        elseif cfg.id == 4 then
            --采集
            str = string.format(richText[data[1] > 0],"采集", data[1].."/"..data_max[1])
            handle = GUI:RichText_Create(_parent, "txt_title_2", 115,70, str, 200,17)
            GUI:setAnchorPoint(handle, 0.5,0)
        elseif cfg.id == 6 then
            --沙城争霸 按钮
            handle = GUI:Button_Create(_parent, "btn_open_wnd_3", 87,0, "res/custom/activitySystem/5.png")
            GUI:addOnClickEvent(handle, function()  ActivitySystem.openMiniWnd(3) end)
        end
    end
end

local miniwnd_w,miniwnd_h = 400,500
function ActivitySystem.openMiniWnd(idx)
    local _parent = GUI:GetWindow(GUIparent, "layout_miniWnd")
    if _parent then
        GUI:removeAllChildren(_parent)
    else
        _parent = GUI:Layout_Create(GUIparent, "layout_miniWnd", 0,0, winSize.width, winSize.height)
        GUI:setTouchEnabled(_parent, true)
        GUI:setLocalZOrder(_parent,99)
        GUI:addOnClickEvent(_parent, function() GUI:removeFromParent(_parent) end)
    end

    local mainUI = GUI:Image_Create(_parent, "img_bg", x,y, "res/private/TradingBankLayer/bg_jiaoyh_05.png")
    GUI:Image_setScale9Slice(mainUI, 20, 20, 20, 20)
    GUI:setAnchorPoint(mainUI, 0.8, 0.55)
    GUI:setContentSize(mainUI,{width = miniwnd_w, height = miniwnd_h})
    GUI:setTouchEnabled(mainUI, true)

    handle = GUI:Button_Create(mainUI, "btn_close", miniwnd_w,miniwnd_h, "res/public/1900000510.png")
    GUI:setAnchorPoint(handle, 0,1)
    GUI:Button_loadTexturePressed(handle, "res/public/1900000511.png")
    GUI:addOnClickEvent(handle, function() GUI:removeFromParent(_parent) end)

    local list_handle = GUI:ListView_Create(mainUI, "list_checkBox_1", 11,miniwnd_h - 58, miniwnd_w - 22,miniwnd_h - 68, 1)
    GUI:setAnchorPoint(list_handle, 0,1)
    GUI:ListView_setClippingEnabled(list_handle,true)
    GUI:ListView_setItemsMargin(list_handle, 5)

    local msgTitle = ""
    local str = ""
    local item_x,item_y = 15,5
    if idx == 1 then
        msgTitle = "积分奖励"
        for i, v in ipairs(cfg_jifen_gift) do
            local layout = GUI:Layout_Create(list_handle, "layout_page_"..i,0,0, 380,50)

            str = string.format(richText[idx],v.needPoints)
            handle = GUI:RichText_Create(layout, "txt_title", 120,15, str, 265,16,"#FFD700")
            GUI:setAnchorPoint(handle,0.5,0)

            item_x,item_y = 250,5
            for j, var in ipairs(v.reward) do
                handle = GUI:Image_Create(layout, "itemshow_"..j, item_x,item_y, "res/custom/common/img_cell_1.png")
                GUI:ItemShow_Create(handle, "item",3,3, {index = var[1], count = var[2], look = true})
                GUI:setScale(handle, 0.6)
                item_x = item_x + 50
            end
        end
    elseif idx == 2 then
        msgTitle = "击杀奖励"
        for i, v in ipairs(cfg_killer_gift) do
            local layout = GUI:Layout_Create(list_handle, "layout_page_"..i,0,0, 380,50)

            str = string.format(richText[2],v.ranking[1][1])
            if v.ranking[1][1] ~= v.ranking[1][2] then
                str = string.format(richText[3],v.ranking[1][1],v.ranking[1][2])
            end
            handle = GUI:RichText_Create(layout, "txt_title", 100,15, str, 265,14,"#FFD700")
            GUI:setAnchorPoint(handle,0.5,0)

            item_x,item_y = 190,8
            for j, var in ipairs(v.reward) do
                handle = GUI:Image_Create(layout, "itemshow_"..j, item_x,item_y, "res/custom/common/img_cell_1.png")
                GUI:ItemShow_Create(handle, "item",3,3, {index = var[1], count = var[2], look = true})
                GUI:setScale(handle, 0.5)
                item_x = item_x + 40
            end
        end
    elseif idx == 3 then
        msgTitle = "攻沙奖励"

        local layout = GUI:Layout_Create(list_handle, "layout_page_1",0,0, miniwnd_w,120)

        handle = GUI:Text_Create(layout, "txt_giftsTitle", 380 / 2,65, 16, "#00FF00", "胜利方会长奖励")
        GUI:setAnchorPoint(handle, 0.5,0)

        item_x,item_y = 44,8
        for j, var in ipairs(cfg_sbk[1].reward) do
            handle = GUI:Image_Create(layout, "itemshow_"..j, item_x,item_y, "res/custom/common/img_cell_1.png")
            GUI:ItemShow_Create(handle, "item",3,3, {index = var[1], count = var[2], look = true})
            GUI:setScale(handle, 0.7)
            item_x = item_x + 60
        end

        layout = GUI:Layout_Create(list_handle, "layout_page_2",0,0, miniwnd_w,120)
        handle = GUI:Text_Create(layout, "txt_giftsTitle", 380 / 2,65, 16, "#00FF00", "胜利方成员奖励")
        GUI:setAnchorPoint(handle, 0.5,0)

        item_x,item_y = 78,8
        for j, var in ipairs(cfg_sbk[1].rewardt) do
            handle = GUI:Image_Create(layout, "itemshow_"..j, item_x,item_y, "res/custom/common/img_cell_1.png")
            GUI:ItemShow_Create(handle, "item",3,3, {index = var[1], count = var[2], look = true})
            GUI:setScale(handle, 0.7)
            item_x = item_x + 60
        end

        layout = GUI:Layout_Create(list_handle, "layout_page_3",0,0, miniwnd_w,140)
        handle = GUI:Text_Create(layout, "txt_giftsTitle", 380 / 2,65, 16, "#DCDCDC", "失败方奖励")
        GUI:setAnchorPoint(handle, 0.5,0)

        item_x,item_y = 78,8
        for j, var in ipairs(cfg_sbk[2].rewardt) do
            handle = GUI:Image_Create(layout, "itemshow_"..j, item_x,item_y, "res/custom/common/img_cell_1.png")
            GUI:ItemShow_Create(handle, "item",3,3, {index = var[1], count = var[2], look = true})
            GUI:setScale(handle, 0.7)
            item_x = item_x + 60
        end
    end

    handle = GUI:Text_Create(mainUI, "txt_title", miniwnd_w / 2,miniwnd_h - 18, 20, "#D6C6AD", msgTitle)
    GUI:setAnchorPoint(handle, 0.5,1)
end

ActivitySystem.main()