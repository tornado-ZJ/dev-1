---在进入游戏时就读表 并将表进行适配111

------------------------------------------------------cfg_npcfunction--------------------------
local cfg = SL:RequireGameCfg("cfg_npclist")   --GUIinit.lua 当前方法执行 npc点击关联功能
cfg_npclist = cfg

--转换单位 10000 = 1万
function SLUnitBase(strnum)

    if strnum >= 10000 and  strnum < 100000000 then
        strnum = math.floor(strnum*0.001)*0.1
        strnum = tostring(strnum).."万"
    elseif strnum >= 100000000 then
        strnum = math.floor(strnum*0.0000001)*0.1
        strnum = tostring(strnum).."亿"
    end

    return strnum
end



--元宝：100/1000 （strdes：Anum/Bnum）
function SLChangeColour(Anum,Bnum,strdes)
    local a = "<font color='#E1BD70' size='16'>%s</font><font color='#C0C0C0' size='16'>：</font><font color='#4AE74A' size='16'>%s</font>"
    local b = "<font color='#E1BD70' size='16'>%s</font><font color='#C0C0C0' size='16'>：</font><font color='#FF0000' size='16'>%s</font>"
    local rtext_str = ""
    local A = SLUnitBase(Anum)
    local B = SLUnitBase(Bnum)

    if Anum >= Bnum then
        rtext_str = string.format(a, strdes,A.."/"..B)
    else
        rtext_str = string.format(b, strdes,A.."/"..B)
    end

    return rtext_str
end


--[[
    @desc: 配置表属性转客户端显示数据
    --@attr: table 配置表属性
    --@chnum: chnum 属性名中间的空格数
    @return: table 客户端显示数据
]]
local cfg_att_score = SL:RequireGameCfg("cfg_att_score")
local _attrgroup = {{5,6},{9,10},{13,14},{17,18},{21,22}}        --属性组：攻击 魔法 道术 防御 魔御 的下上限idx
local _attrname = {[5]="攻%s击", [9]="魔%s法", [13]="道%s术", [17]="防%s御", [21]="魔%s御"}
function SLAttrToClient(attr, chnum)
   
    --深拷贝表
    local newattr = clone(attr)
    local attridxs = {}
    for i,v in ipairs(newattr) do
        attridxs[i] = tonumber(v[1])
    end

    --重组属性
    for _,v in ipairs(_attrgroup) do
        local loweridx, upperidx =  v[1], v[2]
        local lower, upper = table.indexof(attridxs, loweridx), table.indexof(attridxs, upperidx)
        if lower and upper then                 --同时有某上下限属性
            table.remove(attridxs, upper)
            local upper_attr = table.remove(newattr, upper)
            table.insertto(newattr[lower], upper_attr)
        elseif lower and not upper then         --有下限属性
            table.insertto(newattr[lower], {loweridx+1, 0})
        elseif not lower and upper then         --有上限属性
            table.insert(newattr[upper], 0, 1)
            table.insert(newattr[upper], upperidx-1, 1)
        end
    end

    --转显示属性
    local showattr = {}
    for i,v in ipairs(newattr) do
        local idx = tonumber(v[1])
        local name = _attrname[idx] or cfg_att_score[idx].name

        local value = ""
        --下限 上限 值
        local attrvalue1, attrvalue2 = v[2], v[4]

        if not attrvalue2 then
            local type = cfg_att_score[idx].type or 1
            if type == 1 then
                value = attrvalue1..""
            elseif type == 2 then--万分比
                value = (attrvalue1 / 100) .. "%"
            end
        end

        if attrvalue2 then
            local ch = ""
            if chnum and chnum > 0 then
                for i=1,chnum do ch = ch.."　" end
            end
            name = string.format(name, ch)
            if attrvalue2 == 0 then
                value = attrvalue1
            else
                value = attrvalue1.."-"..attrvalue2
            end
        end
        name = name .. "："
        showattr[i] = {name=name, value=value}
    end

    return showattr
end

--更新属性显示
--cfg 需要更新的属性表
--num 更新的数量
--root 根控件
--attrname 属性名控件id前缀
--valuename 属性值控件id前缀
--chnum 递增值
function SLUpdateAttrShow(cfg, num, root, attrname, valuename, chnum)
    table.sort(cfg, function(a,b) return a[1] < b[1] end)
    local cattr = SLAttrToClient(cfg, chnum)
    for i=1,num do
        local attr = cattr[i]
        local names = GUI:GetWindow(root,attrname..i)
        local values = GUI:GetWindow(root,valuename..i)
        if attr then
            GUI:setVisible(names,true)
            GUI:setVisible(values,true)
            GUI:Text_setString(names,attr.name)
            GUI:Text_setString(values,attr.value)
        else
            GUI:setVisible(names,false)
            GUI:setVisible(values,false)
        end
    end
end


--npc关联功能
function SLnpcfunction(data)
    local tstr = cfg_npclist[data.index].sScript

    local tab = string.split(tstr, ":")
    if #tab == 2 then
        SL:SubmitForm(tab[1],tab[2],data.index)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "客户端点击npc时", SLnpcfunction)





function SLStrSplit2(str, reps)
    -- ssrPrint(debug.traceback())
	local r = {}
	if str == nil then return nil end
	string.gsub(str, "[^"..reps.."]+", function(w) table.insert(r, tonumber(w) or w ) end)
    return r
end

--repsArr  切割符 {"|","#"}|：第一切割 #：第二切割
-- att = "3#1#4260|3#3#36|3#4#76"
--解析为
-- att = {
--     [1] = {
--         [1] = 3,
--         [2] = 1,
--         [3] = 4260,
--     },
--     [2] = {
--         [1] = 3,
--         [2] = 3,
--         [3] = 36,
--     },
--     [3] = {
--         [1] = 3,
--         [2] = 4,
--         [3] = 76,
--     },
-- },
--切割字符串
function SLStrSplitByMore(str, repsArr)
    if #repsArr < 1 then
        return tonumber(str) or str
    end
    local repsArrCopy = {}

    for k,v in ipairs(repsArr) do
        repsArrCopy[k] = v
    end
    
    local r = SLStrSplit2(str,repsArrCopy[1])
    table.remove(repsArrCopy, 1)
    
    for k,v in ipairs(r) do
        r[k] = SLStrSplitByMore(v,repsArrCopy)
    end
    
    return r
end

