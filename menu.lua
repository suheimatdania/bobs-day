
local composer = require( "composer" )
local widget = require("widget")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function goToGameEvent( event )
  local phase = event.phase
  if ("ended" == phase) then
    composer.gotoScene("game", {time=800, effect="crossFade"})
  end
end

local function goToInstructionsEvent( event )
  local phase = event.phase
  if ("ended" == phase) then
    composer.gotoScene("instructions", {time=800, effect="crossFade"})
  end
end




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

  local background = display.newImageRect( sceneGroup, "menu-background.png", 1500, 1000 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	-- local title = display.newImageRect( sceneGroup,"title.png", 500, 80 )
	-- title.x = display.contentCenterX
	-- title.y = 200

  --
	-- local playButton = display.newText(sceneGroup, "Play", display.contentCenterX, 700, native.systemFont, 44)
	-- playButton:setFillColor(0, 0, 0)

  local playButton = widget.newButton(
    {
      left = 150,
      top = 200,
      width = 415,
      height = 270,
      defaultFile = "playButton.png",
      -- overFile = "platform.png",
      -- label = "Play",
      onEvent = goToGameEvent,
    }
  )

  local instructionsButton = widget.newButton(
    {
      left = 150,
      top = 200,
      width = 640,
      height = 415,
      defaultFile = "instructions.png",
      overFile = "platform.png",
      -- label = "Play",
      onEvent = goToInstructionsEvent,
    }
  )

  playButton.x = display.contentCenterX
  playButton.y = 450
  sceneGroup:insert(playButton)

  instructionsButton.x = display.contentCenterX
  instructionsButton.y = 700
  sceneGroup:insert(instructionsButton)

	-- local highScoresButton = display.newText( sceneGroup, "Instructions", display.contentCenterX, 810, native.systemFont, 44 )
	-- highScoresButton:setFillColor(0, 0, 0)
  --
	-- playButton:addEventListener("tap", gotoGame)
	-- highScoresButton:addEventListener("tap", goToInstructions)

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
