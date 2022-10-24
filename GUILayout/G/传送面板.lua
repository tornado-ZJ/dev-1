Deliver = {}

local cfg_deliver = cfg_deliver
local cfg_map_npc = cfg_map_npc

if cfg_deliver then
    print("读取配置文件cfg_deliver成功")
else
    print("读取配置文件cfg_deliver失败")
end

if cfg_map_npc then
    print("读取配置文件cfg_map_npc成功")
else
    print("读取配置文件cfg_map_npc失败")
end


local cfg_npc = {} --怪物地图信息
local cfg_del = {} -- 怪物传送信息
local cfg_effect = {} --怪物特效
local npcId = 0

local GUIparent = ""


Deliver.config = function()
    npcId = tonumber(SL.FormParam[1])
    for _, v in ipairs(cfg_map_npc) do
        if v.npcidx == npcId then
            cfg_npc = v
        end
    end

    for _, v in ipairs(cfg_deliver) do
        if v.id == cfg_npc.Id then
            cfg_del = v
        end
    end
end

Deliver.config()

Deliver.main =function()
    local _parent = GUI:Win_Create("deliver", 0, 0, 0, 0, false, false, true, false)
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

        --点击面板以外区域关闭面板
        local bg_close = GUI:Image_Create(_parent, "bg_close", 0, 0, "res/01/010010.png")
        if bg_close then
            GUI:setContentSize(bg_close, {width = w, height = h})
            GUI:setTouchEnabled(bg_close, true)
            GUI:addOnClickEvent(bg_close, function()
                GUI:Win_Close(_parent)
            end)
        end

        --设置面板框图片
        local bg_Mbkuang = GUI:Image_Create(_parent, "bg_Mbkuang", 145, 45, "res/01/010000.png")
        if bg_Mbkuang then
            GUI:setContentSize(bg_Mbkuang, {width = 815, height = 575})
            GUI:setTouchEnabled(bg_Mbkuang, true)
        end

        --设置关闭按钮
        local btn_close = GUI:Button_Create(_parent, "btn_close", 870, 515, "res/01/010008.png")
        if btn_close then
            GUI:Button_loadTexturePressed(btn_close, "res/01/010009.png")
            GUI:addOnClickEvent(btn_close, function()
                GUI:Win_Close(_parent)
            end)
        end

        --设置背景
        local bg_deliver = GUI:Image_Create(_parent, "bg_deliver", 200, 66, "res/custom/common/019.jpg")
        if bg_deliver then
            GUI:setContentSize(bg_deliver, {width = 700, height = 470})
        end

        --设置界面标题
        local title_deliver = GUI:Text_Create(_parent, "title_deliver", 510, 555, 20, "#D6C6AD", cfg_npc.mapname)

        --介绍标题
        local title_intro = GUI:Text_Create(_parent, "title_intro", 780,500,20, "#D6C6AD","介  绍")

        --介绍内容
        local intro = GUI:RichText_Create(_parent, "intro", 750, 320, cfg_npc.mapDesc, 150, 16,nil, nil )
        --特效
        GUI:Effect_Create(_parent, "effect_deliver", 320, 450, 0, cfg_npc.img)

        --掉落展示
        for i = 1, #cfg_npc.yulan do

            local itemdata = {}
            itemdata.index = cfg_npc.yulan[i]
            itemdata.look = true
            itemdata.bgVisible = true
            itemdata.count = 1
            itemdata.showModelEffect = true

            local item_diaoluo = GUI:ItemShow_Create(_parent, "item_diaoluo"..i, 300+70*(i-1), 120, itemdata)
            if item_diaoluo then
                GUI:setAnchorPoint(item_diaoluo, 0.5, 0.5)
            end
        end

        --消耗
        local cost_text = ""
        local cost_name = ""
        local cost_num = ""
        local text_btn =""
        if cfg_del.cost ~= nil then
            cost_text = "消耗"
            cost_name = SL:GetItemNameByIndex(cfg_del.cost[1][1])
            cost_num = SLUnitBase(cfg_del.cost[1][2])
            text_btn = cfg_npc.anniu
        else
            text_btn = "免费进入"
        end
        local cost = GUI:Text_Create(_parent, "xiaohao", 740, 130, 16, "#D6C6AD", cost_text..cost_num..cost_name)
        --按钮
        local btn_deliver = GUI:Button_Create(_parent, "btn_deliver", 750, 80, "res/01/010005.png")
        if btn_deliver then
            --按钮文本
            local text_btn_deliver = GUI:Text_Create(btn_deliver, "text_btn_deliver", 55, 20, 16, "#D6C6AD", text_btn)
            GUI:setAnchorPoint(text_btn_deliver, 0.5, 0.5)
            GUI:Button_loadTexturePressed(btn_deliver, "res/01/010006.png")
            GUI:addOnClickEvent(btn_deliver, function()
                Deliver.chuansong(cfg_npc.Id)
            end)
        end
    end
end

Deliver.chuansong = function(id)
    --传入cfg_map_npc的id用于查找对应cfg_deliver中的地图
    if id then
        SL:SubmitForm("G/传送", "MapMove", id)
        SL:RegisterLUAEvent("LUA_EVENT_CHANGESCENE", "注册传送事件", Deliver.close)
    end
end

Deliver.close =function()
    GUI:Win_Close(GUIparent)
end

Deliver.main()


