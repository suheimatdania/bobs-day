
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local function gotoGame()
  composer.gotoScene("game", {time=800, effect="crossFade"})
end

local function gotoLessons()
  composer.gotoScene("lessons", {time=800, effect="crossFade"})
end

local function setReactionToDog(event)
  local requiredReaction = event.target.text
  if(requiredReaction == "Yell") then
    bobReactionTo["dog"] = "yell"
  elseif(requiredReaction == "Cry") then
    bobReactionTo["dog"] = "cry"
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

  local playButton = display.newText(sceneGroup, "Back to bob!", display.contentCenterX - 500, display.contentCenterY - 400, native.systemFont, 44)
  playButton:setFillColor(0, 0, 0)

  local clownText = display.newText(sceneGroup, "If the dog barks, then bob will...", display.contentCenterX, display.contentCenterY - 300, native.systemFont, 44)
  clownText:setFillColor(0, 0, 0)

	local yellButton = display.newText(sceneGroup, "Yell", display.contentCenterX, display.contentCenterY - 200, native.systemFont, 44)
	yellButton:setFillColor(0, 0, 0)

  local jumpButton = display.newText(sceneGroup, "Cry", display.contentCenterX, display.contentCenterY - 100, native.systemFont, 44)
  jumpButton:setFillColor(0, 0, 0)

	playButton:addEventListener("tap", gotoGame)
  yellButton:addEventListener("tap", setReactionToDog)
  jumpButton:addEventListener("tap", setReactionToDog)



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
