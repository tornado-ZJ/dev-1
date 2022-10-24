EqualStar = {}
local cfg = cfg_qianghua
local GUIparent = ""


local EqualStar_data = {}
local Select_index = 1
local type_tab = 30  --强星自定义属性组

local _cfg_qianghua= {}
for i,v in ipairs(cfg_qianghua) do
    _cfg_qianghua[v.weizhi] = _cfg_qianghua[v.weizhi] or {}
    table.insert( _cfg_qianghua[v.weizhi], v)
end


local Equallv_Data = {
    [1] = {
        index = 1,
        name = "武器",
    },
    [2] = {
        index = 0,
        name = "衣服",
    },
    [3] = {
        index = 3,
        name = "项链",
    },
    [4] = {
        index = 4,
        name = "头盔",
    },
    [5] = {
        index = 5,
        name = "右手镯",
    },
    [6] = {
        index = 6,
        name = "左手镯",
    },
    [7] = {
        index = 7,
        name = "右戒指",
    },
    [8] = {
        index = 8,
        name = "左戒指",
    },
    [9] = {
        index = 10,
        name = "腰带",
    },
    [10] = {
        index = 11,
        name = "鞋子",
    },

}


local Win_W,Win_H = 815,575
EqualStar.main = function()
    SL:SubmitForm("D/装备强星","SyncResponse")
end 
EqualStar.main()

--同步信息
function EqualStar.SyncResponse(data)
    if not data then return end
    local data = string.gsub(data, "'","")
    EqualStar_data = SL:JsonDecode(data)
    if not GUI:GetWindow(nil,"QSQ_EqualStar") then
        EqualStar.createUI()
    else
        EqualStar.updateUI()
    end
end

EqualStar.createUI = function()
    local _parent = GUI:Win_Create("QSQ_EqualStar", 0, 0, 0, 0, false, false, true, false)
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
        local handle = GUI:Image_Create(_parent, "bg_kuang", 142, 45, "res/01/010000.png")
        if handle then
            GUI:setContentSize(handle,{width = Win_W, height = Win_H})
            GUI:setTouchEnabled(handle, true)
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
        local title = GUI:Text_Create(_parent, "title", 510, 558, 20, "#D6C6AD", "装备强星")

        local handle = GUI:Layout_Create(_parent, "Bgimg", 142, 45, Win_W, Win_W)
        if handle then
            local layout = GUI:Layout_Create(handle, "layout_layout", 0, 0, Win_W, Win_W)
            local Equal_ListView = GUI:ListView_Create(handle, "Equal_ListView", 62, 18, 160, 446, 1)
            if Equal_ListView then
                GUI:ListView_setItemsMargin(Equal_ListView, 1)
                for i,v in ipairs(Equallv_Data) do
                    local _handle = GUI:Layout_Create(Equal_ListView, "layout_Equallv" .. i, 0, 0, 160, 43)
                    if _handle then
                        -- GUI:Layout_setBackGroundColor(_handle, "#4AE74A")
                        -- GUI:Layout_setBackGroundColorType(_handle, 1)
                        -- GUI:Layout_setBackGroundColorOpacity(_handle, 155)

                        local img = GUI:Image_Create(_handle, "img_Equallv", 0, 0, "res/custom/common/dragon_btn_1.png")
                        if img then
                            GUI:Image_setScale9Slice(img, 10, 10, 10, 10)
                            GUI:setContentSize(img,{width = 155, height = 43})
                            GUI:setTouchEnabled(img, true)
                            GUI:addOnClickEvent(img, function()
                                EqualStar.SelectEqual(i)
                            end)
                        end
                    
                        local img = GUI:Image_Create(_handle, "img_Equallv_frame", 0, 0, "res/custom/common/dragon_btn_2.png")
                        if img then
                            GUI:Image_setScale9Slice(img, 10, 10, 10, 10)
                            GUI:setContentSize(img,{width = 155, height = 43})
                            GUI:setVisible(img,false)
                        end
                        --名字
                        local text = GUI:Text_Create(_handle, "text_Equallv_name", 75, 22, 18, "#D6C6AD", v.name)
                        if text then
                            GUI:setAnchorPoint(text, 0.5, 0.5) 
                        end

                    end
                end
            end

            --右边背景图
            local img = GUI:Image_Create(handle, "img_rightbg", 218, 20, "res/custom/painting/dragon_ball_bg.jpg")
            if img then
                GUI:Image_setScale9Slice(img, 10, 10, 10, 10)
                GUI:setContentSize(img,{width = 536, height = 446})
            end

            local pos_y = 20
            --当前属性图
            local img = GUI:Image_Create(handle, "img_nowattr", 215, 80 + pos_y, "res/custom/qianghua/now_bg.png")
            if img then
                GUI:Image_setScale9Slice(img, 10, 10, 10, 10)
                GUI:setContentSize(img,{width = 200, height = 150})
            end

            --升级属性图
            local img = GUI:Image_Create(handle, "img_nextattr", 540, 80 + pos_y, "res/custom/qianghua/next_bg.png")
            if img then
                GUI:Image_setScale9Slice(img, 10, 10, 10, 10)
                GUI:setContentSize(img,{width = 200, height = 150})
            end
            --当前属性
            for i = 1,4 do
                local text = GUI:Text_Create(handle, "text_title_nowattr" .. i, 290, 180 - 30 * (i - 1) + pos_y, 16, "#ffffff", "")
                GUI:setAnchorPoint(text, 0.5, 0.5)
                GUI:Text_setString(text, "生命：")
                
                local text = GUI:Text_Create(handle, "text_value_nowattr" .. i, 290 + 60, 180 - 30 * (i - 1) + pos_y, 16, "#ffffff", "")
                GUI:setAnchorPoint(text, 0.5, 0.5)
                GUI:Text_setString(text, "20")
            end

            --升级属性
            for i = 1,4 do
                local text = GUI:Text_Create(handle, "text_title_nextattr" .. i, 280 + 340, 180 - 30 * (i - 1) + pos_y, 16, "#ffffff", "")
                GUI:setAnchorPoint(text, 0.5, 0.5)
                GUI:Text_setString(text, "生命：")
                local text = GUI:Text_Create(handle, "text_value_nextattr" .. i, 280 + 60 + 340, 180 - 30 * (i - 1) + pos_y, 16, "#ffffff", "")
                GUI:setAnchorPoint(text, 0.5, 0.5)
                GUI:Text_setString(text, "20")
            end

            --成功率
            local text = GUI:Text_Create(handle, "text_rate",620,48, 16, "#00ff00", "成功率：80%")

            --幸运保底
            local checkbox = GUI:CheckBox_Create(handle, "check_lucky", 250, 40, "res/custom/Gem/cb_1_1.png", "res/custom/Gem/cb_1_2.png")
            if checkbox then
                GUI:CheckBox_addOnEvent(checkbox, EqualStar.Setcheckboxstate)
            end    
            local text = GUI:Text_Create(handle, "text_lucky",280,40, 16, "#ffffff", "幸运保底")

            --装备强星按钮
            local btn = GUI:Button_Create(handle, "btn_equalstar", 430, 40, "res/01/010005.png")
            if btn then
                local text = GUI:Text_Create(btn, "tx_btn_hecheng", 54, 20, 16, "#FFFFcc", "装备强星")
                GUI:setAnchorPoint(text, 0.5, 0.5)
                GUI:Button_loadTexturePressed(btn, "res/01/010006.png")   
                GUI:addOnClickEvent(btn, function()
                    EqualStar.Shengji()
                end)
            end

            --已满级
            local img = GUI:Image_Create(handle, "img_max", 430, 210, "res/custom/common/1_png.ghost.png.ghost.img_Ghost_A54.png")


            --强星规则
            local str ="<a href='1'><font color='#00ff00' size='16'>".."强星规则".."</font></a>" 
            local richtext = GUI:RichText_Create(handle, "richtext_rule", 670 , 430, str, 500, nil, nil, nil, function (tstr, rt)
                EqualStar.OpenRuleDesc()
            end)

        end

        EqualStar.updateUI()
    end
end

--更新
function EqualStar.updateUI()
   -- if Select_index == 0 then
    --     EqualStar.SelectEqual(1)
    -- else
        EqualStar.SelectEqual(Select_index)    
    -- end
end

function EqualStar.SelectEqual(param)
   -- if Select_index == param then return end
    Select_index = param
    local equalpos = Equallv_Data[Select_index].index --当前装备位
    local handle =  GUI:GetWindow(nil,"QSQ_EqualStar/Bgimg")
    if handle then
        local Equal_ListView = GUI:GetWindow(handle,"Equal_ListView") 
        if Equal_ListView then 
            for i,v in ipairs(Equallv_Data) do
                local _handle = GUI:GetWindow(Equal_ListView,"layout_Equallv" .. i)
                if _handle then
                    local img = GUI:GetWindow(_handle,"img_Equallv_frame")
                    local text = GUI:GetWindow(_handle,"text_Equallv_name")
                    if img and text then
                        local state = i == Select_index
                        GUI:setVisible(img,state)
                        if state then
                            GUI:Text_setTextColor(text, "#ffcc00")
                        else
                            GUI:Text_setTextColor(text, "#D6C6AD")
                        end
                    end
                end
            end
        end

        --物品框
        local item = GUI:GetWindow(handle,"item_roleequal")
        if item then GUI:removeFromParent(item) end

        --消耗
        local richtext = GUI:GetWindow(handle,"richtext_xiaohao")
        if richtext then GUI:removeFromParent(richtext) end

        local role_equaldata = SL:GetEquipDataByPos(Equallv_Data[Select_index].index) --根据装备位获取装备数据

    
        if role_equaldata then
            role_equaldata.Star = role_equaldata.Star and role_equaldata.Star or 0
            item = GUIItemShow_Create(handle,"item_roleequal",457,281,{makeindex = role_equaldata.MakeIndex, look = true, bgVisible = true, count = 1})
           -- item = GUI:ItemShow_Create(handle, "item_roleequal",457,281, {index = role_equaldata.index, look = true, bgVisible = true, count = 1})
            -- if item then
            --     --星星
            --     if role_equaldata.Star then
            --         local img = GUI:Image_Create(item, "img_starbg", 0, 20 - 10, "res/custom/qianghua/icon_star_00_1.png")
            --         if img then
            --             GUI:Image_setScale9Slice(img, 10, 10, 10, 10)
            --             GUI:setContentSize(img,{width = 30, height = 50})
            --         end
            --         local tx_atlsas = GUI:TextAtlas_Create(item, "TextAtlas_star", 8, 50 - 5, role_equaldata.Star, "res/01/010007.png", 19, 25, "0")
            --         if tx_atlsas then 
            --             GUI:setScale(tx_atlsas, 0.7)
            --             GUI:setAnchorPoint(tx_atlsas, 0.5, 0.5) 
            --         end      
            --         local img = GUI:Image_Create(item, "img_star", 8+1, 34 - 8, "res/custom/qianghua/icon_star_00.png")
            --         if img then
            --             GUI:setAnchorPoint(img, 0.5, 0.5) 
            --         end  
            --     end
                
            -- end
            local consume = {} --消耗
            if role_equaldata.Star == 0 then --role_equaldata.ExtAbil[type_tab]
                consume = _cfg_qianghua[equalpos][1].xiaohao
            else
                consume = _cfg_qianghua[equalpos][role_equaldata.Star + 1] and _cfg_qianghua[equalpos][role_equaldata.Star + 1].xiaohao or nil
            end
            local cost_str = ""
            if consume then
                local cost_name = SL:GetItemNameByIndex(consume[1][1])--获取名字
                local cost_num = consume[1][2]					--消耗数量
                local bag_num = SL:GetItemNumberByIndex(consume[1][1]) --背包数量
                cost_str = SLChangeColour(bag_num,cost_num,cost_name)
            else
                cost_str = nil 
            end
            --消耗材料
            if cost_str then
                local richtext = GUI:RichText_Create(handle, "richtext_xiaohao", 490, 140, cost_str, 250, nil, nil, nil)
                if richtext then
                    GUI:setAnchorPoint(richtext, 0.5, 0.5)
                end
            end

            
             --当前属性
            local attr_tab = _cfg_qianghua[equalpos][role_equaldata.Star] and _cfg_qianghua[equalpos][role_equaldata.Star].shuxing or nil
            for i = 1,4 do
                local text_title = GUI:GetWindow(handle,"text_title_nowattr" .. i)
                local text_value = GUI:GetWindow(handle,"text_value_nowattr" .. i)
                local state = attr_tab ~= nil 
                GUI:setVisible(text_title,state)
                GUI:setVisible(text_value,state)
                if attr_tab then
                    SLUpdateAttrShow(attr_tab,4,handle,"text_title_nowattr","text_value_nowattr",1) 
                end
            end
            local attr_tab = _cfg_qianghua[equalpos][role_equaldata.Star + 1] and _cfg_qianghua[equalpos][role_equaldata.Star + 1].shuxing or nil
            --升级属性
            for i = 1,4 do
                local text_title = GUI:GetWindow(handle,"text_title_nextattr" .. i)
                local text_value = GUI:GetWindow(handle,"text_value_nextattr" .. i)
                local state = attr_tab ~= nil 
                GUI:setVisible(text_title,state)
                GUI:setVisible(text_value,state)
                if attr_tab then
                    SLUpdateAttrShow(attr_tab,4,handle,"text_title_nextattr","text_value_nextattr",1) 
                end
                
            end
        
            --成功率
            local rate = _cfg_qianghua[equalpos][role_equaldata.Star + 1] and _cfg_qianghua[equalpos][role_equaldata.Star + 1].chenggonglv or nil 
            local text = GUI:GetWindow(handle,"text_rate")
            local state = rate ~= nil 
            GUI:setVisible(text,state)
            if rate then
                GUI:Text_setString(text,"成功率：" .. rate / 100 .."%")
            end

            --已满级
            local img = GUI:GetWindow(handle,"img_max") 
            local state = role_equaldata.Star == 18
            GUI:setVisible(img,state)
        else
            --属性
            for i = 1,4 do
                local text = GUI:GetWindow(handle,"text_title_nowattr" .. i)
                GUI:setVisible(text,false)
                local text = GUI:GetWindow(handle,"text_value_nowattr" .. i)
                GUI:setVisible(text,false)
                local text = GUI:GetWindow(handle,"text_title_nextattr" .. i)
                GUI:setVisible(text,false)
                local text = GUI:GetWindow(handle,"text_value_nextattr" .. i)
                GUI:setVisible(text,false)
            end
             --成功率
            local text = GUI:GetWindow(handle,"text_rate")
            GUI:setVisible(text,false)
            --已满级
            local img = GUI:GetWindow(handle,"img_max") 
            GUI:setVisible(img,false)
        end

        --幸运保底
        local checkbox = GUI:GetWindow(handle,"check_lucky")
        if checkbox then
            local state = EqualStar_data[1] == 1
            GUI:CheckBox_setSelected(checkbox, state)
        end

    end
    EqualStar.OpenRuleDesc("close")
end


local str_data = {
    [1] = {
        color = "#ffcc00",
        str = "装备强星：",
    },
    [2] = {
        color = "#ffffff",
        str = "1.装备强星可以提升大量属性。",
    },
    [3] = {
        color = "#ffffff",
        str = "2.强星失败装备将降一个星级。",
    },
    [4] = {
        color = "#ffffff",
        str = "4.商城购买幸运石可以保护装备强星失败不降星。",
    },
}
--打开镶嵌规则
function EqualStar.OpenRuleDesc(switch)
    local _parent = GUI:GetWindow(nil,"QSQ_EqualStar/Bgimg")
    local handle = GUI:GetWindow(_parent, "layout_ruledesc")
    if switch then
        if handle then GUI:removeFromParent(handle) end
        return      
    end
    local box_w,box_h = 350,100
    if not handle then
        handle = GUI:Layout_Create(_parent, "layout_ruledesc", 670 - box_w,430 - box_h , box_w, box_h)
        GUI:setTouchEnabled(handle, true)
        GUI:addOnClickEvent(handle, function()
            EqualStar.OpenRuleDesc()
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

function EqualStar.Setcheckboxstate(handle,state) --复选框监听事件
    SL:SubmitForm("D/装备强星","Setcheckboxstate",state)
end

function EqualStar.Shengji()
    SL:SubmitForm("D/装备强星","Shengji",Equallv_Data[Select_index].index.."#"..Select_index)
end    

