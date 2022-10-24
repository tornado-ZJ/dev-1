sss = {}
function sss.main(parent)
	-- Create ImageView_1
	local ImageView_1 = GUI:Image_Create(parent, "ImageView_1", 136.00, 52.00, "res/ui/npc/免费会员/2.png")
	GUI:setTouchEnabled(ImageView_1, false)
	GUI:setTag(ImageView_1, -1)

	-- Create ListView_1
	local ListView_1 = GUI:ListView_Create(parent, "ListView_1", 209.00, 79.00, 110.00, 322.00, 1)
	GUI:ListView_setBackGroundColorType(ListView_1, 1)
	GUI:ListView_setBackGroundColor(ListView_1, "#9696ff")
	GUI:ListView_setBackGroundColorOpacity(ListView_1, 100)
	GUI:setTouchEnabled(ListView_1, true)
	GUI:setTag(ListView_1, -1)
end
return sss