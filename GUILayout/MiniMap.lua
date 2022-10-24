MiniMap = {}

function MiniMap.main()
    local parent = GUI:Attach_Parent()

    local MapNameBG = GUI:Image_Create(parent, "MapNameBG", 330, 408, "res/private/minimap/1900012107.png")

    local MapName = GUI:Text_Create(parent, "MapName", 430, 420, 16, "#ffffff", "")
    GUI:setAnchorPoint(MapName, {x=0.5, y=0.5})
end