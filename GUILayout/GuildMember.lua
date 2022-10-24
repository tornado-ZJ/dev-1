GuildMember = {}
GuildMember._TextPosX = {
    [1] = 92, [2] = 251, [3] = 401, [4] = 526, [5] = 674
}

function GuildMember.main()
     -- 容器
    local parent  = GUI:Attach_Parent()
    local attachW = GUIShare.WinView.Width
    local attachH = GUIShare.WinView.Height
    GuildMember._Attr = {
        attachW = attachW, attachH = attachH
    }
 
    local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, attachW, attachH, true)
    GUI:setTouchEnabled(FrameLayout, true)
 
    local BG = GUI:Image_Create(FrameLayout, "BG", attachW / 2, attachH / 2, "res/private/guild_ui/bg_member.png")
    GUI:setAnchorPoint(BG, {x=0.5, y=0.5})
    GUI:setTouchEnabled(BG, true)

    -- 列表
    local list = GUI:ListView_Create(FrameLayout, "MemberList", 0, 72, attachW, attachH - 98, 1)
    local item = GuildMember.CreateItem(FrameLayout)
    GUI:setVisible(item, false)
 
    -- 标题
    local Title1 = GUI:Text_Create(FrameLayout, "Title1", GuildMember._TextPosX[1], attachH - 10, 16, "#F2E7CF", "玩家名字")
    GUI:setAnchorPoint(Title1, 0.5, 0.5)
    local Text_level = GUI:Text_Create(FrameLayout, "Text_level", GuildMember._TextPosX[2], attachH - 10, 16, "#F2E7CF", "等级")
    GUI:setAnchorPoint(Text_level, 0.5, 0.5)
    GUI:Layout_Create(Text_level, "TouchSize", 0, -1, 45, 30, false)
    GUI:setTouchEnabled(Text_level, true)

    local Title3 = GUI:Text_Create(FrameLayout, "Title3", GuildMember._TextPosX[3], attachH - 10, 16, "#F2E7CF", "职业")
    GUI:setAnchorPoint(Title3, 0.5, 0.5)
    local Title4 = GUI:Text_Create(FrameLayout, "Title4", GuildMember._TextPosX[4], attachH - 10, 16, "#F2E7CF", "职务")
    GUI:setAnchorPoint(Title4, 0.5, 0.5)
    local Title5 = GUI:Text_Create(FrameLayout, "Title5", GuildMember._TextPosX[5], attachH - 10, 16, "#F2E7CF", "状态")
    GUI:setAnchorPoint(Title5, 0.5, 0.5)
    
    GuildMember.CreateFilterLevel(FrameLayout)
    GuildMember.CreateFilterJob(FrameLayout)
    GuildMember.CreateFilterOfficial(FrameLayout)
    
    local BtnLevel = GUI:Button_Create(FrameLayout, "BtnLevel", 336, 432, "res/public/btn_arrow_down.png")
    GUI:setAnchorPoint(BtnLevel, 0.5, 0.5)
    GUI:Layout_Create(BtnLevel, "TouchSize", -15, -1, 75, 30, false)

    local BtnJob = GUI:Button_Create(FrameLayout, "BtnJob", 461, 432, "res/public/btn_arrow_down.png")
    GUI:setAnchorPoint(BtnJob, 0.5, 0.5)
    GUI:Layout_Create(BtnJob, "TouchSize", -15, -1, 75, 30, false)

    local BtnOfficial = GUI:Button_Create(FrameLayout, "BtnOfficial", 586, 432, "res/public/btn_arrow_down.png")
    GUI:setAnchorPoint(BtnOfficial, 0.5, 0.5)
    GUI:Layout_Create(BtnOfficial, "TouchSize", -15, -1, 75, 30, false)

    local btnCreate = GUI:Button_Create(FrameLayout, "btnCreate", 665, 35, "res/public/btn_push_common.png")
    GUI:setAnchorPoint(btnCreate, 0.5, 0.5)
    GUI:Button_setTitleFontSize(btnCreate, 16)
    GUI:Button_setTitleColor(btnCreate, "#F7F0E2")
    GUI:Button_setTitleText(btnCreate, "创建行会")
    GUI:setAnchorPoint(btnCreate, 0.5, 0.5)
    GUI:setVisible(btnCreate, false)

    local LabelOnline = GUI:Text_Create(FrameLayout, "LabelOnline", 25, 35, 16, "#41CA44", "")
    GUI:setAnchorPoint(LabelOnline, 0, 0.5)

    local BtnApplyList = GUI:Button_Create(FrameLayout, "BtnApplyList", 530, 35, "res/public/btn_push_common.png")
    GUI:setAnchorPoint(BtnApplyList, 0.5, 0.5)
    GUI:Button_setTitleFontSize(BtnApplyList, 16)
    GUI:Button_setTitleColor(BtnApplyList, "#F7F0E2")
    GUI:Button_setTitleText(BtnApplyList, "申请列表")
    GUI:setAnchorPoint(BtnApplyList, 0.5, 0.5)
    GUI:setVisible(BtnApplyList, false)
    GUI:addOnClickEvent(BtnApplyList, function ()
        SL:CloseGuildMainUI()
        SL:OpenGuildApplyListUI()
    end)

    local BtnEditTitle = GUI:Button_Create(FrameLayout, "BtnEditTitle", 390, 35, "res/public/btn_push_common.png")
    GUI:setAnchorPoint(BtnEditTitle, 0.5, 0.5)
    GUI:Button_setTitleFontSize(BtnEditTitle, 16)
    GUI:Button_setTitleColor(BtnEditTitle, "#F7F0E2")
    GUI:Button_setTitleText(BtnEditTitle, "编辑封号")
    GUI:setAnchorPoint(BtnEditTitle, 0.5, 0.5)
    GUI:setVisible(BtnEditTitle, false)

    local BtnQuit = GUI:Button_Create(FrameLayout, "BtnQuit", 670, 35, "res/public/btn_push_common.png")
    GUI:setAnchorPoint(BtnQuit, 0.5, 0.5)
    GUI:Button_setTitleFontSize(BtnQuit, 16)
    GUI:Button_setTitleColor(BtnQuit, "#F7F0E2")
    GUI:Button_setTitleText(BtnQuit, "退出行会")
    GUI:setAnchorPoint(BtnQuit, 0.5, 0.5)
    GUI:setVisible(BtnQuit, false)

    local BtnDissolve = GUI:Button_Create(FrameLayout, "BtnDissolve", 670, 35, "res/public/btn_push_common.png")
    GUI:setAnchorPoint(BtnDissolve, 0.5, 0.5)
    GUI:Button_setTitleFontSize(BtnDissolve, 16)
    GUI:Button_setTitleColor(BtnDissolve, "#F7F0E2")
    GUI:Button_setTitleText(BtnDissolve, "解散行会")
    GUI:setAnchorPoint(BtnDissolve, 0.5, 0.5)
    GUI:setVisible(BtnDissolve, false)

    local Image_none = GUI:Image_Create(FrameLayout, "Image_none", 366, 245, "res/private/guild_ui/word_hhzy_12.png")
    GUI:setAnchorPoint(Image_none, {x=0.5, y=0.5})
    GUI:setVisible(Image_none, false)
end

function GuildMember.CreateFilterLevel(parent)
    local FilterLevel = GUI:Image_Create(parent, "FilterLevel", 251, 418, "res/public/1900000677.png")
    GUI:setAnchorPoint(FilterLevel, 0.5, 1)
    GUI:Image_setScale9Slice(FilterLevel, 15, 15, 20, 20)
    GUI:setContentSize(FilterLevel, {width = 110, height = 70})
    GUI:setVisible(FilterLevel, false)
    
    local ListView_filter = GUI:ListView_Create(FilterLevel, "ListView_filter", 5, 7, 100, 56, 1)
    GUI:ListView_setItemsMargin(ListView_filter, 2)

    local filter1 = GUI:Layout_Create(ListView_filter, "filter1", 0, 0, 100, 26, true)
    local image_select1 = GUI:Image_Create(filter1, "Image_select", 50, 13, "res/public/1900000678.png")
    GUI:setContentSize(image_select1, {width = 100, height = 26})
    GUI:setAnchorPoint(image_select1, 0.5, 0.5)
    local text = GUI:Text_Create(filter1, "text", 50, 13, 16, "#F7F0E2", "由高到低")
    GUI:setAnchorPoint(text, 0.5, 0.5)

    local filter2 = GUI:Layout_Create(ListView_filter, "filter2", 0, 0, 100, 26, true)
    local image_select2 = GUI:Image_Create(filter2, "Image_select", 50, 13, "res/public/1900000678.png")
    GUI:setContentSize(image_select2, {width = 100, height = 26})
    GUI:setAnchorPoint(image_select2, 0.5, 0.5)
    local text = GUI:Text_Create(filter2, "text", 50, 13, 16, "#F7F0E2", "由低到高")
    GUI:setAnchorPoint(text, 0.5, 0.5)
end

function GuildMember.CreateFilterJob(parent)
    local FilterJob = GUI:Image_Create(parent, "FilterJob", 421, 418, "res/public/1900000677.png")
    GUI:setAnchorPoint(FilterJob, 0.5, 1)
    GUI:Image_setScale9Slice(FilterJob, 15, 15, 20, 20)
    GUI:setContentSize(FilterJob, {width = 110, height = 126})
    GUI:setVisible(FilterJob, false)
    
    local ListView_filter = GUI:ListView_Create(FilterJob, "ListView_filter", 5, 7, 100, 112, 1)
    GUI:ListView_setItemsMargin(ListView_filter, 2)

    local filter0 = GUI:Layout_Create(ListView_filter, "filter0", 0, 0, 100, 26, true)
    local image_select1 = GUI:Image_Create(filter0, "Image_select", 50, 13, "res/public/1900000678.png")
    GUI:setContentSize(image_select1, {width = 100, height = 26})
    GUI:setAnchorPoint(image_select1, 0.5, 0.5)
    GUI:setTouchEnabled(filter0, true)
    local text = GUI:Text_Create(filter0, "text", 50, 13, 16, "#F7F0E2", "全部")
    GUI:setAnchorPoint(text, 0.5, 0.5)

    local filter1 = GUI:Layout_Create(ListView_filter, "filter1", 0, 0, 100, 26, true)
    local image_select2 = GUI:Image_Create(filter1, "Image_select", 50, 13, "res/public/1900000678.png")
    GUI:setContentSize(image_select2, {width = 100, height = 26})
    GUI:setAnchorPoint(image_select2, 0.5, 0.5)
    GUI:setTouchEnabled(filter1, true)
    local text = GUI:Text_Create(filter1, "text", 50, 13, 16, "#F7F0E2", "战士")
    GUI:setAnchorPoint(text, 0.5, 0.5)

    local filter2 = GUI:Layout_Create(ListView_filter, "filter2", 0, 0, 100, 26, true)
    local image_select2 = GUI:Image_Create(filter2, "Image_select", 50, 13, "res/public/1900000678.png")
    GUI:setContentSize(image_select2, {width = 100, height = 26})
    GUI:setAnchorPoint(image_select2, 0.5, 0.5)
    GUI:setTouchEnabled(filter2, true)
    local text = GUI:Text_Create(filter2, "text", 50, 13, 16, "#F7F0E2", "法师")
    GUI:setAnchorPoint(text, 0.5, 0.5)

    local filter3 = GUI:Layout_Create(ListView_filter, "filter3", 0, 0, 100, 26, true)
    local image_select2 = GUI:Image_Create(filter3, "Image_select", 50, 13, "res/public/1900000678.png")
    GUI:setContentSize(image_select2, {width = 100, height = 26})
    GUI:setAnchorPoint(image_select2, 0.5, 0.5)
    GUI:setTouchEnabled(filter3, true)
    local text = GUI:Text_Create(filter3, "text", 50, 13, 16, "#F7F0E2", "道士")
    GUI:setAnchorPoint(text, 0.5, 0.5)
end

function GuildMember.CreateFilterOfficial(parent)
    local FilterOfficial = GUI:Image_Create(parent, "FilterOfficial", 550, 418, "res/public/1900000677.png")
    GUI:setAnchorPoint(FilterOfficial, 0.5, 1)
    GUI:Image_setScale9Slice(FilterOfficial, 15, 15, 20, 20)
    GUI:setContentSize(FilterOfficial, {width = 110, height = 182})
    GUI:setVisible(FilterOfficial, false)
    
    local ListView_filter = GUI:ListView_Create(FilterOfficial, "ListView_filter", 5, 7, 100, 168, 1)
    GUI:ListView_setItemsMargin(ListView_filter, 2)

    local filter0 = GUI:Layout_Create(ListView_filter, "filter0", 0, 0, 100, 26, true)
    local image_select1 = GUI:Image_Create(filter0, "Image_select", 50, 13, "res/public/1900000678.png")
    GUI:setContentSize(image_select1, {width = 100, height = 26})
    GUI:setAnchorPoint(image_select1, 0.5, 0.5)
    GUI:setTouchEnabled(filter0, true)
    local text = GUI:Text_Create(filter0, "text", 50, 13, 16, "#F7F0E2", "全部")
    GUI:setAnchorPoint(text, 0.5, 0.5)

    local filter1 = GUI:Layout_Create(ListView_filter, "filter1", 0, 0, 100, 26, true)
    local image_select2 = GUI:Image_Create(filter1, "Image_select", 50, 13, "res/public/1900000678.png")
    GUI:setContentSize(image_select2, {width = 100, height = 26})
    GUI:setAnchorPoint(image_select2, 0.5, 0.5)
    GUI:setTouchEnabled(filter1, true)
    local text = GUI:Text_Create(filter1, "text", 50, 13, 16, "#F7F0E2", "会长")
    GUI:setAnchorPoint(text, 0.5, 0.5)

    local filter2 = GUI:Layout_Create(ListView_filter, "filter2", 0, 0, 100, 26, true)
    local image_select2 = GUI:Image_Create(filter2, "Image_select", 50, 13, "res/public/1900000678.png")
    GUI:setContentSize(image_select2, {width = 100, height = 26})
    GUI:setAnchorPoint(image_select2, 0.5, 0.5)
    GUI:setTouchEnabled(filter2, true)
    local text = GUI:Text_Create(filter2, "text", 50, 13, 16, "#F7F0E2", "副会长")
    GUI:setAnchorPoint(text, 0.5, 0.5)

    local filter3 = GUI:Layout_Create(ListView_filter, "filter3", 0, 0, 100, 26, true)
    local image_select2 = GUI:Image_Create(filter3, "Image_select", 50, 13, "res/public/1900000678.png")
    GUI:setContentSize(image_select2, {width = 100, height = 26})
    GUI:setAnchorPoint(image_select2, 0.5, 0.5)
    GUI:setTouchEnabled(filter3, true)
    local text = GUI:Text_Create(filter3, "text", 50, 13, 16, "#F7F0E2", "长老")
    GUI:setAnchorPoint(text, 0.5, 0.5)

    local filter4 = GUI:Layout_Create(ListView_filter, "filter4", 0, 0, 100, 26, true)
    local image_select2 = GUI:Image_Create(filter4, "Image_select", 50, 13, "res/public/1900000678.png")
    GUI:setContentSize(image_select2, {width = 100, height = 26})
    GUI:setAnchorPoint(image_select2, 0.5, 0.5)
    GUI:setTouchEnabled(filter4, true)
    local text = GUI:Text_Create(filter4, "text", 50, 13, 16, "#F7F0E2", "精英")
    GUI:setAnchorPoint(text, 0.5, 0.5)

    local filter5 = GUI:Layout_Create(ListView_filter, "filter5", 0, 0, 100, 26, true)
    local image_select2 = GUI:Image_Create(filter5, "Image_select", 50, 13, "res/public/1900000678.png")
    GUI:setContentSize(image_select2, {width = 100, height = 26})
    GUI:setAnchorPoint(image_select2, 0.5, 0.5)
    GUI:setTouchEnabled(filter5, true)
    local text = GUI:Text_Create(filter5, "text", 50, 13, 16, "#F7F0E2", "成员")
    GUI:setAnchorPoint(text, 0.5, 0.5)
end

function GuildMember.CreateItem(parent)
    local y = 25
    local item = GUI:Layout_Create(parent, "item", 0, 0, GuildMember._Attr.attachW, y * 2, true)
    local line = GUI:Image_Create(item, "line", 0, 0, "res/public/img_line_long.png")
    GUI:setPosition(line, 0, 0)
    -- 玩家名字
    local username = GUI:Text_Create(item, "username", GuildMember._TextPosX[1], y, 16, "#F2E7CF", "")
    GUI:setAnchorPoint(username, 0.5, 0.5)
    -- 等级
    local level = GUI:Text_Create(item, "level", GuildMember._TextPosX[2], y, 16, "#F2E7CF", "")
    GUI:setAnchorPoint(level, 0.5, 0.5)
    -- 职业
    local job = GUI:Text_Create(item, "job", GuildMember._TextPosX[3], y, 16, "#F2E7CF", "")
    GUI:setAnchorPoint(job, 0.5, 0.5)
    -- 职务
    local official = GUI:Text_Create(item, "official", GuildMember._TextPosX[4], y, 16, "#F2E7CF", "")
    GUI:setAnchorPoint(official, 0.5, 0.5)

    local online = GUI:Text_Create(item, "online", GuildMember._TextPosX[5], y, 16, "#F2E7CF", "")
    GUI:setAnchorPoint(online, 0.5, 0.5)
    GUI:setVisible(online, false)
    
    return item
end