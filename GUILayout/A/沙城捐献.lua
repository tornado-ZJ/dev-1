shachengjuanxian = {}
local cfg = {
    name = "沙城捐献",
    shuxing = {

    },
    effectid = 30117,
    rankshuxing = {
        [1] = {

        },
        [2] = {

        },
        [3] = {

        }
    }
}

local Color_List = { "#ff0000", "#ff9900", "#ffff00", "#FF33CC", "#99CC0", "#FF9966", "#FFFFCC", "#336699", "#666666", "#FF6666" }

local GUIparent = ""
juanxian_data = {}
juanxian_tab = {}
juanxian_number = 0
juanxian_zongshu = 0
local Win_W, Win_H = 815, 575
shachengjuanxian.main = function()
    --SL:print("main")
    SL:SubmitForm("A/沙城捐献", "SyncResponse")
end
shachengjuanxian.main()
----同步信息
function shachengjuanxian.SyncResponse(data)
    --SL:print("SyncResponse")
    if not data then
        return
    end
    receiveList = SL:JsonDecode(data)
    --排行前三
    juanxian_tab = receiveList[1]
    --我的捐献数量
    juanxian_number = receiveList[2]
    --总捐献数量
    juanxian_zongshu = receiveList[3]
    --整合排行榜信息
    for i = 1, math.ceil(#juanxian_tab / 2) do
        juanxian_data[i] = { money = juanxian_tab[i * 2], name = juanxian_tab[i * 2 - 1] }
    end
    --SL:print(data)
    if not GUI:GetWindow(nil, "shachengjuanxian") then
        shachengjuanxian.createUI()
    else
        shachengjuanxian.updateUI()
    end
end

shachengjuanxian.createUI = function()
    local _parent = GUI:Win_Create("shachengjuanxian", 0, 0, 0, 0, false, false, true, false)
    if _parent then
        GUI:Timeline_Window1(_parent)
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
        local bg_close = GUI:Image_Create(_parent, "bg_close", 0, 0, "res/ui/npc/沙城捐献/1.png")
        if bg_close then
            GUI:setContentSize(bg_close, { width = w, height = h })
            GUI:setTouchEnabled(bg_close, true)
            GUI:addOnClickEvent(bg_close, function()
                GUI:Win_Close(_parent)
            end)
        end
        --背景框
        local img_bg = GUI:Image_Create(_parent, "img_bg", 111.00, 40.00,"res/ui/npc/沙城捐献/2.png")
        GUI:setContentSize(img_bg, 815, 575)
        GUI:setIgnoreContentAdaptWithSize(img_bg, false)
        GUI:setTouchEnabled(img_bg, true)
        GUI:setTag(img_bg, -1)

        -- Create 标题
        local text_title = GUI:Text_Create(_parent, "text_title", 223.00, 537.00, 20, "#ffeed9", [[沙城捐献]])
        GUI:setTouchEnabled(text_title, false)
        GUI:setTag(text_title, -1)

        -- Create 关闭按钮
        local btn_close = GUI:Button_Create(_parent, "btn_close", 856.00, 510.00, "res/ui/npc/沙城捐献/3.png")
        GUI:Button_loadTexturePressed(btn_close, "res/ui/npc/沙城捐献/4.png")
        GUI:Button_loadTextureDisabled(btn_close, "res/private/gui_edit/Button_Disable.png")
        GUI:setTouchEnabled(btn_close, true)
        GUI:setTag(btn_close, -1)
        GUI:addOnClickEvent(btn_close, function()
            GUI:Win_Close(_parent)
        end)

        -- 标题 背景
        local img_biaoti = GUI:Image_Create(_parent, "img_biaoti", 168.00, 474.00, "res/ui/npc/沙城捐献/5.png")
        GUI:setContentSize(img_biaoti, 700, 60)
        GUI:setIgnoreContentAdaptWithSize(img_biaoti, false)
        GUI:setTouchEnabled(img_biaoti, false)
        GUI:setTag(img_biaoti, -1)

        -- 标题 排名
        local text_biaoti_juanxianpaihang = GUI:Text_Create(img_biaoti, "text_biaoti_juanxianpaihang", 44.00, 16.00, 22, "#b9a988", [[捐献排行]])
        GUI:setTouchEnabled(text_biaoti_juanxianpaihang, false)
        GUI:setTag(text_biaoti_juanxianpaihang, -1)

        -- 标题 名字
        local text_biaoti_wanjiamingzi = GUI:Text_Create(img_biaoti, "text_biaoti_wanjiamingzi", 199.00, 16.00, 22, "#b9a988", [[玩家名字]])
        GUI:setTouchEnabled(text_biaoti_wanjiamingzi, false)
        GUI:setTag(text_biaoti_wanjiamingzi, -1)

        -- 标题 数量
        local text_biaoti_juanxianshuliang = GUI:Text_Create(img_biaoti, "text_biaoti_juanxianshuliang", 354.00, 16.00, 22, "#b9a988", [[捐献数量]])
        GUI:setTouchEnabled(text_biaoti_juanxianshuliang, false)
        GUI:setTag(text_biaoti_juanxianshuliang, -1)

        -- 标题 属性
        local text_biaoti_shuxing = GUI:Text_Create(img_biaoti, "text_biaoti_shuxing", 509.00, 16.00, 22, "#b9a988", [[属性]])
        GUI:setTouchEnabled(text_biaoti_shuxing, false)
        GUI:setTag(text_biaoti_shuxing, -1)

        -- 排行榜 容器
        local layer_qiansanming = GUI:ListView_Create(_parent, "layer_qiansanming", 179.00, 238.00, 680.00, 230.00, 1)
        GUI:ListView_setBackGroundColorType(layer_qiansanming, 1)
        GUI:ListView_setBackGroundColor(layer_qiansanming, "#9696ff")
        GUI:ListView_setBackGroundColorOpacity(layer_qiansanming, 0)
        GUI:setTouchEnabled(layer_qiansanming, true)
        GUI:setTag(layer_qiansanming, -1)
        --排行榜具体信息
        if layer_qiansanming then
            for i = 1,3 do
                local layout_handle = GUI:Layout_Create(layer_qiansanming, "layout_RankList"..i, 0,0, 690, 65)
                local img_line = GUI:Image_Create(layout_handle, "img_line", 0, 0, "res/ui/npc/沙城捐献/9.png")
                local text =GUI:Text_Create(layout_handle, "text_rank", 105 - 20 + 150 * (1-1), 20, 20, Color_List[i], "NO."..i)--排名
                GUI:setAnchorPoint(text, 0.5, 0)
                local str = juanxian_data[i] == nil and "暂无" or juanxian_data[i].name
                local text = GUI:Text_Create(layout_handle, "text_name", 105 - 20 + 150 * (2-1), 20, 20, Color_List[i], str)--名字
                GUI:setAnchorPoint(text, 0.5, 0)
                local str = juanxian_data[i] == nil and "0" or juanxian_data[i].money
                local text = GUI:Text_Create(layout_handle, "text_money", 105 - 20 + 150 * (3-1), 20, 20, Color_List[i], str)--捐献数量
                GUI:setAnchorPoint(text, 0.5, 0)
                local text = GUI:Text_Create(layout_handle, "text_attr", 105 - 20 + 150 * (4-1), 20, 20, Color_List[i], "属 性")--属性
            end
        end

        -- Create 捐献说明
        local img_shuoming = GUI:Image_Create(_parent, "img_shuoming", 168.00, 156.00, "res/ui/npc/沙城捐献/5.png")
        GUI:setContentSize(img_shuoming, 700, 100)
        GUI:setIgnoreContentAdaptWithSize(img_shuoming, false)
        GUI:setTouchEnabled(img_shuoming, false)
        GUI:setTag(img_shuoming, -1)
        local str = "<font color='#77ef67'>（1）单次捐献至少100RMB点</font>"
        GUI:RichText_Create(img_shuoming, "rich_shuoming", 20,60,str,500,20,nil,nil,nil)

        --  当前奖池
        local text_dangqianjiangchi = GUI:Text_Create(_parent, "text_dangqianjiangchi", 197.00, 114.00, 22, "#ffeed9", [[当前奖池:]])
        GUI:setTouchEnabled(text_dangqianjiangchi, false)
        GUI:setTag(text_dangqianjiangchi, -1)

        -- 当前奖池数量
        local text_dangqianjiangchi_number = GUI:Text_Create(_parent, "text_dangqianjiangchi_number", 301.00, 114.00, 22, "#02aae1", math.ceil(0.6 * juanxian_zongshu))
        GUI:setTouchEnabled(text_dangqianjiangchi_number, false)
        GUI:setTag(text_dangqianjiangchi_number, -1)

        -- 我的捐献
        local text_wodejuanxian = GUI:Text_Create(_parent, "text_wodejuanxian", 415.00, 114.00, 22, "#ffeed9", [[我的捐献:]])
        GUI:setTouchEnabled(text_wodejuanxian, false)
        GUI:setTag(text_wodejuanxian, -1)

        -- 我的捐献数量
        local text_wodejuanxian_number = GUI:Text_Create(_parent, "text_wodejuanxian_number", 519.00, 114.00, 22, "#02aae1", juanxian_number)
        GUI:setTouchEnabled(text_wodejuanxian_number, false)
        GUI:setTag(text_wodejuanxian_number, -1)

        -- Create 捐献输入框背景图
        local img_bg_juanxianshuliang = GUI:Image_Create(_parent, "img_bg_juanxianshuliang", 585.00, 119.00, "res/ui/npc/沙城捐献/8.png")
        GUI:setContentSize(img_bg_juanxianshuliang, 120, 25)
        GUI:setIgnoreContentAdaptWithSize(img_bg_juanxianshuliang, false)
        GUI:setTouchEnabled(img_bg_juanxianshuliang, false)
        GUI:setTag(img_bg_juanxianshuliang, -1)

        -- 捐献数量输入框
        local img_bg_juanxianshuliang = GUI:TextInput_Create(img_bg_juanxianshuliang, "img_bg_juanxianshuliang", 0.00, 0.00, 120.00, 25.00, 16)
        GUI:TextInput_setString(img_bg_juanxianshuliang, "")
        GUI:TextInput_setPlaceHolder(img_bg_juanxianshuliang, "请输入捐献数量")
        GUI:setTouchEnabled(img_bg_juanxianshuliang, true)
        GUI:setTag(img_bg_juanxianshuliang, -1)
        -- Create 捐献按钮
        local btn_juanxian = GUI:Button_Create(_parent, "btn_juanxian", 734.00, 114.00, "res/ui/npc/沙城捐献/6.png")
        GUI:Button_loadTexturePressed(btn_juanxian,  "res/ui/npc/沙城捐献/7.png")
        GUI:Button_loadTextureDisabled(btn_juanxian, "res/private/gui_edit/Button_Disable.png")
        GUI:Button_setTitleColor(btn_juanxian, "#ffeed9")
        GUI:Button_setTitleFontSize(btn_juanxian, 18)
        GUI:Button_setTitleText(btn_juanxian, "捐献")
        GUI:setTouchEnabled(btn_juanxian, true)
        GUI:setTag(btn_juanxian, -1)
        GUI:addOnClickEvent(btn_juanxian, function()
            local number = tonumber(GUI:TextInput_getString(img_bg_juanxianshuliang))
            if not number then
                SL:ShowSystemTips("请输入捐献数量")
                return
            end
            if number < 0 then
                SL:ShowSystemTips("捐献数量不合法！")
                return
            end
            if number < 100 then
                SL:ShowSystemTips("单次捐献至少100！")
                return
            end
            --SL:ShowSystemTips(tostring(GUI:TextInput_getString(img_bg_juanxianshuliang)))
            SL:SubmitForm("A/沙城捐献", "Juanxian", number)
        end)
    end
end

function shachengjuanxian.updateUI()
    local _parent = GUIparent
    --当前奖池
    GUI:Text_setString(GUI:GetWindow(_parent, "text_dangqianjiangchi_number"), math.ceil(0.6*juanxian_zongshu))
    GUI:Text_setString(GUI:GetWindow(_parent, "text_wodejuanxian_number"), juanxian_number)
    local layer_qiansanming = GUI:GetWindow(_parent, "layer_qiansanming")
    GUI:removeAllChildren(layer_qiansanming)
    --排行榜具体信息
    if layer_qiansanming then
        for i = 1,3 do
            local layout_handle = GUI:Layout_Create(layer_qiansanming, "layout_RankList"..i, 0,0, 690, 65)
            local img_line = GUI:Image_Create(layout_handle, "img_line", 0, 0, "res/custom/shajuan/shajuan_1.png")

            local text =GUI:Text_Create(layout_handle, "text_rank", 105 - 20 + 150 * (1-1), 20, 20, Color_List[i], "NO."..i)--排名
            GUI:setAnchorPoint(text, 0.5, 0)
            local str = juanxian_data[i] == nil and "暂无" or juanxian_data[i].name
            local text = GUI:Text_Create(layout_handle, "text_name", 105 - 20 + 150 * (2-1), 20, 20, Color_List[i], str)--名字
            GUI:setAnchorPoint(text, 0.5, 0)
            local str = juanxian_data[i] == nil and "0" or juanxian_data[i].money
            local text = GUI:Text_Create(layout_handle, "text_money", 105 - 20 + 150 * (3-1), 20, 20, Color_List[i], str)--捐献数量
            GUI:setAnchorPoint(text, 0.5, 0)
            local text = GUI:Text_Create(layout_handle, "text_attr", 105 - 20 + 150 * (4-1), 20, 20, Color_List[i], "属 性")--属性
        end
    end
end

