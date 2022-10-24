MainMiniMap = {}

-- 触摸层的尺寸，若修改地图的尺寸，此处要修改
MainMiniMap._TouchSize = {
    width = 143, height = 131
}

-- 动画移动距离
MainMiniMap._MoveDis = 143

-- 战斗模式的图片
MainMiniMap._Pics = {
    [0]="res/private/main/Pattern/1900012200.png",
    [1]="res/private/main/Pattern/1900012201.png",
    [2]="res/private/main/Pattern/1900012206.png",
    [3]="res/private/main/Pattern/1900012207.png",
    [4]="res/private/main/Pattern/1900012202.png",
    [5]="res/private/main/Pattern/1900012203.png",
    [6]="res/private/main/Pattern/1900012204.png",
    [10]="res/private/main/Pattern/1900012205.png"
}

function MainMiniMap.main()
    local parent = GUI:Attach_MainMiniMap()

    local MapBG = GUI:Image_Create(parent, "MapBG", 71, 130, "res/private/main/miniMap/1900012101.png")
    GUI:setAnchorPoint(MapBG, {x=0.5, y=1})

    local Image_empty = GUI:Image_Create(parent, "Image_empty", 71, 125, "res/private/main/miniMap/1900012102.png")
    GUI:setAnchorPoint(Image_empty, {x=0.5, y=1})
    GUI:setContentSize(Image_empty, 133.5, 122)

    local MapNameBG = GUI:Image_Create(parent, "MapNameBG", 0, 160, "res/private/main/miniMap/1900012100.png")
    GUI:setAnchorPoint(MapNameBG, {x=0, y=1})

    local MapName = GUI:Text_Create(parent, "MapName", 71.5, 155, 16, "#ffffff", "")
    GUI:setAnchorPoint(MapName, {x=0.5, y=1})

    local MapStatusBG = GUI:Layout_Create(parent, "MapStatusBG", 4, 2, 135, 17)
    GUI:Layout_setBackGroundColorType(MapStatusBG, 1)
    GUI:Layout_setBackGroundColor(MapStatusBG, "#000000")
    GUI:Layout_setBackGroundColorOpacity(MapStatusBG, 100)

    local btn_GM = GUI:Button_Create(parent, "btn_GM", -160, -20, "res/01/010013.png")
    if btn_GM then
        local tx_switch = GUI:Text_Create(btn_GM, "tx_switch", 50, 20, 18, "#FFFFFF", "G  M")
        if tx_switch then
            GUI:setAnchorPoint(tx_switch, 0.5, 0.5)
        end
        GUI:setContentSize(btn_GM, { width = 100, height = 40 })
        GUI:setAnchorPoint(btn_GM, 0.5, 0.5)
        GUI:addOnClickEvent(btn_GM, function()
            GUI:Win_Open("GM")
        end)
    end

    local MapStatus = GUI:Text_Create(parent, "MapStatus", 3.5, 11, 14, "#ffffff", "安全区域")
    GUI:setAnchorPoint(MapStatus, {x=0, y=0.5})

    local PlayerPos = GUI:Text_Create(parent, "PlayerPos", 138, 11, 14, "#ffffff", "0:0")
    GUI:setAnchorPoint(PlayerPos, {x=1, y=0.5})

    local MapButton = GUI:Button_Create(parent, "MapButton", 4, 160, "res/private/main/Button/1900012153.png")
    GUI:Button_loadTexturePressed(MapButton, "res/private/main/Button/1900012152.png")
    GUI:setAnchorPoint(MapButton, {x=1, y=0})
    GUI:setFlippedY(MapButton, true)

    local MapButtonText = GUI:Image_Create(MapButton, "MapButtonText", 22.5, 40, "res/private/main/Button_1/1900012301.png")
    GUI:setAnchorPoint(MapButtonText, {x=0.5, y=0.5})
    GUI:setFlippedY(MapButtonText, true)
    GUI:setContentSize(MapButtonText, {width=27, height=52})

    local PKModelLayout = GUI:Layout_Create(parent, "PKModelLayout", 4, 0, 45, 80)
    GUI:setAnchorPoint(PKModelLayout, {x=1, y=0})
    GUI:setLocalZOrder(PKModelLayout, -1)

    local PKModelButton = GUI:Button_Create(PKModelLayout, "PKModelButton", 45, 40, "res/private/main/Button/1900012153.png")
    GUI:Button_loadTexturePressed(PKModelButton, "res/private/main/Button/1900012152.png")
    GUI:setAnchorPoint(PKModelButton, {x=1, y=0.5})
    GUI:Win_SetParam(PKModelButton, false)
    MainMiniMap._PKModelButton = PKModelButton
    GUI:addOnClickEvent(PKModelButton, function ()
        MainMiniMap.onBtnPkEvent()
    end)

    local PKModelButtomText = GUI:Image_Create(PKModelButton, "PKModelButtomText", 22.5, 40, "res/private/main/Button_1/1900012200.png")
    GUI:setAnchorPoint(PKModelButtomText, {x=0.5, y=0.5})
    GUI:setContentSize(PKModelButtomText, {width=27, height=52})
    MainMiniMap._PKModelButtomText = PKModelButtomText

    local PKModelCell = GUI:Layout_Create(PKModelLayout, "PKModelCell", 0, 0, 0, 80)
    MainMiniMap._PKModelCell = PKModelCell
    GUI:setVisible(MainMiniMap._PKModelCell, true)

    local PKModelCellsBg = GUI:Image_Create(PKModelCell, "PKModelCellsBg", 232, 80, "res/private/main/Button/1900012160.png")
    GUI:Image_setScale9Slice(PKModelCellsBg,  29, 29, 10, 10)
    GUI:setAnchorPoint(PKModelCellsBg, {x=1, y=0.5})
    GUI:setPosition(PKModelCellsBg, 0, 40)
    GUI:setVisible(PKModelCellsBg, false)

    local PKModelListView = GUI:ListView_Create(PKModelCell, "PKModelListView", 0, 0, 0, 80, 2)
    GUI:setAnchorPoint(PKModelListView, {x=1, y=0.5})
    GUI:setPosition(PKModelListView, 0, 40)
    MainMiniMap._PKModelListView = PKModelListView

    local PKModelListViewCell = GUI:Layout_Create(PKModelCell, "PKModelListViewCell", 0, 0, 55, 80, true)
    local ImageName = GUI:Image_Create(PKModelListViewCell, "ImageName", 27.5, 40, "res/private/main/Pattern/1900012200.png")
    GUI:setAnchorPoint(ImageName, {x=0.5, y=0.5})
    GUI:setVisible(PKModelListViewCell, false)
    GUI:setTouchEnabled(PKModelListViewCell, true)
    MainMiniMap._PKModelListViewCell = PKModelListViewCell

    MainMiniMap.UpdatePKMode()

    SL:RegisterLUAEvent(LUA_EVENT_PKMODECHANGE, "MainMiniMap", MainMiniMap.UpdatePKMode)
end

function MainMiniMap.onBtnPkEvent(sender, eventType)
    local param = GUI:Win_GetParam(MainMiniMap._PKModelButton)
    if param then
        MainMiniMap.HidePKModeCells()
    else
        MainMiniMap.ShowPKModeCells()
    end
end

function MainMiniMap.HidePKModeCells()
    local pkCell = MainMiniMap._PKModelListViewCell
    if not pkCell then
        return false
    end

    GUI:Win_SetParam(MainMiniMap._PKModelButton, false)

    local cSize = pkCell:getContentSize()
    local width = GUI:ListView_getItemCount(MainMiniMap._PKModelListView) * cSize.width

    GUI:Timeline_StopAll(MainMiniMap._PKModelButton)
    GUI:runAction(MainMiniMap._PKModelButton,
            GUI:ActionEaseBackOut(
                    GUI:ActionMoveTo(0.2, MainMiniMap._PKModelButton:getContentSize().width, cSize.height/2)))
    GUI:runAction(MainMiniMap._PKModelCell,
            GUI:ActionSequence(
                    GUI:ActionEaseBackOut(
                            GUI:ActionMoveTo(0.2, cc.p(width + cSize.width, 0)),
                            GUI:ActionShow())))
end

function MainMiniMap.ShowPKModeCells()
    local pkListBg = GUI:getChildByName(MainMiniMap._PKModelCell, "PKModelCellsBg")
    local pkList   = MainMiniMap._PKModelListView
    local pkCell   = MainMiniMap._PKModelListViewCell

    GUI:Win_SetParam(MainMiniMap._PKModelButton, true)

    GUI:setVisible(pkListBg, true)
    GUI:setVisible(pkCell, false)
    GUI:removeAllChildren(pkList)

    local pkModeTB = {0, 1, 4, 5, 6, 2}
    -- 区服模式只能在跨服时可切换
    if SL:GetMetaValue("KFSTATE") then
        table.insert(pkModeTB, 10)
    end
    GUI:RichText_Create()
    for i, mode in ipairs(pkModeTB) do
        if SL:IsShowCurPkMode(mode) then
            local cell = GUI:Clone(pkCell)
            GUI:ListView_pushBackCustomItem(pkList, cell)
            GUI:setVisible(cell, true)

            GUI:getChildByName(cell, "ImageName"):loadTexture(MainMiniMap._Pics[mode])
            GUI:addOnClickEvent(cell, function ()
                SL:RequestChangePKMode(mode)
                MainMiniMap.HidePKModeCells()
            end)
        end
    end

    local PKModelButton = MainMiniMap._PKModelButton

    local buttonModewWidth = GUI:getContentSize(PKModelButton).width

    local cSize = GUI:getContentSize(pkCell)
    local width = GUI:ListView_getItemCount(pkList) * cSize.width

    GUI:setContentSize(MainMiniMap._PKModelCell, width, cSize.height)
    GUI:setContentSize(pkListBg, width, cSize.height)
    GUI:setContentSize(pkList, width, cSize.height)

    GUI:setPositionX(PKModelButton, 0)
    GUI:Timeline_StopAll(PKModelButton)

    GUI:runAction(PKModelButton,
            GUI:ActionEaseBackOut(
                    GUI:ActionMoveTo(0.2, -(width) + buttonModewWidth, cSize.height/2)))

    GUI:setVisible(MainMiniMap._PKModelCell, true)
    GUI:setPositionX(MainMiniMap._PKModelCell, width + buttonModewWidth)
    GUI:runAction(MainMiniMap._PKModelCell, GUI:ActionEaseBackOut(GUI:ActionMoveTo(0.2, buttonModewWidth, 0)))
end

function MainMiniMap:UpdatePKMode()
    local pkMode = SL:GetMetaValue("PKMODE")
    MainMiniMap._PKModelButtomText:loadTexture(MainMiniMap._Pics[pkMode])
end