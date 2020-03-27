-- this is the text which gives the actual information on While loops

local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local function goToForLoops( event )
  local phase = event.phase
  if ("ended" == phase) then
    composer.gotoScene("forLoops", {time=800, effect="crossFade"})
  end
end

local function gotoLessons()
  composer.gotoScene("lessons", {time=800, effect="crossFade"})
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

  display.setDefault( "background",  245,245,220, 1 )

  local lessonsButton = display.newText(sceneGroup, "Back to lessons", display.contentCenterX - 500, display.contentCenterY - 450, native.systemFont, 44)
  lessonsButton:setFillColor(0, 0, 0)
  lessonsButton:addEventListener("tap", gotoLessons)


  local speakingBob = display.newImageRect( sceneGroup, "./all-bobs/speaking2.png", 240, 426 )
  speakingBob.x = display.contentCenterX - 500
  speakingBob.y = display.contentCenterY + 300

  local title = display.newText(sceneGroup, "The For Loop", display.contentCenterX, display.contentCenterY - 350, native.Helvetica, 80)
  title:setFillColor(0.23,0.36,0.56)

  local whileInfo = display.newText(sceneGroup, "A for loop is a loop that tells a computer to repeat a \nsequence of actions a given number of times (iterations).\nThe syntax usually looks like this:", display.contentCenterX + 90, display.contentCenterY - 200, Helvetica, 38)
  whileInfo:setFillColor(0, 0, 0)
  local whileSyntax =  display.newText(sceneGroup, "For <N number> of times \n{\n  Action to execute repeatedly, N times.\n}", display.contentCenterX + 90, display.contentCenterY, Helvetica, 38)
  whileSyntax:setFillColor(0.32,0.43,0.56)
  local whileSyntax =  display.newText(sceneGroup, "Now, you will decide, how I react to the flower releasing pollen\nin a For Loop! (I have spring allergies)", display.contentCenterX + 150, display.contentCenterY + 220, Helvetica, 35)
  whileSyntax:setFillColor(0,0,0)

  local speechBubble = display.newImageRect( sceneGroup, "speechBubble.png", 1040, 250 )
  speechBubble.x = display.contentCenterX + 145
  speechBubble.y = display.contentCenterY + 250

  local nextButton = widget.newButton(
    {
      left = 150,
      top = 200,
      width = 184,
      height = 100,
      defaultFile = "reactionButtonFrame.png",
      overFile = "reactionButtonFramePressed.png",
      onEvent = goToForLoops,
      label = "Next",
      font = "Arial Black",
	    fontSize = 45,
	    labelColor = { default = { 0, 0, 0, 1.0 }, over = { 255, 0, 0 , 0.8} },
    }
  )

  nextButton.x = display.contentCenterX + 500
  nextButton.y = display.contentCenterY + 400
  sceneGroup:insert(nextButton)

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
