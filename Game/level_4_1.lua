local utf8 = require( "modules.utf8_simple" )  --摮葡����(utf8)
local composer  = require( "composer" )   --頧��
local widget    = require( "widget" )     --����
local movieclip = require( "movieclip" )  --��
local physics   = require( "physics" )    --������
physics.start()                           --��������
physics.setGravity( 0, 0 )


local scene = composer.newScene()         --撱箇���

------------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called
------------------------------------------------------------------------------------------------------------------


-- "scene:create()" �����隞嗅遣蝡���native�隞塚�X嚗撓�獢��府�scene:show()��鋆∪遣蝡�
function scene:create( event )

    local sceneGroup = self.view     --�����隞嗅�蝢斤����迨�����

      -- Initialize the scene here
      -- Example: add display objects to "sceneGroup", add touch listeners, etc.

-- ����� --------------------------------------------------------------------------------
    local background = display.newImageRect( sceneGroup, "images/面具店.png", 580, 340 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
------------------------------------------------------------------------------------------
    
end

-- "scene:show()" �隞亙���閬�銵����--�銵甈�
function scene:show( event ) 

    local sceneGroup = self.view
    local phase = event.phase
    
    --憒�身摰ill or did ��銵甈�
    if ( phase == "will" ) then      --���撟�銵�X嚗宏�������宏���
    
        -- Called when the scene is still off screen (but is about to come on screen)
        
    elseif ( phase == "did" ) then   --撌脣�撟�銵�
    
        audio.stop()

-- ���璅� ----------------------------------------------
      local bgm = audio.loadSound("sounds/lv1.wav" ) 
      audio.play( bgm, { loops=-1 } )
----------------------------------------------------------

-- 鈭箇���� ------------------------------------------------------------------------------------
      local main_actor = display.newImageRect(sceneGroup, 'images/沈安.png', 200, 300)
      main_actor.x = display.contentCenterX - 100
      main_actor.y = display.contentCenterY +20
      
      local mask_clink = display.newImageRect(sceneGroup, 'images/面具店店員.png', 200, 300)
      mask_clink.x = display.contentCenterX + 100
      mask_clink.y = display.contentCenterY - 30
      mask_clink:setFillColor(0.5,0.5,0.5)
------------------------------------------------------------------------------------------------

-- 撠店獢� -----------------------------------------------------------------
      local txt = display.newImageRect("images/txt_box.jpg", 500, 100)
      txt.x=display.contentCenterX
      txt.y=display.contentCenterY + 100
      sceneGroup:insert(txt)
---------------------------------------------------------------------------

-- 撠店�� ------------------------------------------
      local txt ={
        "沈安:\n我是調查局的調查員沈安，目前正在調查這幾天的死亡案件，想請問你一些問題。",
        "沈安:\n請問有沒有一個女人來買過面具?",
        "店員:\n那個人長得滿像村長女兒的，沒記錯的話，他買過一個狐狸面具。",
        "沈安:\n村長有一個女兒?\n他不是沒老婆嗎??",
        "店員:\n那女兒並不是親生的，好像是村長有一次從村外回來時，在樹林裡發現的。發現他時，身邊沒有任何親人，覺得可憐，便把她帶回村裡一直養到現在。",
      }
      
      local txt2 ={
        "這在哪???"
      }
      
      -- ��憿舐內霈
      local i = 1         -- txt ��� conuter
      local ii = 1        -- txt2 ��� counter
      local j = 1         -- txt ��� txt2 ��� counter
      local lock = 1      -- lock next 銋�����
      local lock2 = 0     -- lock next
----------------------------------------------------
   
-- ����� --------------------------------------------------------------------------
      local multiText = display.newText( "", 125, 240, 400, 70, "Helvetica", 14 )
      multiText.x=display.contentCenterX - 25
      multiText.y=display.contentCenterY + 103
      multiText:setFillColor( 1,1,1 ) 
      sceneGroup:insert(multiText)
------------------------------------------------------------------------------------
  
-- ���銝���� ------------------------------------------------------------
      local goto = function(event)
        LEVEL = 4.2; lock = 1; lock2 = 1
        save()                                -- ����
        composer.gotoScene("level_4_2",{ time=500, effect="fade" } )
      end
--------------------------------------------------------------------------
      
-- 憿舐內�� -------------------------------------------------------------- 
      -- 憿舐內 next 銋���
      local iter2 = function()
        multiText.text = utf8.sub(txt2[ii],1,j)
        j = j + 1
        print (multiText.text)
        
        if (j == utf8.len(txt2[ii])) then
          lock2 = 0
        end
      end
      
      -- 憿舐內 next ���
      local iter = function()
        multiText.text = utf8.sub(txt[i],1,j)
        j = j + 1
        print (multiText.text)
        
        if (j == utf8.len(txt[i])) then
          lock = 0
        end
      end
      
      -- 蝚砌�甈∪銵�憿舐內
      audio.play( btn, {channel=2,1} )
      timer.performWithDelay(50,iter,utf8.len(txt[i]))
      
      -- next function
      local function press_next(event)
        if (lock2 == 0 and i~=5) then
        
          if (i~=5) then
            i = i + 1
            audio.play( btn, {channel=2,1} )
          end
          
          if (i==2 or i==4) then
            main_actor:setFillColor(1,1,1)
            mask_clink:setFillColor(0.5,0.5,0.5)
          elseif (i==1 or i==3 or i==5) then
            main_actor:setFillColor(0.5,0.5,0.5)
            mask_clink:setFillColor(1,1,1)
          else
            main_actor:setFillColor(0.5,0.5,0.5)
            mask_clink:setFillColor(0.5,0.5,0.5)
          end
          
          j = 1; lock = 1
          timer.performWithDelay(50,iter,utf8.len(txt[i]))
          
          if (i==5) then
            timer.performWithDelay(8000,goto)
          end
          
        end
      end
----------------------------------------------------------------------- 

-- 餈�� --------------------------------------------------------------
      local b_Press = function( event )
        if (lock == 0 and lock2 == 0) then
          audio.play( btn, {channel=2,1} ) 
          composer.gotoScene("mlist",{ time=500, effect="fade" } )
        end
      end
--------------------------------------------------------------------------
      
-- return list button -------------------------------------------------------------
      local button = widget.newButton
      {
          defaultFile = "images/bMain.png",             -- ������＊蝷箇����
          overFile = "images/bMaino.png",
          onPress = b_Press,                            -- 閫貊������辣閬銵�撘�
      }
      -- ���隞嗡�蔭
      button.width = 70
      button.height = 45
      button.x = display.contentCenterX+220
      button.y = display.contentCenterY-130
      sceneGroup:insert(button)
-----------------------------------------------------------------------------------

-- next button -----------------------------------------
      local buttonNext = widget.newButton
      {
        defaultFile = "images/bChose.png", 
        overFile = "images/bChoseo.png",                     
        label = "next",                             
        font = native.systemFont,                     
        labelColor = { default = { 1, 1, 1 } },       
        fontSize = 100,                               
        onPress = press_next,                    
      }
      sceneGroup:insert(buttonNext)
      buttonNext.x = display.contentCenterX + 220
      buttonNext.y = display.contentCenterY + 120
      buttonNext.width = 35
      buttonNext.height = 30
---------------------------------------------------------

-- 摮�� ------------------------------------------
      local buttonSave = widget.newButton
      {
        defaultFile = "images/bChose.png", 
        overFile = "images/bChoseo.png",                     
        label = "save",                             
        font = native.systemFont,                     
        labelColor = { default = { 1, 1, 1 } },       
        fontSize = 100,                               
        onPress = save,                    
      }
      sceneGroup:insert(buttonSave)
      buttonSave.x = display.contentCenterX + 220
      buttonSave.y = display.contentCenterY + 80
      buttonSave.width = 35
      buttonSave.height = 30
--------------------------------------------------


-- ���� ---------------------------------------------

---------------------------------------------------------

---- ����辣 ---------------------------------------------
--      local buttonHandler = function( event )
--        if (lock == 0 and lock2 == 0) then
--        
--          --myText.text = "id = " .. event.target.id .. ", ����� = " .. event.phase  -- 憿舐內閫貊����� id ���閫貊鈭辣������
--          audio.play( btn2, {channel=2,1} )
--          if (event.target.id == 1 or event.target.id == 2 or event.target.id == 3 or event.target.id == 4) then
--            j = 1;   ii = 1;   lock2 = 1
--            timer.performWithDelay(50,iter2,utf8.len(txt2[1]))
--          end
--          
--        end
--      end
-----------------------------------------------------------
--
---- ����� -----------------------------------------------------------
--      local button1 = widget.newButton{
--        id = 1,                                  -- 蝯行������迂
--        defaultFile = "images/bChose.png",       -- ���������
--        overFile = "images/bChoseo.png",         -- ���������
--        onEvent = buttonHandler                  -- 撘閫貊鈭辣閬銵�撘�
--      }
--
--      local button2 = widget.newButton{
--        id = 2,
--        defaultFile = "images/bChose.png",
--        overFile = "images/bChoseo.png",
--        onEvent = buttonHandler
--      }
--      
--      local button3 = widget.newButton{
--        id = 3,
--        defaultFile = "images/bChose.png",
--        overFile = "images/bChoseo.png",
--        onEvent = buttonHandler
--      }
--      
--      local button4 = widget.newButton{
--        id = 4,
--        defaultFile = "images/bChose.png",
--        overFile = "images/bChoseo.png",
--        onEvent = buttonHandler
--      }
--      
--      -- ���隞嗉身蝵�
--      button1.x = display.contentCenterX-235; button1.y = display.contentCenterY+30; button1.width = 35; button1.height = 30; sceneGroup:insert(button1)
--      button2.x = display.contentCenterX-200; button2.y = display.contentCenterY+30; button2.width = 35; button2.height = 30; sceneGroup:insert(button2)
--      button3.x = display.contentCenterX-165; button3.y = display.contentCenterY+30; button3.width = 35; button3.height = 30; sceneGroup:insert(button3)
--      button4.x = display.contentCenterX-130; button4.y = display.contentCenterY+30; button4.width = 35; button4.height = 30; sceneGroup:insert(button4)
---------------------------------------------------------------------
      
    end
end


-- "scene:hide()" --�銵甈�
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then     --����撟��頛�銵�  EX:蝯迫�璅��迫��
        -- Called when the scene is on screen (but is about to go off screen)
        -- Insert code here to "pause" the scene
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then  --����撟頛���銵�
        -- Called immediately after scene goes off screen
        composer.removeScene("level_4_1")
    end
end


-- "scene:destroy()"
function scene:destroy( event )

        local sceneGroup = self.view   
        sceneGroup:removeSelf()        --��蝢斤�隞�
        sceneGroup = nil
        
        local beamGroup = self.view   
        beamGroup:removeSelf()         --��蝢斤�隞�
        beamGroup = nil

end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )   --�����◤�����嚗隞亙�����閬�隞嗡誑��撠���
scene:addEventListener( "show", scene )     --��閬������脣暺��ㄐ�隞亙���閬�銵���
scene:addEventListener( "hide", scene )     --��閬◤������嚗�停�閬������
scene:addEventListener( "destroy", scene )  --��鋡怎宏����

-- -------------------------------------------------------------------------------

return scene