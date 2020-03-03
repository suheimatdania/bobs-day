
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local function gotoGame()
  composer.gotoScene("game", {time=800, effect="crossFade"})
end

local function setReaction(event)
  local requiredReaction = event.target.text
  -- print(requiredReaction)
  if(requiredReaction == "Nill") then
    bobReactionTo["clown"] = nil
  else
    bobReactionTo["clown"] = "jump"
  end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

  local background = display.newImageRect( sceneGroup, "backgroundL.jpg", 3500, 2300 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

  local playButton = display.newText(sceneGroup, "Play", display.contentCenterX, 500, native.systemFont, 44)
  playButton:setFillColor(0, 0, 0)

	local jumpButton = display.newText(sceneGroup, "Jump", display.contentCenterX, 700, native.systemFont, 44)
	jumpButton:setFillColor(0, 0, 0)

	local nillButton = display.newText( sceneGroup, "Nill", display.contentCenterX, 810, native.systemFont, 44 )
	nillButton:setFillColor(0, 0, 0)

	playButton:addEventListener("tap", gotoGame)
  jumpButton:addEventListener("tap", setReaction)
  nillButton:addEventListener("tap", setReaction)

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
