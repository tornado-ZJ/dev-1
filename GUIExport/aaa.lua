aaa = {}
function aaa.main(parent)
	-- Create ImageView_2
	local ImageView_2 = GUI:Image_Create(parent, "ImageView_2", 120.00, 49.00, "res/public/1900000610.png")
	GUI:setTouchEnabled(ImageView_2, false)
	GUI:setTag(ImageView_2, -1)

	-- Create ImageView_1
	local ImageView_1 = GUI:Image_Create(parent, "ImageView_1", 147.00, 87.00, "res/public/1900000664.png")
	GUI:Image_setScale9Slice(ImageView_1, 0, 0, 0, 0)
	GUI:setContentSize(ImageView_1, 112, 450)
	GUI:setIgnoreContentAdaptWithSize(ImageView_1, false)
	GUI:setTouchEnabled(ImageView_1, false)
	GUI:setTag(ImageView_1, -1)

	-- Create ListView_1
	local ListView_1 = GUI:ListView_Create(parent, "ListView_1", 150.00, 87.00, 106.00, 450.00, 1)
	GUI:ListView_setBackGroundColorType(ListView_1, 1)
	GUI:ListView_setBackGroundColor(ListView_1, "#9696ff")
	GUI:ListView_setBackGroundColorOpacity(ListView_1, 100)
	GUI:setTouchEnabled(ListView_1, true)
	GUI:setTag(ListView_1, -1)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(ListView_1, "Button_1", 0.00, 410.00, "res/public/1900000660.png")
	GUI:Button_loadTexturePressed(Button_1, "res/public/1900000661.png")
	GUI:Button_loadTextureDisabled(Button_1, "res/private/gui_edit/Button_Disable.png")
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 14)
	GUI:Button_setTitleText(Button_1, "Button")
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, -1)
end
return aaa