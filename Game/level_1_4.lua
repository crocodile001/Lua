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
    local background = display.newImageRect( sceneGroup, "images/river.jpg", 580, 340 )
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
      main_actor.y = display.contentCenterY - 30
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
        "----------文末----------"
      }
      
      local txt2 ={
        "\n\n我是物品欄喔",
        "\n\n發現石頭上有一點點乾掉的血跡     ( 獲得線索x1 )",
        "\n\n獲得竹竿",
        "\n\n測量河水深度，發現這個深度淹不死人     ( 獲得線索x1 )",
        "沈安：\n\n咦，瓶子裡有信!( 獲得線索X1 )",
        "沈安：\n\n您剛才說被銀狐大人索命是什麼意思？",
        "沈安：\n\n石頭上怎麼會有血?",
        "沈安：\n\n河水深度不到竹竿的一半，應該不致於溺死人",
        "沈安：\n\n咦，瓶子裡有信!",
        "村長：\n但不知從何時開始，有人不明原因的死亡，發現屍體的人說看到了狐狸，我們就想是不是那人惹怒了銀狐大人。",
        "村長：\n銀狐大人是我們村子從百年前開始就有的信仰，守護村民的健康，及村庄年年豐收，我們每年都會舉行銀狐祭典，感謝銀狐大人的守護。",
        "\n\n請回答法醫問題",
        "那是很冷很冷的冬天，我找不到食物，餓了好幾天。我嘗試到樹林裡找尋食物，但風雪太大，我迷了路，走了好久好久，真的撐不下去了。風雪不斷往我身上打，我慢慢閉眼，以為我近千年的修行就要如此化為泡影。",
        "突然，我感覺到一陣暖意，是一個人類，他把我抱了起來，帶我回家。我記得他的眼神，就像太陽一樣和煦。他說他叫沈安，沈安，我認識的第一個人類。給我好吃好喝的，還有暖暖的床，我真的好喜歡這個人類。"
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
        if (lock2 == 0 and lock3 == 0 and i~=1) then
        
          --x.text = i
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
local correct_ans = 0
-------------------------
      
---- 法醫問題 ---------------------------------------------
      local talk6 = function(event)
        multiText.text = ""
        print (correct_ans)
        if (correct_ans >= 3) then
          audio.play( btn, {channel=2,1} )
          multiText.text = "\n\n獲得線索X1"
          local clue5 = display.newImageRect("images/法醫.png", 30, 25)
          clue5.x=display.contentCenterX-95
          clue5.y=display.contentCenterY+30
          sceneGroup:insert(clue5)
          Doctor_letter = 1
        else
          audio.play( btn, {channel=2,1} )
          multiText.text = "\n\n錯誤超過兩題，無法獲得線索"
        end
        correct_ans = 0
        lock3 = 0
      end

      local question5 = function(event)
        audio.play( btn, {channel=2,1} )
        multiText.text = "溺死全過程時間大約幾分鐘?"
        local result = display.newText( "", display.contentCenterX+120, display.contentCenterY+80, 60, 20, "Helvetica", 16 )
        local ans1 = display.newText( "A.3分鐘", display.contentCenterX-150, display.contentCenterY+120, 60, 20, "Helvetica", 14 )
        local ans2 = display.newText( "B.6分鐘", display.contentCenterX-20, display.contentCenterY+120, 60, 20, "Helvetica", 14 )
        local ans3 = display.newText( "C.10分鐘", display.contentCenterX+110, display.contentCenterY+120, 60, 20, "Helvetica", 14 )
        local erase5 = function()
          if (result.text ~= "錯誤") then
            correct_ans = correct_ans + 1
          end
          print (correct_ans)
          display.remove(ans1)
          display.remove(ans2)
          display.remove(ans3)
          display.remove(result)
          timer.performWithDelay(500,talk6)
        end
        local on1 = function()
          audio.play( btn2, {channel=2,1} )
          if (result.text == "") then
            timer.performWithDelay(500,erase5)
          end
          result.text = "錯誤"
        end
        local on2 = function()
          audio.play( btn2, {channel=2,1} )
          if (multiText.text ~= "正確") then
            timer.performWithDelay(500,erase5)
          end
          multiText.text = "正確"
        end
        local on3 = function()
          audio.play( btn2, {channel=2,1} )
          if (result.text == "") then
            timer.performWithDelay(500,erase5)
          end
          result.text = "錯誤"
        end
        ans1:addEventListener("touch",on1)
        ans2:addEventListener("touch",on2)
        ans3:addEventListener("touch",on3)
        sceneGroup:insert(ans1)
        sceneGroup:insert(ans2)
        sceneGroup:insert(ans3)
        sceneGroup:insert(result)
      end

      local question4 = function(event)
        audio.play( btn, {channel=2,1} )
        multiText.text = "死者屍體不會有何特徵?"
        local result = display.newText( "", display.contentCenterX+120, display.contentCenterY+80, 60, 20, "Helvetica", 16 )
        local ans1 = display.newText( "A.口鼻出現蕈狀白色泡沫", display.contentCenterX-150, display.contentCenterY+120, 160, 20, "Helvetica", 14 )
        local ans2 = display.newText( "B.指甲縫有泥沙水草", display.contentCenterX+5, display.contentCenterY+120, 130, 20, "Helvetica", 14 )
        local ans3 = display.newText( "C.血液濃度增加", display.contentCenterX+130, display.contentCenterY+120, 100, 20, "Helvetica", 14 )
        local erase4 = function()
          if (result.text ~= "錯誤") then
            correct_ans = correct_ans + 1
          end
          print (correct_ans)
          display.remove(ans1)
          display.remove(ans2)
          display.remove(ans3)
          display.remove(result)
          timer.performWithDelay(500,question5)
        end
        local on1 = function()
          audio.play( btn2, {channel=2,1} )
          if (result.text == "") then
            timer.performWithDelay(500,erase4)
          end
          result.text = "錯誤"
        end
        local on2 = function()
          audio.play( btn2, {channel=2,1} )
          if (result.text == "") then
            timer.performWithDelay(500,erase4)
          end
          result.text = "錯誤"   
        end
        local on3 = function()
          audio.play( btn2, {channel=2,1} )
          if (multiText.text ~= "正確") then
            timer.performWithDelay(500,erase4)
          end
          multiText.text = "正確"
        end
        ans1:addEventListener("touch",on1)
        ans2:addEventListener("touch",on2)
        ans3:addEventListener("touch",on3)
        sceneGroup:insert(ans1)
        sceneGroup:insert(ans2)
        sceneGroup:insert(ans3)
        sceneGroup:insert(result)
      end

      local question3 = function(event)
        audio.play( btn, {channel=2,1} )
        multiText.text = "死後被棄屍者，身上較不可能有何種傷口?"
        local result = display.newText( "", display.contentCenterX+120, display.contentCenterY+80, 60, 20, "Helvetica", 16 )
        local ans1 = display.newText( "A.皮下出血", display.contentCenterX-150, display.contentCenterY+120, 80, 20, "Helvetica", 14 )
        local ans2 = display.newText( "B.骨折、裂創", display.contentCenterX-40, display.contentCenterY+120, 90, 20, "Helvetica", 14 )
        local ans3 = display.newText( "C.被魚類咬食的傷口", display.contentCenterX+110, display.contentCenterY+120, 140, 20, "Helvetica", 14 )
        local erase3 = function()
          if (result.text ~= "錯誤") then
            correct_ans = correct_ans + 1
          end
          print (correct_ans)
          display.remove(ans1)
          display.remove(ans2)
          display.remove(ans3)
          display.remove(result)
          timer.performWithDelay(500,question4)
        end
        local on1 = function()
          audio.play( btn2, {channel=2,1} )
          if (multiText.text ~= "正確") then
            timer.performWithDelay(500,erase3)
          end
          multiText.text = "正確"
        end
        local on2 = function()
          audio.play( btn2, {channel=2,1} )
          if (result.text == "") then
            timer.performWithDelay(500,erase3)
          end
          result.text = "錯誤"
        end
        local on3 = function()
          audio.play( btn2, {channel=2,1} )
          if (result.text == "") then
            timer.performWithDelay(500,erase3)
          end
          result.text = "錯誤"   
        end
        ans1:addEventListener("touch",on1)
        ans2:addEventListener("touch",on2)
        ans3:addEventListener("touch",on3)
        sceneGroup:insert(ans1)
        sceneGroup:insert(ans2)
        sceneGroup:insert(ans3)
        sceneGroup:insert(result)
      end

      local question2 = function(event)
        audio.play( btn, {channel=2,1} )
        multiText.text = "生前落水溺死者，身上不會有何特徵?"
        local result = display.newText( "", display.contentCenterX+120, display.contentCenterY+80, 60, 20, "Helvetica", 16 )
        local ans1 = display.newText( "A.肺部膨脹", display.contentCenterX-150, display.contentCenterY+120, 80, 20, "Helvetica", 14 )
        local ans2 = display.newText( "B.臟器有藻類入侵", display.contentCenterX-25, display.contentCenterY+120, 120, 20, "Helvetica", 14 )
        local ans3 = display.newText( "C.身上有銳器創傷", display.contentCenterX+110, display.contentCenterY+120, 120, 20, "Helvetica", 14 )
        local erase2 = function()
          if (result.text ~= "錯誤") then
            correct_ans = correct_ans + 1
          end
          print (correct_ans)
          display.remove(ans1)
          display.remove(ans2)
          display.remove(ans3)
          display.remove(result)
          timer.performWithDelay(500,question3)
        end
        local on1 = function()
          audio.play( btn2, {channel=2,1} )
          if (result.text == "") then
            timer.performWithDelay(500,erase2)
          end
          result.text = "錯誤" 
        end
        local on2 = function()
          audio.play( btn2, {channel=2,1} )
          if (result.text == "") then
            timer.performWithDelay(500,erase2)
          end
          result.text = "錯誤"    
        end
        local on3 = function()
          audio.play( btn2, {channel=2,1} )
          if (multiText.text ~= "正確") then
            timer.performWithDelay(500,erase2)
          end
          multiText.text = "正確"
        end
        ans1:addEventListener("touch",on1)
        ans2:addEventListener("touch",on2)
        ans3:addEventListener("touch",on3)
        sceneGroup:insert(ans1)
        sceneGroup:insert(ans2)
        sceneGroup:insert(ans3)
        sceneGroup:insert(result)
      end

      local question1 = function(event)
        correct_ans = 0
        audio.play( btn, {channel=2,1} )
        multiText.text = "生前落水者，身體哪個器官會膨脹像海綿?"
        local result = display.newText( "", display.contentCenterX+120, display.contentCenterY+80, 60, 20, "Helvetica", 16 )
        local ans1 = display.newText( "A.心臟", display.contentCenterX-150, display.contentCenterY+120, 60, 20, "Helvetica", 14 )
        local ans2 = display.newText( "B.肺部", display.contentCenterX-20, display.contentCenterY+120, 60, 20, "Helvetica", 14 )
        local ans3 = display.newText( "C.肝臟", display.contentCenterX+110, display.contentCenterY+120, 60, 20, "Helvetica", 14 )
        local erase1 = function()
          if (result.text ~= "錯誤") then
            correct_ans = correct_ans + 1
          end
          print (correct_ans)
          display.remove(ans1)
          display.remove(ans2)
          display.remove(ans3)
          display.remove(result)
          timer.performWithDelay(500,question2)
        end
        local on1 = function()
          audio.play( btn2, {channel=2,1} )
          if (result.text == "") then
            timer.performWithDelay(500,erase1)
          end
          result.text = "錯誤"
        end
        local on2 = function()
          audio.play( btn2, {channel=2,1} )
          if (multiText.text ~= "正確") then
            timer.performWithDelay(500,erase1)
          end
          multiText.text = "正確" 
        end
        local on3 = function()
          audio.play( btn2, {channel=2,1} )
          if (result.text == "") then
            timer.performWithDelay(500,erase1)
          end
          result.text = "錯誤"
        end
        ans1:addEventListener("touch",on1)
        ans2:addEventListener("touch",on2)
        ans3:addEventListener("touch",on3)
        sceneGroup:insert(ans1)
        sceneGroup:insert(ans2)
        sceneGroup:insert(ans3)
        sceneGroup:insert(result)
      end     
-------------------------------------------------------
      
---- 按鈕事件 ---------------------------------------------
      local unlock = function(event)
        lock3 = 0
      end

      local goto = function(event)
        LEVEL = 2.1
        save()
        composer.gotoScene("mlist",{ time=500, effect="fade" } )
      end
      
      local talk = function(event)
        audio.play( btn, {channel=2,1} )
        j = 1;  ii = 7;   lock2 = 1
        timer.performWithDelay(50,iter2,utf8.len(txt2[7]))
        timer.performWithDelay(2000,unlock)
      end
      local talk2 = function(event)
        audio.play( btn, {channel=2,1} )
        j = 1;  ii = 8;   lock2 = 1
        timer.performWithDelay(50,iter2,utf8.len(txt2[8]))
        timer.performWithDelay(2000,unlock)
      end
      local talk6 = function(event)
        audio.play( btn, {channel=2,1} )
        j = 1;  ii = 14; 
        timer.performWithDelay(50,iter2,utf8.len(txt2[14]))
        timer.performWithDelay(10000,unlock)
      end
      local talk3 = function(event)
        audio.play( btn, {channel=2,1} )
        j = 1;  ii = 13; 
        timer.performWithDelay(50,iter2,utf8.len(txt2[13]))
        timer.performWithDelay(13000,talk6)
      end
      local talk5 = function(event)
        audio.play( btn, {channel=2,1} )
        j = 1;  ii = 10;
        timer.performWithDelay(50,iter2,utf8.len(txt2[10]))
        timer.performWithDelay(7000,goto)
      end
      local talk4 = function(event)
        main_actor:setFillColor(0.5,0.5,0.5)
        audio.play( btn, {channel=2,1} )
        j = 1;  ii = 11;
        timer.performWithDelay(50,iter2,utf8.len(txt2[11]))
        timer.performWithDelay(8000,talk5)
      end

      local buttonHandler = function( event )
        if (lock == 0 and lock2 == 0 and lock3 == 0) then
          --myText.text = "id = " .. event.target.id .. ", 狀態 = " .. event.phase  -- 顯示觸發的按鈕 id 和引發觸發事件的狀態
          audio.play( btn2, {channel=2,1} )
          if (event.target.id == 1 or event.target.id == 2 or event.target.id == 3 or event.target.id == 4 or event.target.id == 5) then
            j = 1;  ii = 1;   lock2 = 1
            timer.performWithDelay(50,iter2,utf8.len(txt2[1]))
          elseif (event.target.id == "stone") then
            j = 1;  ii = 2;   lock2 = 1
            timer.performWithDelay(50,iter2,utf8.len(txt2[2]))
            local clue1 = display.newImageRect("images/沾血石頭.png", 30, 25)
            clue1.x=display.contentCenterX-235
            clue1.y=display.contentCenterY+30
            sceneGroup:insert(clue1)
            Stone = 1;  lock3 = 1
            timer.performWithDelay(2500,talk)
          elseif (event.target.id == "bamboo") then
            j = 1;  ii = 3;   lock2 = 1
            timer.performWithDelay(50,iter2,utf8.len(txt2[3]))
            local clue2 = display.newImageRect("images/竹竿.png", 30, 25)
            clue2.x=display.contentCenterX-200
            clue2.y=display.contentCenterY+30
            sceneGroup:insert(clue2)
            Bamboo = 1
          elseif (event.target.id == "river" and Bamboo == 1) then
            j = 1;  ii = 4;   lock2 = 1
            timer.performWithDelay(50,iter2,utf8.len(txt2[4]))
            local clue3 = display.newImageRect("images/stone.png", 30, 25)
            clue3.x=display.contentCenterX-165
            clue3.y=display.contentCenterY+30
            sceneGroup:insert(clue3)
            River = 1;  lock3 = 1
            timer.performWithDelay(3000,talk2)
          elseif (event.target.id == "bottle") then
            j = 1;  ii = 5;   lock2 = 1
            timer.performWithDelay(50,iter2,utf8.len(txt2[5]))
            local clue4 = display.newImageRect("images/漂流瓶.png", 30, 25)
            clue4.x=display.contentCenterX-130
            clue4.y=display.contentCenterY+30
            sceneGroup:insert(clue4)
            Bottle = 1; lock3 = 1;
            timer.performWithDelay(3000,talk3)
          elseif (event.target.id == "village_headman" and Bamboo == 1 and Stone == 1 and River == 1 and Bottle == 1 and Doctor_letter == 1) then
            main_actor.isVisible = true
            j = 1;  ii = 6;  lock3 = 1
            timer.performWithDelay(50,iter2,utf8.len(txt2[6]))
            timer.performWithDelay(2500,talk4)
            LEVEL2 = 1                                --  通關 
          elseif (event.target.id == "doctor") then
            j = 1;  ii = 12;   lock2 = 1; lock3 = 1
            timer.performWithDelay(50,iter2,utf8.len(txt2[12]))
            timer.performWithDelay(1500,question1)
          end

        end
      end
----------------------------------------------------------
      
---- 物品欄 --------------------------------------------------------------
      local button1 = widget.newButton{
        id = 1,                                  -- 給按鈕ㄧ個識別名稱
        defaultFile = "images/bChose.png",       -- 未按按鈕的圖片
        overFile = "images/bChoseo.png",         -- 按下按鈕的圖片
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
------------------------------------------------------------------------
-- 物品 ------------------------------------------------------------------
      local person1 = widget.newButton{
        id = "village_headman",
        defaultFile = "images/村長_1.png",
        onEvent = buttonHandler
      }
      
      local person2 = widget.newButton{
        id = "stone",
        defaultFile = "images/沾血石頭.png",
        onEvent = buttonHandler,
        onRelease = buttonRelease
      }
      
      local person3 = widget.newButton{
        id = "bamboo",
        defaultFile = "images/竹竿.png",
        onEvent = buttonHandler,
        onRelease = buttonRelease
      }
      
      local person4 = widget.newButton{
        id = "river",
        defaultFile = "images/stone.png",
        onEvent = buttonHandler,
        onRelease = buttonRelease
      }
      
      local person5 = widget.newButton{
        id = "bottle",
        defaultFile = "images/漂流瓶.png",
        onEvent = buttonHandler,
        onRelease = buttonRelease
      }
      
      local person6 = widget.newButton{
        id = "doctor",
        defaultFile = "images/法醫.png",
        onEvent = buttonHandler
      }
      
      -- 按鈕物件設置
      button1.x = display.contentCenterX-235; button1.y = display.contentCenterY+30; button1.width = 35; button1.height = 30; sceneGroup:insert(button1)
      button2.x = display.contentCenterX-200; button2.y = display.contentCenterY+30; button2.width = 35; button2.height = 30; sceneGroup:insert(button2)
      button3.x = display.contentCenterX-165; button3.y = display.contentCenterY+30; button3.width = 35; button3.height = 30; sceneGroup:insert(button3)
      button4.x = display.contentCenterX-130; button4.y = display.contentCenterY+30; button4.width = 35; button4.height = 30; sceneGroup:insert(button4)
      button5.x = display.contentCenterX-95; button5.y = display.contentCenterY+30; button5.width = 35; button5.height = 30; sceneGroup:insert(button5)
      person1.x = display.contentCenterX-200; person1.y = display.contentCenterY- 60; person1.width = 110; person1.height = 175;sceneGroup:insert(person1)
      person2.x = display.contentCenterX-20; person2.y = display.contentCenterY; person2.width = 50; person2.height = 60; sceneGroup:insert(person2)
      person3.x = display.contentCenterX; person3.y = display.contentCenterY-80; person3.width = 90; person3.height = 100; sceneGroup:insert(person3)
      person4.x = display.contentCenterX+150; person4.y = display.contentCenterY+ 25; person4.width = 35; person4.height = 30; sceneGroup:insert(person4)
      person5.x = display.contentCenterX+100; person5.y = display.contentCenterY+10; person5.width = 90; person5.height = 100; sceneGroup:insert(person5)
      person6.x = display.contentCenterX+220; person6.y = display.contentCenterY- 25; person6.width = 100; person6.height = 150;sceneGroup:insert(person6)
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
        composer.removeScene("level_1_4")
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