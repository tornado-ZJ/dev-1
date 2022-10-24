GuildList = {}

GuildList._TextPosX = {
    [1] = 76, [2] = 228, [3] = 365, [4] = 480, [5] = 635
}

function GuildList.main()
    -- 容器
    local parent  = GUI:Attach_Parent()
    local attachW = GUIShare.WinView.Width
    local attachH = GUIShare.WinView.Height
    GuildList._Attr = {
        attachW = attachW, attachH = attachH
    }

    local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, attachW, attachH, true)
    GUI:setTouchEnabled(FrameLayout, true)

    local FrameLayout = GUI:Image_Create(FrameLayout, "BG", attachW / 2, attachH / 2, "res/private/guild_ui/bg_guild_list.png")
    GUI:setAnchorPoint(FrameLayout, {x=0.5, y=0.5})
    GUI:setTouchEnabled(FrameLayout, true)

    -- 标题
    local Title1 = GUI:Text_Create(FrameLayout, "Title1", GuildList._TextPosX[1], attachH - 10, 16, "#F2E7CF", "行会名字")
    GUI:setAnchorPoint(Title1, 0.5, 0.5)
    local Title2 = GUI:Text_Create(FrameLayout, "Title2", GuildList._TextPosX[2], attachH - 10, 16, "#F2E7CF", "会长")
    GUI:setAnchorPoint(Title2, 0.5, 0.5)
    local Title3 = GUI:Text_Create(FrameLayout, "Title3", GuildList._TextPosX[3], attachH - 10, 16, "#F2E7CF", "人数")
    GUI:setAnchorPoint(Title3, 0.5, 0.5)
    local Title4 = GUI:Text_Create(FrameLayout, "Title4", GuildList._TextPosX[4], attachH - 10, 16, "#F2E7CF", "加入条件")
    GUI:setAnchorPoint(Title4, 0.5, 0.5)
    local Title5 = GUI:Text_Create(FrameLayout, "Title5", GuildList._TextPosX[5], attachH - 10, 16, "#F2E7CF", "操作")
    GUI:setAnchorPoint(Title5, 0.5, 0.5)

    local btnCreate = GUI:Button_Create(FrameLayout, "btnCreate", 665, 35, "res/public/btn_push_common.png")
    GUI:setAnchorPoint(btnCreate, 0.5, 0.5)
    GUI:Button_setTitleFontSize(btnCreate, 16)
    GUI:Button_setTitleColor(btnCreate, "#F7F0E2")
    GUI:Button_setTitleText(btnCreate, "创建行会")
    GUI:setAnchorPoint(btnCreate, 0.5, 0.5)
    GUI:setVisible(btnCreate, false)
    GUI:addOnClickEvent(btnCreate, function ()
        SL:CloseGuildMainUI()
        SL:OpenGuildCreateUI()
    end )

    local CheckBox = GUI:CheckBox_Create(FrameLayout, "CheckBox", 45, 35, "res/public/1900000550.png", "res/public/1900000551.png")
    local cbLabel = GUI:Text_Create(CheckBox, "Label", 35, 2, 16, "#41CA44", "只显示会长在线的行会")
    GUI:setAnchorPoint(CheckBox, 0.5, 0.5)
    GuildList._CheckBox = CheckBox
    GUI:CheckBox_setSelected(CheckBox, false)
    -- CheckBox 触摸层
    GUI:Layout_Create(CheckBox, "TouchSize", 0, -1, GUI:getContentSize(CheckBox).width + GUI:getContentSize(cbLabel).width, 28, false)

    local list = GUI:ListView_Create(FrameLayout, "list", 0, 72, attachW, attachH - 98, 1)
    GuildList._list = list
end

function GuildList.CreateItem(item, data, y)
    local guildLevel  = data.Level
    local level       = SL:GetRoleData().level

    local line = GUI:Image_Create(item, "line", 0, 0, "res/public/img_line_long.png")
    GUI:setPosition(line, 0, 0)
    -- 行会名字
    local TName = GUI:Text_Create(item, "TName", GuildList._TextPosX[1], y, 16, "#F2E7CF", data.GuildName)
    GUI:setAnchorPoint(TName, 0.5, 0.5)
    -- 会长
    local TChairman = GUI:Text_Create(item, "TChairman", GuildList._TextPosX[2], y, 16, "#F2E7CF", data.ChiefName)
    GUI:setAnchorPoint(TChairman, 0.5, 0.5)
    -- 人数
    local TCount = GUI:Text_Create(item, "TCount", GuildList._TextPosX[3], y, 16, "#F2E7CF", "")
    GUI:setAnchorPoint(TCount, 0.5, 0.5)
    -- 条件
    local TCondition = GUI:Text_Create(item, "TCondition", GuildList._TextPosX[4], y, 16, "#F2E7CF", "")
    GUI:setAnchorPoint(TCondition, 0.5, 0.5)

    local TDesc = GUI:Text_Create(item, "TDesc", GuildList._TextPosX[5], y, 16, "#F2E7CF", "已申请")
    GUI:setAnchorPoint(TDesc, 0.5, 0.5)
    GUI:setVisible(TDesc, false)

    -- 宣战按钮
    local BtnWar = GUI:Button_Create(item, "BtnWar", 590, y, "res/public/btn_push_short.png")
    GUI:setAnchorPoint(BtnWar, 0.5, 0.5)
    GUI:Button_setTitleText(BtnWar, "宣战")
    GUI:Button_setTitleColor(BtnWar,"#F7F0E2")
    GUI:Button_setTitleFontSize(BtnWar, 16)

    -- 结盟按钮
    local BtnAlly = GUI:Button_Create(item, "BtnAlly", 680, y, "res/public/btn_push_short.png")
    GUI:setAnchorPoint(BtnAlly, 0.5, 0.5)
    GUI:Button_setTitleText(BtnAlly, "结盟")
    GUI:Button_setTitleColor(BtnAlly,"#F7F0E2")
    GUI:Button_setTitleFontSize(BtnAlly, 16)
    
    -- 加入按钮
    local BtnJoin = GUI:Button_Create(item, "BtnJoin", GuildList._TextPosX[5], y, "res/public/btn_push_short.png")
    GUI:setAnchorPoint(BtnJoin, 0.5, 0.5)
    GUI:Button_setTitleColor(BtnJoin,"#F7F0E2")
    GUI:Button_setTitleFontSize(BtnJoin, 16)

    -- 取消按钮
    local BtnCancel = GUI:Button_Create(item, "BtnCancel", 720, y, "res/public/btn_gban_01.png")
    GUI:setAnchorPoint(BtnCancel, 0.5, 0.5)

    -- 系统方法，不需要了解
    GuildList._SetItemOther(item, data)
end

function GuildList.RefreshUI()
    local list = GuildList._list
    GUI:removeAllChildren(list)

    local isSelected = GUI:CheckBox_isSelected(GuildList._CheckBox)

    local iHeight = 50
    -- 获取联盟列表
    local guildList = GuildList._GetGuildListInfo()
    for i,v in ipairs(guildList) do
        if v and (not isSelected or v.MasterLine == 1) then
            local item = GUI:Layout_Create(list, "item"..i, 0, 0, GuildList._Attr.attachW, iHeight, true)
            GuildList.CreateItem(item, v, iHeight / 2)
        end
    end
end
