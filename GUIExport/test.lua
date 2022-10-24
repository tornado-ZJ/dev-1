test = {}
function test.main(parent)
	-- Create ListView_1
	local ListView_1 = GUI:ListView_Create(parent, "ListView_1", 249.00, 261.00, 500.00, 200.00, 1)
	GUI:ListView_setBackGroundColorType(ListView_1, 1)
	GUI:ListView_setBackGroundColor(ListView_1, "#9696ff")
	GUI:ListView_setBackGroundColorOpacity(ListView_1, 100)
	GUI:setTouchEnabled(ListView_1, true)
	GUI:setTag(ListView_1, -1)

	-- Create Input_1
	local Input_1 = GUI:TextInput_Create(ListView_1, "Input_1", 0.00, 400.00, 100.00, 25.00, 16)
	GUI:TextInput_setString(Input_1, "输入框")
	GUI:setTouchEnabled(Input_1, true)
	GUI:setTag(Input_1, -1)

	-- Create ScrollView_1
	local ScrollView_1 = GUI:ScrollView_Create(ListView_1, "ScrollView_1", 0.00, 200.00, 500.00, 200.00, 1)
	GUI:ScrollView_setBackGroundColorType(ScrollView_1, 1)
	GUI:ScrollView_setBackGroundColor(ScrollView_1, "#ff9664")
	GUI:ScrollView_setBackGroundColorOpacity(ScrollView_1, 100)
	GUI:ScrollView_setInnerContainerSize(ScrollView_1, 500.00, 200.00)
	GUI:setTouchEnabled(ScrollView_1, true)
	GUI:setTag(ScrollView_1, -1)

	-- Create Layout_1
	local Layout_1 = GUI:Layout_Create(ListView_1, "Layout_1", 0.00, 0.00, 500.00, 200.00, false)
	GUI:Layout_setBackGroundColorType(Layout_1, 1)
	GUI:Layout_setBackGroundColor(Layout_1, "#96c8ff")
	GUI:Layout_setBackGroundColorOpacity(Layout_1, 140)
	GUI:setTouchEnabled(Layout_1, false)
	GUI:setTag(Layout_1, -1)
end
return test