Die = {}

local _cfg = cfg_fuhuo

local GUIparent = ""

local _color = {
    [true] = "#787974",[false] = "#DEBA6C"
}

local wnd_w,wnd_h = 815,575                         --大背景图宽高

local revive_type = {
    FREE = 0,               --免费复活
    PAY = 1,                --收费复活
}

local countTime = 10

local scheduleID

local richText = {
    "<font color='#FFFFFF'>你被 </font><font color='#FF0000'>%s</font><font color='#FFFFFF'> 击败，君子报仇，十年不晚</font>",
}

function Die.main()
    local _parent = GUI:Win_Create("Die", 0, 0, 0, 0, false, false, true, false)
    GUIparent = _parent
    local winSize = SL:GetScreenSize()              --获取屏幕宽高
    local x = winSize.width / 2
    local y = winSize.height / 2
    local w = winSize.width
    local h = winSize.height

    countTime = 10

    local killer_name = SL.FormParam[1] or "上帝"

    local text = string.format(richText[1] , killer_name)

    local handle = GUI:Layout_Create(_parent, "layout_close", x, y, w, h)
    if handle then
        GUI:Layout_setBackGroundColor(handle, "#000000")
        GUI:Layout_setBackGroundColorType(handle, 1)
        GUI:Layout_setBackGroundColorOpacity(handle, 100)
        GUI:setAnchorPoint(handle, 0.5, 0.5)
        GUI:setTouchEnabled(handle, true)
        GUI:addOnClickEvent(handle, function()
            -- GUI:Win_Close(GUIparent)
        end)
    end

    handle = GUI:Image_Create(_parent, "img_bg", x, y, "res/custom/Die/img_di.png")
    if handle then
        GUI:setAnchorPoint(handle, 0.5, 0.4)
        GUI:setTouchEnabled(handle, true)

        _parent = handle

        handle = GUI:Image_Create(_parent, "img_line", 100,-50, "res/custom/Die/img_1.png")

        local post = GUI:getContentSize(_parent)

        handle = GUI:RichText_Create(_parent, "txt_title", post.height / 2 - 18,90, text, w,18)
        GUI:setAnchorPoint(handle, 0.5,0)


        --回城复活
        handle = GUI:Button_Create(_parent, "btn_realive_1", 35,20, "res/public/1900000652.png")
        if handle then
            local txt_handle = GUI:Text_Create(handle, "title", 100 / 2,35 / 2, 16, "#FFFFFF", "免费复活")
            GUI:setAnchorPoint(txt_handle, 0.5, 0.5)

            local txt_countTime = GUI:Text_Create(handle, "title2", 100 / 2,35, 16, "#FFFFFF", "自动复活："..countTime.."秒")
            GUI:setAnchorPoint(txt_countTime, 0.5, 0)

            scheduleID = SL:Schedule(function()
                countTime = countTime - 1
                if countTime < 0 then
                    Die.Go(revive_type.FREE)
                    return
                end
                GUI:Text_setString(txt_countTime, "自动复活："..countTime.."秒")
            end, 1)

            GUI:setContentSize(handle,{width = 100, height = 33})
            GUI:Button_loadTexturePressed(handle, "res/public/1900000652_1.png")
            GUI:Button_loadTextureDisabled(handle, "res/public/1900000652_1.png")
            GUI:addOnClickEvent(handle, function()
                Die.Go(revive_type.FREE)
            end)
        end

        --原地复活
        handle = GUI:Button_Create(_parent, "btn_realive_2", 188,20, "res/public/1900000652.png")
        if handle then
            local txt_handle = GUI:Text_Create(handle, "title", 100 / 2,35 / 2, 16, "#00FF00", "原地复活")
            GUI:setAnchorPoint(txt_handle, 0.5, 0.5)

            txt_handle = GUI:Text_Create(handle, "title2", 100 / 2,35, 16, "#00FF00", "200灵符")
            GUI:setAnchorPoint(txt_handle, 0.5, 0)

            GUI:setContentSize(handle,{width = 100, height = 33})
            GUI:Button_loadTexturePressed(handle, "res/public/1900000652_1.png")
            GUI:Button_loadTextureDisabled(handle, "res/public/1900000652_1.png")
            GUI:addOnClickEvent(handle, function()
                Die.Go(revive_type.PAY)
            end)
        end
    end
end

function Die.Go(realiveType)
    SL:UnSchedule(scheduleID)
    SL:SubmitForm("F/死亡复活表单","RequestRevive",realiveType)
    GUI:Win_Close(GUIparent)
end

Die.main()