local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local missions = services.missions
local variables = services.variables

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function assign_mission(character, mission)
    local reserved = value(missions.reserve(mission))
    value(missions.assign(character, reserved.token))
end

local function track_cryptid(variable, mission_id)
    return function(ctx)
        local character = ctx.character
        if not character then
            return 0
        end
        local tracked = value(variables.get_number(character, variable, { strict = true })).value or 0
        if tracked == 1 then
            ctx:message(ccb.services.translate("You already know where this map leads."))
        elseif tracked == 0 then
            ctx:message(ccb.services.translate("You reference your map with your location, determining the path to take to find the cryptid."))
            assign_mission(character, id("mission", mission_id))
            value(variables.set(character, variable, 1, { include_before = false }))
        end
        return 0
    end
end

ccb.runtime.handler("read_deathworm_map", track_cryptid("tracked_deathworm", "MISSION_DEATHWORM"))
ccb.runtime.handler("read_sevenoclock_map", track_cryptid("tracked_sevenoclock", "MISSION_SEVENOCLOCK"))

ccb.runtime.handler("read_vampire_hunter_map", function(ctx)
    local character = ctx.character
    if not character then
        return 0
    end
    local mission = id("mission", "MISSION_FIND_VAMPIRE_HUNTER_BASE")
    if value(missions.has_active(character, mission)) and character.subtype == "avatar" then
        local text = ccb.services.translate("There's nothing more to be learned from that map.")
        ccb.presentation.notice(text)
        services.activities.offer_interruption("")
        ctx:message(text)
    end
    if not value(missions.has_active(character, mission)) then
        assign_mission(character, mission)
    end
    return 0
end)

do
    -- The maps and notes are intended to share the same name, so the player won't know what they'll hunt before the game starts.
    local item = content.Item {
        id = "deathworm_map",
        category = "books",
        name = ccb.content.plural_text("map to the cryptid", "map to the cryptids"),
        description = ccb.content.text("The map on which you wrote the cryptid's location."),
        symbol = ",",
        color = "white",
        mass_milligrams = 30000,
        volume_ml = 10,
    }
    item:clear_use_actions()
    item:on_use("read_deathworm_map", ccb.content.text("Read"), ccb.content.text("Read the map."))
    content.add(item)
end

do
    -- The maps and notes are intended to share the same name, so the player won't know what they'll hunt before the game starts.
    local item = content.Item {
        id = "sevenoclock_map",
        category = "books",
        name = ccb.content.plural_text("map to the cryptid", "map to the cryptids"),
        description = ccb.content.text("The map on which you wrote the cryptid's location."),
        symbol = ",",
        color = "white",
        mass_milligrams = 3000,
        volume_ml = 10,
    }
    item:clear_use_actions()
    item:on_use("read_sevenoclock_map", ccb.content.text("Read"), ccb.content.text("Read the map."))
    content.add(item)
end

do
    local item = content.Item {
        id = "vampire_hunter_map",
        category = "books",
        name = ccb.content.plural_text("smudged map", "smudged maps"),
        description = ccb.content.text("A scrap of paper bearing crude lines all over it.  The only noteworthy location is a small building with a few arrows pointing at it."),
        color = "brown_green",
        symbol = ",",
        mass_milligrams = 3000,
        volume_ml = 10,
    }
    item:clear_use_actions()
    item:on_use("read_vampire_hunter_map", ccb.content.text("Activate"))
    content.add(item)
end
