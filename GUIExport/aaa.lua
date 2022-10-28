aaa = {}
function aaa.main(parent)
	-- Create ImageView_2
	local ImageView_2 = GUI:Image_Create(parent, "ImageView_2", 120.00, 49.00, "res/public/1900000610.png")
	GUI:setContentSize(ImageView_2, 790, 540)
	GUI:setIgnoreContentAdaptWithSize(ImageView_2, false)
	GUI:setTouchEnabled(ImageView_2, false)
	GUI:setTag(ImageView_2, -1)

	-- Create ImageView_1
	local ImageView_1 = GUI:Image_Create(parent, "ImageView_1", 148.00, 88.00, "res/public/bg_yxui_1.png")
	GUI:Image_setScale9Slice(ImageView_1, 10, 8, 10, 10)
	GUI:setContentSize(ImageView_1, 736, 451)
	GUI:setIgnoreContentAdaptWithSize(ImageView_1, false)
	GUI:setTouchEnabled(ImageView_1, false)
	GUI:setTag(ImageView_1, -1)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(parent, "Button_1", 642.00, 145.00, "res/public/1900000679.png")
	GUI:Button_loadTexturePressed(Button_1, "res/public/1900000679_1.png")
	GUI:Button_loadTextureDisabled(Button_1, "res/private/gui_edit/Button_Disable.png")
	GUI:Button_setScale9Slice(Button_1, 10, 8, 10, 10)
	GUI:setContentSize(Button_1, 76, 33)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 14)
	GUI:Button_setTitleText(Button_1, "Button")
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, -1)
end
return aaa