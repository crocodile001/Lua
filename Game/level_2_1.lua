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
    
-- 背景圖 ----------------------------------------------------------------------------------
    local background = display.newImageRect( sceneGroup, "images/office.jpg", 580, 340 )
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
      local main_actor = display.newImageRect(sceneGroup, 'images/沈安.png', 200, 300)
      main_actor.x = display.contentCenterX - 100
      main_actor.y = display.contentCenterY + 20
      main_actor.isVisible = false
------------------------------------------------------------------------------------------------

-- 對話框 -----------------------------------------------------------------
      local txt = display.newImageRect("images/txt_box.jpg", 500, 100)
      txt.x=display.contentCenterX
      txt.y=display.contentCenterY + 100
      sceneGroup:insert(txt)
---------------------------------------------------------------------------


-- 對話文本 ------------------------------------------
      local txt ={
        "沈安：\n既然有人不明原因的死亡，應該會有死亡紀錄，去查看歷年資料應該會有線索"
      }
      
      local txt2 ={
        "\n\n我是物品欄喔",
        "\n\n獲得文獻分類資料",
        "\n\n找到歷年刑案紀錄及死亡紀錄位置",
        "\n\n獲得梯子",
        "沈安：\n奇怪，資料不見了。欸，是那個奇怪女人唱的童謠，還有一個狐狸形狀的鈴鐺，那女人的面具也是狐狸圖案的，難道有什麼關聯嗎？",
        "\n\n獲得狐狸鈴鐺",
        "\n\n獲得打火機",
        "沈安：\n\n獲得一封信",
        "沈安：\n\n原來資料在這裡!",
        "沈安：\n\n怎麼有一頁是空白的?好像要用打火機才可以開",
        "(信件內容)\n被沈安救起後，我在他家住了下來，他在我的脖子上掛了一個可愛的狐狸鈴鐺，也給我取了一個名字，他叫我小諾。諾是諾言的諾，他說他把我救起來，就會照顧我，",
        "讓我開開心心、無憂無慮過每一天。這些是他對我的諾，我好喜歡這個名字。而他也遵守他的諾，在他身邊我很開心，直到那件事發生……我離開村子，繼續修行，化為人形後，我幫自己取名許諾。沈安許我一世安穩，我諾沈安深仇必報。",
        "(紙上內容)\n七月初一鬼門開，銀狐大人過小橋。橋下河水流啊流，河裡飄個傻姑娘。七月初五花兒香，銀狐大人巡庄稼。田中有棵大榕樹，樹上吊個老農民。",
        "(歷年資料內容)\n第一次銀狐索命發生在瘟疫後一百年，前五年七月初一到七月初九的死亡紀錄，但七月初九的死亡方式都被塗掉了。而且發現每年這段時間都會有三人死亡，且原因都被記錄為自殺",
        "沈安：\n\n去村長家問問看!"
      }
      
      local i = 1
      local ii = 1
      local j = 1
      local lock = 0
      local lock2 = 0
      local lock3 = 0
----------------------------------------------------
      
-- 文字框 --------------------------------------------------------------------------
      local multiText = display.newText( "", 125, 240, 400, 70, "Helvetica", 14 )
      multiText.x=display.contentCenterX - 25
      multiText.y=display.contentCenterY + 103
      multiText:setFillColor( 1,1,1 ) 
      sceneGroup:insert(multiText)
----------------------------------------------------------------------------------

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
      --audio.play( btn, {channel=2,1} )
      --timer.performWithDelay(50,iter,utf8.len(txt[i]))
      
      -- next function
      local function press_next(event)
        if (lock==0 and lock2 == 0 and lock3 == 0 and i~=1) then
        
          if (i~=1) then
            i = i + 1
            audio.play( btn, {channel=2,1} )
          end
          
          j = 1; lock = 1
          timer.performWithDelay(50,iter,utf8.len(txt[i]))
        
        end
      end
-----------------------------------------------------------------------

-- 返回選單 --------------------------------------------------------------
      local b_Press = function( event )
        if (lock == 0 and lock2 == 0 and lock3 == 0) then
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
local bell = 0
local paper = 0
local box = 0
local ladder = 0
local letter = 0
local lighter = 0
-------------------------
      
---- 按鈕事件 ---------------------------------------------
      local goto = function(event)
        LEVEL = 2.2
        save()
        audio.play( btn, {channel=2,1} )
        composer.gotoScene("level_2_2",{ time=500, effect="fade" } )
      end

      local unlock = function(event)
        lock3 = 0
      end

      local talk = function(event)
        audio.play( btn, {channel=2,1} )
        j = 1;  ii = 5;   lock2 = 1
        timer.performWithDelay(50,iter2,utf8.len(txt2[5]))
        timer.performWithDelay(3000,unlock)
      end
      
      local talk3 = function(event)
        audio.play( btn, {channel=2,1} )
        j = 1;  ii = 12;   lock2 = 1
        timer.performWithDelay(50,iter2,utf8.len(txt2[12]))
        timer.performWithDelay(3000,unlock)
      end
      
      local talk2 = function(event)
        audio.play( btn, {channel=2,1} )
        j = 1;  ii = 11;   lock2 = 1
        timer.performWithDelay(50,iter2,utf8.len(txt2[11]))
        timer.performWithDelay(10000,talk3)
      end
      
      local talk4 = function(event)
        audio.play( btn, {channel=2,1} )
        j = 1;  ii = 15;
        timer.performWithDelay(50,iter2,utf8.len(txt2[15]))
        timer.performWithDelay(2000,goto)
      end
      
      
      
      local buttonHandler = function( event )
        if (lock == 0 and lock2 == 0 and lock3 == 0) then
      
          --myText.text = "id = " .. event.target.id .. ", 狀態 = " .. event.phase  -- 顯示觸發的按鈕 id 和引發觸發事件的狀態
          audio.play( btn2, {channel=2,1} )
          if (event.target.id == 1 or event.target.id == 2 or event.target.id == 3 or event.target.id == 4 or event.target.id == 5 or event.target.id == 6 or event.target.id == 7) then
            j = 1;  ii = 1;   lock2 = 1
            timer.performWithDelay(50,iter2,utf8.len(txt2[1]))
            
          elseif (event.target.id == "ladder") then
            j = 1;  ii = 4;   lock2 = 1
            timer.performWithDelay(50,iter2,utf8.len(txt2[4]))
            local clue1 = display.newImageRect("images/梯子.png", 30, 25)
            clue1.x=display.contentCenterX-235
            clue1.y=display.contentCenterY+30
            sceneGroup:insert(clue1)
            ladder = 1; 
          elseif( event.target.id == "paper") then
            j = 1;  ii = 13;   lock2 = 1
            timer.performWithDelay(50,iter2,utf8.len(txt2[13]))
            local clue2 = display.newImageRect("images/童謠紙_有字版.png", 30, 25)
            clue2.x=display.contentCenterX-200
            clue2.y=display.contentCenterY+30
            sceneGroup:insert(clue2)
            paper = 1; lock3 = 1
            timer.performWithDelay(10000,talk)
          elseif( event.target.id == "bell") then
            j = 1;  ii = 6;   lock2 = 1
            timer.performWithDelay(50,iter2,utf8.len(txt2[6]))
            local clue3 = display.newImageRect("images/狐狸鈴鐺.png", 30, 25)
            clue3.x=display.contentCenterX-165
            clue3.y=display.contentCenterY+30
            sceneGroup:insert(clue3)
            bell = 1;
          elseif( event.target.id == "lighter") then
            j = 1;  ii = 7;   lock2 = 1
            timer.performWithDelay(50,iter2,utf8.len(txt2[7]))
            local clue4 = display.newImageRect("images/打火機.png", 30, 25)
            clue4.x=display.contentCenterX-130
            clue4.y=display.contentCenterY+30
            sceneGroup:insert(clue4)
            lighter = 1; 
          elseif( event.target.id == "box" and bell ==1) then
            j = 1;  ii = 9;   lock2 = 1
            timer.performWithDelay(50,iter2,utf8.len(txt2[9]))
            local clue5 = display.newImageRect("images/盒子.png", 30, 25)
            clue5.x=display.contentCenterX-95
            clue5.y=display.contentCenterY+30
            sceneGroup:insert(clue5)
            box = 1;
          --elseif( event.target.id == "time_paper") then
            --j = 1;  ii = 10;   lock2 = 1
            --timer.performWithDelay(50,iter2,utf8.len(txt2[10]))
            --time_paper = 1;  
          elseif( event.target.id == "time_paper" and lighter ==1 and ladder==1 and bell==1 and paper==1 and box==1 and letter==1) then
            j = 1;  ii = 14;   lock2 = 1
            timer.performWithDelay(50,iter2,utf8.len(txt2[14]))
            local clue6 = display.newImageRect("images/歷年資料.png", 30, 25)
            clue6.x=display.contentCenterX-60
            clue6.y=display.contentCenterY+30
            sceneGroup:insert(clue6)
            time_paper = 1; lock=3
            timer.performWithDelay(12000,talk4)
          elseif( event.target.id == "letter") then
            j = 1;  ii = 8;   lock2 = 1
            timer.performWithDelay(50,iter2,utf8.len(txt2[8]))
            local clue7 = display.newImageRect("images/信.png", 30, 25)
            clue7.x=display.contentCenterX-25
            clue7.y=display.contentCenterY+30
            sceneGroup:insert(clue7)
            letter = 1;  lock3 = 1
            timer.performWithDelay(1500,talk2)
          --elseif (event.target.id == "wood" and straw == 1 and stone == 1) then
            --j = 1;  ii = 6;  lock3 = 1
            --timer.performWithDelay(50,iter2,utf8.len(txt2[6]))
            --timer.performWithDelay(2500,goto)
          end

        end
      end
----------------------------------------------------------
      
---- 物品欄 --------------------------------------------------------------
      local button1 = widget.newButton{
        id = 1,                                  -- 給按鈕ㄧ個識別名稱
        defaultFile = "images/bChose.png",          -- 未按按鈕的圖片
        overFile = "images/bChoseo.png",      -- 按下按鈕的圖片
        onEvent = buttonHandler                  -- 引發觸發事件要執行的函式
      }

      local button2 = widget.newButton{
        id = 2,
        defaultFile = "images/bChose.png",
        overFile = "images/bChoseo.png",
        onEvent = buttonHandler
      }
      
      local button3 = widget.newButton{
        id = 3,
        defaultFile = "images/bChose.png",
        overFile = "images/bChoseo.png",
        onEvent = buttonHandler
      }
      
      local button4 = widget.newButton{
        id = 4,
        defaultFile = "images/bChose.png",
        overFile = "images/bChoseo.png",
        onEvent = buttonHandler
      }
      
      local button5 = widget.newButton{
        id = 5,
        defaultFile = "images/bChose.png",
        overFile = "images/bChoseo.png",
        onEvent = buttonHandler
      }
      
      local button6 = widget.newButton{
        id = 6,
        defaultFile = "images/bChose.png",
        overFile = "images/bChoseo.png",
        onEvent = buttonHandler
      }
      
      local button7 = widget.newButton{
        id = 7,
        defaultFile = "images/bChose.png",
        overFile = "images/bChoseo.png",
        onEvent = buttonHandler
      }
      
------------------------------------------------------------------------
-- 物品 ------------------------------------------------------------------
      local person1 = widget.newButton{
        id = "ladder",
        defaultFile = "images/梯子.png",
        onEvent = buttonHandler
      }
      
      local person2 = widget.newButton{
        id = "paper",
        defaultFile = "images/童謠紙_有字版.png",
        onEvent = buttonHandler,
        onRelease = buttonRelease
      }
      
      local person3 = widget.newButton{
        id = "bell",
        defaultFile = "images/狐狸鈴鐺.png",
        onEvent = buttonHandler,
        onRelease = buttonRelease
      }
      
      local person4 = widget.newButton{
        id = "lighter",
        defaultFile = "images/打火機.png",
        onEvent = buttonHandler,
        onRelease = buttonRelease
      }
      
      local person5 = widget.newButton{
        id = "box",
        defaultFile = "images/盒子.png",
        onEvent = buttonHandler,
        onRelease = buttonRelease
      }
      
      local person6 = widget.newButton{
        id = "time_paper",
        defaultFile = "images/歷年資料.png",
        onEvent = buttonHandler,
        onRelease = buttonRelease
      }
      
      local person7 = widget.newButton{
        id = "letter",
        defaultFile = "images/信.png",
        onEvent = buttonHandler,
        --onRelease = buttonRelease
      }
      
      
      -- 按鈕物件設置
      button1.x = display.contentCenterX-235; button1.y = display.contentCenterY+30; button1.width = 35; button1.height = 30; sceneGroup:insert(button1)
      button2.x = display.contentCenterX-200; button2.y = display.contentCenterY+30; button2.width = 35; button2.height = 30; sceneGroup:insert(button2)
      button3.x = display.contentCenterX-165; button3.y = display.contentCenterY+30; button3.width = 35; button3.height = 30; sceneGroup:insert(button3)
      button4.x = display.contentCenterX-130; button4.y = display.contentCenterY+30; button4.width = 35; button4.height = 30; sceneGroup:insert(button4)
      button5.x = display.contentCenterX-95; button5.y = display.contentCenterY+30; button5.width = 35; button5.height = 30; sceneGroup:insert(button5)
      button6.x = display.contentCenterX-60; button6.y = display.contentCenterY+30; button6.width = 35; button6.height = 30; sceneGroup:insert(button6)
      button7.x = display.contentCenterX-25; button7.y = display.contentCenterY+30; button7.width = 35; button7.height = 30; sceneGroup:insert(button7)
      person1.x = display.contentCenterX+120; person1.y = display.contentCenterY-55; person1.width = 60; person1.height = 90;sceneGroup:insert(person1)
      person2.x = display.contentCenterX-200; person2.y = display.contentCenterY-60; person2.width = 60; person2.height = 60; sceneGroup:insert(person2)
      person3.x = display.contentCenterX-150; person3.y = display.contentCenterY-60; person3.width = 100; person3.height = 120; sceneGroup:insert(person3)
      person4.x = display.contentCenterX+30; person4.y = display.contentCenterY+0; person4.width = 60; person4.height = 70; sceneGroup:insert(person4)
      person5.x = display.contentCenterX+180; person5.y = display.contentCenterY+10; person5.width = 70; person5.height = 50; sceneGroup:insert(person5)
      person6.x = display.contentCenterX+145; person6.y = display.contentCenterY-120; person6.width = 70; person6.height = 50; sceneGroup:insert(person6)
      person7.x = display.contentCenterX+100; person7.y = display.contentCenterY+10; person7.width = 60; person7.height = 40; sceneGroup:insert(person7)
-------------------------------------------------------------------------
      
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
        composer.removeScene("level_2_1")
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