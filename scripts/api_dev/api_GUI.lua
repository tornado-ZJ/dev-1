---@class GUI
GUI = {}


--�Ƴ����������ӿؼ�
---@param widget widget�ؼ�����
function GUI:removeAllChildren(widget) end
--���ÿؼ�͸����
--widget	��	parent	�ؼ�����
--value	��	int	͸����(0-255)
---@param value parent
---@param widget string
function GUI:setOpacity(widget, value) end

--���ÿؼ�����
---@param value integer
---@return nil
--widget    ��    parent    �ؼ�����
--value	��	int	���ű��� 1Ϊ�������� 0.5Ϊ��Сһ�� 2Ϊ�Ŵ�һ��
function GUI:setScale(widget, value) end

--��ȡ�ؼ���С
---@param widget parent
---@return size
function GUI:getContentSize(widget) end

--����ͼƬ�ؼ�
---@param parent parent���ؼ�����
---@param ID string�ؼ�ID
---@param PosX int�ؼ�λ�õĺ�����
---@param PosY int�ؼ�λ�õ�������
---@param nimg stringͼƬ·��
---@return widget �����ɹ��򷵻��½��ؼ��Ķ���,����ʧ���򷵻ؿ�
function GUI:Image_Create(parent, ID, PosX, PosY, nimg) end

---������Ʒ��ؼ�
---@param parent parent���ؼ�����
---@param ID string�ؼ�ID
---@param x int�ؼ�λ�õĺ�����
---@param y int�ؼ�λ�õ�������
---@param itemData itemdata
---@return �����ɹ��򷵻ؿؼ��Ķ��󴴽�ʧ���򷵻�nil
function GUI:ItemShow_Create(parent, ID, x, y, itemData) end



---���ÿؼ�����¼�
---@param widget parent�ؼ�����
---@param value fun�ص�����
function GUI:addOnClickEvent(widget, value) end


---���ÿؼ��Ƿ���Ե��
---@param widget parent�ؼ�����
---@param value bool�Ƿ�ɵ��
function GUI:setTouchEnabled(widget, value) end

---�ر����
---@param parent parent�ؼ�����
function GUI:Win_Close(parent) end

---���ÿؼ���С
---@param widget parent�ؼ�����
---@param size size
function GUI:setContentSize(widget, size) end

---������ť�ؼ�
---@param _Parent parent���ؼ�����
---@param _ID string�ؼ�ID
---@param _PosX int�ؼ�λ�õĺ�����
---@param _PosY int�ؼ�λ�õ�������
---@param _nimg stringͼƬ·��
---@return �����ɹ��򷵻��½��ؼ��Ķ��󴴽�ʧ���򷵻ؿ�
function GUI:Button_Create( _Parent, _ID, _PosX, _PosY, _nimg) end

---���ð�ť����״̬ͼƬ
---@param widget parent��ť����
---@param filepath stringͼƬ·��
function GUI:Button_loadTextureNormal(widget, filepath) end


---���ð�ť����״̬ͼƬ
---@param widget parent��ť����
---@param filepath stringͼƬ·��
function GUI:Button_loadTexturePressed(widget, filepath) end


---���ð�ť����״̬ͼƬ
---@param widget parent��ť����
---@param filepath stringͼƬ·��
function GUI:Button_loadTextureDisabled(widget, filepath) end


---���ÿؼ�ê��
---@param widget parent�ؼ�����
---@param x int�ؼ�����ê��
---@param y int�ؼ�����ê��
function GUI:setAnchorPoint(widget, x, y) end

---���������ؼ�
---@param _Parent parent���ؼ�����
---@param _ID string�ؼ�ID
---@param _PosX int�ؼ�λ�õĺ�����
---@param _PosY int�ؼ�λ�õ�������
---@param _Width int�ؼ��Ŀ�
---@param _Height int�ؼ��ĸ�
---@param _isClip bool�Ƿ�ü�
---@return �����ɹ��򷵻��½��ؼ��Ķ��󴴽�ʧ���򷵻ؿ�
function GUI:Layout_Create( _Parent, _ID, _PosX, _PosY, _Width, _Height, _isClip) end

---���ÿؼ�����
---@param widget parent�ؼ�����
---@param value int���ű���
function GUI:setScale(widget, value) end


---��������������ɫ
---@param widget parent�ؼ�����
---@param value string��ɫ
function GUI:Layout_setBackGroundColor(widget, value) end


---���������Ƿ��б�����ɫ
---@param widget parent�ؼ�����
---@param value bool�Ƿ�����ɫ
function GUI:Layout_setBackGroundColorType(widget, value) end


---������������͸����
---@param widget parent�ؼ�����
---@param value int͸����(0-255)
function GUI:Layout_setBackGroundColorOpacity(widget, value) end

---����ͼƬ�ؼ��Ź������
---@param widget parent�ؼ�����
---@param scale9l int��߱���
---@param scale9r int�ұ߱���
---@param scale9t int�ϱ߱���
---@param scale9b int�±߱���
function GUI:Image_setScale9Slice(widget, scale9l, scale9r, scale9t, scale9b) end


---�����б������Ƿ�ü�
---@param widget parent�ؼ�����
---@param value bool�Ƿ�ü�
function GUI:ListView_setClippingEnabled(widget, value) end


---�����б�����
---@param parent parent���ؼ�����
---@param ID string�ؼ�ID
---@param x int�ؼ�λ�õĺ�����
---@param y int�ؼ�λ�õ�������
---@param width int�ؼ��Ŀ�
---@param height int�ؼ��ĸ�
---@param direction int��������1��ֱ2ˮƽ
---@return �����ɹ��򷵻��½��ؼ��Ķ��󴴽�ʧ���򷵻ؿ�
function GUI:ListView_Create(parent, ID, x, y, width, height, direction) end


---��ȡ�ؼ�����
---@param parent parent���ؼ�����
---@param ID string�ؼ�ID
---@return ��ȡ�ɹ��򷵻��½��ؼ��Ķ����ȡʧ���򷵻ؿ�
function GUI:GetWindow(parent, ID) end

---���ð�ť�Ƿ������չ
---@param widget parent��ť����
---@param value bool�Ƿ����
function GUI:Button_setBrightEx(widget, value) end



---�����ı��ؼ�
---@param parent parent���ؼ�����
---@param ID string�ؼ�ID
---@param x int�ؼ�λ�õĺ�����
---@param y int�ؼ�λ�õ�������
---@param fontSize int�����С
---@param fontColor string��ɫ
---@param str string�ı�����
---@return �����ɹ��򷵻��½��ؼ��Ķ��󴴽�ʧ���򷵻ؿ�
function GUI:Text_Create(parent, ID, x, y, fontSize, fontColor, str) end

---��ȡ�����ؼ��ı�
---@param widget parent�ؼ�����
---@return str/int
function GUI:TextInput_getString(widget) end

---�����ı��ؼ����ı�
---@param widget parent�ؼ�����
---@param value string�ı�
function GUI:Text_setString(widget, value) end

---�������ı��ؼ�
---@param parent parent���ؼ�����
---@param ID string�ؼ�ID
---@param x int�ؼ�λ�õĺ�����
---@param y int�ؼ�λ�õ�������
---@param str string�ı�����
---@param width int�ؼ��Ŀ�
---@param Size int�����С
---@param Color int��ɫ
---@param vspace int���
---@param hyperlinkCB fun�����ص�
---@return �����ɹ��򷵻��½��ؼ��Ķ��󴴽�ʧ���򷵻ؿ�
function GUI:RichText_Create(parent, ID, x, y, str, width, Size, Color, vspace, hyperlinkCB) end

---���ô������Ч(С-��)1
---@param widget parent���ؼ�����
function GUI:Timeline_Window1(widget) end
---���ô������Ч(С-��)2
---@param widget parent���ؼ�����
function GUI:Timeline_Window2(widget) end
---���ô������Ч(С-��)3
---@param widget parent���ؼ�����
function GUI:Timeline_Window3(widget) end
---���ô������Ч(��-С)4
---@param widget parent���ؼ�����
function GUI:Timeline_Window4(widget) end
---���ô������Ч(��-С)5
---@param widget parent���ؼ�����
function GUI:Timeline_Window5(widget) end
---���ô������Ч(��-С)6
---@param widget parent���ؼ�����
function GUI:Timeline_Window6(widget) end

---������Ч�ؼ�
---@param parent parent���ؼ�����
---@param ID string�ؼ�ID
---@param x int�ؼ�λ�õĺ�����
---@param y int�ؼ�λ�õ�������
---@param effecttype ��Ч����0��Ч1NPC2����3����4����5����6���7����
---@param effectid int��ЧID
---@param sex int�Ա�
---@param act ��Ч����0����1��2����3ʩ��4����5�ܲ�
---@param dir ��Ч����0��1����2��
---@param speed int�����ٶ�
function GUI:Effect_Create(parent, ID, x, y, effecttype, effectid, sex, act, dir, speed) end

---������Ч����
---@param widget parent�ؼ�����
---@param act ��Ч����0����1��2����3ʩ��4����5�ܲ�
---@param dir ��Ч����0��1����2��
---@param isLoop bool�Ƿ�ѭ��
---@param speed int�����ٶ�
---@param isSequence int�Ƿ���ͣ���һ֡
function GUI:Effect_play(widget, act, dir, isLoop, speed, isSequence) end

---���������ֿؼ�
---@param parent parent���ؼ�����
---@param ID string�ؼ�ID
---@param x int�ؼ�λ�õĺ�����
---@param y int�ؼ�λ�õ�������
---@param value int��ǰ��ʾ����
---@param charMapFile string������ͼƬ·��
---@param Width int�ַ���
---@param Height int�ַ���
---@param startCharMap int���ַ�
---@return �����ɹ��򷵻��½���ť�ؼ��Ķ���
function GUI:TextAtlas_Create(parent, ID, x, y, stringValue, charMapFile, Width, Height, startCharMap) end


---���������ֿؼ�����
---@param widget parent�ؼ�����
---@param value int����
function GUI:TextAtlas_setString(widget, value) end

---��ȡ�����ֿؼ�����
---@param widget parent�ؼ�����
---@return ��ȡ�ɹ��򷵻�����������
function GUI:TextAtlas_getString(widget) end

---�����б������ؼ����
---@param widget parent�ؼ�����
---@param value int���
function GUI:ListView_setItemsMargin(widget, value) end

---������ѡ��ؼ�
---@param parent parent���ؼ�����
---@param ID string�ؼ�ID
---@param x int�ؼ�λ�õĺ�����
---@param y int�ؼ�λ�õ�������
---@param nimg stringͼƬ����ͼƬ
---@param pimg string��ͼƬ·��
---@return �����ɹ��򷵻��½��ؼ��Ķ��󴴽�ʧ���򷵻ؿ�
function GUI:CheckBox_Create(parent, ID, x, y, nimg, pimg) end

---Text_setTextColor
---@param widget parent�ؼ�����
---@param value string��ɫ
function GUI:Text_setTextColor(widget, value) end

---���ؼ��Ӹ��ؼ��Ƴ�
---@param widget parent	�ؼ�����
function GUI:removeFromParent(widget) end

---���ÿؼ��Ƿ���ʾ
---@param widget parent�ؼ�����
---@param value bool�Ƿ���ʾ
function GUI:setVisible(widget, value) end
