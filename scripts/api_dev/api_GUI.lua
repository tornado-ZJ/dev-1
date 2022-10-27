---@class GUI
GUI = {}


--移除其下所有子控件
---@param widget widget控件对象
function GUI:removeAllChildren(widget) end
--设置控件透明度
--widget	是	parent	控件对象
--value	是	int	透明度(0-255)
---@param value parent
---@param widget string
function GUI:setOpacity(widget, value) end

--设置控件缩放
---@param value integer
---@return nil
--widget    是    parent    控件对象
--value	是	int	缩放比例 1为正常比例 0.5为缩小一半 2为放大一倍
function GUI:setScale(widget, value) end

--获取控件大小
---@param widget parent
---@return size
function GUI:getContentSize(widget) end

--创建图片控件
---@param parent parent父控件对象
---@param ID string控件ID
---@param PosX int控件位置的横坐标
---@param PosY int控件位置的纵坐标
---@param nimg string图片路径
---@return widget 创建成功则返回新建控件的对象,创建失败则返回空
function GUI:Image_Create(parent, ID, PosX, PosY, nimg) end

---创建物品框控件
---@param parent parent父控件对象
---@param ID string控件ID
---@param x int控件位置的横坐标
---@param y int控件位置的纵坐标
---@param itemData itemdata
---@return 创建成功则返回控件的对象创建失败则返回nil
function GUI:ItemShow_Create(parent, ID, x, y, itemData) end



---设置控件点击事件
---@param widget parent控件对象
---@param value fun回调函数
function GUI:addOnClickEvent(widget, value) end


---设置控件是否可以点击
---@param widget parent控件对象
---@param value bool是否可点击
function GUI:setTouchEnabled(widget, value) end

---关闭面板
---@param parent parent控件对象
function GUI:Win_Close(parent) end

---设置控件大小
---@param widget parent控件对象
---@param size size
function GUI:setContentSize(widget, size) end

---创建按钮控件
---@param _Parent parent父控件对象
---@param _ID string控件ID
---@param _PosX int控件位置的横坐标
---@param _PosY int控件位置的纵坐标
---@param _nimg string图片路径
---@return 创建成功则返回新建控件的对象创建失败则返回空
function GUI:Button_Create( _Parent, _ID, _PosX, _PosY, _nimg) end

---设置按钮正常状态图片
---@param widget parent按钮对象
---@param filepath string图片路径
function GUI:Button_loadTextureNormal(widget, filepath) end


---设置按钮按下状态图片
---@param widget parent按钮对象
---@param filepath string图片路径
function GUI:Button_loadTexturePressed(widget, filepath) end


---设置按钮禁用状态图片
---@param widget parent按钮对象
---@param filepath string图片路径
function GUI:Button_loadTextureDisabled(widget, filepath) end


---设置控件锚点
---@param widget parent控件对象
---@param x int控件横向锚点
---@param y int控件纵向锚点
function GUI:setAnchorPoint(widget, x, y) end

---创建容器控件
---@param _Parent parent父控件对象
---@param _ID string控件ID
---@param _PosX int控件位置的横坐标
---@param _PosY int控件位置的纵坐标
---@param _Width int控件的宽
---@param _Height int控件的高
---@param _isClip bool是否裁剪
---@return 创建成功则返回新建控件的对象创建失败则返回空
function GUI:Layout_Create( _Parent, _ID, _PosX, _PosY, _Width, _Height, _isClip) end

---设置控件缩放
---@param widget parent控件对象
---@param value int缩放比例
function GUI:setScale(widget, value) end


---设置容器背景颜色
---@param widget parent控件对象
---@param value string颜色
function GUI:Layout_setBackGroundColor(widget, value) end


---设置容器是否有背景颜色
---@param widget parent控件对象
---@param value bool是否有颜色
function GUI:Layout_setBackGroundColorType(widget, value) end


---设置容器背景透明度
---@param widget parent控件对象
---@param value int透明度(0-255)
function GUI:Layout_setBackGroundColorOpacity(widget, value) end

---设置图片控件九宫格参数
---@param widget parent控件对象
---@param scale9l int左边比例
---@param scale9r int右边比例
---@param scale9t int上边比例
---@param scale9b int下边比例
function GUI:Image_setScale9Slice(widget, scale9l, scale9r, scale9t, scale9b) end


---设置列表容器是否裁剪
---@param widget parent控件对象
---@param value bool是否裁剪
function GUI:ListView_setClippingEnabled(widget, value) end


---创建列表容器
---@param parent parent父控件对象
---@param ID string控件ID
---@param x int控件位置的横坐标
---@param y int控件位置的纵坐标
---@param width int控件的宽
---@param height int控件的高
---@param direction int滑动方向1垂直2水平
---@return 创建成功则返回新建控件的对象创建失败则返回空
function GUI:ListView_Create(parent, ID, x, y, width, height, direction) end


---获取控件对象
---@param parent parent父控件对象
---@param ID string控件ID
---@return 获取成功则返回新建控件的对象获取失败则返回空
function GUI:GetWindow(parent, ID) end

---设置按钮是否禁用拓展
---@param widget parent按钮对象
---@param value bool是否禁用
function GUI:Button_setBrightEx(widget, value) end



---创建文本控件
---@param parent parent父控件对象
---@param ID string控件ID
---@param x int控件位置的横坐标
---@param y int控件位置的纵坐标
---@param fontSize int字体大小
---@param fontColor string颜色
---@param str string文本内容
---@return 创建成功则返回新建控件的对象创建失败则返回空
function GUI:Text_Create(parent, ID, x, y, fontSize, fontColor, str) end

---获取输入框控件文本
---@param widget parent控件对象
---@return str/int
function GUI:TextInput_getString(widget) end

---设置文本控件的文本
---@param widget parent控件对象
---@param value string文本
function GUI:Text_setString(widget, value) end

---创建富文本控件
---@param parent parent父控件对象
---@param ID string控件ID
---@param x int控件位置的横坐标
---@param y int控件位置的纵坐标
---@param str string文本内容
---@param width int控件的宽
---@param Size int字体大小
---@param Color int颜色
---@param vspace int间距
---@param hyperlinkCB fun超链回调
---@return 创建成功则返回新建控件的对象创建失败则返回空
function GUI:RichText_Create(parent, ID, x, y, str, width, Size, Color, vspace, hyperlinkCB) end

---设置打开面板特效(小-大)1
---@param widget parent父控件对象
function GUI:Timeline_Window1(widget) end
---设置打开面板特效(小-大)2
---@param widget parent父控件对象
function GUI:Timeline_Window2(widget) end
---设置打开面板特效(小-大)3
---@param widget parent父控件对象
function GUI:Timeline_Window3(widget) end
---设置打开面板特效(大-小)4
---@param widget parent父控件对象
function GUI:Timeline_Window4(widget) end
---设置打开面板特效(大-小)5
---@param widget parent父控件对象
function GUI:Timeline_Window5(widget) end
---设置打开面板特效(大-小)6
---@param widget parent父控件对象
function GUI:Timeline_Window6(widget) end

---创建特效控件
---@param parent parent父控件对象
---@param ID string控件ID
---@param x int控件位置的横坐标
---@param y int控件位置的纵坐标
---@param effecttype 特效类型0特效1NPC2怪物3技能4人物5武器6翅膀7发型
---@param effectid int特效ID
---@param sex int性别
---@param act 特效动作0待机1走2攻击3施法4死亡5跑步
---@param dir 特效方向0上1右上2右
---@param speed int播放速度
function GUI:Effect_Create(parent, ID, x, y, effecttype, effectid, sex, act, dir, speed) end

---设置特效播放
---@param widget parent控件对象
---@param act 特效动作0待机1走2攻击3施法4死亡5跑步
---@param dir 特效方向0上1右上2右
---@param isLoop bool是否循环
---@param speed int播放速度
---@param isSequence int是否暂停最后一帧
function GUI:Effect_play(widget, act, dir, isLoop, speed, isSequence) end

---创建艺术字控件
---@param parent parent父控件对象
---@param ID string控件ID
---@param x int控件位置的横坐标
---@param y int控件位置的纵坐标
---@param value int当前显示数字
---@param charMapFile string艺术字图片路径
---@param Width int字符宽
---@param Height int字符高
---@param startCharMap int首字符
---@return 创建成功则返回新建按钮控件的对象
function GUI:TextAtlas_Create(parent, ID, x, y, stringValue, charMapFile, Width, Height, startCharMap) end


---设置艺术字控件内容
---@param widget parent控件对象
---@param value int内容
function GUI:TextAtlas_setString(widget, value) end

---获取艺术字控件内容
---@param widget parent控件对象
---@return 获取成功则返回艺术字内容
function GUI:TextAtlas_getString(widget) end

---设置列表容器控件间隔
---@param widget parent控件对象
---@param value int间隔
function GUI:ListView_setItemsMargin(widget, value) end

---创建复选框控件
---@param parent parent父控件对象
---@param ID string控件ID
---@param x int控件位置的横坐标
---@param y int控件位置的纵坐标
---@param nimg string图片背景图片
---@param pimg string打勾图片路径
---@return 创建成功则返回新建控件的对象创建失败则返回空
function GUI:CheckBox_Create(parent, ID, x, y, nimg, pimg) end

---Text_setTextColor
---@param widget parent控件对象
---@param value string颜色
function GUI:Text_setTextColor(widget, value) end

---将控件从父控件移除
---@param widget parent	控件对象
function GUI:removeFromParent(widget) end

---设置控件是否显示
---@param widget parent控件对象
---@param value bool是否显示
function GUI:setVisible(widget, value) end
