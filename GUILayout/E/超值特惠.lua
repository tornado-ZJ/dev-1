
<form>
	<dialog id="QSQ_TeHui" x=0 y=0 w=0 h=0  OnInit=TeHui.Init >
        <Image id="bg_close" x=0 y=0 w=1136 h=640 revmsg=true image="res/01/010010.png" OnClick=TeHui.close />
        <Image id="bg_kuang" x=142 y=45 w=815 h=575  revmsg=true image="res/01/010000.png" OnClick=TeHui.btn />
		<Image id="bg_bagua" x=203 y=66 w=692 h=446 image="res/04/040048.jpg" />

		<Text id="title" x=520 y=558 text="强  化"  size =20 color="#D6C6AD" />

	</dialog>
	<script>

		TeHui = {}
		local Handle = ""
		--local TeHui_tab = cfg_TeHuidz
		local equip_page1 = 0

		--local qh_tab = unserialize(SL.FormParam[1])

		function TeHui.Init(this)
			Handle = this
			local bg_bagua = GUI:GetWindow(Handle,"bg_bagua")
			if bg_bagua then
				GUI:removeAllChildren(bg_bagua)
				GUI:setOpacity(bg_bagua,220)
			end
		end

		function TeHui.shuaxing(equip,tab)
			TeHui.equip(equip,tab)
			TeHui.Zequip(tab)
		end

		function TeHui.ok()
			if equip_page1 == 0 then
				SL:ShowSystemTips("请选中要强化的装备")
				return
			end
			SL:SubmitForm("强化", "TeHuiok",equip_page1)
		end

		function TeHui.close()
			GUI:Win_Close(Handle)
		end
	</script>  
</form>

