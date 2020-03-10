
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local function gotoWhile()
  composer.gotoScene("while", {time=800, effect="crossFade"})
end

local function gotoIf()
	composer.gotoScene("if", {time=800, effect="crossFade"})
end

local function gotoFor()
	composer.gotoScene("for", {time=800, effect="crossFade"})
end

local function gotoGame()
  composer.gotoScene("game", {time=800, effect="crossFade"})
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

  display.setDefault( "background", 0, 100, 0, 1 )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

  local background = display.newImageRect( sceneGroup, "backgroundL.jpg", 3500, 2300 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	-- local title = display.newImageRect( sceneGroup,"title.png", 500, 80 )
	-- title.x = display.contentCenterX
	-- title.y = 200

  local playButton = display.newText(sceneGroup, "Back to bob!", display.contentCenterX - 500, display.contentCenterY - 400, native.systemFont, 44)
  playButton:setFillColor(0, 0, 0)

  playButton:addEventListener("tap", gotoGame)

	local whileButton = display.newText(sceneGroup, "While statements", display.contentCenterX, 700, native.systemFont, 44)
	whileButton:setFillColor(0, 0, 0)

	local ifButton = display.newText( sceneGroup, "If statements", display.contentCenterX, 810, native.systemFont, 44 )
	ifButton:setFillColor(0, 0, 0)

  local forButton = display.newText( sceneGroup, "For statements (iteration)", display.contentCenterX, 910, native.systemFont, 44 )
	forButton:setFillColor(0, 0, 0)

	whileButton:addEventListener("tap", gotoWhile)
	ifButton:addEventListener("tap", gotoIf)
  forButton:addEventListener("tap", gotoFor)

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
