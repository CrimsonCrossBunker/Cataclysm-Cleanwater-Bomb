local ccb = require("ccb")
local state = require("raid_state")
local construction = require("island_construction")

local function repair(response, progress, level, build, feedback)
    response.condition = function()
        return state.number(progress) == level
    end
    response.on_action = function(context)
        local character = context:speaker()
        build(character)
        state.message(character, feedback(), "neutral", true)
    end
    return response
end

local function stone()
    return ccb.services.translate("You hear a grinding sound from beneath the earth.")
end

local function chimes()
    return ccb.services.translate("You hear the sound of crystalline chimes.")
end

ccb.dialogue.register_topic {
    id = "SKYISLAND_FIX_CONSTRUCTIONS",
    dynamic_line = "Please remove all obstructing appliances or vehicles from the section of the island in question.  Where do you need help with?",
    dynamic_line_translation = {},
    responses = {
        repair({
            text = "I need help with the Bunker Entrance.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_base", 1, construction.base1,
            stone),
        repair({
            text = "I need help with the Miner's Cameo stage of the main room.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_bigroom", 1, construction.bigroom1,
            stone),
        repair({
            text = "I need help with the Hollow Carver stage of the main room.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_bigroom", 2, construction.bigroom2,
            stone),
        repair({
            text = "I need help with the Warped Reinforcement stage of the main room.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_bigroom", 3, construction.bigroom3,
            stone),
        repair({
            text = "I need help with the Cavernous Soul stage of the main room.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_bigroom", 4, construction.bigroom4,
            stone),
        repair({
            text = "I need help with the Hollow Carver stage of the western room.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_westroom", 2, construction.westroom2,
            stone),
        repair({
            text = "I need help with the Warped Reinforcement stage of the western room.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_westroom", 3, construction.westroom3,
            stone),
        repair({
            text = "I need help with the Crystalline Glass stage of the western room.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_westroom", 4, construction.westroom4,
            stone),
        repair({
            text = "I need help with the Inverted Cube for the western side rooms.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_west_side_rooms", 1, construction.west_side_rooms,
            stone),
        repair({
            text = "I need help with the Hollow Carver stage of the eastern room.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_eastroom", 2, construction.eastroom2,
            stone),
        repair({
            text = "I need help with the Warped Reinforcement stage of the eastern room.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_eastroom", 3, construction.eastroom3,
            stone),
        repair({
            text = "I need help with the Crystalline Glass stage of the eastern room.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_eastroom", 4, construction.eastroom4,
            stone),
        repair({
            text = "I need help with the Inverted Cube for the eastern side rooms.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_east_side_rooms", 1, construction.east_side_rooms,
            stone),
        repair({
            text = "I need help with the Hollow Carver stage of the northern room.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_northroom", 2, construction.northroom2,
            stone),
        repair({
            text = "I need help with the Warped Reinforcement stage of the northern room.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_northroom", 3, construction.northroom3,
            stone),
        repair({
            text = "I need help with the Cavernous Soul stage of the northern room.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_northroom", 4, construction.northroom4,
            stone),
        repair({
            text = "I need help with the Inverted Cube for the northern side rooms.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_north_side_rooms", 1, construction.north_side_rooms,
            stone),
        repair({
            text = "I need help with the Glass Figurine stage of the central skylight.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_centralskylight", 1, construction.centralskylight2,
            chimes),
        repair({
            text = "I need help with the Crystalline Mirror stage of the central skylight.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_centralskylight", 2, construction.centralskylight3,
            chimes),
        repair({
            text = "I need help with the Transparent Cube stage of the central skylight.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_centralskylight", 3, construction.centralskylight4,
            chimes),
        repair({
            text = "I need help with the Miner's Cameo stage of the south room.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_greenhouse", 1, construction.greenhouse1,
            stone),
        repair({
            text = "I need help with the Hollow Carver stage of the south room.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_greenhouse", 2, construction.greenhouse2,
            stone),
        repair({
            text = "I need help with the Warped Reinforcement stage of the south room.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_greenhouse", 3, construction.greenhouse3,
            stone),
        repair({
            text = "I need help with the Cavernous Soul stage of the south room.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_greenhouse", 4, construction.greenhouse4,
            stone),
        repair({
            text = "I need help with the Glass Figurine stage of the south skylight.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_greenhouse_skylight", 1, construction.greenhouse_skylight1,
            chimes),
        repair({
            text = "I need help with the Crystalline Mirror stage of the south skylight.", text_translation = {}, topic = "SKYISLAND_UPGRADE",
        }, "skyisland_build_greenhouse_skylight", 2, construction.greenhouse_skylight2,
            chimes),
    },
}
