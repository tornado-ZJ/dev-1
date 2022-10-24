cfg_qiandao = SL:RequireCsvCfg("cfg_qiandao")

temp = SL:RequireCsvCfg("cfg_fenjie")
cfg_fenjiee = {}
for i, v in ipairs(temp) do
cfg_fenjiee[v.leixing] = cfg_fenjiee[v.leixing] or { title = v.txt }
    table.insert(cfg_fenjiee[v.leixing], {
        harvest = v.harvest, beizhu = v.beizhu, equipid = v.equipid
    })
end
