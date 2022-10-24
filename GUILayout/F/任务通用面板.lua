TaskWnd = {}

local _color = {[true] = "#787974",[false] = "#FFFFB7"}

local winSize = SL:GetScreenSize()              --获取屏幕宽高
local x = winSize.width / 2
local y = winSize.height / 2
local w = winSize.width
local h = winSize.height

local handle

local GUIparent = nil

local richText = {
    "<font color='#FFFFFF'>积分达到 </font><font color='#7FFF00'>%d</font><font color='#FFFFFF'> 将获得</font>",
    "<font color='#FFFFFF'>击杀榜 </font><font color='#FFD700'>No.%d</font><font color='#FFFFFF'> 将获得</font>",
    "<font color='#FFFFFF'> </font><font color='#7FFF00'>No.%d ~ No.%d</font><font color='#FFFFFF'> 将获得</font>",
}
--------------------------------------------↓↓↓ 鬼谷押镖 ↓↓↓--------------------------------------------
--押镖 任务栏信息创建
function TaskWnd.CreatYabiaoBtn(info)
    if not info then
        --测试用
        info = {}
        info[1] = 100
        info[2] = 1000
        info[3] = 99
        info[4] = 99
        info[5] = "初级镖车"
    else
        info = string.gsub(info, "'","")
        info = SL:JsonDecode(info)
    end

    local _parent = MainAssist.Panel_mission
    if not _parent then return end

    dump(info,"押镖任务栏"..type(info))

    _parent = GUI:GetWindow(_parent, "TaskWnd_yabiao")
    if _parent then
        GUI:removeFromParent(_parent)
        _parent = nil
    end
    local function Messagebox_ok(param1,param2,param3)
        print("param1",type(param1),param1)
        if param1 == 1 then
            SL:SubmitForm("F/押镖表单","RequestGiveup","")
        end
    end

    if not _parent then
        _parent = GUI:Node_Create(MainAssist.Panel_mission, "TaskWnd_yabiao", 0,0)

        handle = GUI:Text_Create(_parent, "txt_title", 100,165, 16, "#D2B48C", "正在押送"..info[5].."["..info[3]..","..info[4].."]")
        GUI:setAnchorPoint(handle, 0.5, 0.5)

        handle = GUI:Text_Create(_parent, "txt_hp1", 110,125, 16, "#FFFFFF", "镖车血量")
        GUI:setAnchorPoint(handle, 0.5, 0.5)

        handle = GUI:Image_Create(_parent, "img_hp_bg", 40,90, "res/custom/activity/1900012530.png")

        handle =  GUI:LoadingBar_Create(_parent, "bar_hp", 40 + 1,90 + 1, "res/custom/activity/1900012532.png", 0)
        GUI:LoadingBar_setPercent(handle, info[1] / info[2] * 100)

        handle = GUI:Text_Create(_parent, "txt_hp2", 110,98, 14, "#FFFFFF", info[1].."/"..info[2])
        GUI:setAnchorPoint(handle, 0.5, 0.5)

        handle = GUI:Button_Create(_parent, "btn_yabiao_1", 10,30, "res/01/010005.png")
        local txt_handle = GUI:Text_Create(handle, "title", 90 / 2,32 / 2, 15, _color[false], "放弃押镖")
        GUI:setAnchorPoint(txt_handle, 0.5, 0.5)
        GUI:setContentSize(handle,{width = 90, height = 30})
        GUI:Button_loadTexturePressed(handle, "res/01/010006.png")
        GUI:Button_loadTextureDisabled(handle, "res/01/010006.png")
        GUI:addOnClickEvent(handle, function()

            local data = {}

            data.btnDesc = {"确认","取消"}
            -- data.btnRes={{"res/01/010005.png","res/01/010006.png"},{"res/01/010005.png","res/01/010006.png"}}--按钮图片
            data.btnStyle={255,255}    --参考 cfg_colour_style 表 
            data.str="<font color='#C0C0C0' size='16'>是否确认放弃本次押镖任务</font>"          --文本内容
            data.callback = Messagebox_ok    --回调函数  type = 1时为第一个按钮 2为第二个
            data.showEdit=false    --是否显示输入框
            data.editParams={str="请输入",inputMonde=4,maxLength=5}    --输入框参数{str, inputMode, maxLength}可为空
        
            SL:OpenCommonTipsPop(data)
        end)

        handle = GUI:Button_Create(_parent, "btn_yabiao_2", 105,30, "res/01/010005.png")
        txt_handle = GUI:Text_Create(handle, "title", 90 / 2,32 / 2, 16, _color[false], "自动押镖")
        GUI:setAnchorPoint(txt_handle, 0.5, 0.5)
        GUI:setContentSize(handle,{width = 90, height = 30})
        GUI:Button_loadTexturePressed(handle, "res/01/010006.png")
        GUI:Button_loadTextureDisabled(handle, "res/01/010006.png")
        GUI:addOnClickEvent(handle, function()
            SL:SubmitForm("F/押镖表单","RequestAuto","")
        end)
    end

    TaskWnd.UpdataYabiaoBtn(info)
end

--押镖 任务结束清空按钮
function TaskWnd.DeletYabiaoBtn()
    local _parent = MainAssist.Panel_mission
    if not _parent then return end

    _parent = GUI:GetWindow(_parent, "TaskWnd_yabiao")
    if _parent then
        GUI:removeFromParent(_parent)
    end
end

--押镖 任务栏信息更新
function TaskWnd.UpdataYabiaoBtn(info)
    local _parent = MainAssist.Panel_mission
    _parent = GUI:GetWindow(_parent, "TaskWnd_yabiao")
    if not _parent then return end
    handle = GUI:GetWindow(_parent,"txt_title")
    if handle then
        GUI:Text_setString(handle, "正在押送"..info[5].."["..info[3]..","..info[4].."]")
    end
    handle = GUI:GetWindow(_parent,"txt_hp2")
    if handle then
        GUI:Text_setString(handle, info[1].."/"..info[2])
    end
    handle = GUI:GetWindow(_parent,"bar_hp")
    if handle then
        GUI:LoadingBar_setPercent(handle, info[1] / info[2] * 100)
    end
end
--------------------------------------------↓↓↓ 鬼谷采集 ↓↓↓--------------------------------------------
--展示/隐藏 采集按钮
function TaskWnd.IconSetVisible(flag)
    flag = tonumber(flag)
    local bool = flag == 1 or false
    print("bool",tostring(bool),type(flag))
    local _parent = GUI:GetWindow(nil, "GameMainWnd_caiji")
    if bool then
        if not _parent then
            _parent = GUI:Win_Create("GameMainWnd_caiji", 0, 0, 0, 0, false, false, true, false)
            handle = GUI:Image_Create(_parent, "img_bg", x,y, "res/custom/activity/btn_main_caiji.png")
            GUI:setAnchorPoint(handle, 0.5, 0.5)
            GUI:setTouchEnabled(handle, true)
            GUI:addOnClickEvent(handle, function()
                SL:SubmitForm("F/采集表单","RequestStart")
            end)

            handle = GUI:ProgressTimer_Create(_parent, "bar_caiji", x,y, "res/custom/activity/btn_main_caiji_jindutiao.png")
            GUI:setAnchorPoint(handle, 0.5, 0.5)


            handle = GUI:Text_Create(_parent, "txt_title", x,y - 50, 15, "#FFFFFF", "开始采集")
            GUI:setAnchorPoint(handle, 0.5,0)
        end
    else
        if _parent then
            GUI:Win_Close(_parent)
        end
    end
end
--停止采集
function TaskWnd.StopProgress()
    handle = GUI:GetWindow(nil, "GameMainWnd_caiji/bar_caiji")
    if handle then
        -- GUI:ProgressTimer_setPercentage(handle, 0)
        GUI:removeFromParent(handle)
        local _parent = GUI:GetWindow(nil, "GameMainWnd_caiji")
        if _parent then
            handle = GUI:ProgressTimer_Create(_parent, "bar_caiji", x,y, "res/custom/activity/btn_main_caiji_jindutiao.png")
            GUI:setAnchorPoint(handle, 0.5, 0.5)
        end
    end
    handle = GUI:GetWindow(nil, "GameMainWnd_caiji/txt_title")
    if handle then
        GUI:Text_setString(handle, "开始采集")
    end
end

local function finish()
    print("采集完成,finish")
    SL:SubmitForm("F/采集表单","RequestFinish")
    -- TaskWnd.StopProgress()
end
--开始采集
function TaskWnd.StartResponse(monobj,monidx)

    handle = GUI:GetWindow(nil, "GameMainWnd_caiji/bar_caiji")
    if handle then
        GUI:ProgressTimer_progressFromTo(handle, 10, 1, 100, finish())
    end
    handle = GUI:GetWindow(nil, "GameMainWnd_caiji/txt_title")
    if handle then
        GUI:Text_setString(handle, "采集中")
    end
end
--------------------------------------------↓↓↓ 大乱斗 ↓↓↓--------------------------------------------
--决战紫禁之巅/大乱斗 进入地图按钮创建
function TaskWnd.CreatdldBtn()
    local _parent = MainAssist.Panel_mission
    if not _parent then return end

    _parent = GUI:GetWindow(_parent, "TaskWnd_dldBtn")
    if _parent then
        GUI:removeAllChildren(_parent)
    else
        _parent = GUI:Node_Create(MainAssist.Panel_mission, "TaskWnd_dldBtn", 0,0)
    end

    handle = GUI:Button_Create(_parent, "btn_dld_1", 25,-65, "res/custom/activitySystem/5.png")
    GUI:addOnClickEvent(handle, function()
        SL:SubmitForm("F/大乱斗表单","RequestOpenRankWnd",1)
    end)
    handle = GUI:Button_Create(_parent, "btn_dld_2", 125,-65, "res/custom/activitySystem/3.png")
    GUI:addOnClickEvent(handle, function()
        SL:SubmitForm("F/大乱斗表单","RequestOpenRankWnd",3)
    end)

    handle = GUI:Button_Create(_parent, "btn_dld_3", 76,y - 30, "res/01/010005.png")
    local txt_handle = GUI:Text_Create(handle, "title", 112 / 2,39 / 2, 16, _color[false], "关闭活动")
    GUI:setAnchorPoint(txt_handle, 0.5, 0.5)
    GUI:Button_loadTexturePressed(handle, "res/01/010006.png")
    GUI:Button_loadTextureDisabled(handle, "res/01/010006.png")
    GUI:addOnClickEvent(handle, function()
        SL:SubmitForm("F/大乱斗表单","custom_close","")
    end)
end

--决战紫禁之巅/大乱斗 离开地图按钮删除
function TaskWnd.DeletdldBtn()
    local _parent = MainAssist.Panel_mission
    if not _parent then return end

    _parent = GUI:GetWindow(_parent, "TaskWnd_dldBtn")
    if _parent then
        GUI:removeFromParent(_parent)
    end
end
local miniwnd_w,miniwnd_h = 400,500
function TaskWnd.OpenRankWnd(data)
    data = string.gsub(data, "'","")
    data = SL:JsonDecode(data)
    local idx,myNum,myRank,rank_list = tonumber(data[1]),tonumber(data[2]),tonumber(data[3]),data[4]

    local _parent = GUI:GetWindow(nil, "TaskWnd")
    if _parent then
        GUI:removeAllChildren(_parent)
    else
        _parent = GUI:Win_Create("TaskWnd", 0, 0, 0, 0, false, false, true, false)
    end

    GUIparent = _parent

    _parent = GUI:Layout_Create(_parent, "layout_mainWnd", 0,0, winSize.width, winSize.height)
    GUI:setTouchEnabled(_parent, true)
    GUI:addOnClickEvent(_parent, function()
        GUI:Win_Close(GUIparent)
    end)

    _parent = GUI:Image_Create(_parent, "img_bg", x,y, "res/private/TradingBankLayer/bg_jiaoyh_05.png")
    GUI:Image_setScale9Slice(_parent, 20, 20, 20, 20)
    GUI:setAnchorPoint(_parent, 0.5, 0.5)
    GUI:setContentSize(_parent,{width = miniwnd_w, height = miniwnd_h})
    GUI:setTouchEnabled(_parent, true)

    handle = GUI:Button_Create(_parent, "btn_close", miniwnd_w,miniwnd_h, "res/public/1900000510.png")
    GUI:setAnchorPoint(handle, 0,1)
    GUI:Button_loadTexturePressed(handle, "res/public/1900000511.png")
    GUI:addOnClickEvent(handle, function()
        GUI:Win_Close(GUIparent)
    end)

    local list_handle = GUI:ListView_Create(_parent, "list_checkBox_1", 11,miniwnd_h - 58, miniwnd_w - 22,miniwnd_h - 68, 1)
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
    elseif idx == 3 then
        msgTitle = "大乱斗排行榜"
        -- rank_list = {{"测试1",10},{"测试2111111",9},{"测试3",9},{"测试4",9},{"测试5",9},{"测试6",9},{"测试7",9},{"测试8",9},{"测试9",9},{"测试10",9}}
        local rank_color = {"#FFD700","#FF00FF","#90EE90"}
        for i, v in ipairs(rank_list) do
            local color = rank_color[i] or "#FFFFFF"
            local layout = GUI:Layout_Create(list_handle, "layout_page_"..i,0,0, 380,38)
            handle = GUI:RichText_Create(layout, "txt_num", 30,13, "No."..i, 200,16,color)
            handle = GUI:RichText_Create(layout, "txt_name", 160,13, v[1], 200,16,color)
            GUI:setAnchorPoint(handle, 0.5,0)
            handle = GUI:RichText_Create(layout, "txt_killNum", 300,13, "击杀"..v[2].."人", 200,16,color)
            GUI:setAnchorPoint(handle, 0.5,0)
        end
        if #rank_list == 0 then
            handle = GUI:Text_Create(_parent, "txt_nil", miniwnd_w / 2,miniwnd_h /2, 18, "#808080", "当前排行榜为空")
            GUI:setAnchorPoint(handle, 0.5,1)
        end
    end
    handle = GUI:Text_Create(_parent, "txt_title", miniwnd_w / 2,miniwnd_h - 18, 20, "#D6C6AD", msgTitle)
    GUI:setAnchorPoint(handle, 0.5,1)
end

return TaskWnd