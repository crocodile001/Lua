
local composer = require( "composer" )
composer.gotoScene( "m_title", options )

-- 全域音樂 -------------------------------------------------
btn = audio.loadSound( "effects/button04a.wav" )
btn2 = audio.loadSound( "effects/select07.wav" )
----------------------------------------------------------

audio.setVolume( 0.5 , {channel=2})                       -- 設置頻道音量

-- 全域變數 -------------------------------------------------
Stone = 0
Bamboo = 0
River = 0
Bottle = 0
Doctor_letter = 0

Bookshelf_low = 0
Ladder = 0
Bell = 0
Fox_Key = 0
File = 0
Historical_Data = 0

Chair = 0
Rope = 0

Dinner_table = 0
Cup = 0
Diary = 0

LEVEL = 1.1
----------------------------------------------------------

-- 存檔函式 ---------------------------------------------------------------------------
json = require("json")
 
function saveTable(myTable, filename)
    local path = system.pathForFile( filename, system.DocumentsDirectory)
    local file = io.open(path, "w")
    if file then
        local sTable = json.encode(myTable)--encode the table to string
        print (sTable)
        file:write( sTable )
        io.close( file )
        return true
    else
        return false
    end
end
 
function loadTable(filename)
    local path = system.pathForFile( filename, system.DocumentsDirectory)
    local contents = ""
    local myTable = {}
    local file = io.open( path, "r" )
    if file then        
         local sTable = file:read( "*a" )-- read the entire contents of the file
         myTable = json.decode(sTable)--decode the string back to table
         io.close( file )
         file = nil
         return myTable 
    end
    return nil
end
-------------------------------------------------------------------------------------

-- 存檔 -------------------------------------------------------------------------------
gameSettingsFileName = "mygamesettings.json"
myGameSettings = loadTable("mygamesettings.json")
if(myGameSettings == nil or myGameSettings.level == nil) then
   -- the default settings --
   myGameSettings = {}
   myGameSettings.level = LEVEL
   saveTable(myGameSettings, gameSettingsFileName)
else
  LEVEL = myGameSettings.level
end

function save(event)
  audio.play( btn, {channel=2,1} )
  if (myGameSettings.level~=999) then
    myGameSettings.level = LEVEL
    saveTable(myGameSettings, gameSettingsFileName)
    print (myGameSettings.level)
  end
end
-------------------------------------------------------------------------------------

-- 隱藏 Bottom Navigation -----------------------------------------------------------
if ( system.getInfo("platformName") == "Android" ) then
   local androidVersion = string.sub( system.getInfo( "platformVersion" ), 1, 3)
   if( androidVersion and tonumber(androidVersion) >= 4.4 ) then
     native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )
     --native.setProperty( "androidSystemUiVisibility", "lowProfile" )
   elseif( androidVersion ) then
     native.setProperty( "androidSystemUiVisibility", "lowProfile" )
   end
end
-------------------------------------------------------------------------------------