
local composer = require( "composer" )

local scene = composer.newScene()

local DragMgr = require 'dmc_corona.dmc_dragdrop'
local DropTarget = require 'drop_target'

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local function createSquare( params )
	params = params or {}
	if params.fillColor==nil then params.fillColor=DragMgr.COLOR_LIGHTGREY end
	if params.strokeColor==nil then params.strokeColor=DragMgr.COLOR_GREY end
	if params.strokeWidth==nil then params.strokeWidth=3 end
	--==--
	local o = display.newRect(0, 0, params.width, params.height )
	o.strokeWidth = params.strokeWidth
	o:setFillColor( unpack( params.fillColor ) )
	o:setStrokeColor( unpack( params.strokeColor ) )
	return o
end


local function setupBackground()

	local o

	localGroup = display.newGroup()

	-- background
	o = display.newImageRect( "backgroundL.jpg", 3500, 2300 )
	o.x = display.contentCenterX
	o.y = display.contentCenterY
	-- o.anchorX, o.anchorY = 0, 0
	-- o.x=0 ; o.y=0
	localGroup:insert( o )
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

  display.setStatusBar( display.HiddenStatusBar )

  setupBackground()

  --======================================================--
  -- START: Setup DROP Targets - areas we drag TO

  local dropTarget2, dropTarget3, dropTarget4


  --== Setup Drop Targets, using object-oriented code ==--
  -- For details, see the file 'drop_target.lua'


  -- this one, Blue, accepts only Blue drag notifications

  dropTarget2 = DropTarget:new{
  	format={ 'blue' },
  	color=DragMgr.COLOR_LIGHTBLUE
  }
  dropTarget2.x, dropTarget2.y = 80, 240

  DragMgr:register( dropTarget2 )


  -- this one, Light Red, accepts only Red drag notifications

  dropTarget4 = DropTarget:new{
  	format='red',
  	color=DragMgr.COLOR_LIGHTRED
  }
  dropTarget4.x, dropTarget4.y = 240, 240

  DragMgr:register( dropTarget4 )

  -- END: Setup DROP Targets - areas we drag TO
  --======================================================--



  --======================================================--
  -- START: Setup DRAG Targets - areas we drag FROM

  local Y_BASE = 400
  local dragItem, dragItemTouchHandler
  local dragItem2, dragItem2TouchHandler


  --== create Red Drag Target ==--

  dragItemTouchHandler = function( event )

  	if event.phase=='began' then

  		local target = event.target

  		local custom_proxy = createSquare{
  			width=75, height=75,
  			fillColor=DragMgr.COLOR_LIGHTRED,
  			strokeColor=DragMgr.COLOR_GREY,
  			strokeWidth=2
  		}

  		-- setup info about the drag operation
  		local drag_info = {
  			proxy = custom_proxy,
  			format = 'red',
  			yOffset = -30,
  		}

  		-- now tell the Drag Manager about it
  		DragMgr:doDrag( target, event, drag_info )
  	end

  	return true
  end

  -- this is the drag target, the location from which we start a drag
  dragItem = createSquare{
  	width=75, height=75,
  	fillColor=DragMgr.COLOR_LIGHTRED,
  	strokeColor=DragMgr.COLOR_GREY,
  	strokeWidth=3
  }
  dragItem.x, dragItem.y = 80, Y_BASE

  dragItem:addEventListener( 'touch', dragItemTouchHandler )



  --== create Blue Drag Target ==--

  dragItem2TouchHandler = function( event )

  	if event.phase == 'began' then

  		local target = event.target

  		local custom_proxy = createSquare{
  			width=75, height=75,
  			fillColor=DragMgr.COLOR_LIGHTBLUE,
  			strokeColor=DragMgr.COLOR_GREY,
  			strokeWidth=2
  		}

  		-- setup info about the drag operation
  		local drag_info = {
  			proxy = custom_proxy,
  			format = 'blue',
  			yOffset = -30,
  		}

  		-- now tell the Drag Manager about it
  		DragMgr:doDrag( target, event, drag_info )
  	end

  	return true
  end

  -- this is the drag target, the location from which we start a drag
  dragItem2 = createSquare{
  	width=75, height=75,
  	fillColor=DragMgr.COLOR_LIGHTBLUE,
  	strokeColor=DragMgr.COLOR_GREY,
  	strokeWidth=3
  }

  dragItem2.x, dragItem2.y = 240, Y_BASE

  dragItem2:addEventListener( 'touch', dragItem2TouchHandler )

  -- END: Setup DRAG Targets - areas we drag FROM
  --======================================================--


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
