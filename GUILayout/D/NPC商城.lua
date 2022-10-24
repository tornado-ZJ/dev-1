NpcShop = {}
local cfg = cfg_npc_store
local GUIparent = ""


local ChoosePage_Index = 0

local RightPage = {"材\n料","灵\n宝","称\n号"}

local BuyCount_data ={}

local NpcShop_data = {
    [1] = {
        index = {1,4},
    },
    [2] = {
        index = {5,28},
    },
    [3] = {
        index = {29,39},
    },
}
local buy_num = 0 --要购买商品数量
local buy_index = 0
NpcShop.main = function()
    SL:SubmitForm("D/NPC商城","SyncResponse")
end 
NpcShop.main()

--同步信息
function NpcShop.SyncResponse(data)
    if not data then return end
    local data = string.gsub(data, "'","")
    BuyCount_data = SL:JsonDecode(data)
    if not GUI:GetWindow(nil,"QSQ_NpcShop") then
        NpcShop.createUI()
    else
        NpcShop.updatebuytext()
    end
end

NpcShop.createUI = function()

    local _parent = GUI:Win_Create("QSQ_NpcShop", 0, 0, 0, 0, false, false, true, false)
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
        local title = GUI:Text_Create(_parent, "title", 510, 558, 20, "#D6C6AD", "百晓生")

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
                        NpcShop.ChoosePage(i)
                    end)
                    local text_rightlist_btn = GUI:Text_Create(btn_rightlist, "text_rightlist_btn", 16, 53, 20, "#D6C6AD", data)
                    if text_rightlist_btn then
                       GUI:setAnchorPoint(text_rightlist_btn, 0.5, 0.5)
                    end
                end
            end
        end


        --分割线
        local img_line = GUI:Image_Create(_parent, "img_line", 545, 100, "res/custom/shajuan/shajuan_1.png")
        if img_line then
            GUI:setAnchorPoint(img_line, 0.5, 0)
            GUI:setContentSize(img_line,{width = 692, height = 2})
        end

        --货币背景框 --7400005
        local img_moneybg = GUI:Image_Create(_parent, "img_moneybg", 260, 72, "res/custom/NTGM/img_di2.png")
        local money_name = SL:GetItemNameByIndex(cfg[5].price[1][1])--获取名字
        local money_num = SL:GetItemNumberByIndex(cfg[5].price[1][1]) --背包数量
        GUI:Text_Create(img_moneybg, "text_money", 4, 0, 16, "#00ff00", money_name.."："..money_num)

        if ChoosePage_Index == 0 then
            NpcShop.ChoosePage(1)
        else
            NpcShop.updateUI()
        end
       -- SL:RegisterLUAEvent("LUA_EVENT_MONEYCHANGE", "神兵锻造", NpcShop.updateText) --货币变化时触发
    end
end

--选择页签
function NpcShop.ChoosePage(param)
    if not param then return end
    if ChoosePage_Index == param then return end
    local btn_rightlist = GUI:GetWindow(nil,"QSQ_NpcShop/Right_List/btn_rightlist"..ChoosePage_Index)
    if btn_rightlist then
        GUI:Button_setBright(btn_rightlist,true)
    end
    local btn_rightlist = GUI:GetWindow(nil,"QSQ_NpcShop/Right_List/btn_rightlist"..param)
    if btn_rightlist then
        GUI:Button_setBright(btn_rightlist,false)
    end
    ChoosePage_Index = param
    NpcShop.updateUI()
end
--更新
function NpcShop.updateUI()
    local Right_List = GUI:GetWindow(nil,"QSQ_NpcShop/Right_List")
    if Left_list then
    end

    local _parent = GUI:GetWindow(GUIparent, "bg_kuang")
     --中间商品列表
    local Shop_List = GUI:GetWindow(_parent, "Shop_List")
    if not Shop_List then
        Shop_List = GUI:ListView_Create(_parent, "Shop_List", 63, 63, 690, 400, 1)
        GUI:ListView_setClippingEnabled(Shop_List,true)
        GUI:ListView_setItemsMargin(Shop_List, 10)
    end
    GUI:removeAllChildren(Shop_List)
    local item_begin = NpcShop_data[ChoosePage_Index].index[1]
    local item_end = NpcShop_data[ChoosePage_Index].index[2]
    local maxnum = item_end - item_begin + 1-- 数量
    local box_w,box_h = 210,130
    local index = 0
    local limit_row = maxnum <= 3 and maxnum or 3--一排的最大数量
    local limit_rol = math.ceil(maxnum/limit_row) --一列的最大数量
    if Shop_List then
        GUI:ListView_setItemsMargin(Shop_List, 5)
        for i = 1,limit_rol do
            local handle = GUI:Layout_Create(Shop_List, "layout_ShopList_"..i, 0,0, 690, box_h)
            for j = 1,limit_row do
               index = index + 1
               if index <= maxnum then
                    local handle_index = limit_row * (i - 1) + j + item_begin - 1
                    local _handle = GUI:Image_Create(handle, "img_layout_item_" .. handle_index, 15 + (box_w + 15 ) * (j - 1), 0, "res/custom/common/img_bg_3.png")
                    GUI:setTouchEnabled(_handle, true)
                    GUI:addOnClickEvent(_handle, function()
                        NpcShop.Buy(handle_index)
                    end)
                    GUI:Image_setScale9Slice(_handle, 10, 10, 10, 10)
                    GUI:setContentSize(_handle,{width = box_w, height = box_h})

                    local _data = cfg[index + item_begin - 1]
                   
                    if not _data then return end

                    local item_id = _data.itemId[1][1] --物品id
                    --商品名字
                    local shop_name = SL:GetItemNameByIndex(item_id)--获取名字
                    local text_title = GUI:Text_Create(_handle, "text_title" .. j, box_w / 2, box_h - 33, 16, "#D6C6AD", shop_name)
                    GUI:setAnchorPoint(text_title, 0.5, 0)

                    --物品框
                    local item_x,item_y = 45,55
                    local item_ =  GUI:ItemShow_Create(_handle, "shop_item_",item_x,item_y, {index = item_id, look = false, bgVisible = true, count = 1})
                    GUI:setScale(item_, 0.9)
                    GUI:setAnchorPoint(item_, 0.5, 0.5)
                    
                    --限购
                    local str = ""
                    if _data.leixing then
                        if _data.leixing == 1 then
                            str = "<font color='#ffffff' size='16'>".."今日限购：".."</font><font color='#4AE74A' size='16'>"..BuyCount_data[handle_index].."/".._data.singleLimit .."</font>"
                        else
                            str = "<font color='#ffffff' size='16'>".."永久限购：".."</font><font color='#4AE74A' size='16'>"..BuyCount_data[handle_index].."/".._data.singleLimit.."</font>" 
                        end
                    else
                        str = "<font color='#ffffff' size='16'>不限次数</font>"
                    end

                    GUI:RichText_Create(_handle, "text_shopcount", 75, 60, str, 150, nil, nil, nil)
                    --费用
                    local str = "<font color='#ffffff' size='16'>"..SL:GetItemNameByIndex(_data.price[1][1]).."：</font><font color='#ff0000' size='16'>".._data.price[1][2].."</font>"           
                    GUI:RichText_Create(_handle, "text_shopmoney", 75, 30, str, 150, 16, nil, nil)
               end
            end
        end
    end

    NpcShop.UpdateMoneyText() --更新货币数量
    NpcShop.CloseSecond() --关闭商品购买界面
end

--购买
function NpcShop.Buy(param)

    local handle = GUI:GetWindow(nil, "QSQ_NpcShop/bg_kuang/second_latout")
    if handle then return end

    buy_index = param
    if not buy_index then return end
    buy_num = 1 --初始购买数量
    local _parents = GUI:GetWindow(GUIparent, "bg_kuang")
    local _parent = GUI:Layout_Create(_parents, "second_latout", 270, 70, 370, 426)

    NpcShop.ClickSwitch(false) -- 禁止点击开关

    local second_bgimg = GUI:Image_Create(_parent, "second_bgimg", 0, 0, "res/custom/huishou/img_1.jpg")
    GUI:Image_setScale9Slice(second_bgimg, 10, 10, 10, 10)
    local box_w,box_h = 280,380
    GUI:setContentSize(second_bgimg,{width = box_w,height = box_h})
    --创建关闭按钮
    local second_btn_close = GUI:Button_Create(_parent, "second_btn_close", 259, 318, "res/01/010008.png")
    if second_btn_close then
        GUI:Button_loadTexturePressed(second_btn_close, "res/01/010009.png")   
        GUI:addOnClickEvent(second_btn_close, function()
            NpcShop.CloseSecond() --关闭商品购买界面
        end)
    end

    local _data = cfg[buy_index]

    --物品框
    local item_x,item_y = 65,300
    local img_handle = GUI:Image_Create(_parent, "second_img_item", item_x, item_y, "res/custom/hecheng/equip_gridBg1.png")
    GUI:setAnchorPoint(img_handle, 0.5, 0.5)
    local img_handle = GUI:Image_Create(_parent, "second_img_item_frame",item_x, item_y, "res/custom/hecheng/equip_gridBg1_s.png")
    GUI:setAnchorPoint(img_handle, 0.5, 0.5)
    local item_handle=  GUI:ItemShow_Create(_parent, "shop_item_",item_x,item_y, {index = _data.itemId[1][1], look = true, bgVisible = true, count = 1})
    GUI:setScale(item_handle, 0.9)
    GUI:setAnchorPoint(item_handle, 0.5, 0.5)

    --商品名字
    local shop_name = SL:GetItemNameByIndex(_data.itemId[1][1])--获取名字
    local text_title = GUI:Text_Create(_parent, "second_text_shopname" , 180, 300, 16, "#00ff00", shop_name)
    GUI:setAnchorPoint(text_title, 0.5, 0)
    --单价
    local str = "<font color='#ffffff' size='16'>单价：</font><font color='#00ff00' size='16'>"..SL:GetItemNameByIndex(_data.price[1][1]).." * ".._data.price[1][2].."</font>"           
    GUI:RichText_Create(_parent, "second_oneprice", 75, 220, str, 150, nil, nil, nil)

    --单价数量背景图
    local second_bgnum = GUI:Image_Create(_parent, "second_bgnum", box_w/2, box_h/2, "res/custom/NTGM/img_di2.png")
    GUI:setAnchorPoint(second_bgnum, 0.5, 0.5)

    --购买数量输入框
    local input_handle = GUI:TextInput_Create(_parent, "second_input_text", box_w/2, box_h/2, 30, 20, 16) --146, 20
    GUI:setAnchorPoint(input_handle, 0.5, 0.5)
    GUI:TextInput_setMaxLength(input_handle, 3)
    GUI:TextInput_setInputMode(input_handle, 2)
    GUI:TextInput_setFontColor(input_handle,"#C0C0C0")
    GUI:TextInput_setString(input_handle,buy_num)
    GUI:TextInput_addOnEvent(input_handle, NpcShop.InputChange)

    --总价
    local str = "<font color='#ffffff' size='16'>总价：</font><font color='#00ff00' size='16'>"..SL:GetItemNameByIndex(_data.price[1][1]).." * ".._data.price[1][2] * buy_num.."</font>"           
    GUI:RichText_Create(_parent, "second_totleprice", 75, 100, str, 150, nil, nil, nil)

    --减少按钮
    local second_btn_reduce = GUI:Button_Create(_parent, "second_btn_reduce", box_w/2 - 100, box_h/2, "res/custom/hecheng/btn_del_1.jpg")
    if second_btn_reduce then
        GUI:setAnchorPoint(second_btn_reduce, 0.5, 0.5)
        GUI:Button_loadTexturePressed(second_btn_reduce, "res/custom/hecheng/btn_del_2.jpg")
        GUI:addOnClickEvent(second_btn_reduce, function()
            NpcShop.ChangeBuyNum(1)
        end)
    end
    --增加按钮
    local second_btn_add = GUI:Button_Create(_parent, "second_btn_add", box_w/2 + 100, box_h/2, "res/custom/hecheng/btn_add_1.jpg")
    if second_btn_add then
        GUI:setAnchorPoint(second_btn_add, 0.5, 0.5)
        GUI:Button_loadTexturePressed(second_btn_add, "res/custom/hecheng/btn_add_2.jpg")
        GUI:addOnClickEvent(second_btn_add, function()
            NpcShop.ChangeBuyNum(2)
        end)
    end

    --购买按钮
    local handle = GUI:Button_Create(_parent, "second_btn_buy", box_w/2, box_h/2 - 140, "res/01/010005.png")
    if handle then
        local text = GUI:Text_Create(handle, "second_btn_text", 54, 20, 16, "#FFFF66", "购 买")
        GUI:setAnchorPoint(text, 0.5, 0.5)
        GUI:setAnchorPoint(handle, 0.5, 0.5)
        GUI:Button_loadTexturePressed(handle, "res/01/010006.png")
        GUI:addOnClickEvent(handle, function()
            NpcShop.BuyGoods()
        end)
    end

end

function NpcShop.ChangeBuyNum(param)
    local isadd = param
    if isadd == 1 then--减少
        buy_num = buy_num - 1 > 0 and buy_num - 1 or 1
    else
        buy_num = buy_num + 1 < 1000 and buy_num + 1 or buy_num
    end
    local handle = GUI:GetWindow(nil, "QSQ_NpcShop/bg_kuang/second_latout/second_input_text")
    GUI:TextInput_setString(handle,buy_num)
    NpcShop.ChangeTotlePrice() --更新总价
end
function NpcShop.ChangeTotlePrice() --更新总价
    local handle = GUI:GetWindow(nil, "QSQ_NpcShop/bg_kuang/second_latout/second_totleprice")
    GUI:removeFromParent(handle)
    local _data = cfg[buy_index]
    local _parent = GUI:GetWindow(nil, "QSQ_NpcShop/bg_kuang/second_latout")
    local str = "<font color='#ffffff' size='16'>总价：</font><font color='#00ff00' size='16'>"..SL:GetItemNameByIndex(_data.price[1][1]).." * ".._data.price[1][2] * buy_num.."</font>"           
    local handle = GUI:RichText_Create(_parent, "second_totleprice", 75, 100, str, 250, nil, nil, nil)
end
--输入框监听事件
function NpcShop.InputChange(handle,editbox)
    if editbox == 0 then
        --began--进入
    elseif editbox == 1 then
        --ended--退出
    elseif editbox == 2 then
        --changed--改变
    elseif editbox == 3 then
        --return--输出
        local num = tonumber(GUI:TextInput_getString(handle))
        buy_num = num < 1 and 1 or num
        GUI:TextInput_setString(handle,buy_num)
        NpcShop.ChangeTotlePrice() --更新总价
    elseif editbox == 4 then
        --send--发送
    end
end

function NpcShop.ClickSwitch(param)
    local Shop_List = GUI:GetWindow(nil, "QSQ_NpcShop/bg_kuang/Shop_List")
    if not Shop_List then return end
    GUI:setTouchEnabled(Shop_List, param)
end


function NpcShop.CloseSecond() --关闭商品购买界面
    local handle = GUI:GetWindow(nil, "QSQ_NpcShop/bg_kuang/second_latout")
    if handle then  
        GUI:removeFromParent(handle)
    end
    local handle = GUI:GetWindow(GUIparent, "bg_kuang")
    GUI:setTouchEnabled(handle, true)
    NpcShop.ClickSwitch(true) -- 禁止点击开关
end
      
function NpcShop.updatebuytext()
    --中间商品列表
    local Shop_List = GUI:GetWindow(nil, "QSQ_NpcShop/bg_kuang/Shop_List")
    if not Shop_List then return end
    local item_begin = NpcShop_data[ChoosePage_Index].index[1]
    local item_end = NpcShop_data[ChoosePage_Index].index[2]
    local maxnum = item_end - item_begin + 1-- 数量
    local box_w,box_h = 210,130
    local index = 0
    local limit_row = maxnum <= 3 and maxnum or 3--一排的最大数量
    local limit_rol = math.ceil(maxnum/limit_row) --一列的最大数量
    for i = 1,limit_rol do
        local handle = GUI:GetWindow(Shop_List, "layout_ShopList_"..i)
        for j = 1,limit_row do
            index = index + 1
            if index <= maxnum then
                local handle_index = limit_row * (i - 1) + j + item_begin - 1
                local _handle = GUI:GetWindow(handle, "img_layout_item_"..handle_index)
                local _data = cfg[index + item_begin - 1]
                if not _data then return end
                --限购
                local str = ""
                if _data.leixing then
                    if _data.leixing == 1 then
                        str = "<font color='#ffffff' size='16'>".."今日限购：".."</font><font color='#4AE74A' size='16'>"..BuyCount_data[handle_index].."/".._data.singleLimit .."</font>"
                    else
                        str = "<font color='#ffffff' size='16'>".."永久限购：".."</font><font color='#4AE74A' size='16'>"..BuyCount_data[handle_index].."/".._data.singleLimit.."</font>" 
                    end
                else
                    str = "<font color='#ffffff' size='16'>不限次数</font>"
                end
                local text_handle = GUI:GetWindow(_handle, "text_shopcount")
                GUI:removeFromParent(text_handle)
                local str = ""
                if _data.leixing then
                    if _data.leixing == 1 then
                        str = "<font color='#ffffff' size='16'>".."今日限购：".."</font><font color='#4AE74A' size='16'>"..BuyCount_data[handle_index].."/".._data.singleLimit .."</font>"
                    else
                        str = "<font color='#ffffff' size='16'>".."永久限购：".."</font><font color='#4AE74A' size='16'>"..BuyCount_data[handle_index].."/".._data.singleLimit.."</font>" 
                    end
                else
                    str = "<font color='#ffffff' size='16'>不限次数</font>"
                end
                GUI:RichText_Create(_handle, "text_shopcount", 75, 60, str, 150, nil, nil, nil)
            end
        end
    end
    NpcShop.UpdateMoneyText() --更新货币数量
    NpcShop.CloseSecond() --关闭商品购买界面
end


function NpcShop.UpdateMoneyText() --更新货币数量
    --货币数量
    local money_name = SL:GetItemNameByIndex(cfg[5].price[1][1])--获取名字
    local money_num = SL:GetItemNumberByIndex(cfg[5].price[1][1]) --背包数量
    local handle = GUI:GetWindow(nil, "QSQ_NpcShop/img_moneybg")
    local text_handle = GUI:GetWindow(handle, "text_money")
    GUI:Text_setString(text_handle, money_name.."："..money_num)
end
--购买商品
function NpcShop.BuyGoods()
    SL:SubmitForm("D/NPC商城","BuyGoods",buy_index.."#"..buy_num)
end
