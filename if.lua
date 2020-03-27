
local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local function goToGame(event)
  local phase = event.phase
  if ("ended" == phase) then
    composer.gotoScene("game", {time=800, effect="crossFade"})
  end
end

local function gotoLessons()
  composer.gotoScene("lessons", {time=800, effect="crossFade"})
end


local function gotoWhileLessonText( event )
  local phase = event.phase
  if ("ended" == phase) then
    composer.gotoScene("whileLessonText", {time=800, effect="crossFade"})
  end
end

local function goToPart2( event )
  local phase = event.phase
  if ("ended" == phase) then
    composer.gotoScene("ifLessonText2", {time=800, effect="crossFade"})
  end
end

local function setReactionToDog( event )
  local phase = event.phase
  if ("ended" == phase) then
    local requiredReaction = event.target:getLabel()
      if(requiredReaction == "Yell") then
        bobReactionTo["dog"] = "yell"
      elseif(requiredReaction == "Cry") then
        bobReactionTo["dog"] = "cry"
      end
  end
end

local function setReactionToBusLeft( event )
  local phase = event.phase
  if ("ended" == phase) then
    local requiredReaction = event.target:getLabel()
      if(requiredReaction == "Wave") then
        bobReactionTo["busLeft"] = "wave"
      elseif(requiredReaction == "Say Goodbye") then
        bobReactionTo["busLeft"] = "goodbye"
      end
  end
end

local function setReactionToBusRight( event )
  local phase = event.phase
  if ("ended" == phase) then
    local requiredReaction = event.target:getLabel()
      if(requiredReaction == "Wave") then
        bobReactionTo["busRight"] = "wave"
      elseif(requiredReaction == "Say Hello") then
        bobReactionTo["busRight"] = "hello"
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

  local lessonsButton = display.newText(sceneGroup, "Back to lessons", display.contentCenterX - 500, display.contentCenterY - 450, native.systemFont, 44)
  lessonsButton:setFillColor(0,0,0)
  lessonsButton:addEventListener("tap", gotoLessons)


    local backButton = widget.newButton(
      {
        left = 150,
        top = 200,
        width = 184,
        height = 100,
        defaultFile = "reactionButtonFrame.png",
        overFile = "reactionButtonFramePressed.png",
        onEvent = goToPart2,
        label = "Back",
        font = "Helvetica",
        fontSize = 30,
        labelColor = { default = { 0, 0, 0, 1.0 }, over = { 255, 0, 0 , 0.8} },
      }
    )

    backButton.x = display.contentCenterX - 500
    backButton.y = display.contentCenterY + 430
    sceneGroup:insert(backButton)


  local playButton = widget.newButton(
    {
      left = 150,
      top = 200,
      width = 284,
      height = 100,
      defaultFile = "reactionButtonFrame.png",
      overFile = "reactionButtonFramePressed.png",
      onEvent = goToGame,
      label = "Go to Bob\nto see results!",
      font = "Helvetica",
      fontSize = 35,
      labelColor = { default = {0,0,0 }, over = { 255, 0, 0 , 0.8} },
    }
  )

  playButton.x = display.contentCenterX + 500
  playButton.y = display.contentCenterY + 430
  sceneGroup:insert(playButton)

  -- 1
  local dogText = display.newText(sceneGroup, "1) If the dog barks, then Bob will...", display.contentCenterX, display.contentCenterY - 360, Helvetica, 48)
  dogText:setFillColor(0.32,0.43,0.56)

  local yellButton = widget.newButton(
    {
      left = 150,
      top = 200,
      width = 184,
      height = 100,
      defaultFile = "reactionButtonFrame.png",
      overFile = "reactionButtonFramePressed.png",
      onEvent = setReactionToDog,
      label = "Yell",
      font = "Arial Black",
      fontSize = 45,
      labelColor = { default = { 0, 0, 0, 1.0 }, over = { 255, 0, 0 , 0.8} },
    }
  )

  yellButton.x = display.contentCenterX
  yellButton.y = display.contentCenterY - 260
  sceneGroup:insert(yellButton)


  local cryButton = widget.newButton(
    {
      left = 150,
      top = 200,
      width = 184,
      height = 100,
      defaultFile = "reactionButtonFrame.png",
      overFile = "reactionButtonFramePressed.png",
      onEvent = setReactionToDog,
      label = "Cry",
      font = "Arial Black",
	    fontSize = 45,
	    labelColor = { default = { 0, 0, 0, 1.0 }, over = { 255, 0, 0 , 0.8} },
    }
  )

  cryButton.x = display.contentCenterX
  cryButton.y = display.contentCenterY - 160
  sceneGroup:insert(cryButton)



  -- 2
  local busIfText = display.newText(sceneGroup, "2) If the bus drives away (to the left), then Bob will...", display.contentCenterX, display.contentCenterY - 60, Helvetica, 48)
  busIfText:setFillColor(0.55,0.32,0.63)

  local waveButton = widget.newButton(
    {
      left = 150,
      top = 200,
      width = 360,
      height = 100,
      defaultFile = "reactionButtonFrame.png",
      overFile = "reactionButtonFramePressed.png",
      onEvent = setReactionToBusLeft,
      label = "Wave",
      font = "Arial Black",
      fontSize = 45,
      labelColor = { default = { 0, 0, 0, 1.0 }, over = { 255, 0, 0 , 0.8} },
    }
  )

  waveButton.x = display.contentCenterX
  waveButton.y = display.contentCenterY + 40
  sceneGroup:insert(waveButton)

  local goodbyeButton = widget.newButton(
    {
      left = 150,
      top = 200,
      width = 360,
      height = 100,
      defaultFile = "reactionButtonFrame.png",
      overFile = "reactionButtonFramePressed.png",
      onEvent = setReactionToBusLeft,
      label = "Say Goodbye",
      font = "Arial Black",
      fontSize = 45,
      labelColor = { default = { 0, 0, 0, 1.0 }, over = { 255, 0, 0 , 0.8} },
    }
  )

  goodbyeButton.x = display.contentCenterX
  goodbyeButton.y = display.contentCenterY + 140
  sceneGroup:insert(goodbyeButton)

  local busElseText = display.newText(sceneGroup, "Else (when the bus is coming back)", display.contentCenterX, display.contentCenterY + 240, Helvetica, 48)
  busElseText:setFillColor(0.55,0.32,0.63)

  local waveButton2 = widget.newButton(
    {
      left = 150,
      top = 200,
      width = 360,
      height = 100,
      defaultFile = "reactionButtonFrame.png",
      overFile = "reactionButtonFramePressed.png",
      onEvent = setReactionToBusRight,
      label = "Wave",
      font = "Arial Black",
      fontSize = 45,
      labelColor = { default = { 0, 0, 0, 1.0 }, over = { 255, 0, 0 , 0.8} },
    }
  )

  waveButton2.x = display.contentCenterX
  waveButton2.y = display.contentCenterY + 340
  sceneGroup:insert(waveButton2)

  local helloButton = widget.newButton(
    {
      left = 150,
      top = 200,
      width = 360,
      height = 100,
      defaultFile = "reactionButtonFrame.png",
      overFile = "reactionButtonFramePressed.png",
      onEvent = setReactionToBusRight,
      label = "Say Hello",
      font = "Arial Black",
      fontSize = 45,
      labelColor = { default = { 0, 0, 0, 1.0 }, over = { 255, 0, 0 , 0.8} },
    }
  )

  helloButton.x = display.contentCenterX
  helloButton.y = display.contentCenterY + 440
  sceneGroup:insert(helloButton)
  --
  -- local helloButton = display.newText(sceneGroup, "Say Hello", display.contentCenterX, display.contentCenterY + 240, native.systemFont, 44)
  -- helloButton:setFillColor(0,0,205)

  -- waveButton:addEventListener("tap", setReactionToBusLeft)
  -- helloButton:addEventListener("tap", setReactionToBusRight)

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

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
