
<form>
<dialog id="QSQ_GMxml" x=0 y=0 w=0 h=0  OnInit=QSQGM.Init >
    <Image id="bg_close" x=0 y=0 w=1136 h=640 revmsg=true image="res/01/010010.png" OnClick=QSQGM.close />
    <Image id="bg_kuang" x=2 y=2 w=360 h=420  revmsg=true image="res/01/010032.png" />
    <Button id="btn_clsoe" nimg="res/01/010008.png" x=308 y=362 w=64 h=80 OnClick=QSQGM.close />

    <ScrollView id="SV0" x=2 y=2 w=360 h=420 revmsg=false clip=false >
        <Button id="SV0_btn1" nimg="res/01/010006.png" text="货币" color="#C0C0C0" x=20 y=340  w=120 h=36 param=1 OnClick=QSQGM.btn1 />
        <Button id="SV0_btn2" nimg="res/01/010006.png" text="等级" color="#C0C0C0" x=20 y=300  w=120 h=36 param=2 OnClick=QSQGM.btn1 />
        <Button id="SV0_btn3" nimg="res/01/010006.png" text="道具" color="#C0C0C0" x=20 y=260  w=120 h=36 param=3 OnClick=QSQGM.btn1 />
        <Button id="SV0_btn4" nimg="res/01/010006.png" text="清空背包" color="#C0C0C0" x=20 y=220  w=120 h=36 param=4 OnClick=QSQGM.btn1 />
        <Button id="SV0_btn5" nimg="res/01/010006.png" text="背包信息" color="#C0C0C0" x=20 y=180  w=120 h=36 param=5 OnClick=QSQGM.btn1 />
        <Button id="SV0_btn6" nimg="res/01/010006.png" text="触发每日" color="#C0C0C0" x=20 y=140  w=120 h=36 param=6 OnClick=QSQGM.btn1 />
        <Button id="SV0_btn7" nimg="res/01/010006.png" text="充值" color="#C0C0C0" x=20 y=100  w=120 h=36 param=7 OnClick=QSQGM.btn1 />
        <Button id="SV0_btn8" nimg="res/01/010006.png" text="刷怪" color="#C0C0C0" x=20 y=60  w=120 h=36 param=8 OnClick=QSQGM.btn1 />


        <Button id="SV0_cbtn1" nimg="res/01/010006.png" text="无敌模式" color="#C0C0C0" x=200 y=10  w=120 h=36 param=1 OnClick=QSQGM.cbtn1 />
        <Button id="SV0_cbtn2" nimg="res/01/010006.png" text="隐身模式" color="#C0C0C0" x=200 y=50  w=120 h=36 param=2 OnClick=QSQGM.cbtn1 />
        <Button id="SV0_cbtn3" nimg="res/01/010006.png" text="管理模式" color="#C0C0C0" x=200 y=90  w=120 h=36 param=3 OnClick=QSQGM.cbtn1 />
        <Button id="SV0_cbtn4" nimg="res/01/010006.png" text="全屏清怪" color="#C0C0C0" x=200 y=130  w=120 h=36 param=4 OnClick=QSQGM.cbtn1 />

        <Button id="SV0_cbtn11" nimg="res/01/010006.png" text="int变量" color="#C0C0C0" x=200 y=340  w=120 h=36 param=11 OnClick=QSQGM.btn1 />
        <Button id="SV0_cbtn12" nimg="res/01/010006.png" text="str变量" color="#C0C0C0" x=200 y=300  w=120 h=36 param=12 OnClick=QSQGM.btn1 />


    </ScrollView>


    <ScrollView id="SV1" x=2 y=2 w=360 h=420 revmsg=false visible=false clip=false >

        <Button id="SV1_btn1" nimg="res/01/010006.png" text="货币清除" color="#C0C0C0" x=20 y=340  w=120 h=36 param=1 OnClick=QSQGM.huobi />
        <Button id="SV1_btn2" nimg="res/01/010006.png" text="rmb点" color="#C0C0C0" x=20 y=280  w=120 h=36 param=2 OnClick=QSQGM.huobi />
        <Button id="SV1_btn3" nimg="res/01/010006.png" text="充值点" color="#C0C0C0" x=20 y=220  w=120 h=36 param=3 OnClick=QSQGM.huobi />
        <Button id="SV1_btn4" nimg="res/01/010006.png" text="充值金额" color="#C0C0C0" x=20 y=160  w=120 h=36 param=4 OnClick=QSQGM.huobi />
        <Button id="SV1_btn10" nimg="res/01/010006.png" text="名著币" color="#C0C0C0" x=20 y=100  w=120 h=36 param=10 OnClick=QSQGM.huobi />
       
        <Button id="SV1_btn5" nimg="res/01/010006.png" text="爆率" color="#C0C0C0" x=200 y=340  w=120 h=36 param=5 OnClick=QSQGM.huobi />
        <Button id="SV1_btn6" nimg="res/01/010006.png" text="元宝" color="#C0C0C0" x=200 y=280  w=120 h=36 param=6 OnClick=QSQGM.huobi />
        <Button id="SV1_btn7" nimg="res/01/010006.png" text="倍攻" color="#C0C0C0" x=200 y=220  w=120 h=36 param=7 OnClick=QSQGM.huobi />
        <Button id="SV1_btn8" nimg="res/01/010006.png" text="刀刀切割" color="#C0C0C0" x=200 y=160  w=120 h=36 param=8 OnClick=QSQGM.huobi />


        <Button id="SV1_btn9" nimg="res/01/010006.png" text="返回" color="#C0C0C0" x=200 y=20  w=125 h=39 param=9 OnClick=QSQGM.huobi />
    </ScrollView>

    <ScrollView id="SV2" x=2 y=2 w=360 h=420 revmsg=false visible=false clip=false >
        <Button id="SV2_btn1" nimg="res/01/010006.png" text="等级+1" color="#C0C0C0" x=20 y=340  w=120 h=36 param=1 OnClick=QSQGM.lv />
        <Button id="SV2_btn2" nimg="res/01/010006.png" text="等级+10" color="#C0C0C0" x=20 y=280  w=120 h=36 param=2 OnClick=QSQGM.lv />
        <Button id="SV2_btn3" nimg="res/01/010006.png" text="等级+100" color="#C0C0C0" x=20 y=220  w=120 h=36 param=3 OnClick=QSQGM.lv />
        <Button id="SV2_btn4" nimg="res/01/010006.png" text="等级═1" color="#C0C0C0" x=20 y=160  w=120 h=36 param=4 OnClick=QSQGM.lv />

        <Button id="SV2_btn5" nimg="res/01/010006.png" text="转生+1" color="#C0C0C0" x=200 y=340  w=120 h=36 param=5 OnClick=QSQGM.lv />
        <Button id="SV2_btn6" nimg="res/01/010006.png" text="转生═0" color="#C0C0C0" x=200 y=280  w=120 h=36 param=6 OnClick=QSQGM.lv />

        <Button id="SV2_btn7" nimg="res/01/010006.png" text="返回" color="#C0C0C0" x=200 y=20  w=125 h=39 param=7 OnClick=QSQGM.lv />
    </ScrollView>


    <ScrollView id="SV3" x=2 y=2 w=360 h=420 revmsg=false visible=false clip=false >

        <Image id="SV3_img1" x=60 y=280 w=220 h=40  revmsg=true image="res/input/input_10.png" />
        <Image id="SV3_img2" x=60 y=220 w=220 h=40  revmsg=true image="res/input/input_10.png" />

        <Button id="SV3_btn1" nimg="res/01/010006.png" text="添加" color="#C0C0C0" x=20 y=140  w=120 h=36 param=1 OnClick=QSQGM.item />
        <Button id="SV3_btn2" nimg="res/01/010006.png" text="返回" color="#C0C0C0" x=200 y=140  w=120 h=36 param=2 OnClick=QSQGM.item />
    </ScrollView>

    <ScrollView id="SV7" x=2 y=2 w=360 h=420 revmsg=false visible=false clip=false >

        <Image id="SV7_img1" x=60 y=280 w=220 h=40  revmsg=true image="res/input/input_10.png" />
        <Image id="SV7_img2" x=60 y=220 w=220 h=40  revmsg=true image="res/input/input_10.png" />

        <Button id="SV7_btn1" nimg="res/01/010006.png" text="充值" color="#C0C0C0" x=20 y=140  w=120 h=36 param=1 OnClick=QSQGM.recharge />
        <Button id="SV7_btn2" nimg="res/01/010006.png" text="返回" color="#C0C0C0" x=200 y=140  w=120 h=36 param=2 OnClick=QSQGM.recharge />
    </ScrollView>

    <ScrollView id="SV8" x=2 y=2 w=360 h=420 revmsg=false visible=false clip=false >

        <Image id="SV8_img1" x=60 y=280 w=220 h=40  revmsg=true image="res/input/input_10.png" />
        <Image id="SV8_img2" x=60 y=220 w=220 h=40  revmsg=true image="res/input/input_10.png" />

        <Button id="SV8_btn1" nimg="res/01/010006.png" text="刷怪" color="#C0C0C0" x=20 y=140  w=120 h=36 param=1 OnClick=QSQGM.monster />
        <Button id="SV8_btn2" nimg="res/01/010006.png" text="返回" color="#C0C0C0" x=200 y=140  w=120 h=36 param=2 OnClick=QSQGM.monster />
    </ScrollView>

    <ScrollView id="SV11" x=2 y=2 w=360 h=420 revmsg=false visible=false clip=false >

        <Image id="SV11_img1" x=60 y=340 w=220 h=40  revmsg=true image="res/input/input_10.png" />
        <Image id="SV11_img2" x=60 y=280 w=220 h=40  revmsg=true image="res/input/input_10.png" />
        <Image id="SV11_img3" x=60 y=220 w=220 h=40  revmsg=true image="res/input/input_10.png" />
        <Image id="SV11_img4" x=60 y=160 w=220 h=40  revmsg=true image="res/input/input_10.png" />

        <Button id="SV11_btn1" nimg="res/01/010006.png" text="修改" color="#C0C0C0" x=20 y=100  w=120 h=36 param=1 OnClick=QSQGM.var />
        <Button id="SV11_btn2" nimg="res/01/010006.png" text="查询" color="#C0C0C0" x=200 y=100  w=120 h=36 param=2 OnClick=QSQGM.var />
        <Button id="SV11_btn3" nimg="res/01/010006.png" text="返回" color="#C0C0C0" x=110 y=40  w=120 h=36 param=3 OnClick=QSQGM.var />

    </ScrollView>


</dialog>
<script>


    QSQGM = {}
    local Handle = ""
    function QSQGM.Init(this)
        Handle = this
        --添加道具
        local SV3_img1 = GUI:GetWindow(Handle,"SV3/SV3_img1")
        local SV3_input1 = GUI:TextInput_Create(SV3_img1, "SV3_input1", 110, 20, 212, 30, 18)
        GUI:setAnchorPoint(SV3_input1, 0.5, 0.5)
        GUI:TextInput_setPlaceHolder(SV3_input1,"输入道具索引名或者ID")
        GUI:TextInput_setPlaceholderFontSize(SV3_input1,18)
        GUI:TextInput_setPlaceholderFontColor(SV3_input1,"#FFFFFF")
        GUI:TextInput_setFontColor(SV3_input1,"#FFFFFF")

        local SV3_img2 = GUI:GetWindow(Handle,"SV3/SV3_img2")
        local SV3_input2 = GUI:TextInput_Create(SV3_img2, "SV3_input2", 110, 20, 212, 30, 18)
        GUI:setAnchorPoint(SV3_input2, 0.5, 0.5)
        GUI:TextInput_setPlaceHolder(SV3_input2,"输入道具数，不填为1")
        GUI:TextInput_setPlaceholderFontSize(SV3_input2,18)
        GUI:TextInput_setPlaceholderFontColor(SV3_input2,"#FFFFFF")
        GUI:TextInput_setFontColor(SV3_input2,"#FFFFFF")
        --
        --充值
        local SV7_img1 = GUI:GetWindow(Handle,"SV7/SV7_img1")
        local SV7_input1 = GUI:TextInput_Create(SV7_img1, "SV7_input1", 110, 20, 212, 30, 18)
        GUI:setAnchorPoint(SV7_input1, 0.5, 0.5)
        GUI:TextInput_setPlaceHolder(SV7_input1,"充值货币ID")
        GUI:TextInput_setPlaceholderFontSize(SV7_input1,18)
        GUI:TextInput_setPlaceholderFontColor(SV7_input1,"#FFFFFF")
        GUI:TextInput_setFontColor(SV7_input1,"#FFFFFF")

        local SV7_img2 = GUI:GetWindow(Handle,"SV7/SV7_img2")
        local SV7_input2 = GUI:TextInput_Create(SV7_img2, "SV7_input2", 110, 20, 212, 30, 18)
        GUI:setAnchorPoint(SV7_input2, 0.5, 0.5)
        GUI:TextInput_setPlaceHolder(SV7_input2,"充值金额")
        GUI:TextInput_setPlaceholderFontSize(SV7_input2,18)
        GUI:TextInput_setPlaceholderFontColor(SV7_input2,"#FFFFFF")
        GUI:TextInput_setFontColor(SV7_input2,"#FFFFFF")
        --
        --刷怪
        local SV8_img1 = GUI:GetWindow(Handle,"SV8/SV8_img1")
        local SV8_input1 = GUI:TextInput_Create(SV8_img1, "SV8_input1", 110, 20, 212, 30, 18)
        GUI:setAnchorPoint(SV8_input1, 0.5, 0.5)
        GUI:TextInput_setPlaceHolder(SV8_input1,"输入怪物名")
        GUI:TextInput_setPlaceholderFontSize(SV8_input1,18)
        GUI:TextInput_setPlaceholderFontColor(SV8_input1,"#FFFFFF")
        GUI:TextInput_setFontColor(SV8_input1,"#FFFFFF")

        local SV8_img2 = GUI:GetWindow(Handle,"SV8/SV8_img2")
        local SV8_input2 = GUI:TextInput_Create(SV8_img2, "SV8_input2", 110, 20, 212, 30, 18)
        GUI:setAnchorPoint(SV8_input2, 0.5, 0.5)
        GUI:TextInput_setPlaceHolder(SV8_input2,"输入怪物数量，不填为1")
        GUI:TextInput_setPlaceholderFontSize(SV8_input2,18)
        GUI:TextInput_setPlaceholderFontColor(SV8_input2,"#FFFFFF")
        GUI:TextInput_setFontColor(SV8_input2,"#FFFFFF")
        --
        --变量
        local SV11_img1 = GUI:GetWindow(Handle,"SV11/SV11_img1")
        local SV11_input1 = GUI:TextInput_Create(SV11_img1, "SV11_input1", 110, 20, 212, 30, 18)
        GUI:setAnchorPoint(SV11_input1, 0.5, 0.5)
        GUI:TextInput_setPlaceHolder(SV11_input1,"对象类型，系统变量不填")
        GUI:TextInput_setPlaceholderFontSize(SV11_input1,18)
        GUI:TextInput_setPlaceholderFontColor(SV11_input1,"#FFFFFF")
        GUI:TextInput_setFontColor(SV11_input1,"#FFFFFF")

        local SV11_img2 = GUI:GetWindow(Handle,"SV11/SV11_img2")
        local SV11_input2 = GUI:TextInput_Create(SV11_img2, "SV11_input2", 110, 20, 212, 30, 18)
        GUI:setAnchorPoint(SV11_input2, 0.5, 0.5)
        GUI:TextInput_setPlaceHolder(SV11_input2,"对象，自己与系统则不填")
        GUI:TextInput_setPlaceholderFontSize(SV11_input2,18)
        GUI:TextInput_setPlaceholderFontColor(SV11_input2,"#FFFFFF")
        GUI:TextInput_setFontColor(SV11_input2,"#FFFFFF")
        
        local SV11_img3 = GUI:GetWindow(Handle,"SV11/SV11_img3")
        local SV11_input3 = GUI:TextInput_Create(SV11_img3, "SV11_input3", 110, 20, 212, 30, 18)
        GUI:setAnchorPoint(SV11_input3, 0.5, 0.5)
        GUI:TextInput_setPlaceHolder(SV11_input3,"变量名")
        GUI:TextInput_setPlaceholderFontSize(SV11_input3,18)
        GUI:TextInput_setPlaceholderFontColor(SV11_input3,"#FFFFFF")
        GUI:TextInput_setFontColor(SV11_input3,"#FFFFFF")

        local SV11_img4 = GUI:GetWindow(Handle,"SV11/SV11_img4")
        local SV11_input4 = GUI:TextInput_Create(SV11_img4, "SV11_input4", 110, 20, 212, 30, 18)
        GUI:setAnchorPoint(SV11_input4, 0.5, 0.5)
        GUI:TextInput_setPlaceHolder(SV11_input4,"变量值，查询时无效")
        GUI:TextInput_setPlaceholderFontSize(SV11_input4,18)
        GUI:TextInput_setPlaceholderFontColor(SV11_input4,"#FFFFFF")
        GUI:TextInput_setFontColor(SV11_input4,"#FFFFFF")
        --
    end
    local vartype = ""
    function QSQGM.btn1(parent,param)
        param = tonumber(param)
        if param == 4 then
            SL:SendGMMsgToChat( "cbg")
        elseif param == 5 then
            SL:SendGMMsgToChat( "cx")
        elseif param == 6 then
            SL:SendGMMsgToChat( "day")
        else
        if param == 11 then vartype = "int" end
        if param == 12 then param = 11 vartype = "str" end
        local SV0 = GUI:GetWindow(Handle,"SV0")
        GUI:setVisible(SV0,false)
        local SV1 = GUI:GetWindow(Handle,"SV"..param)
        GUI:setVisible(SV1,true)
        end
    end

    function QSQGM.huobi(parent,param)
        param = tonumber(param)
        if param == 9 then
            local SV0 = GUI:GetWindow(Handle,"SV0")
            GUI:setVisible(SV0,true)
            local SV1 = GUI:GetWindow(Handle,"SV1")
            GUI:setVisible(SV1,false)
        elseif param == 1 then
            SL:SendGMMsgToChat( "jian_huobi")
        elseif param == 5 then
            SL:SendGMMsgToChat( "jia_baolv")
        elseif param == 2 then
            SL:SendGMMsgToChat( "jia_rmb")
        elseif param == 6 then
            SL:SendGMMsgToChat( "jia_yuanbao")
        elseif param == 3 then
            SL:SendGMMsgToChat( "jia_czd")
        elseif param == 7 then
            SL:SendGMMsgToChat( "jia_beigong")
        elseif param == 4 then
            SL:SendGMMsgToChat( "jia_czje")
        elseif param == 8 then
            SL:SendGMMsgToChat( "jia_ddqg")
        elseif param == 10 then
            SL:SendGMMsgToChat( "jia_mzb")
        end
    end

    function QSQGM.lv(parent,param)
        param = tonumber(param)
        if param == 7 then
            local SV0 = GUI:GetWindow(Handle,"SV0")
            GUI:setVisible(SV0,true)
            local SV = GUI:GetWindow(Handle,"SV2")
            GUI:setVisible(SV,false)
        elseif param == 1 then
            local level = SL:GetRoleData().level + 1
            SL:SendGMMsgToChat( "level "..level)
        elseif param == 2 then
            local level = SL:GetRoleData().level + 10
            SL:SendGMMsgToChat( "level "..level)
        elseif param == 3 then
            local level = SL:GetRoleData().level + 100
            SL:SendGMMsgToChat( "level "..level)
        elseif param == 4 then
            SL:SendGMMsgToChat( "level")
        elseif param == 5 then
            SL:SendGMMsgToChat( "zsLevel1")
        elseif param == 6 then
            SL:SendGMMsgToChat( "zsLevel2")

        end
    end

    function QSQGM.item(parent,param)
        param = tonumber(param)
        if param == 2 then
            local SV0 = GUI:GetWindow(Handle,"SV0")
            GUI:setVisible(SV0,true)
            local SV = GUI:GetWindow(Handle,"SV3")
            GUI:setVisible(SV,false)
        else
            local SV3_input1 = GUI:GetWindow(Handle,"SV3/SV3_img1/SV3_input1")
            local SV3_input2 = GUI:GetWindow(Handle,"SV3/SV3_img2/SV3_input2")

            local str1 = GUI:Text_getString(SV3_input1)
            local str2 = GUI:Text_getString(SV3_input2)
            SL:SendGMMsgToChat( "i "..str1.." "..str2 )
        end
    end

    function QSQGM.recharge(parent,param)
        param = tonumber(param)
        if param == 2 then
            local SV0 = GUI:GetWindow(Handle,"SV0")
            GUI:setVisible(SV0,true)
            local SV = GUI:GetWindow(Handle,"SV7")
            GUI:setVisible(SV,false)
        else
            local SV7_input1 = GUI:GetWindow(Handle,"SV7/SV7_img1/SV7_input1")
            local SV7_input2 = GUI:GetWindow(Handle,"SV7/SV7_img2/SV7_input2")

            local str1 = GUI:Text_getString(SV7_input1)
            local str2 = GUI:Text_getString(SV7_input2)
            SL:SendGMMsgToChat( "testrecharge "..str2.." "..str1 )
        end
    end

    function QSQGM.monster(parent,param)
        param = tonumber(param)
        if param == 2 then
            local SV0 = GUI:GetWindow(Handle,"SV0")
            GUI:setVisible(SV0,true)
            local SV = GUI:GetWindow(Handle,"SV8")
            GUI:setVisible(SV,false)
        else
            local SV8_input1 = GUI:GetWindow(Handle,"SV8/SV8_img1/SV8_input1")
            local SV8_input2 = GUI:GetWindow(Handle,"SV8/SV8_img2/SV8_input2")

            local str1 = GUI:Text_getString(SV8_input1)
            local str2 = GUI:Text_getString(SV8_input2)
            SL:SendGMMsgToChat( "monster "..str1.." "..str2 )
        end
    end

    function QSQGM.var(parent,param)
        param = tonumber(param)
        if param == 3 then
            local SV0 = GUI:GetWindow(Handle,"SV0")
            GUI:setVisible(SV0,true)
            local SV = GUI:GetWindow(Handle,"SV11")
            GUI:setVisible(SV,false)
        elseif param == 2 then
            local SV11_input1 = GUI:GetWindow(Handle,"SV11/SV11_img1/SV11_input1")
            local SV11_input2 = GUI:GetWindow(Handle,"SV11/SV11_img2/SV11_input2")
            local SV11_input3 = GUI:GetWindow(Handle,"SV11/SV11_img3/SV11_input3")

            local str1 = GUI:Text_getString(SV11_input1)
            local str2 = GUI:Text_getString(SV11_input2)
            local str3 = GUI:Text_getString(SV11_input3)

            if str1 == "" then str1 = "QSQ_var" end
            if str2 == "" then str2 = "QSQ_var" end
            if str3 == "" then return end
            SL:SendGMMsgToChat( "getvar 2 "..vartype.." "..str1.." "..str2.." "..str3)
        elseif param == 1 then
            local SV11_input1 = GUI:GetWindow(Handle,"SV11/SV11_img1/SV11_input1")
            local SV11_input2 = GUI:GetWindow(Handle,"SV11/SV11_img2/SV11_input2")
            local SV11_input3 = GUI:GetWindow(Handle,"SV11/SV11_img3/SV11_input3")
            local SV11_input4 = GUI:GetWindow(Handle,"SV11/SV11_img4/SV11_input4")

            local str1 = GUI:Text_getString(SV11_input1)
            local str2 = GUI:Text_getString(SV11_input2)
            local str3 = GUI:Text_getString(SV11_input3)
            local str4 = GUI:Text_getString(SV11_input4)

            if str1 == "" then str1 = "QSQ_var" end
            if str2 == "" then str2 = "QSQ_var" end
            if str3 == "" then return end


            SL:SendGMMsgToChat( "getvar 1 "..vartype.." "..str1.." "..str2.." "..str3.." "..str4 )
        end
    end




    function QSQGM.cbtn1(parent,param)
        param = tonumber(param)
        if param == 1 then
            SL:SendGMMsgToChat( "3")
        elseif param == 2 then
            SL:SendGMMsgToChat( "2")
        elseif param == 3 then
            SL:SendGMMsgToChat( "1")
        elseif param == 4 then
            SL:SendGMMsgToChat( "killMon")
        end
    end

    function QSQGM.close()
        GUI:Win_Close(Handle)
    end

</script>
</form>

