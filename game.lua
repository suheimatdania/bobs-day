
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local socket = require("socket")
--configuring sounds to be used
local soundTable =
{
  speakerSong = audio.loadSound("speaker_song.mp3"),
  clownSong = audio.loadSound(""),
  frogCroak = audio.loadSound("frog_croak.mp3"),
  dogBark = audio.loadSound(""),
  bobSing = audio.loadSound(""),
  bobYell = audio.loadSound(""),
  bobLaugh = audio.loadSound(""),
  bobCheer = audio.loadSound(""),
  bobHello = audio.loadSound(""),
  bobCry = audio.loadSound("")
}

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

-- for bob laughing animation
local cheerOptions =
{
  width = 540,
  height = 956,
  numFrames = 4
}

-- sequences table for bob laughing
local sequences_cheer = {
    -- consecutive frames sequence
    {
        name = "laughing",
        start = 1,
        count = 4,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    }
}

-- for bob dancing animation
local danceOptions =
{
  width = 540,
  height = 956,
  numFrames = 4
}

-- sequences table for bob laughing
local sequences_dance = {
    -- consecutive frames sequence
    {
        name = "dancing",
        start = 1,
        count = 4,
        time = 1000,
        loopCount = 0,
        loopDirection = "forward"
    }
}

-- for bob singing animation
local singOptions =
{
  width = 540,
  height = 956,
  numFrames = 5
}

-- sequences table for bob laughing
local sequences_sing = {
    -- consecutive frames sequence
    {
        name = "singing",
        start = 1,
        count = 4,
        time = 2000,
        loopCount = 0,
        loopDirection = "forward"
    }
}


-- for bob crying animation
local cryOptions =
{
  width = 540,
  height = 956,
  numFrames = 4
}

-- sequences table for bob crying
local sequences_cry = {
    -- consecutive frames sequence
    {
        name = "crying",
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

-- sequences table for bob yelling
local sequences_yell = {
    -- consecutive frames sequence
    {
        name = "yelling",
        start = 1,
        count = 2,
        time = 2600,
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

-- for frog animation
local frogOptions =
{
  width = 234,
  height = 195,
  numFrames = 8
}

-- sequences table for frog
local sequences_frog = {
    -- consecutive frames sequence
    {
        name = "eating",
        start = 1,
        count = 8,
        time = 1200,
        loopCount = 0,
        loopDirection = "forward"
    }
}

-- for speaker animation
local speakerOptions =
{
  width = 276,
  height = 450,
  numFrames = 5
}

-- sequences table for frog
local sequences_speaker = {
    -- consecutive frames sequence
    {
        name = "music",
        start = 1,
        count = 5,
        time = 700,
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

-- sequences table for dog
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
          displayWidth = 400,
          displayHeight = 243,
          name = "pond",
          displayX = 180,
          displayY = 900
        },
        { -- 4) froggo
            x = 300,
            y = 0,
            width = 234,
            height = 195,
            displayWidth = 234,
            displayHeight = 195,
            name = "frog",
            displayX = 110,
            displayY = 925,
            isAnimation = true
        },
        { -- 5) speaker
            x = 1116,
            y = 797,
            width = 404,
            height = 643,
            displayWidth = 276,
            displayHeight = 450,
            name = "speaker",
            displayX = 990,
            displayY = 800,
            isAnimation = true
        },
        { -- 6)doggo
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
        { -- 7)doggo bark
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
        { -- 8)sun
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
        {-- 9) cloud
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
local frogSheet = graphics.newImageSheet( "frog_sprite.png", frogOptions )
local speakerSheet = graphics.newImageSheet( "speaker_sprite.png", speakerOptions )
-- bob animation sheets:
local laughSheet = graphics.newImageSheet( "laughing_bob_sprite.png", laughOptions )
local danceSheet = graphics.newImageSheet( "dancing_bob_sprite.png", danceOptions )
local singSheet = graphics.newImageSheet( "singing_bob_sprite.png", singOptions )
local yellSheet = graphics.newImageSheet( "yelling_bob_sprite.png", yellOptions )
local crySheet = graphics.newImageSheet( "crying_bob_sprite.png", cryOptions )
local cheerSheet = graphics.newImageSheet( "cheering_bob_sprite.png", cheerOptions )

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
local firstBusMove = true
_G.bobReactionTo = {}

-- initialising all bob's animations
local laughAnimation
local danceAnimation
local singAnimation
local yellAnimation
local cryAnimation
local cheerAnimation

-- initialising display groups
-- defer the actual creation of our three groups until we create the scene
local backGroup
local mainGroup
local bobGroup

local function goToProgramming()
  composer.gotoScene("lessons", {time=800, effect="crossFade"})
end

local function goToMainMenu()
  composer.gotoScene("menu", {time=800, effect="crossFade"})
end

local function discreteSpriteListener(event)
  local thisSprite = event.target
  if ( event.phase == "loop" ) then
        -- thisSprite:setSequence( "fastRun" )  -- switch to "fastRun" sequence
        thisSprite:pause()  -- play the new sequence
    end
end

local function yellSpriteListener(event)
  local thisSprite = event.target
  local resumePrevAnimLaugh
  local resumePrevAnimDance
  if laughAnimation.isPlaying then
    laughAnimation.isVisible = false
    resumePrevAnimLaugh = true
  elseif danceAnimation.isPlaying then
    danceAnimation.isVisible = false
    resumePrevAnimDance = true
  end
  if ( event.phase == "loop" ) then
        -- thisSprite:setSequence( "fastRun" )  -- switch to "fastRun" sequence
        thisSprite:pause()  -- play the new sequence
        thisSprite.isVisible = false
        if resumePrevAnimLaugh then
          laughAnimation.isVisible = true
        elseif resumePrevAnimDance then
          danceAnimation.isVisible = true
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
    else -- if the clown is already juggling, make it stop
      objectsOnScreen[1]:pause()
    end
  elseif objectTappedOn == "speaker" then
    -- make speaker play
    if objectsOnScreen[5].isPlaying ~= true then -- if speaker not already playing
      objectsOnScreen[5]:play()
      audio.play( soundTable["speakerSong"] )
      if(objectsOnScreen[1].isPlaying) then-- if clown juggling make him stop (only one while loop at a time)
        objectsOnScreen[1]:pause() -- make clown stop
        -- bobsOnScreen[currentBob].isVisible = false
      end
    else -- if the speaker is already playing
      audio.pause( soundTable["speakerSong"] )
      objectsOnScreen[5]:pause()
      objectsOnScreen[5]:setFrame(1)
    end
  elseif objectTappedOn == "dog" then
    -- make dog bark
    objectsOnScreen[6]:play()
  elseif objectTappedOn == "frog" then
    -- make frog eat
    audio.play( soundTable["frogCroak"], {duration = 1500 })
    objectsOnScreen[4]:play()
  elseif objectTappedOn == "bus" then
    if(firstBusMove == false) then
      objectsOnScreen[2]:scale(-1, 1)
    else
      firstBusMove = false
    end
    -- objectsOnScreen[2]:scale(-1, 1)
    if(objectsOnScreen[2].x == 700) then
      transition.to(objectsOnScreen[2], {x=200, y=750, time=2000})
    else
      transition.to(objectsOnScreen[2], {x=700, y=750, time=2000})
    end
  elseif objectTappedOn == "sun" then
    object.isVisible = false
    objectsOnScreen[9].isVisible = true -- display cloud
  elseif objectTappedOn == "cloud" then
    object.isVisible = false
    objectsOnScreen[8].isVisible = true -- display sun
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
          bobsOnScreen[currentBob].isVisible = false -- hide current bob
          cryAnimation.isVisible = true -- show the crying animation and play it
          cryAnimation:play()
        elseif reaction == "yell" then
          bobsOnScreen[currentBob].isVisible = false
          yellAnimation.isVisible = true
          yellAnimation:play()

        elseif reaction == "laugh" then
          -- make current bob invisible,
          bobsOnScreen[currentBob].isVisible = false
          -- make laugh animation visible
          if laughAnimation.isVisible == true then -- if it is playing
            laughAnimation.isVisible = false -- make it stop and hide it
            laughAnimation:pause()
            bobsOnScreen[currentBob].isVisible = true
          else
            laughAnimation.isVisible = true
            laughAnimation:play()
            bobsOnScreen[currentBob].isVisible = false
          end
        elseif reaction == "cheer" then
          -- make bob cheer
          -- make current bob invisible,
          bobsOnScreen[currentBob].isVisible = false
          -- make laugh animation visible
          if cheerAnimation.isVisible == true then -- if it is playing
            cheerAnimation.isVisible = false -- make it stop and hide it
            cheerAnimation:pause()
            bobsOnScreen[currentBob].isVisible = true
          else
            cheerAnimation.isVisible = true
            cheerAnimation:play()
            bobsOnScreen[currentBob].isVisible = false
          end
        elseif reaction == "dance" then
          -- make bob dance
          -- make current bob invisible,
          bobsOnScreen[currentBob].isVisible = false
          -- make dance animation visible
          if danceAnimation.isVisible == true then -- if it is playing
            danceAnimation.isVisible = false
            danceAnimation:pause()
            bobsOnScreen[currentBob].isVisible = true
          else
            danceAnimation.isVisible = true
            danceAnimation:play()
            bobsOnScreen[currentBob].isVisible = false
          end
        elseif reaction == "sing" then
          -- make bob dance
          -- make current bob invisible,
          bobsOnScreen[currentBob].isVisible = false
          -- make dance animation visible
          if singAnimation.isVisible == true then -- if it is playing
            singAnimation.isVisible = false
            singAnimation:pause()
            bobsOnScreen[currentBob].isVisible = true
          else
            singAnimation.isVisible = true
            singAnimation:play()
            bobsOnScreen[currentBob].isVisible = false
          end
        end
      end
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
      elseif name == "speaker" then
        objectToDisplay = display.newSprite( mainGroup, speakerSheet, sequences_speaker)
      elseif name == "dog" then
        objectToDisplay = display.newSprite( mainGroup, dogSheet, sequences_dog)
        objectToDisplay:addEventListener( "sprite", discreteSpriteListener )
      elseif name == "frog" then
        objectToDisplay = display.newSprite( mainGroup, frogSheet, sequences_frog)
        objectToDisplay:addEventListener( "sprite", discreteSpriteListener )
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
  -- dance animation
  danceAnimation = display.newSprite( mainGroup, danceSheet, sequences_laugh)
  danceAnimation.x = bobX
  danceAnimation.y = bobY
  danceAnimation.width = bobsOnScreen[currentBob].width
  danceAnimation.height = bobsOnScreen[currentBob].height
  danceAnimation.isVisible = false
  -- dance animation
  singAnimation = display.newSprite( mainGroup, singSheet, sequences_sing)
  singAnimation.x = bobX
  singAnimation.y = bobY
  singAnimation.width = bobsOnScreen[currentBob].width
  singAnimation.height = bobsOnScreen[currentBob].height
  singAnimation.isVisible = false
  -- cheer animation
  cheerAnimation = display.newSprite( mainGroup, cheerSheet, sequences_cheer)
  cheerAnimation.x = bobX
  cheerAnimation.y = bobY
  cheerAnimation.width = bobsOnScreen[currentBob].width
  cheerAnimation.height = bobsOnScreen[currentBob].height
  cheerAnimation.isVisible = false
  -- yell animation
  yellAnimation = display.newSprite( mainGroup, yellSheet, sequences_yell)
  yellAnimation.x = bobX
  yellAnimation.y = bobY
  yellAnimation.width = bobsOnScreen[currentBob].width
  yellAnimation.height = bobsOnScreen[currentBob].height
  yellAnimation.isVisible = false
  yellAnimation:addEventListener("sprite", yellSpriteListener)
  -- cry animation
  cryAnimation = display.newSprite( mainGroup, crySheet, sequences_cry)
  cryAnimation.x = bobX
  cryAnimation.y = bobY
  cryAnimation.width = bobsOnScreen[currentBob].width
  cryAnimation.height = bobsOnScreen[currentBob].height
  cryAnimation.isVisible = false
  cryAnimation:addEventListener("sprite", yellSpriteListener)


  beginButton = display.newText(mainGroup, "Click here to program Bob!", 750, 100, native.systemFont, 44)
  beginButton:setFillColor(0, 0, 0)
  beginButton:addEventListener("tap", goToProgramming)

  menuButton = display.newText(mainGroup, "Back to main menu", -140, 1000, native.systemFont, 31)
  menuButton:setFillColor(0, 0, 0)
  menuButton:addEventListener("tap", goToMainMenu)

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
