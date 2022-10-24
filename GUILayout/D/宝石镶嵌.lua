GemSetting = {}
local cfg = cfg_baoshi
local GUIparent = ""


local GemSetting_data = {}
local Sift_State = 0 --筛选状态
local ChoosePage_Index = 0
local GemListView_date = {}
local Gem_date = {} --装备位宝石镶嵌数据
local imgpos_List = {{210,391},{309,391},{378,318},{378,215},{309,141},{210,141},{141,215},{141,318}} --8个类型位置
local RightPage = {"镶\n嵌",}
local Setpos_data = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,55} --镶嵌装备位
--local Setpos_item = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18}
local posname = {"衣服","武器","勋章","项链","头盔","右手镯","左手镯","右戒指","左戒指","符","腰带","靴子","宝石","斗笠","军鼓","马牌","盾牌","面巾"}


local PosView = 0 --位置
local Select_pos = 1 --选中要镶嵌迪装备位 
local Select_index = 1 --选中要镶嵌的类型
local updateway = 0 --更新方式
local Win_W,Win_H = 815,575
GemSetting.main = function()
    SL:SubmitForm("D/宝石镶嵌","SyncResponse")
end 
GemSetting.main()

--同步信息
function GemSetting.SyncResponse(data)
    if not cfg then return end
    if not data then return end
    local data = string.gsub(data, "'","")
    GemSetting_data = SL:JsonDecode(data)
    Sift_State = GemSetting_data[1]
    Gem_date = GemSetting_data[2]
    updateway = GemSetting_data[3]
    GemSetting.GetGemListViewDate()
    if not GUI:GetWindow(nil,"QSQ_GemSetting") then
        GemSetting.createUI()
    else
        GemSetting.updateUI()
    end
end

GemSetting.createUI = function()
    local _parent = GUI:Win_Create("QSQ_GemSetting", 0, 0, 0, 0, false, false, true, false)
    if _parent then
        GUIparent = _parent
        local winSize = SL:GetScreenSize()
        local x = winSize.width / 2
        local y = winSize.height / 2
        local w = winSize.width
        local h = winSize.height

        local layout = GUI:Layout_Create(_parent, "diban", x, y, w, h)
        if layout then
            GUI:setAnchorPoint(layout, 0.5, 0.5)
        end
        
        --关闭背景
        local bg_close = GUI:Image_Create(_parent, "bg_close", 0, 0, "res/01/010010.png")
        if bg_close then
            GUI:setContentSize(bg_close, {width = w, height = h})
            GUI:setTouchEnabled(bg_close, true)
            GUI:addOnClickEvent(bg_close, function()
                GUI:Win_Close(_parent)
            end)
        end

        --界面框背景
        local bg_kuang = GUI:Image_Create(_parent, "bg_kuang", 142, 45, "res/01/010000.png")
        if bg_kuang then
            GUI:setContentSize(bg_kuang,{width = 815, height = 575})
            GUI:setTouchEnabled(bg_kuang, true)
        end       

        --创建关闭按钮
        local btn_close = GUI:Button_Create(_parent, "btn_close", 870, 515, "res/01/010008.png")
        if btn_close then
            GUI:Button_loadTexturePressed(btn_close, "res/01/010009.png")   
            GUI:addOnClickEvent(btn_close, function()
                GUI:Win_Close(_parent)
            end)
        end
       
        --界面标题
        local title = GUI:Text_Create(_parent, "title", 510, 558, 20, "#D6C6AD", "宝石系统")

        --右侧列表
        local Right_List = GUI:ListView_Create(_parent, "Right_List", 905, 45, 40, 450, 1)
        if Right_List then
            GUI:ListView_setItemsMargin(Right_List, 15)
            for i,data in ipairs(RightPage) do
                local btn_rightlist = GUI:Button_Create(Right_List, "btn_rightlist"..i, 0, 0, "res/01/010022.png")
                if btn_rightlist then
                    GUI:setContentSize(btn_rightlist,{width = 36, height = 99})
                    GUI:Button_loadTexturePressed(btn_rightlist, "res/01/010023.png")
                    GUI:Button_loadTextureDisabled(btn_rightlist, "res/01/010023.png")
                    GUI:addOnClickEvent(btn_rightlist, function()
                        GemSetting.ChoosePage(i)
                    end)
                    local text_rightlist_btn = GUI:Text_Create(btn_rightlist, "text_rightlist_btn", 16, 53, 20, "#D6C6AD", data)
                    if text_rightlist_btn then
                        GUI:setAnchorPoint(text_rightlist_btn, 0.5, 0.5)
                    end
                end
            end
        end

        local handle = GUI:Layout_Create(_parent, "Bgimg", 142, 45, Win_W, Win_H)
        if handle then
            
            --背景图
            local img = GUI:Image_Create(handle, "img_bg", 61, 21, "res/custom/Gem/img_di_2.jpg")
            if img then
                GUI:setContentSize(img,{width = 692, height = 446})
            end

            --镶嵌规则
            local str ="<a href='1'><font color='#00ff00' size='16'>".."镶嵌规则".."</font></a>" 
            local richtext = GUI:RichText_Create(handle, "richtext_rule", 400 , 438, str, 500, nil, nil, nil, function (tstr, rt)
                GemSetting.OpenRuleDesc()
            end)

            --左按钮
            local btn = GUI:Button_Create(handle, "btn_leftslip", 110 , 38, "res/custom/Gem/img_1.png")
            if btn then
                GUI:Button_loadTexturePressed(btn, "res/custom/Gem/img_1.png")  
               GUI:setFlippedX(btn, true)
                GUI:addOnClickEvent(btn, function()
                    GemSetting.PosListViewSlip(1)
                end)
            end
            --右按钮
            local btn = GUI:Button_Create(handle, "btn_rightslip", 700 , 38, "res/custom/Gem/img_1.png")
            if btn then
                GUI:Button_loadTexturePressed(btn, "res/custom/Gem/img_1.png")  
                GUI:addOnClickEvent(btn, function()
                    GemSetting.PosListViewSlip(2)
                end)
            end

            --下方镶嵌装备位列表
            local Pos_ListView = GUI:ListView_Create(handle, "Pos_ListView", 135, 27, 540, 70, 2)
            if Pos_ListView then
                GUI:ListView_setItemsMargin(Pos_ListView, 8)
                for i,data in ipairs(Setpos_data) do
                    local _handle = GUI:Layout_Create(Pos_ListView, "layout_poslistview"..i, 0, 0, 70, 70)
                    if _handle then
                        --装备位物品框
                        local img = GUI:Image_Create(_handle, "img_itembg"..i, 35, 35, "res/custom/common/img_cell_1.png")
                        if img then
                            GUI:setAnchorPoint(img, 0.5, 0.5) 
                        end
                        local item = GUI:ItemShow_Create(_handle, "item_setpos"..i,35,35, {index = 1, look = false, bgVisible = false, count = 1})
                        if item then 
                            GUI:setAnchorPoint(item, 0.5, 0.5) 
                        end
                        local text = GUI:Text_Create(_handle, "text_posname", 35, 35, 16, "#D6C6AD", posname[i])
                        if text then
                            GUI:setAnchorPoint(text, 0.5, 0.5)
                        end

                        --选中图片
                        local img = GUI:Image_Create(_handle, "img_choosepos"..i, 35, 35, "res/custom/common/img_cell_2.png")
                        if img then
                            GUI:setAnchorPoint(img, 0.5, 0.5)
                            GUI:setVisible(img,false)
                            GUI:setLocalZOrder(img,100)

                        end
                        GUI:setTouchEnabled(_handle, true)
                        GUI:addOnClickEvent(_handle, function()
                            GemSetting.UpdateSelectState(i)
                        end)

                    end    
                end
            end

            --要镶嵌的物品框
            local item = GUI:ItemShow_Create(handle, "item_setting",243,255, {index = 1, look = false, bgVisible = false, count = 1})
            --加号图片
            -- local pos_x,pos_y = 243+10 ,255+10 
            -- local len = 135
            -- local angle = 360/8
            -- local idx = 0
            -- for i = 1,8 do
            --     idx = idx + 1
            --     local radian = math.rad(360 / 8 * i - 22)
            --     local x = pos_x + math.cos(radian) * len
            --     local y = pos_y + math.sin(radian) * len
            --     local img = GUI:Image_Create(handle, "img_add"..i, x, y, "res/custom/Gem/img_2.png")
            -- end  
            for i,data in ipairs(imgpos_List) do
                local _handle = GUI:Layout_Create(handle, "layout_way"..i, data[1] - 15, data[2] - 15, 66, 66)
                GUI:setTouchEnabled(_handle, true)
                GUI:addOnClickEvent(_handle, function()
                    GemSetting.UpdateSelectWay(i)
                end)
         
                local img = GUI:Image_Create(_handle, "img_add", 15, 15, "res/custom/Gem/img_2.png")

                local img = GUI:Image_Create(_handle, "img_add_select", 15 - 27, 15 - 27, "res/custom/common2/340.png")
                if img then
                    GUI:Image_setScale9Slice(img, 10, 10, 10, 10)
                    GUI:setContentSize(img,{width = 86, height = 86})
                    GUI:setVisible(img,false)
                    GUI:setTouchEnabled(img, true)
                    GUI:addOnClickEvent(img, function()
                        GemSetting.Rmove(i)
                    end)
                end
                local item = GUI:ItemShow_Create(_handle, "item_showgem",15 - 13 ,15 - 13, {index = 1, look = false, bgVisible = false, count = 1})
                if item then
                    GUI:setVisible(item,false)
                end

            end

            --复选框 
            local checkbox = GUI:CheckBox_Create(handle, "check_sift", 500, 438, "res/custom/Gem/cb_1_1.png", "res/custom/Gem/cb_1_2.png")
            if checkbox then
                GUI:CheckBox_addOnEvent(checkbox, GemSetting.Setcheckboxstate)
            end
            
            --宝石列表
            local Gem_ListView = GUI:ListView_Create(handle, "Gem_ListView", 485, 105, 268, 322, 1)
            local limit_row = #GemListView_date <= 4 and #GemListView_date or 4--一排的最大数量
            local limit_rol = math.ceil(#GemListView_date/4) --一列的最大数量

            local idx = 1
            if Gem_ListView then
                GUI:ListView_setItemsMargin(Gem_ListView, 11)
                for i = 1,limit_rol do
                    local _handle = GUI:Layout_Create(Gem_ListView, "layout_gemlistview"..i, 0, 0, 268, 66)
                    if _handle then
                        for j = 1,limit_row do
                            if idx <= #GemListView_date then
                                local _index = (i - 1) * limit_row + j
                                local item = GUI:ItemShow_Create(_handle, "item_gem" .. j,5 + 66 * (j -1 ),3, {index = GemListView_date[_index].itemid, look = true, bgVisible = true, count = GemListView_date[_index].count})
                                GUI:setTouchEnabled(item, true)
                                GUI:ItemShow_addDoubleEvent(item, function ()
                                    GemSetting.Setting(_index)
                                end)
                                idx = idx + 1
                            end
                        end

                    end
                end
            end   
                 
                          
            GUI:Text_Create(handle, "text_checkdesc", 525, 438, 16, "#ffffff", "筛选可镶嵌的宝石")

        end

        if ChoosePage_Index == 0 then
            GemSetting.ChoosePage(1)
        else
            GemSetting.updateUI()
        end

    end
end
--选择页签
function GemSetting.ChoosePage(param)
    if not param then return end
    if ChoosePage_Index == param then return end
    local handle = GUI:GetWindow(nil,"QSQ_GemSetting/Right_List/btn_rightlist"..ChoosePage_Index)
    if handle then
        GUI:Button_setBright(handle,true)
    end
    local handle = GUI:GetWindow(nil,"QSQ_GemSetting/Right_List/btn_rightlist"..param)
    if handle then
        GUI:Button_setBright(handle,false)
    end
    --if ChoosePage_Index == 0 then Select_pos = 1 end
    ChoosePage_Index = param
    GemSetting.updateUI()
end
--更新
function GemSetting.updateUI()
    local handle =  GUI:GetWindow(nil,"QSQ_GemSetting/Bgimg")
    local checkbox = GUI:GetWindow(handle,"check_sift")
    if checkbox then
        if Sift_State == 1 then
            GUI:CheckBox_setSelected(checkbox, true)
        else
            GUI:CheckBox_setSelected(checkbox, false)
        end
    end
    GemSetting.UpdateSelectState(Select_pos)
end

function GemSetting.UpdateSelectState(param) --更新选中状态
    --if Select_pos == param then return end
    Select_pos = param
    local handle =  GUI:GetWindow(nil,"QSQ_GemSetting/Bgimg")
    local Pos_ListView = GUI:GetWindow(handle,"Pos_ListView") 
    if Pos_ListView then
        for i,data in ipairs(Setpos_data) do
            local _handle = GUI:GetWindow(Pos_ListView,"layout_poslistview"..i)
            if _handle then
                 --选中图片
                local img = GUI:GetWindow(_handle,"img_choosepos"..i)
                if Select_pos == i then
                    GUI:setVisible(img,true)
                else
                    GUI:setVisible(img,false)
                end
               
                local equal_data = SL:GetEquipDataByPos(data) --根据装备位获取装备数据
                local item =GUI:GetWindow(_handle,"item_setpos"..i)
                if item then 
                    GUI:removeFromParent(item)
                    local itemid = equal_data and equal_data.Index or 1
                    item = GUI:ItemShow_Create(_handle, "item_setpos"..i,35,35, {index = itemid, look = false, bgVisible = false, count = 1})
                    local itemstate = equal_data and true or false
                    GUI:setVisible(item,itemstate)
                    GUI:setAnchorPoint(item, 0.5, 0.5) 
                end
                local text = GUI:GetWindow(_handle,"text_posname") 
                if text then
                    local itemstate = equal_data and true or false
                    GUI:setVisible(text, not itemstate)

                end
            end
        end
    end
    local item = GUI:GetWindow(handle,"item_setting") 
    if item then  GUI:removeFromParent(item) end
    local equal_data = SL:GetEquipDataByPos(Setpos_data[Select_pos]) --根据装备位获取装备数据
    local itemid = equal_data and equal_data.Index or 1
    local item = GUI:ItemShow_Create(handle, "item_setting",243,255, {index = itemid, look = false, bgVisible = false, count = 1})
    local itemstate = equal_data and true or false
    GUI:setVisible(item,itemstate)

    for i,data in ipairs(imgpos_List) do
        
        local _handle = GUI:GetWindow(handle,"layout_way"..i)
        local item =  GUI:GetWindow(_handle,"item_showgem")
        local img = GUI:GetWindow(_handle,"img_add")

        if item then GUI:removeFromParent(item) end
        local itemid = Gem_date[Select_pos][i]
        item = GUI:ItemShow_Create(_handle, "item_showgem",15 - 13 ,15 - 13, {index = itemid, look = false, bgVisible = false, count = 1})

        if item then
            if itemid == 0 then
                GUI:setVisible(item,false)
                GUI:setVisible(img,true)
            else
                GUI:setVisible(item,true)
                GUI:setVisible(img,false)
            end
        end
    end


    if updateway == 1 then
        GemSetting.UpdateSelectWay(Select_index) --更新选中类型
        updateway = 0
    else
        GemSetting.UpdateSelectWay(1) --更新选中类型
    end 

end

function GemSetting.UpdateSelectWay(param) --更新选中类型
    Select_index = param
    local handle =  GUI:GetWindow(nil,"QSQ_GemSetting/Bgimg")
    for i,data in ipairs(imgpos_List) do
        local _handle = GUI:GetWindow(handle,"layout_way"..i)
        local img = GUI:GetWindow(_handle,"img_add_select") 
        if i == Select_index then
            GUI:setVisible(img,true)
        else
            GUI:setVisible(img,false)
        end      
    end

    GemSetting.GetGemListViewDate() --更新右侧筛选宝石数据

    --宝石列表
    local Gem_ListView = GUI:GetWindow(handle,"Gem_ListView") 
    if Gem_ListView then 
        GUI:removeFromParent(Gem_ListView) 
    end
    local Gem_ListView = GUI:ListView_Create(handle, "Gem_ListView", 485, 105, 268, 322, 1)
    local limit_row = #GemListView_date <= 4 and #GemListView_date or 4--一排的最大数量
    local limit_rol = math.ceil(#GemListView_date/4) --一列的最大数量

    local idx = 1
    if Gem_ListView then
        GUI:ListView_setItemsMargin(Gem_ListView, 11)
        for i = 1,limit_rol do
            local _handle = GUI:Layout_Create(Gem_ListView, "layout_gemlistview"..i, 0, 0, 268, 66)
            if _handle then
                for j = 1,limit_row do
                    if idx <= #GemListView_date then
                        local _index = (i - 1) * limit_row + j
                        local item = GUI:ItemShow_Create(_handle, "item_gem" .. j,5 + 66 * (j -1 ),3, {index = GemListView_date[_index].itemid, look = true, bgVisible = true, count = GemListView_date[_index].count})
                        GUI:setTouchEnabled(item, true)
                        GUI:ItemShow_addDoubleEvent(item, function ()
                            GemSetting.Setting(_index)
                        end)
                        idx = idx + 1
                    end
                end
            end
        end
    end   
end

--下方列表左右滑动
function  GemSetting.PosListViewSlip(param)
    local direction = param
    local handle =  GUI:GetWindow(nil,"QSQ_GemSetting/Bgimg")
    local Pos_ListView = GUI:GetWindow(handle,"Pos_ListView") 
    if Pos_ListView then
        if direction == 1 then--左
            PosView = PosView - 1 < 0 and 0 or PosView - 1
        else
            PosView = PosView + 1 > #Setpos_data and #Setpos_data or PosView + 1
        end
        GUI:ListView_jumpToItem(Pos_ListView, PosView)--跳至第一个控件
    end
end


function GemSetting.Setcheckboxstate(handle,state) --复选框监听事件
    SL:SubmitForm("D/宝石镶嵌","Setcheckboxstate",state)
end

function GemSetting.Setting(param)
    local index = param
    local _gemitemid = Gem_date[Select_pos][Select_index]
    local _StdMode = cfg[GemListView_date[index].itemid].StdMode
    if _StdMode ~= Select_index then
        SL:ShowSystemTips("镶嵌的宝石类型不符合！")
        return
    end

    if not _gemitemid then return end 
    if _gemitemid == 0 then
        SL:SubmitForm("D/宝石镶嵌","Setting",Select_pos.."#"..Select_index.."#"..index.."#"..GemListView_date[index].itemid)
    else
        local _dengji = cfg[GemListView_date[index].itemid].dengji
        if _dengji <= cfg[_gemitemid].dengji then
            SL:ShowSystemTips("请选择更高阶的宝石！")
            return
        else
            SL:SubmitForm("D/宝石镶嵌","Setting",Select_pos.."#"..Select_index.."#"..index.."#"..GemListView_date[index].itemid)    
        end
    end
end

function GemSetting.GetGemListViewDate()
    GemListView_date = {}
    for i,data in pairs(cfg) do
        local bag_num = SL:GetItemNumberByIndex(i)
        if bag_num > 0 then
            if Sift_State == 0 then
                table.insert(GemListView_date,{itemid = i ,count = bag_num})
            else
                if cfg[i].StdMode == Select_index then
                    if Gem_date[Select_pos][Select_index] == 0 then
                        table.insert(GemListView_date,{itemid = i ,count = bag_num})
                    else
                        if cfg[i].dengji > cfg[Gem_date[Select_pos][Select_index]].dengji then
                            table.insert(GemListView_date,{itemid = i ,count = bag_num})
                        end
                    end
                end
            end   
        end
    end
end

--卸下
function GemSetting.Rmove(param)
    SL:SubmitForm("D/宝石镶嵌","Rmove",Select_pos.."#"..param)    
end

local str_data = {
    [1] = {
        color = "#ffcc00",
        str = "宝石镶嵌：",
    },
    [2] = {
        color = "#ffffff",
        str = "1.镶嵌宝石可以提升大量属性。",
    },
    [3] = {
        color = "#ffffff",
        str = "2.每种类型的宝石在同一个部位只能镶嵌一颗。",
    },
}
--打开镶嵌规则
function GemSetting.OpenRuleDesc()
    local _parent = GUI:GetWindow(nil,"QSQ_GemSetting/Bgimg")
    local handle = GUI:GetWindow(_parent, "layout_ruledesc")
    local box_w,box_h = 330,80
    if not handle  then
        handle = GUI:Layout_Create(_parent, "layout_ruledesc", 105,368, box_w, box_h)
        GUI:setTouchEnabled(handle, true)
        GUI:addOnClickEvent(handle, function()
            GemSetting.OpenRuleDesc()
        end)
        GUI:Layout_setBackGroundColor(handle, "#000000")
        GUI:Layout_setBackGroundColorType(handle, 1)
        GUI:Layout_setBackGroundColorOpacity(handle, 200)

        local img = GUI:Image_Create(handle, "img_rule_frame", 0, 0, "res/custom/common2/215.png")
        if img then
            GUI:Image_setScale9Slice(img, 10, 10, 10, 10)
            GUI:setContentSize(img,{width = box_w, height = box_h})
        end
        for i,data in ipairs(str_data) do
            GUI:Text_Create(handle, "text_ruledesc"..i, 5, box_h - 24 - 24 * (i - 1) , 16, data.color, data.str)
        end
    else
        GUI:removeFromParent(handle)     
    end

end
