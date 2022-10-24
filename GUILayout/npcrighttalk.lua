npcrighttalk = {}

local cfg_npc_talk = SL:RequireCsvCfg("cfg_npc_talk")     --npcrighttalk.lua


local npcid = tonumber(SL.FormParam[1])
local str = SL.FormParam[2]
local tab = SL.FormParam[3]

npcrighttalk.main = function()


    local cfg_npc = cfg_npc_talk[npcid]
    local _parent = GUI:Win_Create("QSQ_npcrighttalk", 0, 0, 0, 0, true, false, true, false)
    if _parent then
        local winSize = SL:GetScreenSize()
        local x = winSize.width / 2
        local y = winSize.height / 2
        local w = winSize.width
        local h = winSize.height

        local layout = GUI:Layout_Create(_parent, "diban", x, y, w, h)
        if layout then
            GUI:setAnchorPoint(layout, 0.5, 0.5)
        end
----------关闭背景act-----------------
        local bg_close = GUI:Image_Create(_parent, "bg_close", 0, 0, "res/01/010010.png")
        if bg_close then
            GUI:setContentSize(bg_close, {width = w, height = h})
            GUI:setTouchEnabled(bg_close, true)
            GUI:addOnClickEvent(bg_close, function()
                SL:SubmitForm("传送员", "blaobingok")

                GUI:Win_Close(_parent)
            end)
        end

----------界面框背景act-----------------
        local bg_kuang = GUI:Image_Create(_parent, "bg_kuang", 700, 30, "res/01/010032.png")
        if bg_kuang then
            GUI:setTouchEnabled(bg_kuang, true)
        end

        local bg_jiao = GUI:Image_Create(_parent, "bg_jiao", 693,30, "res/01/010031.png")
        if bg_jiao then
            GUI:setContentSize(bg_jiao,{width = 400, height = 522})
            GUI:Image_setScale9Slice(bg_jiao, 10, 10, 10, 10)
            GUI:setTouchEnabled(bg_jiao, true)
        end
        local bg_title = GUI:Image_Create(_parent, "bg_title", 735,508, "res/01/010030.png")
        if bg_title then
            GUI:setTouchEnabled(bg_title, true)
        end

        GUI:Image_Create(_parent, "bg_xian", 700,200, "res/01/010035.png")


----------界面关闭按钮act-----------------
        local btn_close = GUI:Button_Create(_parent, "btn_close", 1050, 503, "res/01/010033.png")
        if btn_close then
            GUI:Button_loadTexturePressed(btn_close, "res/01/010034.png")
            GUI:addOnClickEvent(btn_close, function()
                SL:SubmitForm("传送员", "blaobingok")

                GUI:Win_Close(_parent)
            end)
        end

----------界面标题act-----------------
        local title = GUI:Text_Create(_parent, "title", 890, 530, 20, cfg_npc.title_color, cfg_npc.title)
        if title then
            GUI:setAnchorPoint(title, 0.5, 0.5)
        end


----------描述act-----------------
        local rtx_xiaohao = GUI:RichText_Create(_parent, "xiaohao", 900, 450, cfg_npc.msg, 340)
        if rtx_xiaohao then
            GUI:setAnchorPoint(rtx_xiaohao, 0.5, 0.5)
        end

----------物品act-----------------
        local item_tab = cfg_npc.item
        if item_tab then
            local LV_item = GUI:ListView_Create(_parent, "LV_item", 710, 120, 370, 80, 2)
            if LV_item then
                for i=1,#item_tab do
                    local data = {}
                    data.index = item_tab[i][1]
                    data.look  = true
                    data.bgVisible = true
                    data.count = item_tab[i][2]
                    data.color = 255
                    local item_kg = GUI:Layout_Create(LV_item, "item_kg"..i, 0, 0, 80, 80)
                    local itemhanld = GUI:ItemShow_Create(item_kg, "item_"..i, 0, 5, data)
                    GUI:setScale(itemhanld, 1.2)
                end
            end
        end


----------按钮act-----------------
        local btn_zs = GUI:Button_Create(_parent, "btn_zs", 830, 60, "res/01/010005.png")
        if btn_zs then
            local tx_btn_zs = GUI:Text_Create(btn_zs, "tx_btn_zs", 55, 20, 18, "#D6C6AD", "确    定")
            GUI:setAnchorPoint(tx_btn_zs, 0.5, 0.5)
            GUI:Button_loadTexturePressed(btn_zs, "res/01/010006.png")
            GUI:addOnClickEvent(btn_zs, function()
                SL:SubmitForm("传送员", "blaobingok")
            end)
        end
    end
end


function npcrighttalk.UIint(tab)
    dump(tab)

end


-- -- avoid memory leak
-- collectgarbage("setpause", 100)
-- collectgarbage("setstepmul", 5000)



npcrighttalk.main()
















