MainLeftTop = {}
local GUIparent = ""

function MainLeftTop.main()
    local parent = GUI:Attach_LeftTop()
    GUIparent = parent
    -- 元宝
    local yuanbao = GUI:Text_Create(parent, "yuanbao1", 100, 0, 16, "#fffab5", "元宝:")
    GUI:setAnchorPoint(yuanbao, 1, 1)
    local yuanbao2 = GUI:Text_Create(parent, "yuanbao2", 190, 0, 16, "#00cc00", "0")
    GUI:setAnchorPoint(yuanbao2, 1, 1)
    -- 名著币
    local mingzhubi = GUI:Text_Create(parent, "mingzhubi1", 250, 0, 16, "#fffab5", "名著币:")
    GUI:setAnchorPoint(mingzhubi, 1, 1)
    local mingzhubi2 = GUI:Text_Create(parent, "mingzhubi2", 340, 0, 16, "#00cc00", "0")
    GUI:setAnchorPoint(mingzhubi2, 1, 1)

    local chongzhidian = GUI:Text_Create(parent, "chongzhidian1", 400, 0, 16, "#fffab5", "充值点:")
    GUI:setAnchorPoint(chongzhidian, 1, 1)
    local chongzhidian2 = GUI:Text_Create(parent, "chongzhidian2", 470, 0, 16, "#00cc00", "0")
    GUI:setAnchorPoint(chongzhidian2, 1, 1)

    local rmb = GUI:Text_Create(parent, "rmb1", 520, 0, 16, "#fffab5", "RMB:")
    GUI:setAnchorPoint(rmb, 1, 1)
    local rmb2 = GUI:Text_Create(parent, "rmb2", 580, 0, 16, "#00cc00", "0")
    GUI:setAnchorPoint(rmb2, 1, 1)

    local czje = GUI:Text_Create(parent, "czje1", 650, 0, 16, "#fffab5", "充值金额:")
    GUI:setAnchorPoint(czje, 1, 1)
    local czje2 = GUI:Text_Create(parent, "czje2", 710, 0, 16, "#00cc00", "0")
    GUI:setAnchorPoint(czje2, 1, 1)

    local baolv = GUI:Text_Create(parent, "baolv1", 750, 0, 16, "#fffab5", "爆率:")
    GUI:setAnchorPoint(baolv, 1, 1)
    local baolv2 = GUI:Text_Create(parent, "baolv2", 800, 0, 16, "#00cc00", "0")
    GUI:setAnchorPoint(baolv2, 1, 1)

    local beigong = GUI:Text_Create(parent, "beigong1", 860, 0, 16, "#fffab5", "倍攻:")
    GUI:setAnchorPoint(beigong, 1, 1)
    local beigong2 = GUI:Text_Create(parent, "beigong2", 910, 0, 16, "#00cc00", "0")
    GUI:setAnchorPoint(beigong2, 1, 1)

    local ddqg = GUI:Text_Create(parent, "ddqg1", 1000, 0, 16, "#fffab5", "刀刀切割:")
    GUI:setAnchorPoint(ddqg, 1, 1)
    local ddqg2 = GUI:Text_Create(parent, "ddqg2", 1090, 0, 16, "#00cc00", "0")
    GUI:setAnchorPoint(ddqg2, 1, 1)

    SL:RegisterLUAEvent("LUA_EVENT_MONEYCHANGE", "货币", MainLeftTop.updateUI)  

end

function MainLeftTop.updateUI()
    local yuanbao2 = GUI:GetWindow(GUIparent, "yuanbao2")
    GUI:Text_setString(yuanbao2,SL:GetItemNumberByKeyName("元宝"))
    local mingzhubi2 = GUI:GetWindow(GUIparent, "mingzhubi2")
    GUI:Text_setString(mingzhubi2,SL:GetItemNumberByKeyName("名著币"))
    local chongzhidian2 = GUI:GetWindow(GUIparent, "chongzhidian2")
    GUI:Text_setString(chongzhidian2,SL:GetItemNumberByKeyName("充值点"))
    local rmb2 = GUI:GetWindow(GUIparent, "rmb2")
    GUI:Text_setString(rmb2,SL:GetItemNumberByKeyName("RMB点"))
    local czje2 = GUI:GetWindow(GUIparent, "czje2")
    GUI:Text_setString(czje2,SL:GetItemNumberByKeyName("充值金额"))
    local baolv2 = GUI:GetWindow(GUIparent, "baolv2")
    GUI:Text_setString(baolv2,SL:GetItemNumberByKeyName("爆率").."%")
    local beigong2 = GUI:GetWindow(GUIparent, "beigong2")
    GUI:Text_setString(beigong2,SL:GetItemNumberByKeyName("倍攻").."%")
    local ddqg2 = GUI:GetWindow(GUIparent, "ddqg2")
    GUI:Text_setString(ddqg2,SL:GetItemNumberByKeyName("刀刀切割"))
end