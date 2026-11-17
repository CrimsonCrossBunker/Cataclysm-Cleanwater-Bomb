local ccb = require("ccb")
local services = ccb.services
local state = require("raid_state")
local returning = require("raid_return")
local id = services.types.id
local M = {}

function M.confirm(character)
    if character.subtype ~= "avatar" then return end
    local question = services.translate("This will warp you home directly, bypassing the mission structure and need to find an exit point.  Do you want to warp home directly?")
    if not services.interaction.confirm(state.text(character, question)) then return end
    state.checked(services.characters.cast_spell(character, id("spell", "warp_home_real")))
    if state.checked(services.inventory.has_items(character, id("item", "warp_skyward_beacon"), 1, 0)) then
        state.checked(services.inventory.consume_by_type(character, id("item", "warp_skyward_beacon"), 1, 0))
    end
end

function M.no_enemies(character)
    local search = state.checked(services.variables.get_number(character, "search_radius")).value or 0
    -- The native keyword compares search_radius with 10; it does not assign a ten-tile radius.
    local radius = search == 10 and 1 or 0
    return state.checked(services.monsters.count_nearby(state.position(character), nil,
        { radius = radius, attitude = "hostile" })) <= 0
end

ccb.runtime.handler("sky_warp_home_checked", function(impact)
    if impact.target_creature then M.confirm(impact.target_creature) end
end)

ccb.runtime.handler("sky_warp_home_real", function(impact)
    if impact.target_creature then returning.home(impact.target_creature) end
end)

ccb.runtime.handler("sky_warped_return_shard", function(impact)
    local character = impact.target_creature
    if not character then return end
    if not state.checked(services.inventory.has_items(character, id("item", "warptoken"), 1, 0)) then
        state.message(character, services.translate("You have no warp shards!"), "bad")
    elseif not M.no_enemies(character) then
        state.message(character, services.translate("You cannot warp home with enemies nearby!"), "bad")
    else
        state.checked(services.inventory.consume_by_type(character, id("item", "warptoken"), 1, 0))
        M.confirm(character)
    end
end)

ccb.runtime.handler("sky_warp_home_finished", function(activity)
    M.confirm(activity.character)
end)

local activity = ccb.content.ActivityType {
    id = "ACT_WARP_HOME",
    verb = ccb.content.text("warping"),
    based_on = "time", activity_level = 1,
    can_resume = false, rooted = true,
}
ccb.content.add(activity:on_finish("sky_warp_home_finished"))

ccb.content.add(ccb.content.Spell {
    id = "warp_home",
    name = ccb.content.text("Warp Home"),
    description = ccb.content.text("Take a full minute of concentration and return to the safety of your home base."),
    valid_targets = { "self" },
    spell_class = "NONE",
    flags = { "NO_EXPLOSION_SFX", "NO_FAIL", "NO_LEGS", "NO_HANDS", "VERBAL" },
    difficulty = 0,
    min_damage = 1,
    max_damage = 1,
    duration_increment = 1,
    shape = "blast",
    energy_source = "NONE",
    base_energy_cost = 0,
    final_energy_cost = 0,
    base_casting_time = 6000,
    final_casting_time = 6000,
}:lua_impact("sky_warp_home_checked"))

ccb.content.add(ccb.content.Spell {
    id = "warped_return",
    name = ccb.content.text("Warped Return"),
    description = ccb.content.text("Take a full minute of concentration, pay one warp shard, and return to the safety of your home base."),
    valid_targets = { "self" },
    spell_class = "NONE",
    flags = { "NO_EXPLOSION_SFX", "NO_FAIL", "NO_LEGS", "NO_HANDS", "VERBAL" },
    difficulty = 0,
    min_damage = 1,
    max_damage = 1,
    duration_increment = 1,
    shape = "blast",
    energy_source = "NONE",
    base_energy_cost = 0,
    final_energy_cost = 0,
    base_casting_time = 6000,
    final_casting_time = 6000,
}:lua_impact("sky_warped_return_shard"))

ccb.content.add(ccb.content.Spell {
    id = "warp_home_real",
    name = "Warp Home Real",
    description = "The actual warp home spell.  It's a bug if you have it.",
    valid_targets = { "self" },
    spell_class = "NONE",
    flags = { "NO_EXPLOSION_SFX", "NO_FAIL", "NO_LEGS", "NO_HANDS", "VERBAL" },
    difficulty = 0,
    min_damage = 1,
    max_damage = 1,
    duration_increment = 1,
    shape = "blast",
}:lua_impact("sky_warp_home_real"))

return M
