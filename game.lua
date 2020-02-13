
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
            name = "clown",
            displayX = 800,
            displayY = 690
        },
        {   -- 2) bus
            x = 458,
            y = 0,
            width = 424,
            height = 236,
            name = "bus",
            displayX = -10,
            displayY = 750
        },
    }
}

local objectSheet = graphics.newImageSheet("objects.png", sheetOptions)

-- initialising variables
local clown, bus
local objectsOnScreen = {}

-- initialising display groups
-- defer the actual creation of our three groups until we create the scene
local backGroup
local mainGroup
local uiGroup

-- function which handles what happens when an object on screen is tapped on
local function onTap(event)
  local component = event.target
  local tappedOn = component.name
  -- make object which was tapped do its thing
  if tappedOn == "clown" then
    component:applyLinearImpulse( 0, -10, component.x, component.y )
  elseif tappedOn == "bus" then
    component:applyLinearImpulse( 0, -2, component.x, component.y )
  end
  -- Bob's reaction part
  -- if childCoded == true then
  --   for f=1, #objectsOnScreen do
  --     local reaction = objectsOnScreen[f].bobReaction
  --     if reaction ~= nil then
  --       if reaction == "jump" then
  --         -- bob:applyLinearImpulse(0, -100, bob.x, bob.y )
  --       end
  --     end
  --   end
  -- end
end

-- function which adds physics element to each object to be displayed
local function addPhysics(objectToAddTo)
  if objectToAddTo.name == "bus" then
    physics.addBody( objectToAddTo, "dynamic", {radius = 130, bounce = 0} )
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

  background = display.newImageRect( backGroup, "backgroundL.jpg", 3500, 2300 )
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  -- display objects on main group and add physics to them
  for f=1, #sheetOptions.frames do
    -- display them according to info from sheetOptions
    local objectInfo = sheetOptions.frames[f]
    local objectToDisplay = display.newImageRect(mainGroup, objectSheet, f, objectInfo.width, objectInfo.height)
    objectToDisplay.x = objectInfo.displayX
    objectToDisplay.y = objectInfo.displayY
    objectToDisplay.name = objectInfo.name
    objectToDisplay.bobReaction = "jump"
    objectsOnScreen[#objectsOnScreen+1]=objectToDisplay
    -- adding phsyics
    addPhysics(objectToDisplay)
  end

  -- displaying main character bob on main group
  bob = display.newImageRect( "bob.png", 180, 360 )
  bob.x = display.contentCenterX + 80
  bob.y = display.contentCenterY + 170
  bob.name = "bob"

  -- temporary
  local platform = display.newImageRect( mainGroup, "platform.png", 1024, 250 )
  platform.x = display.contentCenterX
  platform.y = display.contentHeight-25
  platform.name = "platform"
  physics.addBody( platform, "static", {bounce = 0})
  --

  -- adding event listeners to the bodies
  for f=1, #objectsOnScreen do
      objectsOnScreen[f]:addEventListener("tap", onTap)
  end

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
