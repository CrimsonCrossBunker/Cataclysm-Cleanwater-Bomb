local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local state = require("portal_storm_state")
local storm = require("portal_storm")
local dungeon = require("portal_storm_dungeon_exit")

ccb.runtime.handler("portal_calming_anomaly_use", function(context)
    if not context.character then return nil end
    storm.stop(context.character)
    return 1
end)

ccb.runtime.handler("portal_debug_backpack_use", function(context)
    if not context.character then return nil end
    storm.stop(context.character)
    return 0
end)

local calming = content.Item {
    id = "calming_stone",
    copy_from = "escape_stone",
    name = content.plural_text("calming anomaly", "calming anomaly"),
    description = content.text("This defies easy description, it feels solid but the surface is yielding.  Looking at it you are reminded of the calm at the end of a portal storm."),
    color = "red",
}
calming:clear_use_actions()
calming:on_use("portal_calming_anomaly_use", content.text("Activate"),
    content.text("Seems like it could calm local conditions."))
content.upsert(calming)

local backpack = content.edit_item("debug_backpack")
backpack:clear_use_actions()
backpack:on_use("portal_debug_backpack_use", content.text("Activate"),
    content.text("Seems like it could calm local conditions."))

ccb.runtime.handler("portal_dungeon_exit_trigger", function(payload)
    local character = payload.creature
    if not character then return true end
    if state.checked(services.creatures.snapshot(character)).kind ~= "avatar" then return true end
    local position = payload.position
    local tile = state.checked(services.map.tile(services.coords.tripoint_abs_ms(
        position.x, position.y, position.z)))
    local snapshot = state.checked(services.map.snapshot(tile, { field_limit = 0, signage_limit = 0 }))
    -- Consume the triggering tile before exiting changes the reality bubble.
    state.checked(services.map.edit(tile, snapshot.revision, { trap_clear = true }))
    dungeon.exit(character)
    return false
end)

local exit = content.Trap {
    id = "tr_portal_dungeon_exit",
    name = content.text("hole to outside"),
    color = "green",
    symbol = "#",
    visibility = -1,
    avoidance = 99,
    difficulty = 99,
    trap_radius = 2,
    action = "none",
}
exit:flag("UNDODGEABLE")
exit:flag("AVATAR_ONLY")
exit:on_trigger("portal_dungeon_exit_trigger")
content.upsert(exit)
