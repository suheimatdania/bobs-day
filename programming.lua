
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local function gotoGame()
  composer.gotoScene("game", {time=800, effect="crossFade"})
end

local function setReactionIf(event)
  local requiredReaction = event.target.text
  if(requiredReaction == "Jump") then
    bobReactionTo["clown"] = "jump"
  else
    bobReactionTo["clown"] = nil
  end
end

local function setReactionWhile(event)
  local requiredReaction = event.target.text
  -- print(requiredReaction)
  if(requiredReaction == "Smile") then
    bobReactionTo["sun"] = "smile"
  else
    bobReactionTo["sun"] = "cry"
  end
  print(bobReactionTo["sun"])
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

  local ifText = display.newText(sceneGroup, "If the clown jumps, then bob will...", display.contentCenterX, display.contentCenterY - 300, native.systemFont, 44)
  ifText:setFillColor(0, 0, 0)

	local jumpButton = display.newText(sceneGroup, "Jump", display.contentCenterX, display.contentCenterY - 200, native.systemFont, 44)
	jumpButton:setFillColor(0, 0, 0)

	local nillButton = display.newText( sceneGroup, "Not do anything", display.contentCenterX, display.contentCenterY - 100, native.systemFont, 44 )
	nillButton:setFillColor(0, 0, 0)

	playButton:addEventListener("tap", gotoGame)
  jumpButton:addEventListener("tap", setReactionIf)
  nillButton:addEventListener("tap", setReactionIf)

  local whileText = display.newText(sceneGroup, "While the weather is bad, Bob will", display.contentCenterX, display.contentCenterY, native.systemFont, 44)
  whileText:setFillColor(0, 0, 0)

  local smileButton = display.newText(sceneGroup, "Smile", display.contentCenterX, display.contentCenterY +100, native.systemFont, 44)
  smileButton:setFillColor(0, 0, 0)

  local sadButton = display.newText( sceneGroup, "Cry", display.contentCenterX, display.contentCenterY + 200, native.systemFont, 44 )
  sadButton:setFillColor(0, 0, 0)

  smileButton:addEventListener("tap", setReactionWhile)
  sadButton:addEventListener("tap", setReactionWhile)

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
