
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local socket = require("socket")
local physics = require("physics")
physics.start()

-- configuring the image sheet for bob to be used
local bobOptions =
{
    frames =
    {
        {   -- 1) smiley bob
            x = 0,
            y = 0,
            width = 540,
            height = 960,
            name = "smileyBob"
        },
        {   -- 2) normal bob
            x = 540,
            y = 0,
            width = 540,
            height = 960,
            name = "normalBob",
        },
        {   -- 2) sad bob
            x = 1080,
            y = 0,
            width = 540,
            height = 960,
            name = "sadBob",
        }
    }
}

-- for bob laughing animation
local laughOptions =
{
  width = 540,
  height = 956,
  numFrames = 3
}

-- sequences table for bob laughing
local sequences_laugh = {
    -- consecutive frames sequence
    {
        name = "laughing",
        start = 1,
        count = 3,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    }
}

-- for bob yelling animation
local yellOptions =
{
  width = 540,
  height = 956,
  numFrames = 2
}

-- sequences table for bob crying
local sequences_yell = {
    -- consecutive frames sequence
    {
        name = "yelling",
        start = 1,
        count = 2,
        time = 2200,
        loopCount = 0,
        loopDirection = "forward"
    }
}

-- for clown animation
local clownOptions =
{
  width = 291,
  height = 447,
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

-- for dog animation
local dogOptions =
{
  width = 242,
  height = 208,
  numFrames = 3
}

-- sequences table for clown
local sequences_dog = {
    -- consecutive frames sequence
    {
        name = "barking",
        start = 1,
        count = 4,
        time = 2000,
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
            y = 200,
            width = 370,
            height = 556,
            displayWidth = 291,
            displayHeight = 447,
            name = "clown",
            displayX = -90,
            displayY = 600,
            isAnimation = true
        },
        {   -- 2) bus
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
        { -- 3)pond
          x = 505,
          y = 236,
          width = 380,
          height = 297,
          displayWidth = 300,
          displayHeight = 243,
          name = "pond",
          displayX = 180,
          displayY = 900
        },
        { -- 4) froggo
            x = 300,
            y = 0,
            width = 235,
            height = 194,
            displayWidth = 200,
            displayHeight = 161,
            name = "frog",
            displayX = 110,
            displayY = 925
        },
        { -- 5) froggo2
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
        { -- 6) speaker
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
        { -- 7)doggo
          x = 538,
          y = 0,
          width = 242,
          height = 210,
          displayWidth = 240,
          displayHeight = 209,
          name = "dog",
          displayX = 700,
          displayY = 900,
          isAnimation = true
        },
        { -- 8)doggo bark
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
        { -- 9)sun
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
        {-- 10) cloud
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
local bobSheet = graphics.newImageSheet( "defaultBobs.png", bobOptions)
local clownSheet = graphics.newImageSheet( "clown_sprite.png", clownOptions )
local dogSheet = graphics.newImageSheet( "dog_sprite.png", dogOptions )
-- bob animation sheets:
local laughSheet = graphics.newImageSheet( "laughing_bob_sprite.png", laughOptions )
local yellSheet = graphics.newImageSheet( "yelling_bob_sprite.png", yellOptions )

-- initialising variables
-- local clown, bus
local bob
local playButton
local objectsOnScreen = {}
local bobsOnScreen = {}
local childCoded = true
local currentBob = 1 -- keeps track of which bob is currently displayed
-- dictionary storing each object's name and bob's reaction to it
-- this dictionary will be added to when the objects are added to the screen
-- bob's reaction will be initialised to nil at the beginning
_G.bobReactionTo = {}

-- all bob's animations
local laughAnimation
local yellAnimation


-- initialising display groups
-- defer the actual creation of our three groups until we create the scene
local backGroup
local mainGroup
local bobGroup

local function goToProgramming()
  composer.gotoScene("lessons", {time=800, effect="crossFade"})
end

local function dogSpriteListener(event)
  local thisSprite = event.target
  if ( event.phase == "loop" ) then
        -- thisSprite:setSequence( "fastRun" )  -- switch to "fastRun" sequence
        thisSprite:pause()  -- play the new sequence
    end
end

local function yellSpriteListener(event)
  local thisSprite = event.target
  local resumePrevAnim
  if laughAnimation.isPlaying then
    resumePrevAnim = true
  end
  if ( event.phase == "loop" ) then
        -- thisSprite:setSequence( "fastRun" )  -- switch to "fastRun" sequence
        thisSprite:pause()  -- play the new sequence
        thisSprite.isVisible = false
        if resumePrevAnim then
          laughAnimation.isVisible = true
        else
          bobsOnScreen[currentBob].isVisible = true
        end
    end
end


-- function which handles what happens when an object on screen is tapped on
local function onTap(event)
  local object = event.target
  local objectTappedOn = object.name
  -- make object which was tapped do its thing
  if objectTappedOn == "clown" then
    -- make clown juggle
    if objectsOnScreen[1].isPlaying ~= true then -- if clown not already juggling
      objectsOnScreen[1]:play()
    else -- if the clown is already juggling
      objectsOnScreen[1]:pause()
    end
  elseif objectTappedOn == "dog" then
    -- make dog bark
    objectsOnScreen[7]:play()
  elseif objectTappedOn == "bus" then
    object:applyLinearImpulse( 0, -2, object.x, object.y )
  elseif objectTappedOn == "sun" then
    object.isVisible = false
    objectsOnScreen[10].isVisible = true -- display cloud
  elseif objectTappedOn == "cloud" then
    object.isVisible = false
    objectsOnScreen[9].isVisible = true -- display sun
    -- go back to neutral bob
    bobsOnScreen[currentBob].isVisible=false
    bobsOnScreen[2].isVisible = true
    currentBob = 2

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
        elseif reaction == "sad" then
          bobsOnScreen[currentBob].isVisible = false
          bobsOnScreen[3].isVisible = true
          currentBob = 3
        elseif reaction == "speak" then
          -- make bob speak
          -- bobsOnScreen[currentBob].isVisible = false
          -- bobsOnScreen[3].isVisible = true
          -- currentBob = 3
        elseif reaction == "cry" then
          -- make bob cry
          -- hide current bob
          -- bobsOnScreen[currentBob].isVisible = false
          -- create animation from crying sprite and play it
          -- local cryAnimation = display.newSprite( mainGroup, dogSheet, sequences_dog)
          -- objectToDisplay:addEventListener( "sprite", spriteListener )
          -- add an event listener to that sprite, that stops it after the loop, and re-displays current bob
        elseif reaction == "yell" then
          -- make bob yell
          bobsOnScreen[currentBob].isVisible = false
          yellAnimation.isVisible = true
          yellAnimation:play()

        elseif reaction == "laugh" then
          -- make bob laugh
          -- make current bob invisible,
          bobsOnScreen[currentBob].isVisible = false
          -- make laugh animation visible
          if laughAnimation.isVisible == true then -- if it is playing
            laughAnimation.isVisible = false
            laughAnimation:pause()
            bobsOnScreen[currentBob].isVisible = true
          else
            laughAnimation.isVisible = true
            laughAnimation:play()
            bobsOnScreen[currentBob].isVisible = false
          end
        elseif reaction == "jump" then
          -- make bob jump
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
    local name = objectInfo.name
    local objectToDisplay
    if objectInfo.isAnimation == nil then -- if not animation to display
      objectToDisplay = display.newImageRect(mainGroup, objectSheet, f, objectInfo.displayWidth, objectInfo.displayHeight)
    else
      if name == "clown" then
        objectToDisplay = display.newSprite( mainGroup, clownSheet, sequences_clown)
      elseif name == "dog" then
        objectToDisplay = display.newSprite( mainGroup, dogSheet, sequences_dog)
        objectToDisplay:addEventListener( "sprite", dogSpriteListener )
      end
      objectToDisplay.width = objectInfo.displayWidth
      objectToDisplay.height = objectInfo.displayHeight
    end
    if(objectInfo.isReplacement ~= nil) then -- so if it is a replacement image
      objectToDisplay.isVisible = false -- hide it initially
    end
    objectToDisplay.x = objectInfo.displayX
    objectToDisplay.y = objectInfo.displayY

    objectToDisplay.name = name
    -- add them to objects on screen array
    objectsOnScreen[#objectsOnScreen+1]=objectToDisplay


    -- adding the object and bob's reaction to it to the bobReactionTo table
    bobReactionTo[#bobReactionTo+1] = name
    bobReactionTo[name] = "nil" -- default bob's reaction should be none
    -- adding phsyics
    -- addPhysics(objectToDisplay)
  end


  -- displaying main character bob on main group
  local bobX = display.contentCenterX + 80
  local bobY = display.contentCenterY + 170
  for f=1, #bobOptions.frames do
    -- display them according to info from sheetOptions
    local bobInfo = bobOptions.frames[f]
    local name = bobInfo.name
    local bobToDisplay = display.newImageRect(bobGroup, bobSheet, f, 540, 956)
    if(name ~= "normalBob") then -- initially only display normal bob
      bobToDisplay.isVisible = false
    end
    bobToDisplay.x = bobX
    bobToDisplay.y = bobY
    bobToDisplay.name = name
    bobsOnScreen[#bobsOnScreen+1] = bobToDisplay
  end
  currentBob = 2
  -- bobsOnScreen[currentBob].isVisible = false
  -- display all bob sprite animations, and hide each
  --laugh animation
  laughAnimation = display.newSprite( mainGroup, laughSheet, sequences_laugh)
  laughAnimation.x = bobX
  laughAnimation.y = bobY
  laughAnimation.width = bobsOnScreen[currentBob].width
  laughAnimation.height = bobsOnScreen[currentBob].height
  laughAnimation.isVisible = false
  -- yell animation
  yellAnimation = display.newSprite( mainGroup, yellSheet, sequences_yell)
  yellAnimation.x = bobX
  yellAnimation.y = bobY
  yellAnimation.width = bobsOnScreen[currentBob].width
  yellAnimation.height = bobsOnScreen[currentBob].height
  yellAnimation.isVisible = false
  yellAnimation:addEventListener("sprite", yellSpriteListener)




  beginButton = display.newText(mainGroup, "Click here to program Bob!", 750, 100, native.systemFont, 44)
  beginButton:setFillColor(0, 0, 0)

  -- -- temporary
  -- local platform = display.newImageRect( backGroup, "platform.png", 1024, 250 )
  -- platform.x = display.contentCenterX
  -- platform.y = display.contentHeight-25
  -- platform.name = "platform"
  -- physics.addBody( platform, "static", {bounce = 0})
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
