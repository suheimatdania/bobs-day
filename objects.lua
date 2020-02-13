--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:2fb63d1f34acc4cf434a8ff61a8b79fd:ef26de87caab94e840e8b970ca83dcf0:3228e5c33a2f8e8563ac8fce1c9e1c8f$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- bus
            x=468,
            y=1,
            width=421,
            height=235,

        },
        {
            -- clown
            x=1432,
            y=1,
            width=228,
            height=374,

        },
        {
            -- doggo
            x=1169,
            y=1,
            width=261,
            height=325,

        },
        {
            -- froggo-eat
            x=238,
            y=1,
            width=228,
            height=221,

        },
        {
            -- froggo
            x=1,
            y=1,
            width=235,
            height=195,

        },
        {
            -- pond
            x=1,
            y=377,
            width=810,
            height=468,

        },
        {
            -- speaker
            x=813,
            y=377,
            width=368,
            height=600,

        },
        {
            -- sun
            x=891,
            y=1,
            width=276,
            height=264,

        },
        {
            -- tree
            x=1183,
            y=377,
            width=828,
            height=608,

        },
    },

    sheetContentWidth = 2012,
    sheetContentHeight = 986
}

SheetInfo.frameIndex =
{

    ["bus"] = 1,
    ["clown"] = 2,
    ["doggo"] = 3,
    ["froggo-eat"] = 4,
    ["froggo"] = 5,
    ["pond"] = 6,
    ["speaker"] = 7,
    ["sun"] = 8,
    ["tree"] = 9,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
