--------------------------------------------↓↓↓ 加载策划表 ↓↓↓--------------------------------------------
--合成表
cfg_compound = SL:RequireCsvCfg("cfg_compound")
local temp = {}
for k,v in ipairs(cfg_compound) do
    temp[v.page2] = temp[v.page2] or {title = v.name2}
    temp[v.page2][v.page3] = temp[v.page2][v.page3] or {}
    temp[v.page2][v.page3] = {
        idx = k,type = v.type,page2 = v.page2,page3 = v.page3,
        itemid1 = v.itemid1,product = v.product,name = v.name,probability = v.probability,
    }
end
cfg_compound = temp

--每日充值表
cfg_leichong_tsleic = SL:RequireCsvCfg("cfg_leichong_tsleic")
cfg_leichong_mr = SL:RequireCsvCfg("cfg_leichong_mr")

--每日限购表
cfg_mystery_store = SL:RequireCsvCfg("cfg_mystery_store")

--装备首爆表
cfg_shoubao = SL:RequireCsvCfg("cfg_shoubao")

--装备回收表
temp = SL:RequireCsvCfg("cfg_huishou_zhuangbei")
cfg_recycle = {}
for i,v in ipairs(temp) do
    cfg_recycle[v.type] = cfg_recycle[v.type] or {title = v.yeqian}
    cfg_recycle[v.type][v.type2] = cfg_recycle[v.type][v.type2] or {name = v.typename}
    cfg_recycle[v.type][v.type2][v.type3] = {
        idx = i,price = v.price,txt = v.txt,typename = v.typename,
        itemid = v.itemid,gouxuan = v.gouxuan,price1 = v.price1
    }
end

--免费会员表
cfg_xiuxian = SL:RequireCsvCfg("cfg_xiuxian")
cfg_goals = SL:RequireCsvCfg("cfg_goals")

--行会竞技表
cfg_hanghuijingji = SL:RequireCsvCfg("cfg_hanghuijingji")

--死亡复活表
cfg_fuhuo = SL:RequireCsvCfg("cfg_Fuhuo")

--游戏攻略表
cfg_gonglue = SL:RequireCsvCfg("cfg_gonglue")

--活动表
cfg_gameactive = SL:RequireCsvCfg("cfg_gameactive")
cfg_sbk = SL:RequireCsvCfg("cfg_sbk")
cfg_jifen_gift = {}
cfg_killer_gift = {}
cfg_daluandou_rewards = SL:RequireCsvCfg("cfg_daluandou_rewards")
for i,v in ipairs(cfg_daluandou_rewards) do
    if v.type == 1 then
        table.insert(cfg_jifen_gift,1,v)
    elseif v.type == 2 then
        table.insert(cfg_killer_gift,v)
    end
end
cfg_biaoche = SL:RequireCsvCfg("cfg_biaoche")
cfg_caiji = SL:RequireCsvCfg("cfg_caiji")
--------------------------------------------↓↓↓ 加载脚本 ↓↓↓--------------------------------------------
local OBJ_File = {
    "每日充值面板", "每日限购面板", "行会竞技面板", "装备首爆面板",
    "任务通用面板",
}
for _, name in ipairs(OBJ_File) do
    SL:Require("GUILayout/F/"..name)
end