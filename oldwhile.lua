
local composer = require( "composer" )
local widget = require( "widget" )

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

local function setReactionToClown( event )
  local phase = event.phase
  if ("ended" == phase) then
    local requiredReaction = event.target:getLabel()
    print(requiredReaction)
  end
end

-- local function setReactionToClown(event)
--   local requiredReaction = event.target.text
--   if(requiredReaction == "Laugh") then
--     bobReactionTo["clown"] = "laugh"
--   elseif(requiredReaction == "Cheer") then
--     bobReactionTo["clown"] = "cheer"
--   end
-- end

local function setReactionWeather(event)
  local requiredReaction = event.target.text
  if(requiredReaction == "Happy") then
    bobReactionTo["sun"] = "smile"
  elseif requiredReaction == "Sad" then
    bobReactionTo["sun"] = "sad"
  end
end

local function setReactionSpeaker(event)
  local requiredReaction = event.target.text
  if(requiredReaction == "Dancing") then
    bobReactionTo["speaker"] = "dance"
  elseif requiredReaction == "Singing" then
    bobReactionTo["speaker"] = "sing"
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

  local playButton = display.newText(sceneGroup, "Go to Bob!", display.contentCenterX + 500, display.contentCenterY + 400, native.systemFont, 44)
  playButton:setFillColor(255, 255, 255)

  local lessonsButton = display.newText(sceneGroup, "Back to lessons", display.contentCenterX - 500, display.contentCenterY - 400, native.systemFont, 44)
  lessonsButton:setFillColor(255, 255, 255)


	playButton:addEventListener("tap", gotoGame)
  lessonsButton:addEventListener("tap", gotoLessons)

  -- 1

  local clownText = display.newText(sceneGroup, "While the clown juggles, bob will...", display.contentCenterX, display.contentCenterY - 300, native.systemFont, 44)
  clownText:setFillColor(0, 0, 0)

  local laughButton = widget.newButton(
    {
      left = 150,
      top = 200,
      width = 350,
      height = 190,
      defaultFile = "./reactionButtons/laughButton.png",
      overFile = "./reactionButtons/laughPressed.png",
      onEvent = setReactionToClown,
      name = "laugh"
    }
  )

  laughButton.x = display.contentCenterX
  laughButton.y = display.contentCenterY - 200
  laughButton:setLabel("laugh")
  sceneGroup:insert(laughButton)

	-- local laughButton = display.newText(sceneGroup, "Laugh", display.contentCenterX, display.contentCenterY - 200, native.systemFont, 44)
	-- laughButton:setFillColor(0,0,205)

	local nillButton = display.newText( sceneGroup, "Cheer", display.contentCenterX, display.contentCenterY - 100, native.systemFont, 44 )
	nillButton:setFillColor(0,0,205)

  laughButton:addEventListener("tap", setReactionToClown)
  nillButton:addEventListener("tap", setReactionToClown)

  -- 2

  local weatherText = display.newText(sceneGroup, "While the weather is bad, Bob is", display.contentCenterX, display.contentCenterY, native.systemFont, 44)
  weatherText:setFillColor(0, 0, 0)

  local smileButton = display.newText(sceneGroup, "Happy", display.contentCenterX, display.contentCenterY +100, native.systemFont, 44)
  smileButton:setFillColor(0,0,205)

  local sadButton = display.newText( sceneGroup, "Sad", display.contentCenterX, display.contentCenterY + 200, native.systemFont, 44 )
  sadButton:setFillColor(0,0,205)

  smileButton:addEventListener("tap", setReactionWeather)
  sadButton:addEventListener("tap", setReactionWeather)

  --3

  local speakerText = display.newText(sceneGroup, "While the speaker is playing music, Bob is", display.contentCenterX, display.contentCenterY + 300, native.systemFont, 44)
  speakerText:setFillColor(0, 0, 0)

  local danceButton = display.newText(sceneGroup, "Dancing", display.contentCenterX, display.contentCenterY +350, native.systemFont, 44)
  danceButton:setFillColor(0, 0, 0)

  local singButton = display.newText( sceneGroup, "Singing", display.contentCenterX, display.contentCenterY + 400, native.systemFont, 44 )
  singButton:setFillColor(0,0,205)

  danceButton:addEventListener("tap", setReactionSpeaker)
  singButton:addEventListener("tap", setReactionSpeaker)

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
