aaa = {}
function aaa.main(parent)
	-- Create ImageView_1
	local ImageView_1 = GUI:Image_Create(parent, "ImageView_1", 138.00, 33.00, "res/1900000610.png")
	GUI:setTouchEnabled(ImageView_1, false)
	GUI:setTag(ImageView_1, -1)
end
return aaa