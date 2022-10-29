MainLeftTop = {}

function MainLeftTop.main()
    local parent = GUI:Attach_LeftTop()

    local Button_zhuanpan = GUI:Button_Create(parent, "Button_zhuanpan", 380, 0, "res/buff/btn_buffzy_01.png")
    GUI:setAnchorPoint(Button_zhuanpan, 1, 1)
    GUI:Button_loadTexturePressed(Button_zhuanpan, "res/buff/btn_buffzy_02.png")
    GUI:addOnClickEvent(Button_zhuanpan, function()
        GUI:Win_Open("B/转盘")
    end)
end