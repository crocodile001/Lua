local utf8 = require( "modules.utf8_simple" )  --字串處理(utf8)
local composer  = require( "composer" )   --轉換場景
local widget    = require( "widget" )     --按鈕
local movieclip = require( "movieclip" )  --動畫
local physics   = require( "physics" )    --物理引擎
physics.start()                           --物理引擎啟動
physics.setGravity( 0, 0 )

local scene = composer.newScene()         --建立新場景

------------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called
------------------------------------------------------------------------------------------------------------------

-- "scene:create()" 畫面相關物件建立，不包括native物件，EX：輸入框，應該在scene:show()函數裡建立
function scene:create( event )

    local sceneGroup = self.view     --畫面相關物件加入群組，離開此場景時

      -- Initialize the scene here
      -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    
-- 背景圖 --------------------------------------------------------------------------------
    local background = display.newImageRect( sceneGroup, "images/forest.jpg", 580, 340 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
------------------------------------------------------------------------------------------
    
end

-- "scene:show()" 可以加入需要的執行動作，--執行兩次
function scene:show( event ) 

    local sceneGroup = self.view
    local phase = event.phase
    
    --如沒設定will or did 會執行兩次
    if ( phase == "will" ) then      --未在螢幕時執行，EX：移除前一場景、移除場景
    
        -- Called when the scene is still off screen (but is about to come on screen)
        
    elseif ( phase == "did" ) then   --已在螢幕後執行
    
      audio.stop()

-- 背景音樂 ----------------------------------------------
      local bgm = audio.loadSound("sounds/lv1.wav" )
      audio.play( bgm, { loops=-1 } )
----------------------------------------------------------

-- 人物圖片 ------------------------------------------------------------------------------------
      local main_actress = display.newImageRect(sceneGroup, 'images/main_actress_mask.png', 200, 300)
      main_actress.x = display.contentCenterX + 100
      main_actress.y = display.contentCenterY - 30
      
      local main_actor = display.newImageRect(sceneGroup, 'images/沈安.png', 200, 300)
      main_actor.x = display.contentCenterX - 100
      main_actor.y = display.contentCenterY - 30
      main_actor:setFillColor(0.5,0.5,0.5)
------------------------------------------------------------------------------------------------

-- 對話框 -----------------------------------------------------------------
      local txt = display.newImageRect("images/txt_box.jpg", 500, 100)
      txt.x=display.contentCenterX
      txt.y=display.contentCenterY + 100
      sceneGroup:insert(txt)
---------------------------------------------------------------------------

-- 對話文本 ------------------------------------------
      local txt ={
        "???：\n七月初一鬼門開，銀狐大人過小橋。橋下河水流啊流，河裡飄個傻姑娘；七月初五花兒香，銀狐大人巡庄稼。田中有棵大榕樹，樹上吊個老農民。",
        "沈安：\n\n不好意思，請問妳知道銀狐村怎麼走嗎？",
        "???：  ε＝ε＝ε＝(#>д<)ﾉ",
        "沈安：ε=ε=ε=┏(;°ロ°)┛!!",
      }
      
      local txt2 ={
        "\n\n我是物品欄喔"
      }
      
      -- 文本顯示變數
      local i = 1
      local ii = 1
      local j = 1
      local lock = 1
      local lock2 = 0
----------------------------------------------------
  
-- 文字框 --------------------------------------------------------------------------
      local multiText = display.newText( "", 125, 240, 400, 70, "Helvetica", 14 )
      multiText.x=display.contentCenterX - 25
      multiText.y=display.contentCenterY + 103
      multiText:setFillColor( 1,1,1 ) 
      sceneGroup:insert(multiText)
----------------------------------------------------------------------------------

-- 前往下一關 ------------------------------------------------------------
      local goto = function(event)
        LEVEL = 1.3; lock = 1; lock2 = 1
        composer.gotoScene("level_1_3",{ time=500, effect="fade" } )
      end
----------------------------------------------------------------------

-- 顯示文本 -------------------------------------------------------------- 
      -- 顯示 next 之外的文本
      local iter2 = function()
        multiText.text = utf8.sub(txt2[ii],1,j)
        j = j + 1
        print (multiText.text)
        
        if (j == utf8.len(txt2[ii])) then
          lock2 = 0
        end
      end
      
      -- 顯示 next 的文本
      local iter = function()
        multiText.text = utf8.sub(txt[i],1,j)
        j = j + 1
        print (multiText.text)
        
        if (j == utf8.len(txt[i])) then
          lock = 0
        end
      end

      -- 第一次執行文本顯示
      audio.play( btn, {channel=2,1} )
      timer.performWithDelay(50,iter,utf8.len(txt[i]))

      -- next function
      local function press_next(event)
        if (lock2 == 0 and i~=4) then
        
          if (i~=4) then
            i = i + 1
            audio.play( btn, {channel=2,1} )
          end
          
          -- 腳色反黑
          if (i==2 or i==4) then
            main_actor:setFillColor(1,1,1)
            main_actress:setFillColor(0.5,0.5,0.5)
          elseif (i==1 or i==3) then
            main_actor:setFillColor(0.5,0.5,0.5)
            main_actress:setFillColor(1,1,1)
          else
            main_actor:setFillColor(0.5,0.5,0.5)
            main_actress:setFillColor(0.5,0.5,0.5)
          end
          
          j = 1; lock = 1
          timer.performWithDelay(50,iter,utf8.len(txt[i]))
          
          if (i==4) then
            timer.performWithDelay(1000,goto)
          end
          
        end
      end
----------------------------------------------------------------------- 

-- 返回選單 --------------------------------------------------------------
      local b_Press = function( event )
        if (lock == 0 and lock2 == 0) then
          audio.play( btn, {channel=2,1} )
          composer.gotoScene("mlist",{ time=500, effect="fade" } )
        end
      end
-----------------------------------------------------------------------
         
-- return list button -------------------------------------------------------------
      local button = widget.newButton
      {
          defaultFile = "images/bMain.png",          -- 未按按鈕時顯示的圖片
          overFile = "images/bMaino.png",
          onPress = b_Press,                            -- 觸發按下按鈕事件要執行的函式
      }
      -- 按鈕物件位置
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

-- 存檔 ------------------------------------------
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

-- 物品變數 ----------------
-- local village_head = 0
-------------------------

---- 按鈕事件 ---------------------------------------------
--      local buttonHandler = function( event )
--        if (lock == 0 and lock2 == 0) then
--        
--          --myText.text = "id = " .. event.target.id .. ", 狀態 = " .. event.phase  -- 顯示觸發的按鈕 id 和引發觸發事件的狀態
--          audio.play( btn2, {channel=2,1} )
--          if (event.target.id == 1 or event.target.id == 2 or event.target.id == 3 or event.target.id == 4) then
--            j = 1;  ii = 1;   lock2 = 1
--            timer.performWithDelay(50,iter2,utf8.len(txt2[1]))
--          end  
--        
--        end
--      end
----------------------------------------------------------
--      
---- 物品欄 --------------------------------------------------------------
--      local button1 = widget.newButton{
--        id = 1,                                  -- 給按鈕ㄧ個識別名稱
--        defaultFile = "images/bChose.png",          -- 未按按鈕的圖片
--        overFile = "images/bChoseo.png",      -- 按下按鈕的圖片
--        onEvent = buttonHandler                  -- 引發觸發事件要執行的函式
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
--      -- 按鈕物件設置
--      button1.x = display.contentCenterX-235; button1.y = display.contentCenterY+30; button1.width = 35; button1.height = 30; sceneGroup:insert(button1)
--      button2.x = display.contentCenterX-200; button2.y = display.contentCenterY+30; button2.width = 35; button2.height = 30; sceneGroup:insert(button2)
--      button3.x = display.contentCenterX-165; button3.y = display.contentCenterY+30; button3.width = 35; button3.height = 30; sceneGroup:insert(button3)
--      button4.x = display.contentCenterX-130; button4.y = display.contentCenterY+30; button4.width = 35; button4.height = 30; sceneGroup:insert(button4)
------------------------------------------------------------------------

    end
end


-- "scene:hide()" --執行兩次
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then     --場景在螢幕將要卸載時執行  EX:終止音樂、停止動畫
        -- Called when the scene is on screen (but is about to go off screen)
        -- Insert code here to "pause" the scene
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then  --場景在螢幕卸載時立刻執行
        -- Called immediately after scene goes off screen
        composer.removeScene("level_1_2")
    end
end


-- "scene:destroy()"
function scene:destroy( event )

        local sceneGroup = self.view   
        sceneGroup:removeSelf()        --釋放群組物件
        sceneGroup = nil
        
        local beamGroup = self.view   
        beamGroup:removeSelf()        --釋放群組物件
        beamGroup = nil

end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )   --場景時先被呼叫的地方，可以加入場景需要的物件以及相對應的函數
scene:addEventListener( "show", scene )     --場景要開始運作的進入點，在這裡可以加入需要的執行動作
scene:addEventListener( "hide", scene )     --場景要被切換時會呼叫，也就是要離開場景時
scene:addEventListener( "destroy", scene )  --場景被移除時呼叫

-- -------------------------------------------------------------------------------

return scene