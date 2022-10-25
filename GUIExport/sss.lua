sss = {}
function sss.main(parent)
	-- Create ImageView_1
	local ImageView_1 = GUI:Image_Create(parent, "ImageView_1", 100.00, 500.00, "res/private/gui_edit/ImageFile.png")
	GUI:setTouchEnabled(ImageView_1, false)
	GUI:setTag(ImageView_1, -1)
end
return sss