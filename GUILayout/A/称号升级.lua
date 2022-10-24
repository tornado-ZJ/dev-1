chenghaoshengji = {}
local cfg = {
    [1] = {
        name = "初入江湖",
        level = 85,
        effectid = 30101,
        cost = {
            [1] = {
                [1] = 4,
                [2] = 5000,
            },
        },
        shuxing = {
            [1] = {
                [1] = 1,
                [2] = 0,
            },
            [2] = {
                [1] = 3,
                [2] = 0,
            },
            [3] = {
                [1] = 4,
                [2] = 0,
            },
            [4] = {
                [1] = 56,
                [2] = 0,
            },
        },
    },
    [2] = {
        name = "名动江湖",
        level = 90,
        effectid = 30102,
        cost = {
            [1] = {
                [1] = 4,
                [2] = 10000,
            },
        },
        shuxing = {
            [1] = {
                [1] = 1,
                [2] = 400,
            },
            [2] = {
                [1] = 3,
                [2] = 80,
            },
            [3] = {
                [1] = 56,
                [2] = 300,
            },
        },
    },
    [3] = {
        name = "威震八方",
        level = 95,
        effectid = 30103,
        cost = {
            [1] = {
                [1] = 4,
                [2] = 20000,
            },
        },
        shuxing = {
            [1] = {
                [1] = 1,
                [2] = 400,
            },
            [2] = {
                [1] = 3,
                [2] = 80,
            },
            [3] = {
                [1] = 56,
                [2] = 600,
            },
        },
    },
    [4] = {
        name = "剑雨风行",
        level = 100,
        effectid = 30104,
        cost = {
            [1] = {
                [1] = 4,
                [2] = 30000,
            },
        },
        shuxing = {
            [1] = {
                [1] = 1,
                [2] = 400,
            },
            [2] = {
                [1] = 3,
                [2] = 80,
            },
            [3] = {
                [1] = 56,
                [2] = 900,
            },
        },
    },
    [5] = {
        name = "武林至尊",
        level = 110,
        effectid = 30105,
        cost = {
            [1] = {
                [1] = 4,
                [2] = 80000,
            },
        },
        shuxing = {
            [1] = {
                [1] = 1,
                [2] = 400,
            },
            [2] = {
                [1] = 3,
                [2] = 80,
            },
            [3] = {
                [1] = 56,
                [2] = 1200,
            },
        },
    },
    [6] = {
        name = "我就是神",
        level = 120,
        effectid = 30106,
        cost = {
            [1] = {
                [1] = 4,
                [2] = 140000,
            },
        },
        shuxing = {
            [1] = {
                [1] = 1,
                [2] = 400,
            },
            [2] = {
                [1] = 3,
                [2] = 80,
            },
            [3] = {
                [1] = 56,
                [2] = 1500,
            },
        },
    },
    [7] = {
        name = "破天轩辕",
        level = 130,
        effectid = 30107,
        cost = {
            [1] = {
                [1] = 4,
                [2] = 210000,
            },
        },
        shuxing = {
            [1] = {
                [1] = 1,
                [2] = 400,
            },
            [2] = {
                [1] = 3,
                [2] = 80,
            },
            [3] = {
                [1] = 56,
                [2] = 1800,
            },
        },
    },
    [8] = {
        name = "烽火杀戮",
        level = 140,
        effectid = 30108,
        cost = {
            [1] = {
                [1] = 4,
                [2] = 290000,
            },
        },
        shuxing = {
            [1] = {
                [1] = 1,
                [2] = 400,
            },
            [2] = {
                [1] = 3,
                [2] = 80,
            },
            [3] = {
                [1] = 56,
                [2] = 2100,
            },
        },
    },
    [9] = {
        name = "玄灵驭世",
        level = 150,
        effectid = 30109,
        cost = {
            [1] = {
                [1] = 4,
                [2] = 380000,
            },
        },
        shuxing = {
            [1] = {
                [1] = 1,
                [2] = 400,
            },
            [2] = {
                [1] = 3,
                [2] = 80,
            },
            [3] = {
                [1] = 56,
                [2] = 2400,
            },
        },
    },
    [10] = {
        name = "众生俯仰",
        level = 160,
        effectid = 30110,
        cost = {
            [1] = {
                [1] = 4,
                [2] = 480000,
            },
        },
        shuxing = {
            [1] = {
                [1] = 1,
                [2] = 400,
            },
            [2] = {
                [1] = 3,
                [2] = 80,
            },
            [3] = {
                [1] = 56,
                [2] = 2700,
            },
        },
    },

}

local GUIparent = ""
local Win_W, Win_H = 815, 575
local cur_chenghao = 1

chenghaoshengji.main = function()
    SL:SubmitForm("A/称号升级", "SyncResponse")
end
chenghaoshengji.main()
----同步信息
function chenghaoshengji.SyncResponse(data)
    if not data then
        return
    end
    data = SL:JsonDecode(data)
    cur_chenghao = data[1]
    SL:print(cur_chenghao)
    if not GUI:GetWindow(nil, "chenghaoshengji") then
        chenghaoshengji.createUI()
    else
        chenghaoshengji.updateUI()
    end
end

chenghaoshengji.createUI = function()
    local _parent = GUI:Win_Create("chenghaoshengji", 0, 0, 0, 0, false, false, true, false)
    if _parent then
        GUIparent = _parent
        GUI:Timeline_Window1(_parent)
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
        local bg_close = GUI:Image_Create(_parent, "bg_close", 0, 0, "res/ui/npc/称号升级/1.png")
        if bg_close then
            GUI:setContentSize(bg_close, { width = w, height = h })
            GUI:setTouchEnabled(bg_close, true)
            GUI:addOnClickEvent(bg_close, function()
                GUI:Win_Close(_parent)
            end)
        end
        --背景框
        local img_bg = GUI:Image_Create(_parent, "img_bg", 111.00, 40.00, "res/ui/npc/称号升级/2.png")
        GUI:setContentSize(img_bg, 815, 575)
        GUI:setIgnoreContentAdaptWithSize(img_bg, false)
        GUI:setTouchEnabled(img_bg, true)
        GUI:setTag(img_bg, -1)

        -- Create 标题
        local text_title = GUI:Text_Create(_parent, "text_title", 223.00, 537.00, 20, "#ffeed9", [[称号升级]])
        GUI:setTouchEnabled(text_title, false)
        GUI:setTag(text_title, -1)

        -- Create 关闭按钮
        local btn_close = GUI:Button_Create(_parent, "btn_close", 856.00, 510.00, "res/ui/npc/称号升级/3.png")
        GUI:Button_loadTexturePressed(btn_close, "res/ui/npc/称号升级/4.png")
        GUI:Button_loadTextureDisabled(btn_close, "res/private/gui_edit/Button_Disable.png")
        GUI:setTouchEnabled(btn_close, true)
        GUI:setTag(btn_close, -1)
        GUI:addOnClickEvent(btn_close, function()
            GUI:Win_Close(_parent)
        end)

        GUI:Effect_Create(_parent, "effect_chenghoa_cur",500,350,0,cfg[1].effectid,0,0,0,1)

        -- Create 称号按钮
        local btn_zhuansheng = GUI:Button_Create(_parent, "btn_zhuansheng", 465.00, 132.00, "res/ui/npc/称号升级/6.png")
        GUI:Button_loadTexturePressed(btn_zhuansheng, "res/ui/npc/称号升级/7.png")
        GUI:Button_loadTextureDisabled(btn_zhuansheng, "res/private/gui_edit/Button_Disable.png")
        GUI:Button_setTitleColor(btn_zhuansheng, "#ef6f18")
        GUI:Button_setTitleFontSize(btn_zhuansheng, 18)
        GUI:Button_setTitleText(btn_zhuansheng, "称号升级")
        GUI:setTouchEnabled(btn_zhuansheng, true)
        GUI:setTag(btn_zhuansheng, -1)
        GUI:addOnClickEvent(btn_zhuansheng, function()
            if cur_chenghao >= 10  then
                SL:ShowSystemTips("称号已满！")
                return
            end
            SL:SubmitForm("A/称号升级", "chenghao",cur_chenghao)
        end)
        --SL:print(cur_chenghao.."-----------------------------")
        chenghaoshengji.updateUI()
    end

end

function chenghaoshengji.updateUI()
    --称号
    GUI:removeFromParent(GUI:GetWindow(GUIparent, "effect_chenghoa_cur"))
    GUI:Effect_Create(GUIparent, "effect_chenghoa_cur",500,350,0,cfg[cur_chenghao].effectid,0,0,0,1)
end


