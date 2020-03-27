
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

local function goToForLessonText( event )
  local phase = event.phase
  if ("ended" == phase) then
    composer.gotoScene("forLessonText", {time=800, effect="crossFade"})
  end
end

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
      onEvent = goToForLessonText,
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

  local clownText = display.newText(sceneGroup, "If the flower moves", display.contentCenterX, display.contentCenterY - 340, Helvetica, 48)
  clownText:setFillColor(0.32,0.43,0.56)
  local clownText = display.newText(sceneGroup, "For N = ", display.contentCenterX, display.contentCenterY - 240, Helvetica, 48)
  clownText:setFillColor(0.32,0.43,0.56)

  -- local laughButton = widget.newButton(
  --   {
  --     left = 150,
  --     top = 200,
  --     width = 184,
  --     height = 100,
  --     defaultFile = "reactionButtonFrame.png",
  --     overFile = "reactionButtonFramePressed.png",
  --     onEvent = setReactionToClown,
  --     label = "Laugh",
  --     font = "Arial Black",
	--     fontSize = 45,
	--     labelColor = { default = { 0, 0, 0, 1.0 }, over = { 255, 0, 0 , 0.8} },
  --   }
  -- )
  --
  -- laughButton.x = display.contentCenterX
  -- laughButton.y = display.contentCenterY - 250
  -- sceneGroup:insert(laughButton)
  --
  --
  -- local cheerButton = widget.newButton(
  --   {
  --     left = 150,
  --     top = 200,
  --     width = 184,
  --     height = 100,
  --     defaultFile = "reactionButtonFrame.png",
  --     overFile = "reactionButtonFramePressed.png",
  --     onEvent = setReactionToClown,
  --     label = "Cheer",
  --     font = "Arial Black",
	--     fontSize = 45,
	--     labelColor = { default = { 0, 0, 0, 1.0 }, over = { 255, 255, 255 , 0.8} },
  --   }
  -- )
  --
  -- cheerButton.x = display.contentCenterX
  -- cheerButton.y = display.contentCenterY - 140
  -- sceneGroup:insert(cheerButton)



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
