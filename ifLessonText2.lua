-- this is the text which gives the actual information on While loops

local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local function gotoIf( event )
  local phase = event.phase
  if ("ended" == phase) then
    composer.gotoScene("if", {time=800, effect="crossFade"})
  end
end

local function gotoPart1( event )
  local phase = event.phase
  if ("ended" == phase) then
    composer.gotoScene("ifLessonText", {time=800, effect="crossFade"})
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

  local backButton = widget.newButton(
    {
      left = 150,
      top = 200,
      width = 184,
      height = 100,
      defaultFile = "reactionButtonFrame.png",
      overFile = "reactionButtonFramePressed.png",
      onEvent = gotoPart1,
      label = "Back",
      font = "Helvetica",
      fontSize = 30,
      labelColor = { default = { 0, 0, 0, 1.0 }, over = { 255, 0, 0 , 0.8} },
    }
  )

  backButton.x = display.contentCenterX - 500
  backButton.y = display.contentCenterY + 430
  sceneGroup:insert(backButton)

  local lessonsButton = display.newText(sceneGroup, "Back to lessons", display.contentCenterX - 500, display.contentCenterY - 450, native.systemFont, 44)
  lessonsButton:setFillColor(0, 0, 0)
  lessonsButton:addEventListener("tap", gotoLessons)



  local speakingBob = display.newImageRect( sceneGroup, "./all-bobs/speaking2.png", 240, 426 )
  speakingBob.x = display.contentCenterX - 500
  speakingBob.y = display.contentCenterY

  local ifSyntax2 =  display.newText(sceneGroup, "Now, you will choose, according to some conditions around me,\nwhat I will do depending on If conditions around me!", display.contentCenterX + 150, display.contentCenterY - 30, Helvetica, 35)
  ifSyntax2:setFillColor(0,0,0)

  local speechBubble = display.newImageRect( sceneGroup, "speechBubble.png", 1040, 250 )
  speechBubble.x = display.contentCenterX + 145
  speechBubble.y = display.contentCenterY

  local nextButton = widget.newButton(
    {
      left = 150,
      top = 200,
      width = 184,
      height = 100,
      defaultFile = "reactionButtonFrame.png",
      overFile = "reactionButtonFramePressed.png",
      onEvent = gotoIf,
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
