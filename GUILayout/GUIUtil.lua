function TestGUIUtil()
    SL:Print("Hello World, This is GUIUtil!")
end

SL:Print("ssrmain init game world!")

function SLMainError(errinfo)
    if errinfo then 
        SL:Print("--------------------error-----------------------")
        SL:Print("--------------------error-----------------------")
        SL:Print("--------------------error-----------------------")
        SL:Print("--------------------error-----------------------")
        SL:Print(errinfo)
        SL:Print("--------------------error-------------------------")
        SL:Print("--------------------error-------------------------")
        SL:Print("--------------------error-------------------------")
        SL:Print("--------------------error-------------------------")
    end
end

function SL:RequireCsvCfg(path)  --加载策划表格
    return SL:Require("csvcfg/"..path)
end

function SL:RequireGameCfg(path)  --加载官方表格
    return SL:Require("game_config/"..path)
end

local function init()
    SL:Require("GUILayout/A/GUIinit")
    SL:Require("GUILayout/B/GUIinit")
    SL:Require("GUILayout/C/GUIinit")
    SL:Require("GUILayout/D/GUIinit")
    SL:Require("GUILayout/E/GUIinit")
    SL:Require("GUILayout/F/GUIinit")
    SL:Require("GUILayout/G/GUIinit")
end

local result, errinfo = pcall(init)
if not result then SLMainError(errinfo) end

------------全局方法
--local QSQ_Layout = SLGeneralInput(_parent,"QSQ_Layout",x,y,"str","#FFFFFF",0,ceshi.ok,false,false,6)  --一键创建通用输入框
-- function ceshi.ok(_parent,value_num)
--     SL:Print("value===",type(value_num),value_num)
-- end
--_parent： 父控件对象，ID： 控件id ，x： x坐标，y： y坐标，str： 标题，color：标题颜色，value：单位（1：10，2：100，3：1000，4：10000）
--strfun： 回调函数， type：输入类型 true/false （数字/文字）， pass：是否密码，long：输入框最大长度
function SLGeneralInput(_parent,ID,x,y,str,color,value,strfun,type,pass,long)
    local buyNum = 0
    color = color or "#D6C6AD"
    value = value or 0
    local value_str = ""
    local value_num = 1
    local value_tab = {"十","百","千","万","亿"}
    local value_tabnum  = {10,100,1000,10000,100000000}

    if value ~= 0 then
        value_str = value_tab[value]
        value_num = value_tabnum[value]
    end

    local mode = 0
    if type then
        mode = 2
    end

    local QSQ_Layout = GUI:Layout_Create(_parent, ID, x, y, 860, 440, false)
    if QSQ_Layout then
        GUI:setAnchorPoint(QSQ_Layout, 0.5, 0.5)
        GUI:setTouchEnabled(QSQ_Layout, true)
        GUI:addOnClickEvent(QSQ_Layout, function()
            GUI:setVisible(QSQ_Layout, false)
        end)

        local QSQ_Layout_bg = GUI:Image_Create(QSQ_Layout, "QSQ_Layout_bg", 453, 248, "res/input/input_1.png")
        if QSQ_Layout_bg then
            GUI:setContentSize(QSQ_Layout_bg,{width = 300, height = 195})
            GUI:setAnchorPoint(QSQ_Layout_bg, 0.5, 0.5)
            GUI:setTouchEnabled(QSQ_Layout_bg, true)
            GUI:addOnClickEvent(QSQ_Layout_bg, function()
            end)
        end

        local QSQ_Layout_close = GUI:Button_Create(QSQ_Layout, "QSQ_Layout_close", 590, 318, "res/input/input_2.png")
        if QSQ_Layout_close then
            GUI:setAnchorPoint(QSQ_Layout_close, 0.5, 0.5)
            GUI:setContentSize(QSQ_Layout_close,{width = 54, height = 68})
            GUI:Button_loadTexturePressed(QSQ_Layout_close,"res/input/input_3.png")
            GUI:addOnClickEvent(QSQ_Layout_close, function()
                GUI:setVisible(QSQ_Layout, false)
            end)
        end

        local QSQ_Layout_ok = GUI:Button_Create(QSQ_Layout, "QSQ_Layout_ok", 455, 175, "res/input/input_4.png")
        if QSQ_Layout_ok then
            GUI:setAnchorPoint(QSQ_Layout_ok, 0.5, 0.5)
            GUI:setContentSize(QSQ_Layout_ok,{width = 93, height = 30})               
            GUI:Button_loadTexturePressed(QSQ_Layout_ok,"res/input/input_5.png")
            local QSQ_Layout_ok_tx = GUI:Text_Create(QSQ_Layout_ok, "QSQ_Layout_ok_tx", 46, 16, 18, "#D6C6AD", "确  定")
            if QSQ_Layout_ok_tx then
                GUI:setAnchorPoint(QSQ_Layout_ok_tx, 0.5, 0.5)
            end
            GUI:addOnClickEvent(QSQ_Layout_ok, function()
                local strnum = buyNum
                if type then
                    strnum = buyNum*value_num
                end
                strfun(QSQ_Layout_ok,strnum)
            end)
        end

        if type then
            local QSQ_Layout_add = GUI:Button_Create(QSQ_Layout, "QSQ_Layout_add", 560, 244, "res/input/input_6.jpg")
            if QSQ_Layout_add then
                GUI:setAnchorPoint(QSQ_Layout_add, 0.5, 0.5)
                GUI:setContentSize(QSQ_Layout_add,{width = 36, height = 35})               
                GUI:Button_loadTexturePressed(QSQ_Layout_add,"res/input/input_7.jpg")
                GUI:addOnClickEvent(QSQ_Layout_add, function()
                    buyNum = SLInputsetNum(QSQ_Layout,1,type,long)
                end)
            end

            local QSQ_Layout_sub = GUI:Button_Create(QSQ_Layout, "QSQ_Layout_sub", 345, 244, "res/input/input_8.jpg")
            if QSQ_Layout_sub then
                GUI:setAnchorPoint(QSQ_Layout_sub, 0.5, 0.5)
                GUI:setContentSize(QSQ_Layout_sub,{width = 36, height = 35})               
                GUI:Button_loadTexturePressed(QSQ_Layout_sub,"res/input/input_7.jpg")
                GUI:addOnClickEvent(QSQ_Layout_sub, function()
                    buyNum = SLInputsetNum(QSQ_Layout,-1,type,long)
                end)
            end
        end

        local QSQ_Layout_tite = GUI:Text_Create(QSQ_Layout, "QSQ_Layout_tite", 452, 300, 18, color, str)
        if QSQ_Layout_tite then
            GUI:setAnchorPoint(QSQ_Layout_tite, 0.5, 0.5)
        end
        
        local QSQ_Layout_img = GUI:Image_Create(QSQ_Layout, "QSQ_Layout_img", 452, 244, "res/input/input_10.png")
        if QSQ_Layout_img then
            GUI:setContentSize(QSQ_Layout_img,{width = 121, height = 30})
            GUI:setAnchorPoint(QSQ_Layout_img, 0.5, 0.5)
            local QSQ_Layout_tite = GUI:Text_Create(QSQ_Layout_img, "QSQ_Layout_img_unit", 131, 16, 16, "#C0C0C0", value_str)
            if QSQ_Layout_tite then
                GUI:setAnchorPoint(QSQ_Layout_tite, 0.5, 0.5)
            end

            local QSQ_Layout_img_num = GUI:Text_Create(QSQ_Layout_img, "QSQ_Layout_img_num", 114, 16, 16, "#C0C0C0", "0")
            if QSQ_Layout_img_num then
                GUI:setAnchorPoint(QSQ_Layout_img_num, 1, 0.5)
            end

            local QSQ_Layout_img_input = GUI:TextInput_Create(QSQ_Layout_img, "QSQ_Layout_img_input", 61, 15.4, 116, 22, 16)
            if QSQ_Layout_img_input then
                GUI:setAnchorPoint(QSQ_Layout_img_input, 0.5, 0.5)
                if long then
                    GUI:TextInput_setMaxLength(QSQ_Layout_img_input, long)
                end

                if pass then
                    GUI:TextInput_setInputFlag(QSQ_Layout_img_input, 0)
                end

                GUI:TextInput_setInputMode(QSQ_Layout_img_input, mode)

                GUI:TextInput_addOnEvent(QSQ_Layout_img_input, function(QSQ_Layout_img_input,editbox)
                    if editbox == 0 then
                        local num = GUI:Text_getString(QSQ_Layout_img_num)
                        GUI:Text_setString(QSQ_Layout_img_input, num)
                    elseif editbox == 2 then
                        local num = GUI:Text_getString(QSQ_Layout_img_input) or 1
                        GUI:Text_setString(QSQ_Layout_img_input, num)
                    elseif editbox == 3 then
                        local num = GUI:Text_getString(QSQ_Layout_img_input) or 1
                        if pass then
                            GUI:Text_setString(QSQ_Layout_img_num, "******")
                        else
                            GUI:Text_setString(QSQ_Layout_img_num, num)
                        end
                        buyNum = num
                    end
                end)
                GUI:setLocalZOrder(QSQ_Layout_img_input,-1)
            end
        end
    end
    return QSQ_Layout
end

function SLInputsetNum(sender,num,type,long)
    if type then
        local QSQ_Layout_img_num = GUI:GetWindow(sender,"QSQ_Layout_img/QSQ_Layout_img_num")
        local num = QSQ_Layout_img_num:getString() + num
        if long then
            if #(tostring(num)) > long then return end
        end
        if num < 1 then
            num = 1
        end

        QSQ_Layout_img_num:setString(num)
        return num
    end
end


function GUIItemShow_Create(parent, ID, x, y, itemData)
    if itemData.makeindex then
        itemData.itemData = SL:GetItemDataByMakeIndex(itemData.makeindex)
    end
    return GUI:ItemShow_Create(parent, ID, x, y, itemData)
end




function serialize(obj)  --序列化
    local zlua = nil
    local lua = SL:JsonEncode(obj)
    lua = tostring(lua)
    if lua == "nil" or lua == "" then
        return zlua
    end

    zlua = "'"..lua.."'"

    return zlua
end

function unserialize(lua)  --反序列化
    lua = tostring(lua)
    local obj = nil
    if lua == "nil" or lua == "" then
        return obj
    end

    lua = string.gsub(lua, "'","")
    obj = SL:JsonDecode(lua)

    return obj
end




