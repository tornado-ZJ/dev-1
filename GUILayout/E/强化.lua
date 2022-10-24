<form>
	<dialog id="QSQ_Qianghua" x=0 y=0 w=0 h=0  OnInit=Qianghua.Init >
        <Image id="bg_close" x=0 y=0 w=1136 h=640 revmsg=true image="res/01/010010.png" OnClick=Qianghua.close />
        <Image id="bg_kuang" x=142 y=45 w=815 h=575  revmsg=true image="res/01/010000.png" OnClick=Qianghua.btn />
		<Image id="bg_bagua" x=203 y=66 w=692 h=446 image="res/04/040048.jpg" />

		<Text id="title" x=520 y=558 text="强  化"  size =20 color="#D6C6AD" />
	</dialog>
	<script>
        Qianghua = {}
		local Handle = ""
		local qianghua_tab = cfg_qianghuadz
		local equip_page1 = 0

		local qh_tab = unserialize(SL.FormParam[1])

		function Qianghua.Init(this)
			Handle = this
			local bg_bagua = GUI:GetWindow(Handle,"bg_bagua")
			if bg_bagua then
				GUI:removeAllChildren(bg_bagua)
				GUI:setOpacity(bg_bagua,255)
			end

			local equip_di1 = GUI:Image_Create(bg_bagua,"equip_di1",130,200,"res/04/040052.png")
			if equip_di1 then
				local tx_atlsas = GUI:TextAtlas_Create(equip_di1, "tx_atlsas", 94, 11.5, 0, "res/04/040053.png", 12, 21, 0)
				if tx_atlsas then
					GUI:setScale(tx_atlsas, 0.75)
					GUI:setAnchorPoint(tx_atlsas, 0, 0.5)
					local size = GUI:getContentSize(tx_atlsas)
					local equip_bf = GUI:Image_Create(tx_atlsas,"equip_bf",size.width,10,"res/04/040054.png")
					if equip_bf then
						GUI:setAnchorPoint(equip_bf,0,0.5)
						GUI:setScale(equip_bf, 1.3)
					end
				end
			end


			local equip_di2 = GUI:Image_Create(bg_bagua,"equip_di2",50,40,"res/04/040051.png")
			if equip_di2 then
				GUI:setContentSize(equip_di2,{width = 273, height = 140})
				local equip_di2_dq = GUI:Image_Create(equip_di2,"equip_di2_dq",65,95,"res/04/040055.png")
				if equip_di2_dq then
					for i=1,3 do
						local sxname = GUI:Text_Create(equip_di2_dq, "sxname"..i, 100, 50-(i*16), 14, "#9EC5EC", "生    命 :")
						GUI:setAnchorPoint(sxname,1,0.5)
						GUI:setVisible(sxname,false)

						local sxvalue = GUI:Text_Create(equip_di2_dq, "sxvalue"..i, 100, 50-(i*16), 14, "#C0C0C0", "0")
						GUI:setAnchorPoint(sxvalue,0,0.5)
						GUI:setVisible(sxvalue,false)
					end
				end

				local equip_di2_nx = GUI:Image_Create(equip_di2,"equip_di2_nx",65,16,"res/04/040056.png")
				if equip_di2_nx then
					for i=1,3 do
						local nsxname = GUI:Text_Create(equip_di2_nx, "nsxname"..i, 100, 50-(i*16), 14, "#9EC5EC", "生    命 :")
						GUI:setAnchorPoint(nsxname,1,0.5)
						GUI:setVisible(nsxname,false)


						local nsxvalue = GUI:Text_Create(equip_di2_nx, "nsxvalue"..i, 100, 50-(i*16), 14, "#C0C0C0", "0")
						GUI:setAnchorPoint(nsxvalue,0,0.5)
						GUI:setVisible(nsxvalue,false)

					end
				end
				GUI:Image_Create(equip_di2,"equip_di2_jiantou",135,62,"res/04/040057.png")
			end

			local equip = GUI:Image_Create(bg_bagua,"equip",165,310,qianghua_tab[1][1]["itemid"])
			if equip then
				GUI:setVisible(equip,false)
				GUI:setContentSize(equip,{width = 58, height = 58})
				local item_tx = GUI:Text_Create(equip, "item_tx", 53, 47, 14, "#00FF00", "+0")
				if item_tx then
					GUI:setAnchorPoint(item_tx,1,0.5)
				end
			end

			for i=1,4 do
				local item = GUI:Image_Create(bg_bagua,"item"..i,30,440-(100*i),"res/04/040049.png")
				if item then
					GUI:setTouchEnabled(item, true)
					GUI:addOnClickEvent(item, function()
						Qianghua.equip(i)
					end)
				end
				local equip = GUI:Image_Create(bg_bagua,"equip"..i,34,444-(100*i),"")
				if equip then
					GUI:setContentSize(equip,{width = 58, height = 58})
					local item_tx = GUI:Text_Create(equip, "item_tx"..i, 53, 47, 14, "#00FF00", 0)
					if item_tx then
						GUI:setAnchorPoint(item_tx,1,0.5)
					end
				end
				local texiao = GUI:Image_Create(bg_bagua,"equip_texiao"..i,28,438-(100*i),"res/04/040050.png")
				if texiao then
					GUI:setVisible(texiao,false)
				end
			end

			for i=5,8 do
				local item = GUI:Image_Create(bg_bagua,"item"..i,300,440-(100*(i-4)),"res/04/040049.png")
				if item then
					GUI:setTouchEnabled(item, true)
					GUI:addOnClickEvent(item, function()
						Qianghua.equip(i)
					end)
				end
				local equip = GUI:Image_Create(bg_bagua,"equip"..i,304,444-(100*(i-4)),"")
				if equip then
					GUI:setContentSize(equip,{width = 58, height = 58})
					local item_tx = GUI:Text_Create(equip, "item_tx"..i, 53, 47, 14, "#00FF00", 0)
					if item_tx then
						GUI:setAnchorPoint(item_tx,1,0.5)
					end
				end
				local texiao = GUI:Image_Create(bg_bagua,"equip_texiao"..i,298,438-(100*(i-4)),"res/04/040050.png")
				if texiao then
					GUI:setVisible(texiao,false)
				end
			end

			local righttitle = GUI:Image_Create(bg_bagua,"righttitle",480,400,"res/04/040058.png")
			if righttitle then
				local righttitle_tx = GUI:Text_Create(righttitle, "righttitle_tx", 65, 15, 16, "#9EC5EC", "加成属性")
				if righttitle_tx then
					GUI:setAnchorPoint(righttitle_tx,0.5,0.5)
				end
			end

			local rzshuxing = GUI:Image_Create(bg_bagua,"rzshuxing",405,360,"res/04/040061.png")
			if rzshuxing then
				GUI:setContentSize(rzshuxing,{width=285,height=26})
				local rzshuxing_tx = GUI:Text_Create(rzshuxing, "rzshuxing_tx", 30, 15, 16, "#9EC5EC", "属 性")
				if rzshuxing_tx then
					GUI:Text_disableOutLine(rzshuxing_tx)
					GUI:setAnchorPoint(rzshuxing_tx,0.5,0.5)
				end
			end

			for i=1,8 do
				local rsxname = GUI:Text_Create(bg_bagua, "rsxname"..i, 410, 355-(i*26), 16, "#9EC5EC", "生    命 :")
				GUI:Text_Create(bg_bagua, "nrsxvalue"..i, 500, 355-(i*26), 16, "#00FF00", "0")

				local rsxname_timg = GUI:Image_Create(rsxname,"rsxname_timg",80,-4,"res/04/040062.png")
				GUI:setContentSize(rsxname_timg,{width=200,height=28})

				GUI:Image_Create(rsxname,"rsxname_jimg",250,-4,"res/04/040060.png")
			end

			local rxiaohao = GUI:Image_Create(bg_bagua,"rxiaohao",405,115,"res/04/040061.png")
			if rxiaohao then
				GUI:setContentSize(rxiaohao,{width=285,height=26})
				local rxiaohao_tx = GUI:Text_Create(rxiaohao, "rxiaohao_tx", 30, 15, 16, "#9EC5EC", "消 耗")
				if rxiaohao_tx then
					GUI:Text_disableOutLine(rxiaohao_tx)
					GUI:setAnchorPoint(rxiaohao_tx,0.5,0.5)
				end
			end

			for i=1,2 do
				GUI:Layout_Create(bg_bagua, "LC_xh"..i, 420, 110-(i*30), 265,30,false)
			end

			local btn_move = GUI:Button_Create(bg_bagua, "btn_move", 480, 10, "res/01/010005.png")
			if btn_move then
				local tx_btn_move = GUI:Text_Create(btn_move, "tx_btn_zs", 55, 20, 18, "#D6C6AD", "强  化")
				GUI:setAnchorPoint(tx_btn_move, 0.5, 0.5)
				GUI:Button_loadTexturePressed(btn_move, "res/01/010006.png")
				GUI:addOnClickEvent(btn_move, function()
					Qianghua.ok()
				end)
			end

			Qianghua.Zequip()
		end


		function Qianghua.equip(param,tab)
			param = tonumber(param)
			if tab ~= nil then
				qh_tab = tab
			end
			local level = qh_tab

			local bg_bagua = GUI:GetWindow(Handle,"bg_bagua")
			local li = level[param] or {}
			local lx = li[1] or 0
			local cfg = cfg_qianghuadz[param][lx+1]

			if equip_page1 ~= param then

				if equip_page1 ~= 0 then
					local texiao = GUI:GetWindow(bg_bagua,"equip_texiao"..equip_page1)
					if texiao then
						GUI:setVisible(texiao,false)
					end
					local item = GUI:GetWindow(bg_bagua,"item"..equip_page1)
					if item then
						GUI:setTouchEnabled(item, true)
					end
				end

				local texiao = GUI:GetWindow(bg_bagua,"equip_texiao"..param)
				if texiao then
					GUI:setVisible(texiao,true)
				end
				local item = GUI:GetWindow(bg_bagua,"item"..param)
				if item then
					GUI:setTouchEnabled(item, false)
				end
			end

			local equip = GUI:GetWindow(bg_bagua,"equip")
			if equip then
				GUI:Image_loadTexture(equip,cfg.itemid)
				GUI:setVisible(equip,true)
				local item_tx = GUI:GetWindow(equip,"item_tx")
				if item_tx then
					local lv = "+"..lx
					GUI:Text_setString(item_tx,lv)
				end
			end

			local shibai = li[2] or 0
			local cg = ((cfg.cgjl + (shibai*cfg.jiacheng))*0.01)  or 100
			if cg >= 100 then
				cg = 100
			end
			local tx_atlsas = GUI:GetWindow(bg_bagua,"equip_di1/tx_atlsas")
			if tx_atlsas then
				GUI:TextAtlas_setString(tx_atlsas, cg)
				local size = GUI:getContentSize(tx_atlsas)
				local equip_bf = GUI:GetWindow(tx_atlsas,"equip_bf")
				if equip_bf then
					GUI:setPosition(equip_bf,size.width,10)
				end
			end

			local sx_tab = cfg.attribute
			if sx_tab == 0 then
				sx_tab = {}
			end

			local nsx_tab = {}
			if lx+2 <= #cfg_qianghuadz[param] then --没满级
				nsx_tab = cfg_qianghuadz[param][lx+2].attribute
			end


            local equip_di2_dq = GUI:GetWindow(bg_bagua,"equip_di2/equip_di2_dq")
			local equip_di2_nx = GUI:GetWindow(bg_bagua,"equip_di2/equip_di2_nx")

			SLUpdateAttrShow(sx_tab,3,equip_di2_dq,"sxname","sxvalue", 2)
			SLUpdateAttrShow(nsx_tab,3,equip_di2_nx,"nsxname","nsxvalue", 2)

			local cost_tab = cfg.cost
			for i=1,2 do
				local LC_xh = GUI:GetWindow(bg_bagua,"LC_xh"..i)
				GUI:removeAllChildren(LC_xh)
				if lx+2 <= #cfg_qianghuadz[param] then --没满级
					local cost_name = SL:GetItemNameByIndex(cost_tab[i][1])--获取名字
					local cost_num = cost_tab[i][2]						--消耗数量
					local bag_num = SL:GetItemNumberByIndex(cost_tab[i][1]) --背包数量
					local cost_str = SLChangeColour(bag_num,cost_num,cost_name)
					GUI:RichText_Create(LC_xh, "LC_xh_text", 0, 10, cost_str, 265)
				end
			end
			
			if lx+2 > #cfg_qianghuadz[param] then --满级
				local nsxvalue2 = GUI:GetWindow(bg_bagua,"equip_di2/equip_di2_nx/nsxname2")
				GUI:setVisible(nsxvalue2,true)
				GUI:Text_setString(nsxvalue2,"已满级")

				local LC_xh2 = GUI:GetWindow(bg_bagua,"LC_xh2")
				GUI:RichText_Create(LC_xh2, "LC_xh_text2", 90, 20, "已满级", 265)
			end

			equip_page1 = param
		end

		function Qianghua.Zequip(tab)
			local level = tab or qh_tab
			local att_tab = {}
			for i=1,#level do
				local li = level[i] or {}
				local lx = li[1] or 0
				local v = qianghua_tab[i][lx+1].attribute
				if v ~= 0 then
					for t=1,#v do
						table.insert(att_tab,v[t])
					end
				end
			end
			local ztab = {}
			for k, v in ipairs(att_tab) do
				if ztab[v[1]] ~= nil then
					ztab[v[1]] = ztab[v[1]] + v[2]
				else
					ztab[v[1]]=v[2]
				end
			end
			local rt = {}
			local num = 1
			for k, v in pairs(ztab) do
				rt[num] = {}
				rt[num][1] = k
				rt[num][2] = v
				num=num+1
			end

			local bg_bagua = GUI:GetWindow(Handle,"bg_bagua")
			SLUpdateAttrShow(rt,8,bg_bagua,"rsxname","nrsxvalue",2)
			
			for i=1,8 do
			local li = level[i] or {}
			local lx = li[1] or 0
			local equip = GUI:GetWindow(bg_bagua,"equip"..i)
				if equip then
					GUI:Image_loadTexture(equip,qianghua_tab[i][lx+1]["itemid"])
				end
				local lv = "+"..lx
				local item_tx = GUI:GetWindow(equip, "item_tx"..i)
				if item_tx then
					GUI:Text_setString(item_tx,lv)
				end
			end
		end

		function Qianghua.shuaxing(equip,tab)
			tab = unserialize(tab)
			Qianghua.equip(equip,tab)
			Qianghua.Zequip(tab)
		end

		function Qianghua.ok()
			if equip_page1 == 0 then
				SL:ShowSystemTips("请选中要强化的装备")
				return
			end
			SL:SubmitForm("A/强化", "qianghuaok",equip_page1)
		end

		function Qianghua.close()
			GUI:Win_Close(Handle)
		end
	</script>  
</form>


