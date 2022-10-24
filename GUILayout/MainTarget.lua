MainTarget = {}

MainTarget.jobIconPath = {
    "res/private/main/Target/1900012533.png",
    "res/private/main/Target/1900012534.png",
    "res/private/main/Target/1900012535.png"
}
MainTarget.monsterIconPath = "res/private/main/Target/1900012536.png"

function MainTarget.main( ... )
    local parent = GUI:Attach_Parent()
    if not parent then
        return
    end

    local targetPanel = GUI:Layout_Create(parent, "targetPanel", 3, -225, 210, 37)
    GUI:setAnchorPoint(targetPanel, 0, 1)
    GUI:setTouchEnabled(targetPanel, true)

    local icon = GUI:Image_Create(targetPanel, "icon", 18, 18, "res/private/main/Target/1900012534.png")
    GUI:setAnchorPoint(icon, 0.5, 0.5)

    local nameBg = GUI:Image_Create(targetPanel, "nameBg", 105, 35, "res/private/main/Target/1900012531.png")
    GUI:setAnchorPoint(nameBg, 0.5, 1)

    local nameText = GUI:Text_Create(targetPanel, "nameText", 105, 27, 16, "#FFFFFF", "目标名称")
    GUI:Text_enableOutline(nameText, "#111111", 1)
    GUI:setAnchorPoint(nameText, 0.5, 0.5)

    local hpBg = GUI:Image_Create(targetPanel, "Image_hp", 105, 8, "res/private/main/Target/1900012530.png")
    GUI:setAnchorPoint(hpBg, 0.5, 0.5)

    local hpLoadingBar = GUI:LoadingBar_Create(targetPanel, "hpLoadingBar", 105, 8, "res/private/main/Target/1900012532.png", 0)
    GUI:LoadingBar_setPercent(hpLoadingBar, 50)
    GUI:setAnchorPoint(hpLoadingBar, 0.5, 0.5)

    local hpText = GUI:Text_Create(targetPanel, "hpText", 105, 9, 16, "#FFFFFF", "100%")
    GUI:setAnchorPoint(hpText, 0.5, 0.5)

    local cleanBtn = GUI:Button_Create(targetPanel, "cleanBtn", 190, 18.5, "res/private/main/Target/btn_gban_01.png")
    GUI:setAnchorPoint(cleanBtn, 0.5, 0.5)
    GUI:setTouchEnabled(cleanBtn, true)

end