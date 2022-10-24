CityDonate = {}
local cfg = cfg_sj
local GUIparent = ""


local CityDonate_data = {}
local Choose_Index = 1
local Title_List = {"排名","名 字","捐献灵符","属 性"}
local Color_List = {"#ff0000","#ff9900","#ffff00","#FF33CC","#99CC0","#FF9966","#FFFFCC","#336699","#666666","#FF6666"}
local D_num = 1000 --要捐献的数量
local AllDonateNum = 0 --捐献奖池数量
local DonateNum = 0 --我的捐献数量
local Win_W,Win_H = 815,575
CityDonate.main = function()
    SL:SubmitForm("D/沙城捐献","SyncResponse")
end 
CityDonate.main()

--同步信息
function CityDonate.SyncResponse(data)
    if not data then return end
    local data = string.gsub(data, "'","")
    SendList = SL:JsonDecode(data)
    DonateRank_List = SendList[1]
    AllDonateNum =  SendList[2]
    DonateNum =  SendList[3]
    for i = 1,math.ceil(#DonateRank_List/2) do
        CityDonate_data[i] = {money = DonateRank_List[i * 2],name =  DonateRank_List[i * 2 - 1]}
    end

    if not GUI:GetWindow(nil,"QSQ_CityDonate") then
        CityDonate.createUI()
    else
        CityDonate.updateUI()
    end
end

CityDonate.createUI = function()
    local _parent = GUI:Win_Create("QSQ_CityDonate", 0, 0, 0, 0, false, false, true, false)
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
            GUI:addOnClickEvent(handle, function()
                CityDonate.OpenDesc("false") --捐献说明
            end)
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
        local title = GUI:Text_Create(_parent, "title", 510, 558, 20, "#D6C6AD", "沙城捐献")
        


        --背景图
        local img_bg = GUI:Image_Create(handle, "img_bg", 62, 22, "res/custom/kuangbao/kb_2.jpg")
        if img_bg then
            GUI:setContentSize(img_bg,{width = 690, height = 446})
        end  
        local img_top = GUI:Image_Create(handle, "img_top", 62, 408, "res/custom/leichong/1.png")
        if img_top then
            GUI:Image_setScale9Slice(img_top, 10, 10, 10, 10)
            GUI:setContentSize(img_top,{width = 690, height = 60})
        end  
        local img_bottom = GUI:Image_Create(handle, "img_bottom", 62, 22, "res/custom/leichong/1.png")
        if img_bottom then
            GUI:Image_setScale9Slice(img_bottom, 10, 10, 10, 10)
            GUI:setContentSize(img_bottom,{width = 690, height = 60})
        end  

        --标题text
        for i = 1,#Title_List do
            local text_title = GUI:Text_Create(handle, "text_title"..i, 170 - 20 + 150 * (i-1), 425, 20, "#ffff00", Title_List[i])
            GUI:setAnchorPoint(text_title, 0.5, 0)
        end
        --详情
        local btn_description = GUI:Button_Create(handle, "btn_description", Win_W - 110 , Win_H - 150, "res/custom/leichong/8.png")
        if btn_description then
            GUI:Button_loadTexturePressed(btn_description, "res/custom/leichong/8.png")   
            GUI:addOnClickEvent(btn_description, function()
                CityDonate.OpenDesc()
            end)
        end

        --捐献排名列表
        local Rank_List = GUI:ListView_Create(handle, "Rank_List", 63, 84, 690, 322, 1)
        GUI:ListView_setClippingEnabled(Rank_List,true)
        --GUI:ListView_setItemsMargin(Rank_List, 1)
        if Rank_List then
            for i = 1,#cfg do
                local layout_handle = GUI:Layout_Create(Rank_List, "layout_RankList"..i, 0,0, 690, 65)
                local img_line = GUI:Image_Create(layout_handle, "img_line", 0, 0, "res/custom/shajuan/shajuan_1.png")
                
                local text =GUI:Text_Create(layout_handle, "text_rank", 105 - 20 + 150 * (1-1), 20, 20, Color_List[i], "NO."..i)--排名
                GUI:setAnchorPoint(text, 0.5, 0)
                
                local str = CityDonate_data[i] == nil and "暂无" or CityDonate_data[i].name
                local text = GUI:Text_Create(layout_handle, "text_name", 105 - 20 + 150 * (2-1), 20, 20, Color_List[i], str)--名字
                GUI:setAnchorPoint(text, 0.5, 0)
                local str = CityDonate_data[i] == nil and "0" or CityDonate_data[i].money
                local text = GUI:Text_Create(layout_handle, "text_money", 105 - 20 + 150 * (3-1), 20, 20, Color_List[i], str)--捐献数量
                GUI:setAnchorPoint(text, 0.5, 0)

                local img = GUI:Image_Create(layout_handle, "img_attrbg",105 - 20 + 150 * (4-1) + 15, 20 - 5, "res/custom/shajuan/shajuan_3.png")--属性背景图
                GUI:setAnchorPoint(img, 0.5, 0)
                local text = GUI:Text_Create(layout_handle, "text_attr", 105 - 20 + 150 * (4-1), 20, 20, Color_List[i], "属 性")--属性
                GUI:setAnchorPoint(text, 0.5, 0)
                GUI:setTouchEnabled(text, true)
                GUI:addOnClickEvent(text, function()
                    CityDonate.OpenAddattrDesc(i)
                end)
                -- GUI:Layout_setBackGroundColor(layout_handle, "#4AE74A")
                -- GUI:Layout_setBackGroundColorType(layout_handle, 1)
                -- GUI:Layout_setBackGroundColorOpacity(layout_handle, 155)
            end
            
        end
        GUI:setTouchEnabled(Rank_List, true)
        GUI:addOnClickEvent(Rank_List, function()
            CityDonate.OpenDesc("false") --捐献说明
        end)


        --当前奖池
        local str = "<font color='#ffffff' size='18'>当前奖池：</font><font color='#66cccc' size='18'>"..AllDonateNum.."</font>"           
        GUI:RichText_Create(handle, "richtext_AllDonateNum", 100, 40, str, 200, nil, nil, nil)
        --我的捐献
        local str = "<font color='#ffffff' size='18'>我的捐献：</font><font color='#66cccc' size='18'>"..DonateNum.."</font>"           
        GUI:RichText_Create(handle, "richtext_DonateNum", 330, 40, str, 200, nil, nil, nil)


        --捐献按钮
        local btn_donate = GUI:Button_Create(handle, "btn_donate", Win_W - 200 , 30, "res/01/010005.png")
        if btn_donate then
            local text = GUI:Text_Create(btn_donate, "text_btn_donate", 54, 20, 16, "#FFFF99", "捐  献")
            GUI:setAnchorPoint(text, 0.5, 0.5)
            GUI:Button_loadTexturePressed(btn_donate, "res/01/010006.png")   
            GUI:addOnClickEvent(btn_donate, function()
                CityDonate.OpendonateUI()
            end)
        end
        
        CityDonate.updateUI()

    end
end

--更新
function CityDonate.updateUI()
    local _parent = GUI:GetWindow(GUIparent, "bg_kuang")
    --当前奖池
    local richtext = GUI:GetWindow(_parent, "richtext_AllDonateNum")
    GUI:removeFromParent(richtext)
    local str = "<font color='#ffffff' size='18'>当前奖池：</font><font color='#66cccc' size='18'>"..AllDonateNum.."</font>"           
    GUI:RichText_Create(_parent, "richtext_AllDonateNum", 100, 40, str, 200, nil, nil, nil)
    --我的捐献
    local richtext = GUI:GetWindow(_parent, "richtext_DonateNum")
    GUI:removeFromParent(richtext)
    local str = "<font color='#ffffff' size='18'>我的捐献：</font><font color='#66cccc' size='18'>"..DonateNum.."</font>"           
    GUI:RichText_Create(_parent, "richtext_DonateNum", 330, 40, str, 200, nil, nil, nil)



    --捐献排名列表
    local Rank_List = GUI:GetWindow(_parent, "Rank_List")
    if  Rank_List then
        for i = 1,#cfg do
            local layout_handle = GUI:GetWindow(Rank_List, "layout_RankList"..i)

            local text = GUI:GetWindow(layout_handle, "text_name")--名字
            local str = CityDonate_data[i] == nil and "暂无" or CityDonate_data[i].name
            GUI:Text_setString(text, str)

            local text = GUI:GetWindow(layout_handle, "text_money")--捐献数量
            local str = CityDonate_data[i] == nil and "0" or CityDonate_data[i].money
            GUI:Text_setString(text, str)
        end
    end

end
local str_List = {
    [1] = {
        color = "#ffff00",
        str = "沙城捐献：",
    },
    [2] = {
        color = "#ffffff",
        str = "1.单次捐献至少需要一千灵符",
    },
    [3] = {
        color = "#ffffff",
        str = "2.捐献榜上的玩家将获得额外属性加成(与排行榜属性叠加)",
    },
    [4] = {
        color = "#ffffff",
        str = "3.捐献的60%计入攻沙奖励",
    },
}

function CityDonate.OpenDesc(switch) --捐献说明
    local _parent = GUI:GetWindow(GUIparent, "bg_kuang")
    local handle = GUI:GetWindow(_parent, "layout_desc")
    local box_w,box_h = 430,100
    if switch == "false" and not handle then
        return
    end
    if not handle and not switch then
        handle = GUI:Layout_Create(_parent, "layout_desc", Win_W - 525,Win_H - 235, box_w, box_h)
        GUI:Layout_setBackGroundColor(handle, "#000000")
        GUI:Layout_setBackGroundColorType(handle, 1)
        GUI:Layout_setBackGroundColorOpacity(handle, 255)
        for i,data in ipairs(str_List) do
            GUI:Text_Create(handle, "text_desc"..i, 5, box_h - 24 - 24 * (i - 1) , 16, data.color, data.str)
        end
    else
        GUI:removeFromParent(handle)
    end
end

--属性详情
function CityDonate.OpenAddattrDesc(param)
    local box_w,box_h = 240,60
    local index = param
    local _parent = GUI:GetWindow(GUIparent, "bg_kuang")
    local Rank_List = GUI:GetWindow(_parent, "Rank_List")
    local handle = GUI:GetWindow(Rank_List, "layout_RankList"..index.."/text_attr/attr_desc")
    if not handle then
        local layout_handle = GUI:GetWindow(Rank_List, "layout_RankList"..index)
        local text_attr = GUI:GetWindow(layout_handle, "text_attr")
        handle = GUI:Layout_Create(text_attr, "attr_desc", 25,15, box_w, box_h)
        GUI:setAnchorPoint(handle, 0.5, 0.5)
        GUI:Layout_setBackGroundColor(handle, "#000000")
        GUI:Layout_setBackGroundColorType(handle, 1)
        GUI:Layout_setBackGroundColorOpacity(handle, 255)
        for i,data in ipairs(cfg_sj[index].attribute1) do
            local Attr_List = SL:GetAttConfigByAttId(data[1])
            local str = ""
            if Attr_List.type == 1 then
                str = Attr_List.name..":"..data[2]
            else
                str = Attr_List.name..":"..data[2]/100 .."%"
            end
            local text_attrname = GUI:Text_Create(handle, "text_attr_desc"..i,   3 + 120 * ((i-1) % 2),  48  -  math.ceil(i/2) * 20 ,16 , Color_List[index],str)
            GUI:setTouchEnabled(text_attrname, true)
            GUI:addOnClickEvent(text_attrname, function()
                CityDonate.OpenAddattrDesc(param)
            end)
        end
    else
        GUI:removeFromParent(handle)
    end

end


--打开捐献二级界面
function CityDonate.OpendonateUI()
    local box_w,box_h = 350,200
    local _parent = GUI:GetWindow(GUIparent, "bg_kuang")
    local handle = GUI:Layout_Create(_parent, "layout_second", Win_W/2,Win_H/2, box_w, box_h)
    GUI:setAnchorPoint(handle, 0.5, 0.5)
    GUI:Layout_setBackGroundColor(handle, "#000000")
    GUI:Layout_setBackGroundColorType(handle, 1)
    GUI:Layout_setBackGroundColorOpacity(handle, 255)
    
    local img = GUI:Image_Create(handle, "second_bgimg", 0, 0, "res/custom/huishou/img_1.jpg")
    GUI:Image_setScale9Slice(img, 10, 10, 10, 10)
    GUI:setContentSize(img,{width = box_w,height = box_h})

    --创建关闭按钮
    local btn = GUI:Button_Create(handle, "second_btn_close", box_w - 22, box_h - 59, "res/01/010008.png")
    if btn then
        GUI:Button_loadTexturePressed(btn, "res/01/010009.png")   
        GUI:addOnClickEvent(btn, function()
            CityDonate.CloseSecond() --关闭二级界面
        end)
    end

    GUI:Text_Create(handle, "second_text1", 30, box_h - 50 , 18, "@ffffff", "请输入捐献的灵符数量：")



    --灵符数量背景图
    local img = GUI:Image_Create(handle, "second_bgnum", box_w/2, box_h/2, "res/custom/NTGM/img_di2.png")
    GUI:setAnchorPoint(img, 0.5, 0.5)

    --购买数量输入框
    local input_handle = GUI:TextInput_Create(handle, "second_input_text", box_w/2, box_h/2, 146, 20, 16) --146, 20
    GUI:setAnchorPoint(input_handle, 0.5, 0.5)
    GUI:TextInput_setMaxLength(input_handle, 9)
    GUI:TextInput_setInputMode(input_handle, 2)
    GUI:TextInput_setFontColor(input_handle,"#C0C0C0")
    local str = CityDonate.GetDondatenumStr(D_num)
    GUI:TextInput_setString(input_handle,str)
    GUI:TextInput_addOnEvent(input_handle, CityDonate.InputChange)

    --减少按钮
    local btn = GUI:Button_Create(handle, "second_btn_reduce", box_w/2 - 110, box_h/2, "res/custom/hecheng/btn_del_1.jpg")
    if btn then
        GUI:setAnchorPoint(btn, 0.5, 0.5)
        GUI:Button_loadTexturePressed(btn, "res/custom/hecheng/btn_del_2.jpg")
        GUI:addOnClickEvent(btn, function()
            CityDonate.ChangeNum(1)
        end)
    end
    --增加按钮
    local btn = GUI:Button_Create(handle, "second_btn_add", box_w/2 + 110, box_h/2, "res/custom/hecheng/btn_add_1.jpg")
    if btn then
        GUI:setAnchorPoint(btn, 0.5, 0.5)
        GUI:Button_loadTexturePressed(btn, "res/custom/hecheng/btn_add_2.jpg")
        GUI:addOnClickEvent(btn, function()
            CityDonate.ChangeNum(2)
        end)
    end

    --捐献按钮
    local btn = GUI:Button_Create(handle, "second_btn_buy", box_w/2, box_h/2 - 55, "res/01/010005.png")
    if btn then
        local text = GUI:Text_Create(btn, "second_btn_text", 54, 20, 16, "#FFFF66", "捐献")
        GUI:setAnchorPoint(text, 0.5, 0.5)
        GUI:setAnchorPoint(btn, 0.5, 0.5)
        GUI:Button_loadTexturePressed(btn, "res/01/010006.png")
        GUI:addOnClickEvent(btn, function()
            CityDonate.Donate()
        end)
    end

end

function CityDonate.ChangeNum(param)
    local isadd = param
    if isadd == 1 then--减少
        D_num = D_num - 1000 > 0 and D_num - 1000 or 1000
    else
        D_num = D_num + 1000 < 1000000000 and D_num + 1000 or D_num
    end

    local handle = GUI:GetWindow(nil, "QSQ_CityDonate/bg_kuang/layout_second/second_input_text")
    local str = CityDonate.GetDondatenumStr(D_num)
    GUI:TextInput_setString(handle,str)
end

--输入框监听事件
function CityDonate.InputChange(handle,editbox)
    if editbox == 0 then
        --began--进入
        GUI:TextInput_setString(handle,D_num)
    elseif editbox == 1 then
        --ended--退出
    elseif editbox == 2 then
        --changed--改变
    elseif editbox == 3 then
        --return--输出
        local num = tonumber(GUI:TextInput_getString(handle))
        D_num = num < 1000 and 1000 or num
        local str = CityDonate.GetDondatenumStr(D_num)
        GUI:TextInput_setString(handle,str)
    elseif editbox == 4 then
        --send--发送
    end
end


--捐献
function CityDonate.Donate()
    CityDonate.CloseSecond() --关闭二级界面
    SL:SubmitForm("D/沙城捐献","Donate",D_num)
end

function CityDonate.CloseSecond() --关闭二级界面
    local handle = GUI:GetWindow(nil, "QSQ_CityDonate/bg_kuang/layout_second")
    if handle then  
        GUI:removeFromParent(handle)
    end
end
function CityDonate.GetDondatenumStr(param)
    if not param then return end
    local str = param < 10000 and (param/1000) .. "千灵符" or (param >=100000000 and (param/100000000) .. "亿灵符" or (param/10000) .. "万灵符" )
    return str
end
function CityDonate.Hecheng(param)
    SL:SubmitForm("D/沙城捐献","Hecheng",param)
end    

