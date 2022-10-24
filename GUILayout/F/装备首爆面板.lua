DropFirst = {}

local cfg_shoubao   = cfg_shoubao           --装备首爆表

local cfg_clone = clone(cfg_shoubao)

local _data = {}
--------------------------------------------↓↓↓ 本地方法 ↓↓↓--------------------------------------------
local _color = {[true] = "#FFFFB7",[false] = "#787974"}

local wnd_w,wnd_h = 540,450

local layout_h = 70

local handle

function DropFirst.getKeyValueTab(tab)
    local info = {}
    for _, v in ipairs(tab) do
        info[v[1]] = v
    end
    return info
end

--克隆一个排序过后的首爆表
function DropFirst.cloneShouBaoCfg(idx)
    if _data then

        cfg_clone = clone(cfg_shoubao)

        local bool = true

        local temp_top = {}
        local temp_down = {}
        for k = #cfg_clone, 1, -1 do
            bool = true
            local v = cfg_clone[k]
            local _v = clone(v)

            --服务端通知该道具领取状态/数量已更新
            if idx and v.item == idx then
                _data[v.item][3] = v.num
            end

            if v.num - _data[v.item][3] <= 0 and bool then
                table.remove(cfg_clone,k)
                table.insert(temp_down,_v)
                bool = false
            end

            if _data[v.item][2] == 1 and bool then
                table.remove(cfg_clone,k)
                table.insert(temp_top,_v)
                bool = false
            elseif _data[v.item][2] == 2 and bool then
                table.remove(cfg_clone,k)
                table.insert(temp_down,_v)
                bool = false
            end
        end
        for _, var in ipairs(temp_top) do
            table.insert(cfg_clone,1,var)
        end
        for _, var in ipairs(temp_down) do
            table.insert(cfg_clone,var)
        end
    end
end
--------------------------------------------↓↓↓ 网络消息 ↓↓↓--------------------------------------------
--同步信息
function DropFirst.SyncResponse(data)
    data = string.gsub(data, "'","")
    _data = SL:JsonDecode(data)
    _data = DropFirst.getKeyValueTab(_data)
    DropFirst.cloneShouBaoCfg()

    if not GUI:GetWindow(nil,"ActivityMain/layout_main/dropFirst") then
        DropFirst.createUI()
    end
end

function DropFirst.getGift(idx)
    SL:SubmitForm("F/装备首爆表单","RequestGetGift",idx)
end

--更新UI
function DropFirst.updataUI(data)
    data = string.gsub(data, "'","")
    data = SL:JsonDecode(data)
    local idx,state,dbnum = data[1],data[2],data[3]

    _data[idx][2] = state
    _data[idx][3] = dbnum

    DropFirst.cloneShouBaoCfg(idx)

    local layout_main = GUI:GetWindow(nil,"ActivityMain/layout_main")
    if layout_main  then
        GUI:removeAllChildren(layout_main)
    end
    DropFirst.createUI()
end
--------------------------------------------↓↓↓ UI创建 ↓↓↓--------------------------------------------
--一个cell的大小
function DropFirst.cellSizeForTable(table,idx)
    return wnd_w,layout_h
end

--指定创建cell的个数
function DropFirst.numberOfCellsInTableView(table)
    return cfg_shoubao and #cfg_shoubao or 50
end

 --点击cell的时候点击回调函数
function DropFirst.tableCellTouched(table,cell)
end

--创建cell用户可以再cell上添加其他的节点
function DropFirst.tableCellAtIndex(table, idx)
    local cell = table:dequeueCell()

    if not cell then
        cell = cc.TableViewCell:new()
    else
        cell:removeAllChildren()
    end

    local item_layout = GUI:GetWindow(nil,"ActivityMain/layout_main/dropFirst/Layout_item")
    if item_layout then
        local item_clone = item_layout:clone()
        GUI:setVisible(item_clone, true)

        local cfg = cfg_clone[idx + 1]

        if cfg then
            local itemidx,nums = cfg.gift[1][1],cfg.gift[1][2]
            local itemname = SL:GetItemNameByIndex(itemidx)

            local tx_yb = GUI:GetWindow(item_clone, "tx_yb")
            GUI:Text_setString(tx_yb, nums..itemname)

            local img_item = GUI:GetWindow(item_clone, "img_item")
            if img_item then
                local itemdata = {}
                itemdata.index = cfg.item                   --物品模板id
                itemdata.look  = true                   --是否显示tips
                itemdata.bgVisible = false              --是否显示背景框
                itemdata.count = 1                      --物品数量
                itemdata.color = 225                    --颜色
                handle = GUI:ItemShow_Create(img_item, "item"..idx, 0,0, itemdata)
                GUI:setScale(img_item, 0.7)
            end

            local btn = GUI:GetWindow(item_clone, "btn_getGift")
            if btn then
                GUI:addOnClickEvent(btn, function()
                    DropFirst.getGift(cfg.item)
                end)

                local info = _data[cfg.item]
                if info then
                    local tx_sy = GUI:GetWindow(item_clone, "tx_sy")
                    GUI:Text_setString(tx_sy, (cfg.num - info[3]) > 0 and (cfg.num - info[3]) or 0)

                    local img_redPonit = GUI:GetWindow(btn, "img_redPonit")
                    GUI:setVisible(img_redPonit, info[2] == 1)

                    local tx_btn = GUI:GetWindow(btn, "tx_btn")
                    if tx_btn then
                        GUI:Text_setTextColor(tx_btn, _color[info[2] == 1])
                        GUI:Button_setBright(btn,info[2] == 1)

                        if info[2] == 1 then
                            tx_btn:setString([[可 领 取]])
                        elseif info[2] == 2 then
                            tx_btn:setString([[已 领 取]])
                        elseif info[2] == 0 then
                            tx_btn:setString([[未 达 成]])
                        end
                    end
                end
            end
        end
        cell:addChild(item_clone)
    end
    return cell
end

function DropFirst.createUI()
    local _parent = GUI:GetWindow(nil,"ActivityMain/layout_main")
    if not _parent then return end
    _parent = GUI:Node_Create(_parent, "dropFirst", 0,0)
    if _parent then
        local layout = GUI:Layout_Create(_parent, "Layout_item",0,0, wnd_w,layout_h)
        if layout then

            handle = GUI:Image_Create(layout, "img_line",0,0, "res/custom/common/img_line_2.png")

            handle = GUI:Image_Create(layout, "img_item",25,layout_h / 2, "res/custom/common/img_cell_1.png")
            GUI:setAnchorPoint(handle, 0, 0.5)

            handle = GUI:Text_Create(layout, "tx_yb", 150,layout_h / 2, 16, "#FFFFB7", "1000元宝")
            GUI:setAnchorPoint(handle, 0, 0.5)

            handle = GUI:Text_Create(layout, "tx_sy", 300,layout_h / 2, 16, "#FFFFB7", "1000")
            GUI:setAnchorPoint(handle, 0, 0.5)

            handle = GUI:Button_Create(layout, "btn_getGift", 450,layout_h / 2, "res/01/010005.png")
            if handle then
                GUI:setAnchorPoint(handle, 0.5, 0.5)

                local txt_handle = GUI:Text_Create(handle, "tx_btn", 55,19, 16, "#FFFFB7", "领取奖励")
                GUI:setAnchorPoint(txt_handle, 0.5, 0.5)

                local img_handle = GUI:Image_Create(handle, "img_redPonit", 95,15, "res/custom/common/img_2.png")
                GUI:setScale(img_handle, 0.9)
            end
            GUI:setVisible(layout, false)
        end

        local tableView = cc.TableView:create(cc.size(wnd_w,wnd_h))

        tableView:setAnchorPoint(cc.p(0.5,0.5))

        tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)--cc.SCROLLVIEW_DIRECTION_HORIZONTAL横屏

        tableView:setPosition(cc.p(0,0))

        tableView:setDelegate()

        tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)

        tableView:setName("tableView")

        _parent:addChild(tableView)

        tableView:registerScriptHandler(DropFirst.tableCellTouched,cc.TABLECELL_TOUCHED)

        tableView:registerScriptHandler(DropFirst.cellSizeForTable,cc.TABLECELL_SIZE_FOR_INDEX)

        tableView:registerScriptHandler(DropFirst.tableCellAtIndex,cc.TABLECELL_SIZE_AT_INDEX)

        tableView:registerScriptHandler(DropFirst.numberOfCellsInTableView,cc.NUMBER_OF_CELLS_IN_TABLEVIEW)

        tableView:reloadData()
    end
end