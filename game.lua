
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local physics = require("physics")
physics.start()

-- configuring the image sheet to be used
local sheetOptions =
{
    frames =
    {
        {   -- 1) clown
            x = 1424,
            y = 0,
            width = 230,
            height = 370,
            displayWidth = 230,
            displayHeight = 370,
            name = "clown",
            displayX = -90,
            displayY = 690
        },
        {   -- 2) bus
            x = 458,
            y = 0,
            width = 424,
            height = 236,
            displayWidth = 270,
            displayHeight = 150,
            name = "bus",
            displayX = 700,
            displayY = 750
        },
        { -- 3 )pond
          x = 116,
          y = 366,
          width = 680,
          height = 464,
          displayWidth = 450,
          displayHeight = 366,
          name = "pond",
          displayX = 250,
          displayY = 850
        },
        { -- 4) froggo
            x = 0,
            y = 0,
            width = 234,
            height = 188,
            displayWidth = 124,
            displayHeight = 100,
            name = "frog",
            displayX = 120,
            displayY = 900
        },
        { -- 5) speaker
            x = 834,
            y = 392,
            width = 320,
            height = 510,
            displayWidth = 150,
            displayHeight = 240,
            name = "speaker",
            displayX = 990,
            displayY = 800
        },
        { -- 6 )doggo
          x = 1164,
          y = 0,
          width = 225,
          height = 292,
          displayWidth = 190,
          displayHeight = 240,
          name = "dog",
          displayX = 900,
          displayY = 900
        },
        { -- 7 )sun
          x = 881,
          y = 0,
          width = 278,
          height = 270,
          displayWidth = 278,
          displayHeight = 242,
          name = "sun",
          displayX = -150,
          displayY = 150
        },

    }
}

local objectSheet = graphics.newImageSheet("objects.png", sheetOptions)

-- initialising variables
local clown, bus
local bob
local playButton
local objectsOnScreen = {}
local childCoded = true
-- dictionary storing each object's name and bob's reaction to it
-- this dictionary will be added to when the objects are added to the screen
-- bob's reaction will be initialised to nil at the beginning
_G.bobReactionTo = {}

-- initialising display groups
-- defer the actual creation of our three groups until we create the scene
local backGroup
local mainGroup
local uiGroup

local function goToProgramming()
  composer.gotoScene("programming", {time=800, effect="crossFade"})
end

-- swaps an image for another one in the same position
local function switchImage(oldImage, imageFile, width, height)
-- local function switchImage(component)
  print("entered switchImage")
  local newImage = display.newImageRect(mainGroup, imageFile, width, height)
  newImage.x = oldImage.x
  newImage.y = oldImage.y
  oldImage:removeSelf()
  oldImage = nil
end

-- function which handles what happens when an object on screen is tapped on
local function onTap(event)
  local object = event.target
  local objectTappedOn = object.name
  -- make object which was tapped do its thing
  if objectTappedOn == "clown" then
    object:applyLinearImpulse( 0, -10, object.x, object.y )
  elseif objectTappedOn == "bus" then
    object:applyLinearImpulse( 0, -2, object.x, object.y )
  elseif objectTappedOn == "sun" then
    -- switch sun with cloudy
    local objectWidth = 276
    local objectHeight = 242
    switchImage(object, "cloud.jpg", objectWidth, objectHeight)
    -- switchImage(object)

  end
--  Bob's reaction part
  if childCoded == true then
    -- for f=1, #objectsOnScreen do

      -- local reaction = objectsOnScreen[f].bobReaction
      local reaction = bobReactionTo[objectTappedOn]
      -- print(reaction)
      if reaction ~= nil then
        if reaction == "jump" then
           bob:applyLinearImpulse(0, -2, bob.x, bob.y )
        end
      end
    -- end
  end
end

-- function which adds physics element to each object to be displayed
local function addPhysics(objectToAddTo)
  if objectToAddTo.name == "bus" then
    physics.addBody( objectToAddTo, "dynamic", {radius = 90, bounce = 0} )
  elseif objectToAddTo.name == "clown" then
    physics.addBody( objectToAddTo, "dynamic", {radius = 185, bounce = 0})
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

   uiGroup = display.newGroup()    -- Display group for UI objects like the score
   sceneGroup:insert( uiGroup )    -- Insert into the scene's view group

  background = display.newImageRect( backGroup, "background2.jpg", 3500, 2300 )
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  -- display objects on main group and add physics to them
  for f=1, #sheetOptions.frames do
    -- display them according to info from sheetOptions
    local objectInfo = sheetOptions.frames[f]
    local objectToDisplay = display.newImageRect(mainGroup, objectSheet, f, objectInfo.displayWidth, objectInfo.displayHeight)
    objectToDisplay.x = objectInfo.displayX
    objectToDisplay.y = objectInfo.displayY
    local name = objectInfo.name
    objectToDisplay.name = name
    objectToDisplay.bobReaction = "jump" -- default bob's reaction should be none
    objectsOnScreen[#objectsOnScreen+1]=objectToDisplay
    -- adding the object and bob's reaction to it to the bobReactionTo table
    bobReactionTo[#bobReactionTo+1] = name
    bobReactionTo[name] = "nil"
    -- adding phsyics
    addPhysics(objectToDisplay)
  end

  -- displaying main character bob on main group
  bob = display.newImageRect( mainGroup, "bob.png", 180, 360 )
  bob.x = display.contentCenterX + 80
  bob.y = display.contentCenterY + 170
  bob.name = "bob"
  physics.addBody(bob, "dynamic", {radius = 185, bounce = 0})

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
