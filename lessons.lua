
local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local function gotoWhile()
  composer.gotoScene("whileLessonText", {time=800, effect="crossFade"})
end

local function gotoIf()
	composer.gotoScene("ifLessonText", {time=800, effect="crossFade"})
end

local function gotoFor()
	composer.gotoScene("forLessonText", {time=800, effect="crossFade"})
end

local function goToGame( event )
  local phase = event.phase
  if ("ended" == phase) then
    composer.gotoScene("game", {time=800, effect="crossFade"})
  end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

  display.setDefault( "background", 0, 100, 0, 1 )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

  local background = display.newImageRect( sceneGroup, "lessonsBackground.jpg", 3500, 2300 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY


  local lessonsText = display.newImageRect( sceneGroup, "lessonsText.png", 1000, 650 )
	lessonsText.x = display.contentCenterX
	lessonsText.y = display.contentCenterY - 200

  local bobButton = widget.newButton(
    {
      left = 150,
      top = 200,
      width = 284,
      height = 100,
      defaultFile = "reactionButtonFrame.png",
      overFile = "reactionButtonFramePressed.png",
      onEvent = goToGame,
      label = "Back To Bob",
      font = "Arial Black",
      fontSize = 35,
      labelColor = { default = { 0, 0, 0, 1.0 }, over = { 255, 0, 0 , 0.8} },
    }
  )

  bobButton.x = display.contentCenterX - 500
  bobButton.y = display.contentCenterY - 400
  sceneGroup:insert(bobButton)

	local whileButton = display.newText(sceneGroup, "1) While loops", display.contentCenterX, display.contentCenterY + 50, native.systemFont, 44)
	whileButton:setFillColor(0, 0, 0)

	local ifButton = display.newText( sceneGroup, "2) If statements", display.contentCenterX, display.contentCenterY + 160, native.systemFont, 44 )
	ifButton:setFillColor(0, 0, 0)

  local forButton = display.newText( sceneGroup, "3) For loops (iteration)", display.contentCenterX, display.contentCenterY + 270, native.systemFont, 44 )
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
