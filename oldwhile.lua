
local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

--navigate to main Bob page
local function goToGame(event)
  local phase = event.phase
  if ("ended" == phase) then
    composer.gotoScene("game", {time=800, effect="crossFade"})
  end
end

-- navigate to Lessons page
local function gotoLessons()
  composer.gotoScene("lessons", {time=800, effect="crossFade"})
end

-- go to first page of While lesson
local function gotoWhileLessonText( event )
  local phase = event.phase
  if ("ended" == phase) then
    composer.gotoScene("whileLessonText", {time=800, effect="crossFade"})
  end
end

-- sets the reaction to the clown according to which button was pressed
local function setReactionToClown( event )
  local phase = event.phase
  if ("ended" == phase) then
    -- event.target._view._labelColor = { 255, 0, 0, 1.0 }
    local requiredReaction = event.target:getLabel()
      if(requiredReaction == "Laugh") then
        bobReactionTo["clown"] = "laugh"
      elseif(requiredReaction == "Cheer") then
        bobReactionTo["clown"] = "cheer"
      end
  end
end

-- sets the reaction to the weather according to which button was pressed
local function setReactionWeather( event )
  local phase = event.phase
  if ("ended" == phase) then
    local requiredReaction = event.target:getLabel()
      if(requiredReaction == "Happy") then
        bobReactionTo["sun"] = "smile"
      elseif requiredReaction == "Sad" then
        bobReactionTo["sun"] = "sad"
      end
  end
end

-- sets the reaction to the speaker according to which button was pressed
local function setReactionSpeaker( event )
  local phase = event.phase
  if ("ended" == phase) then
    local requiredReaction = event.target:getLabel()
      if(requiredReaction == "Dancing") then
        bobReactionTo["speaker"] = "dance"
      elseif requiredReaction == "Singing" then
        bobReactionTo["speaker"] = "sing"
      end
  end
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

  display.setDefault( "background", 245,245,220, 1 )

  local playButton = widget.newButton(
    {
      left = 150,
      top = 200,
      width = 184,
      height = 100,
      defaultFile = "reactionButtonFrame.png",
      overFile = "reactionButtonFramePressed.png",
      onEvent = goToGame,
      label = "Go to Bob",
      font = "Helvetica",
      fontSize = 35,
      labelColor = { default = {0,0,0 }, over = { 255, 0, 0 , 0.8} },
    }
  )

  playButton.x = display.contentCenterX + 500
  playButton.y = display.contentCenterY + 430
  sceneGroup:insert(playButton)


  local lessonsButton = display.newText(sceneGroup, "Back to lessons", display.contentCenterX - 500, display.contentCenterY - 450, native.systemFont, 44)
  lessonsButton:setFillColor(0, 0, 0)



  lessonsButton:addEventListener("tap", gotoLessons)

  local backButton = widget.newButton(
    {
      left = 150,
      top = 200,
      width = 184,
      height = 100,
      defaultFile = "reactionButtonFrame.png",
      overFile = "reactionButtonFramePressed.png",
      onEvent = gotoWhileLessonText,
      label = "Back",
      font = "Helvetica",
      fontSize = 30,
      labelColor = { default = { 0, 0, 0, 1.0 }, over = { 255, 0, 0 , 0.8} },
    }
  )

  backButton.x = display.contentCenterX - 500
  backButton.y = display.contentCenterY + 430
  sceneGroup:insert(backButton)

  -- 1

  local clownText = display.newText(sceneGroup, "1) While the clown juggles, bob will...", display.contentCenterX, display.contentCenterY - 340, Helvetica, 48)
  clownText:setFillColor(0.32,0.43,0.56)

  local laughButton = widget.newButton(
    {
      left = 150,
      top = 200,
      width = 184,
      height = 100,
      defaultFile = "reactionButtonFrame.png",
      overFile = "reactionButtonFramePressed.png",
      onEvent = setReactionToClown,
      label = "Laugh",
      font = "Arial Black",
	    fontSize = 45,
	    labelColor = { default = { 0, 0, 0, 1.0 }, over = { 255, 0, 0 , 0.8} },
    }
  )

  laughButton.x = display.contentCenterX
  laughButton.y = display.contentCenterY - 250
  sceneGroup:insert(laughButton)


  local cheerButton = widget.newButton(
    {
      left = 150,
      top = 200,
      width = 184,
      height = 100,
      defaultFile = "reactionButtonFrame.png",
      overFile = "reactionButtonFramePressed.png",
      onEvent = setReactionToClown,
      label = "Cheer",
      font = "Arial Black",
	    fontSize = 45,
	    labelColor = { default = { 0, 0, 0, 1.0 }, over = { 255, 255, 255 , 0.8} },
    }
  )

  cheerButton.x = display.contentCenterX
  cheerButton.y = display.contentCenterY - 140
  sceneGroup:insert(cheerButton)

  -- 2

  local weatherText = display.newText(sceneGroup, "2) While the weather is bad, Bob is", display.contentCenterX, display.contentCenterY - 40, Helvetica, 48)
  weatherText:setFillColor(0.55,0.32,0.63)

  local happyButton = widget.newButton(
    {
      left = 150,
      top = 200,
      width = 184,
      height = 100,
      defaultFile = "reactionButtonFrame.png",
      overFile = "reactionButtonFramePressed.png",
      onEvent = setReactionWeather,
      label = "Happy",
      font = "Arial Black",
	    fontSize = 45,
	    labelColor = { default = { 0, 0, 0, 1.0 }, over = { 255, 255, 255 , 0.8} },
    }
  )

  happyButton.x = display.contentCenterX
  happyButton.y = display.contentCenterY + 40
  sceneGroup:insert(happyButton)

  local sadButton = widget.newButton(
    {
      left = 150,
      top = 200,
      width = 184,
      height = 100,
      defaultFile = "reactionButtonFrame.png",
      overFile = "reactionButtonFramePressed.png",
      onEvent = setReactionWeather,
      label = "Sad",
      font = "Arial Black",
	    fontSize = 45,
	    labelColor = { default = { 0, 0, 0, 1.0 }, over = { 255, 255, 255 , 0.8} },
    }
  )

  sadButton.x = display.contentCenterX
  sadButton.y = display.contentCenterY + 150
  sceneGroup:insert(sadButton)

  --3

  local speakerText = display.newText(sceneGroup, "3) While the speaker is playing music, Bob is", display.contentCenterX, display.contentCenterY + 245, Helvetica, 48)
  speakerText:setFillColor(0.22,0.38,0.20)

  local danceButton = widget.newButton(
    {
      left = 150,
      top = 200,
      width = 220,
      height = 100,
      defaultFile = "reactionButtonFrame.png",
      overFile = "reactionButtonFramePressed.png",
      onEvent = setReactionSpeaker,
      label = "Dancing",
      font = "Arial Black",
      fontSize = 45,
      labelColor = { default = { 0}, over = { 255, 255, 255 , 0.8} },
    }
  )

  danceButton.x = display.contentCenterX
  danceButton.y = display.contentCenterY + 330
  sceneGroup:insert(danceButton)


  local singButton = widget.newButton(
    {
      left = 150,
      top = 200,
      width = 220,
      height = 100,
      defaultFile = "reactionButtonFrame.png",
      overFile = "reactionButtonFramePressed.png",
      onEvent = setReactionSpeaker,
      label = "Singing",
      font = "Arial Black",
      fontSize = 45,
      labelColor = { default = { 0, 0, 0, 1.0 }, over = { 255, 255, 255 , 0.8} },
    }
  )

  singButton.x = display.contentCenterX
  singButton.y = display.contentCenterY + 440
  sceneGroup:insert(singButton)

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
      display.setDefault( "background", 245,245,220, 1 )

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
