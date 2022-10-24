FuncDock = {}

function FuncDock.main( ... )
    local parent = GUI:Attach_Parent()
    if not parent then
        return
    end
    local screenW = SL:GetScreenWidth()
    local screenH = SL:GetScreenHeight()

    local touchPanel = GUI:Layout_Create(parent, "touchPanel", 0, 0, screenW, screenH)
    GUI:setTouchEnabled(touchPanel, true)

    local bgImg = GUI:Image_Create(parent, "bgImg", 0, 0, "res/public/1900000677.png")
    GUI:setContentSize(bgImg, {width = 85, height = 100})
    GUI:Image_setScale9Slice(bgImg, 21, 41, 33, 33)

    local funcListView = GUI:ListView_Create(bgImg, "funcListView", 0, 0, 85, 100, 1)
    GUI:ListView_setGravity(funcListView, 2)
    GUI:ListView_setItemsMargin(funcListView, 5)

    local funcCell = GUI:Layout_Create(parent, "funcCell", 0, 0, 85, 30)
    GUI:setTouchEnabled(funcCell, true)
    local funcName = GUI:Text_Create(funcCell, "funcName", 42.5, 15, 16, "#FFFFFF", "")
    GUI:setAnchorPoint(funcName, 0.5, 0.5)
    GUI:Text_enableOutline(funcName, "#111111", 1)
end