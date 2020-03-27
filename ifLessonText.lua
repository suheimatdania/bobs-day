-- this is the text which gives the actual information on While loops

local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local function gotoPart2( event )
  local phase = event.phase
  if ("ended" == phase) then
    composer.gotoScene("ifLessonText2", {time=800, effect="crossFade"})
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



  local title = display.newText(sceneGroup, "The If Statement", display.contentCenterX, display.contentCenterY - 400, native.Helvetica, 80)
  title:setFillColor(0.23,0.36,0.56)

  local ifInfo = display.newText(sceneGroup, "If Statement is used for decision making. \nIt will run the body of code only when IF statement is true. \nThe syntax usually looks like this:", display.contentCenterX + 90, display.contentCenterY - 250, Helvetica, 38)
  ifInfo:setFillColor(0, 0, 0)
  local ifSyntax =  display.newText(sceneGroup, "If <condition is true> \n{\n  Action to execute\n}", display.contentCenterX , display.contentCenterY - 90, Helvetica, 38)
  ifSyntax:setFillColor(0.32,0.43,0.56)


  local ifInfo = display.newText(sceneGroup, "An else statement can be added to the If statement\nto specify what happens when the condition in the 'if' is not true", display.contentCenterX + 90, display.contentCenterY + 50, Helvetica, 38)
  ifInfo:setFillColor(0, 0, 0)
  local ifSyntax =  display.newText(sceneGroup, "If <condition is true> \n{\n  Action to execute\n}\n else\n{\n other action to execute\n}", display.contentCenterX, display.contentCenterY + 270, Helvetica, 38)
  ifSyntax:setFillColor(0.32,0.43,0.56)

  -- local speakingBob = display.newImageRect( sceneGroup, "./all-bobs/speaking2.png", 240, 426 )
  -- speakingBob.x = display.contentCenterX - 500
  -- speakingBob.y = display.contentCenterY + 300

  -- local ifSyntax2 =  display.newText(sceneGroup, "Now, you will choose, according to some conditions around me,\nwhat I will do repeatedly in While Loops\n as a response to my surroundings!", display.contentCenterX + 150, display.contentCenterY + 220, Helvetica, 35)
  -- ifSyntax2:setFillColor(0,0,0)

  -- local speechBubble = display.newImageRect( sceneGroup, "speechBubble.png", 1040, 250 )
  -- speechBubble.x = display.contentCenterX + 145
  -- speechBubble.y = display.contentCenterY + 250

  local nextButton = widget.newButton(
    {
      left = 150,
      top = 200,
      width = 184,
      height = 100,
      defaultFile = "reactionButtonFrame.png",
      overFile = "reactionButtonFramePressed.png",
      onEvent = gotoPart2,
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
