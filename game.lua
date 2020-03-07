
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local socket = require("socket")
local physics = require("physics")
physics.start()

-- configuring the image sheet to be used
local bobOptions =
{
    frames =
    {
        {   -- 1) normal bob
            x = 0,
            y = 0,
            width = 366,
            height = 530,
            name = "normalBob"
        },
        {   -- 2) sad bob
            x = 368,
            y = 78,
            width = 544,
            height = 800,
            name = "sadBob",
        },
        { --3) speaking bob
            x = 902,
            y = 82,
            width = 544,
            height = 800,
            name = "speakingBob"
        }

    }
}

local clownOptions =
{
  width = 364,
  height = 560,
  numFrames = 5
}

-- sequences table for clown
local sequences_clown = {
    -- consecutive frames sequence
    {
        name = "juggling",
        start = 1,
        count = 5,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    }
}

-- configuring the image sheet to be used
local sheetOptions =
{
    frames =
    {
        {   -- 1) clown
            x = 954,
            y = 226,
            width = 370,
            height = 556,
            displayWidth = 230,
            displayHeight = 370,
            name = "clown",
            displayX = -90,
            displayY = 690
        },
        {   -- 2) clown
            x = 1322,
            y = 224,
            width = 370,
            height = 556,
            displayWidth = 230,
            displayHeight = 370,
            name = "clown", -- make it say just clown
            displayX = -90,
            displayY = 690,
            isReplacement = true
        },{   -- 3) clown
            x = 1424,
            y = 0,
            width = 370,
            height = 556,
            displayWidth = 230,
            displayHeight = 370,
            name = "clown",
            displayX = -90,
            displayY = 690,
            isReplacement = true
        },{   -- 4) clown
            x = 362,
            y = 782,
            width = 370,
            height = 556,
            displayWidth = 230,
            displayHeight = 370,
            name = "clown",
            displayX = -90,
            displayY = 690,
            isReplacement = true
        },{   -- 5) clown
            x = 729,
            y = 781,
            width = 370,
            height = 556,
            displayWidth = 230,
            displayHeight = 370,
            name = "clown",
            displayX = -90,
            displayY = 690,
            isReplacement = true
        },
        {   -- 6) bus
            x = 0,
            y = 0,
            width = 300,
            height = 169,
            displayWidth = 270,
            displayHeight = 150,
            name = "bus",
            displayX = 700,
            displayY = 750
        },
        { -- 7)pond
          x = 505,
          y = 236,
          width = 380,
          height = 297,
          displayWidth = 380,
          displayHeight = 309,
          name = "pond",
          displayX = 250,
          displayY = 850
        },
        { -- 8) froggo
            x = 300,
            y = 0,
            width = 235,
            height = 194,
            displayWidth = 124,
            displayHeight = 100,
            name = "frog",
            displayX = 120,
            displayY = 900
        },
        { -- 9) froggo2
            x = 300,
            y = 0,
            width = 235,
            height = 194,
            displayWidth = 124,
            displayHeight = 100,
            name = "frog2",
            displayX = 120,
            displayY = 900,
            isReplacement = true
        },
        { -- 10) speaker
            x = 1116,
            y = 797,
            width = 404,
            height = 643,
            displayWidth = 150,
            displayHeight = 240,
            name = "speaker",
            displayX = 990,
            displayY = 800
        },
        { -- 11 )doggo
          x = 526,
          y = 0,
          width = 242,
          height = 210,
          displayWidth = 203,
          displayHeight = 200,
          name = "dog",
          displayX = 900,
          displayY = 900
        },
        { -- 12 )doggo bark
          x = 778,
          y = 0,
          width = 242,
          height = 205,
          displayWidth = 203,
          displayHeight = 200,
          name = "dog2",
          displayX = 900,
          displayY = 900,
          isReplacement = true
        },
        { -- 13)sun
          x = 1024,
          y = 0,
          width = 228,
          height = 213,
          displayWidth = 278,
          displayHeight = 242,
          name = "sun",
          displayX = -150,
          displayY = 150
        },
        {-- 14) cloud
          x = 0,
          y = 224,
          width = 422,
          height = 231,
          displayWidth = 350,
          displayHeight = 242,
          name = "cloud",
          displayX = -110,
          displayY = 150,
          isReplacement = true,
          secondX = 0,
          secondY = 150
        }
    }
}

local objectSheet = graphics.newImageSheet("objects.png", sheetOptions)
local bobSheet = graphics.newImageSheet( "bobSprite.png", bobOptions)
local clownSheet = graphics.newImageSheet( "clown_sprite.png", clownOptions )

-- initialising variables
local clown, bus
local bob
local playButton
local objectsOnScreen = {}
local bobsOnScreen = {}
local childCoded = true
local currentBob = 1 -- keeps track of which bob is currently displayed
local jugglingClown
-- dictionary storing each object's name and bob's reaction to it
-- this dictionary will be added to when the objects are added to the screen
-- bob's reaction will be initialised to nil at the beginning
_G.bobReactionTo = {}

-- initialising display groups
-- defer the actual creation of our three groups until we create the scene
local backGroup
local mainGroup
local bobGroup

local function goToProgramming()
  composer.gotoScene("programming", {time=800, effect="crossFade"})
end


-- function which handles what happens when an object on screen is tapped on
local function onTap(event)
  local object = event.target
  local objectTappedOn = object.name
  -- make object which was tapped do its thing
  if objectTappedOn == "clown" then
    -- make clown juggle
    if jugglingClown.isPlaying ~= true then
      jugglingClown:play()
    else
      jugglingClown:pause()
    end
  elseif objectTappedOn == "bus" then
    object:applyLinearImpulse( 0, -2, object.x, object.y )
  elseif objectTappedOn == "sun" then
    object.isVisible = false
    objectsOnScreen[14].isVisible = true -- fix after changing sprite
  elseif objectTappedOn == "cloud" then
    object.isVisible = false
    objectsOnScreen[13].isVisible = true -- fix after changing sprite
    bobsOnScreen[currentBob].isVisible=false
    bobsOnScreen[1].isVisible = true
    currentBob = 1
  end

--  Bob's reaction part
  if childCoded == true then
      local reaction = bobReactionTo[objectTappedOn]
      -- print(reaction)
      if reaction ~= nil then
        if reaction == "jump" then
           bobsOnScreen[currentBob]:applyLinearImpulse(0, -2, bobsOnScreen[currentBob].x, bobsOnScreen[currentBob].y )
        elseif reaction == "smile" then
          bobsOnScreen[currentBob].isVisible = false
          bobsOnScreen[1].isVisible = true
          currentBob = 1
        elseif reaction == "cry" then
          bobsOnScreen[currentBob].isVisible = false
          bobsOnScreen[2].isVisible = true
          currentBob = 2
        elseif reaction == "speak" then
          bobsOnScreen[currentBob].isVisible = false
          bobsOnScreen[3].isVisible = true
          currentBob = 3
        end
      end
  end
end

-- function which adds physics element to each object to be displayed
local function addPhysics(objectToAddTo)
  if objectToAddTo.name == "bus" then
    physics.addBody( objectToAddTo, "dynamic", {radius = 70, bounce = 0} )
  -- elseif objectToAddTo.name == "clown" then
  --   physics.addBody( objectToAddTo, "dynamic", {radius = 185, bounce = 0})
  end
end

--display the objects and add the physics in the create scene function

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
  physics.pause()

  backGroup = display.newGroup()  -- Display group for the background image
  sceneGroup:insert( backGroup )  -- Insert into the scene's view group

  mainGroup = display.newGroup()  -- Display group for the ship, asteroids, lasers, etc.
  sceneGroup:insert( mainGroup )  -- Insert into the scene's view group

  bobGroup = display.newGroup()    -- Display group for UI objects like the score
  sceneGroup:insert( bobGroup )    -- Insert into the scene's view group

  background = display.newImageRect( backGroup, "background2.jpg", 3500, 2300 )
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  -- display objects on main group and add physics to them
  for f=1, #sheetOptions.frames do
    -- display them according to info from sheetOptions
    local objectInfo = sheetOptions.frames[f]
    local objectToDisplay = display.newImageRect(mainGroup, objectSheet, f, objectInfo.displayWidth, objectInfo.displayHeight)
    if(objectInfo.isReplacement ~= nil) then -- so if it is a replacement image
      objectToDisplay.isVisible = false -- hide it initially
    end
    objectToDisplay.x = objectInfo.displayX
    objectToDisplay.y = objectInfo.displayY
    local name = objectInfo.name
    objectToDisplay.name = name
    objectsOnScreen[#objectsOnScreen+1]=objectToDisplay
    -- adding the object and bob's reaction to it to the bobReactionTo table
    bobReactionTo[#bobReactionTo+1] = name
    bobReactionTo[name] = "nil" -- default bob's reaction should be none
    -- adding phsyics
    addPhysics(objectToDisplay)
  end

  -- displaying main character bob on main group
  for f=1, #bobOptions.frames do
    -- display them according to info from sheetOptions
    local bobInfo = bobOptions.frames[f]
    local bobToDisplay = display.newImageRect(bobGroup, bobSheet, f, 328, 497)
    if(bobInfo.name ~= "normalBob") then -- initially only display normal bob
      bobToDisplay.isVisible = false
    end
    bobToDisplay.x = display.contentCenterX + 80
    bobToDisplay.y = display.contentCenterY + 170
    local name = bobInfo.name
    bobToDisplay.name = name
    bobsOnScreen[#bobsOnScreen+1] = bobToDisplay
    -- adding phsyics
    physics.addBody(bobToDisplay, "dynamic", {radius = 80, bounce = 0})
  end

  jugglingClown = display.newSprite( clownSheet, sequences_clown )
  jugglingClown.x = 160
  jugglingClown.y = 400


  beginButton = display.newText(mainGroup, "Begin", 900, 100, native.systemFont, 44)
  beginButton:setFillColor(0, 0, 0)

  -- temporary
  local platform = display.newImageRect( backGroup, "platform.png", 1024, 250 )
  platform.x = display.contentCenterX
  platform.y = display.contentHeight-25
  platform.name = "platform"
  physics.addBody( platform, "static", {bounce = 0})
  --

  -- adding event listeners to the bodies
  for f=1, #objectsOnScreen do
      objectsOnScreen[f]:addEventListener("tap", onTap)
  end

  beginButton:addEventListener("tap", goToProgramming)

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
    physics.start()

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
