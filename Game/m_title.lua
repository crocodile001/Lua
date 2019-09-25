
local composer  = require( "composer" ) 
local widget    = require( "widget" ) 
local movieclip = require( "movieclip" )
local physics   = require( "physics" )
physics.start()                    
physics.setGravity( 0, 0 )

local scene = composer.newScene() 

------------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called
------------------------------------------------------------------------------------------------------------------

function scene:create( event )

    local sceneGroup = self.view  

-- 背景圖 -----------------------------------------------------------------------------------
    local background = display.newImageRect( sceneGroup, "images/main_bg.jpg", 580, 320 )
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
        local bgm = audio.loadSound( "sounds/title.wav" )
        audio.play( bgm, { loops=-1 } )
----------------------------------------------------------
        
-- 前往下一關 -----------------------------------------------------------
        local function press_go(event)
          audio.play( btn, {channel=2,1} )
          composer.gotoScene("mlist",{ time=300, effect="fade" } )
        end
 --------------------------------------------------------------------

-- 前往選單 ------------------------------------------
        local button1 = widget.newButton
        {
          defaultFile = "images/start_btn.png", 
          overFile = "images/start_btn_o.png",                          
          onPress = press_go,                 
        }
        sceneGroup:insert(button1)
        -- 按鈕物件位置
        button1.x = display.contentCenterX - 135
        button1.y = display.contentCenterY - 10
        -- 按鈕物件長寬
        button1.width = 180
        button1.height = 150
---------------------------------------------------

    end
end

function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then 
    elseif ( phase == "did" ) then
        composer.removeScene("m_title")
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