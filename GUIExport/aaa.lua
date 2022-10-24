aaa = {}
function aaa.main(parent)
	-- Create img_bg
	local img_bg = GUI:Image_Create(parent, "img_bg", 162.00, 45.00, "res/ui/npc/免费会员/2.png")
	GUI:setContentSize(img_bg, 815, 575)
	GUI:setIgnoreContentAdaptWithSize(img_bg, false)
	GUI:setTouchEnabled(img_bg, true)
	GUI:setTag(img_bg, -1)

	-- Create Button_1_1
	local Button_1_1 = GUI:ListView_Create(parent, "Button_1_1", 232.00, 70.00, 110.00, 340.00, 1)
	GUI:ListView_setBackGroundColorType(Button_1_1, 1)
	GUI:ListView_setBackGroundColor(Button_1_1, "#9696ff")
	GUI:ListView_setBackGroundColorOpacity(Button_1_1, 100)
	GUI:ListView_setBounceEnabled(Button_1_1, true)
	GUI:ListView_setGravity(Button_1_1, 3)
	GUI:ListView_setItemsMargin(Button_1_1, 1)
	GUI:setTouchEnabled(Button_1_1, true)
	GUI:setTag(Button_1_1, -1)

	-- Create Button_1_1_1
	local Button_1_1_1 = GUI:Button_Create(Button_1_1, "Button_1_1_1", 0.00, 304.00, "res/ui/npc/免费会员/6.png")
	GUI:Button_loadTexturePressed(Button_1_1_1, "res/private/gui_edit/Button_Press.png")
	GUI:Button_loadTextureDisabled(Button_1_1_1, "res/private/gui_edit/Button_Disable.png")
	GUI:Button_setTitleColor(Button_1_1_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1_1_1, 18)
	GUI:Button_setTitleText(Button_1_1_1, "VIP")
	GUI:setTouchEnabled(Button_1_1_1, true)
	GUI:setTag(Button_1_1_1, -1)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(parent, "Button_2", 778.00, 88.00, "res/ui/npc/免费会员/6.png")
	GUI:Button_loadTexturePressed(Button_2, "res/ui/npc/免费会员/7.png")
	GUI:Button_loadTextureDisabled(Button_2, "res/private/gui_edit/Button_Disable.png")
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 18)
	GUI:Button_setTitleText(Button_2, "升级VIP")
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, -1)

	-- Create Layout_1
	local Layout_1 = GUI:Layout_Create(parent, "Layout_1", 451.00, 79.00, 300.00, 60.00, false)
	GUI:Layout_setBackGroundColorType(Layout_1, 1)
	GUI:Layout_setBackGroundColor(Layout_1, "#96c8ff")
	GUI:Layout_setBackGroundColorOpacity(Layout_1, 140)
	GUI:setTouchEnabled(Layout_1, false)
	GUI:setTag(Layout_1, -1)

	-- Create listview_VIP_renwu
	local listview_VIP_renwu = GUI:ListView_Create(parent, "listview_VIP_renwu", 539.00, 161.00, 350.00, 200.00, 1)
	GUI:ListView_setBackGroundColorType(listview_VIP_renwu, 1)
	GUI:ListView_setBackGroundColor(listview_VIP_renwu, "#9696ff")
	GUI:ListView_setBackGroundColorOpacity(listview_VIP_renwu, 100)
	GUI:ListView_setBounceEnabled(listview_VIP_renwu, true)
	GUI:setTouchEnabled(listview_VIP_renwu, true)
	GUI:setTag(listview_VIP_renwu, -1)

	-- Create Layout_2
	local Layout_2 = GUI:Layout_Create(listview_VIP_renwu, "Layout_2", 0.00, 95.00, 350.00, 105.00, false)
	GUI:Layout_setBackGroundColorType(Layout_2, 1)
	GUI:Layout_setBackGroundColor(Layout_2, "#96c8ff")
	GUI:Layout_setBackGroundColorOpacity(Layout_2, 140)
	GUI:setTouchEnabled(Layout_2, false)
	GUI:setTag(Layout_2, -1)

	-- Create ImageView_1
	local ImageView_1 = GUI:Image_Create(Layout_2, "ImageView_1", 0.00, 0.00, "res/ui/npc/免费会员/11.png")
	GUI:setContentSize(ImageView_1, 170, 108)
	GUI:setIgnoreContentAdaptWithSize(ImageView_1, false)
	GUI:setTouchEnabled(ImageView_1, false)
	GUI:setTag(ImageView_1, -1)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(ImageView_1, "Button_3", 80.00, 75.00, "res/ui/npc/免费会员/6.png")
	GUI:Button_loadTexturePressed(Button_3, "res/private/gui_edit/Button_Press.png")
	GUI:Button_loadTextureDisabled(Button_3, "res/private/gui_edit/Button_Disable.png")
	GUI:Button_setTitleColor(Button_3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_3, 16)
	GUI:Button_setTitleText(Button_3, "去完成")
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, -1)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(ImageView_1, "Text_1", 10.00, 73.00, 18, "#ffffff", [[文本]])
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, -1)

	-- Create ImageView_4
	local ImageView_4 = GUI:Image_Create(ImageView_1, "ImageView_4", 96.00, 72.00, "res/ui/npc/免费会员/13.png")
	GUI:setTouchEnabled(ImageView_4, false)
	GUI:setTag(ImageView_4, -1)

	-- Create ImageView_2
	local ImageView_2 = GUI:Image_Create(parent, "ImageView_2", 784.00, 91.00, "res/ui/npc/免费会员/10.png")
	GUI:setTouchEnabled(ImageView_2, false)
	GUI:setTag(ImageView_2, -1)

	-- Create ImageView_3
	local ImageView_3 = GUI:Image_Create(parent, "ImageView_3", 572.00, 261.00, "res/ui/npc/免费会员/12.png")
	GUI:setTouchEnabled(ImageView_3, false)
	GUI:setTag(ImageView_3, -1)
end
return aaa