----------------------------------
-- Producer : CHinX2 
-- Finish : 2017 06 13
----------------------------------
-- Main List
----------------------------------

local composer  = require( "composer" )
local widget    = require( "widget" )  
local movieclip = require( "movieclip" )

local scene = composer.newScene() 

------------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called
------------------------------------------------------------------------------------------------------------------

function scene:create( event )

    local sceneGroup = self.view

-- 背景圖 -----------------------------------------------------------------------------------
    local background = display.newImageRect( sceneGroup, "images/bg.jpg", 580, 340 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
------------------------------------------------------------------------------------------
    
end

function scene:show( event ) 

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then  
        
    elseif ( phase == "did" ) then 
      
      audio.stop()
      
-- 背景音樂 -------------------------------------------------
      local bgm = audio.loadStream("sounds/The_Bluest_Star.mp3" )
      audio.play( bgm, { loops=-1 } )
----------------------------------------------------------

-- 關卡 ----------------------------------------------------------------------
      -- level 1
      local function press_go1(event)
        audio.play( btn, {channel=2,1} )
        if(myGameSettings.level >= 1.1) then
          composer.gotoScene("level_1_1",{ time=500, effect="fade" } )
        --elseif(myGameSettings.level == 1.2) then
          --composer.gotoScene("level_1_2",{ time=500, effect="fade" } )
        --elseif(myGameSettings.level == 1.3) then
          --composer.gotoScene("level_1_3",{ time=500, effect="fade" } )
        --elseif(myGameSettings.level >= 1.4) then
          --composer.gotoScene("level_1_4",{ time=500, effect="fade" } )
        end
      end
      local button1 = widget.newButton
      {
        defaultFile = "images/bChose.png", 
        overFile = "images/bChoseo.png",
        label = "1",                         
        font = native.systemFont,                    
        labelColor = { default = { 1, 1, 1 } },     
        fontSize = 120,                             
        onPress = press_go1,                 
      }
      sceneGroup:insert(button1)
      -- 按鈕物件位置
      button1.x = display.contentCenterX-105
      button1.y = display.contentCenterY-60
      -- 按鈕物件長寬
      button1.width = 80
      button1.height = 80
      
      -- level 2
      local function press_go2(event)
          audio.play( btn, {channel=2,1} )
          if(myGameSettings.level >= 2.1) then
            composer.gotoScene("level_2_1",{ time=500, effect="fade" } )
          --elseif(myGameSettings.level >= 2.2) then
            --composer.gotoScene("level_2_2",{ time=500, effect="fade" } )
          end
      end
      local button2 = widget.newButton
      {
        defaultFile = "images/bChose.png",  
        overFile = "images/bChoseo.png",        
        label = "2",                             
        font = native.systemFont,                     
        labelColor = { default = { 1, 1, 1 } },       
        fontSize = 120,                               
        onPress = press_go2,                    
      }
      sceneGroup:insert(button2)
      button2.x = display.contentCenterX-5
      button2.y = display.contentCenterY-60
      button2.width = 80
      button2.height = 80
      if (LEVEL < 2) then
        button2:setFillColor( 0.5,0.5,0.5 )
        print (myGameSettings.level)
      end
      
     -- level 3
      local function press_go3(event)
          audio.play( btn, {channel=2,1} )
          if(myGameSettings.level >= 3.1) then
            composer.gotoScene("level_3_1",{ time=500, effect="fade" } )
          --elseif(myGameSettings.level == 3.2) then
            --composer.gotoScene("level_3_2",{ time=500, effect="fade" } )
          --elseif(myGameSettings.level >= 3.3) then
            --composer.gotoScene("level_3_3",{ time=500, effect="fade" } )
          end
      end
      local button3 = widget.newButton
      {
        defaultFile = "images/bChose.png", 
        overFile = "images/bChoseo.png",                     
        label = "3",                             
        font = native.systemFont,                     
        labelColor = { default = { 1, 1, 1 } },       
        fontSize = 120,                               
        onPress = press_go3,                    
      }
      sceneGroup:insert(button3)
      button3.x = display.contentCenterX + 95
      button3.y = display.contentCenterY - 60
      button3.width = 80
      button3.height = 80
      if (LEVEL < 3) then
        button3:setFillColor( 0.5,0.5,0.5 )
      end

      -- level 4
      local function press_go4(event)
          audio.play( btn, {channel=2,1} )
          if(myGameSettings.level >= 4.1) then
            composer.gotoScene("level_4_1",{ time=500, effect="fade" } )
          --elseif(myGameSettings.level == 4.2) then
            --composer.gotoScene("level_4_2",{ time=500, effect="fade" } )
          --elseif(myGameSettings.level >= 4.3) then
            --composer.gotoScene("level_4_3",{ time=500, effect="fade" } )
          end
      end
      local button4 = widget.newButton
      {
        defaultFile = "images/bChose.png",       
        overFile = "images/bChoseo.png",
        label = "4",                            
        font = native.systemFont,                   
        labelColor = { default = { 1, 1, 1 } },      
        fontSize = 120,                            
        onPress = press_go4,                   
      }
      sceneGroup:insert(button4)
      button4.x = display.contentCenterX-105
      button4.y = display.contentCenterY+60
      button4.width = 80
      button4.height = 80
      if (LEVEL < 4) then
        button4:setFillColor( 0.5,0.5,0.5 )
      end
      
      -- level 5
      local function press_go5(event)
          audio.play( btn, {channel=2,1} )
          if(myGameSettings.level >=5.1) then
            composer.gotoScene("level_5_1",{ time=500, effect="fade" } )
          --elseif(myGameSettings.level == 5.2) then
            --composer.gotoScene("level_5_2",{ time=500, effect="fade" } )
          --elseif(myGameSettings.level >= 5.3) then
            --composer.gotoScene("level_5_3",{ time=500, effect="fade" } )
          end
      end
      local button5 = widget.newButton
      {
        defaultFile = "images/bChose.png",      
        overFile = "images/bChoseo.png",    
        label = "5",                             
        font = native.systemFont,                     
        labelColor = { default = { 1, 1, 1 } },       
        fontSize = 120,                               
        onPress = press_go5,                    
      }
      sceneGroup:insert(button5)
      button5.x = display.contentCenterX-5
      button5.y = display.contentCenterY + 60
      button5.width = 80
      button5.height = 80
      if (LEVEL < 5) then
        button5:setFillColor( 0.5,0.5,0.5 )
      end
      
     -- title
      local function press_got(event)
          audio.play( btn, {channel=2,1} )
          composer.gotoScene("m_title",{ time=500, effect="fade" } )
      end
      local button6 = widget.newButton
      {
        defaultFile = "images/bChose.png",            
        overFile = "images/bChoseo.png",          
        label = "Title",                             
        font = native.systemFont,                     
        labelColor = { default = { 1, 1, 1 } },       
        fontSize = 120,                               
        onPress = press_got,                    
      }
      sceneGroup:insert(button6)
      button6.x = display.contentCenterX+95
      button6.y = display.contentCenterY+60
      button6.width = 80
      button6.height = 80
----------------------------------------------------------------------------

-- 重置存檔 -------------------------------------------------
      local function resave(event)
        audio.play( btn, {channel=2,1} )
        LEVEL = 1.1
        myGameSettings = {}
        myGameSettings.level = LEVEL
        saveTable(myGameSettings, gameSettingsFileName)
        print (myGameSettings.level)
        composer.gotoScene("mlist",{ time=0, effect="fade" } )
      end

      local button7 = widget.newButton
      {
        defaultFile = "images/bChose.png", 
        overFile = "images/bChoseo.png",                     
        label = "reset",                             
        font = native.systemFont,                     
        labelColor = { default = { 1, 1, 1 } },       
        fontSize = 80,                               
        onPress = resave,                    
      }
      sceneGroup:insert(button7)
      button7.x = display.contentCenterX + 175
      button7.y = display.contentCenterY + 120
      button7.width = 40
      button7.height = 40
----------------------------------------------------------

-- 全通關 -------------------------------------------------
      local function allclear(event)
        audio.play( btn, {channel=2,1} )
        LEVEL = 999
        save()
        print (myGameSettings.level)
        composer.gotoScene("mlist",{ time=0, effect="fade" } )
      end

      local button8 = widget.newButton
      {
        defaultFile = "images/bChose.png", 
        overFile = "images/bChoseo.png",                     
        label = "  all\nclear",                             
        font = native.systemFont,                     
        labelColor = { default = { 1, 1, 1 } },       
        fontSize = 80,                               
        onPress = allclear,                    
      }
      sceneGroup:insert(button8)
      button8.x = display.contentCenterX + 225
      button8.y = display.contentCenterY + 120
      button8.width = 40
      button8.height = 40
----------------------------------------------------------


    end
end


function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then  
    elseif ( phase == "did" ) then  
    end
end


function scene:destroy( event )

        local sceneGroup = self.view   
        sceneGroup:removeSelf()    
        sceneGroup = nil
       
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )   --場景時先被呼叫的地方，可以加入場景需要的物件以及相對應的函數
scene:addEventListener( "show", scene )     --場景要開始運作的進入點，在這裡可以加入需要的執行動作
scene:addEventListener( "hide", scene )     --場景要被切換時會呼叫，也就是要離開場景時
scene:addEventListener( "destroy", scene )  --場景被移除時呼叫

-- -------------------------------------------------------------------------------

return scene