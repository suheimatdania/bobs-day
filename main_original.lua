-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here


local physics = require("physics")
physics.start()

local childCoded = true

-- configuring the image sheet to be used
local sheetOptions =
{
    frames =
    {
        {   -- 1) clown
            x = 1424,
            y = 0,
            width = 230,
            height = 370,
            name = "clown",
            displayX = 800,
            displayY = 690
        },
        {   -- 2) bus
            x = 458,
            y = 0,
            width = 424,
            height = 236,
            name = "bus",
            displayX = -10,
            displayY = 750
        },
    }
}

local objectSheet = graphics.newImageSheet("objects.png", sheetOptions)

-- initialising variables
local clown, bus
local objectsOnScreen = {}

-- initialising display groups
local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()

-- functions used

  -- function which handles what happens when object is tapped on
local function onTap(event)
  local component = event.target
  local tappedOn = component.name
  -- make object which was tapped do its thing
  if tappedOn == "clown" then
    component:applyLinearImpulse( 0, -10, component.x, component.y )
  elseif tappedOn == "bus" then
    component:applyLinearImpulse( 0, -2, component.x, component.y )
  end
  -- Bob's reaction part
  if childCoded == true then
    for f=1, #objectsOnScreen do
      local reaction = objectsOnScreen[f].bobReaction
      if reaction ~= nil then
        if reaction == "jump" then
          -- bob:applyLinearImpulse(0, -100, bob.x, bob.y )
        end
      end
    end
  end
end

  -- function which adds physics element to each object to be displayed
local function addPhysics(objectToAddTo)
  if objectToAddTo.name == "bus" then
    physics.addBody( objectToAddTo, "dynamic", {radius = 130, bounce = 0} )
  elseif objectToAddTo.name == "clown" then
    physics.addBody( objectToAddTo, "dynamic", {radius = 185, bounce = 0})
  end
end

-- place the background on background group
local background = display.newImageRect(backGroup, "backgroundL.jpg", 25000, 16428)
background.x = display.contentCenterX
background.y = display.contentCenterY

-- display objects on main group and add physics to them
for f=1, #sheetOptions.frames do
  -- display them according to info from sheetOptions
  local objectInfo = sheetOptions.frames[f]
  local objectToDisplay = display.newImageRect(mainGroup, objectSheet, f, objectInfo.width, objectInfo.height)
  objectToDisplay.x = objectInfo.displayX
  objectToDisplay.y = objectInfo.displayY
  objectToDisplay.name = objectInfo.name
  objectToDisplay.bobReaction = "jump"
  objectsOnScreen[#objectsOnScreen+1]=objectToDisplay
  -- adding phsyics
  addPhysics(objectToDisplay)
end


-- displaying main character bob on main group
bob = display.newImageRect( "bob.png", 180, 360 )
bob.x = display.contentCenterX + 80
bob.y = display.contentCenterY + 170
bob.name = "bob"

--

-- temporary
local platform = display.newImageRect( "platform.png", 1024, 250 )
platform.x = display.contentCenterX
platform.y = display.contentHeight-25
platform.name = "platform"
physics.addBody( platform, "static", {bounce = 0})
--


-- adding event listeners to the bodies
for f=1, #objectsOnScreen do
    objectsOnScreen[f]:addEventListener("tap", onTap)
end
