local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local coords = services.coords
local variables = services.variables

local event_key = "abyssal_hunger"
local level_key = "abyssal_hunger_level"

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function store(key, value)
    checked(variables.set_global(key, value, { include_before = false }))
end

local function point(key)
    return checked(variables.get_global_tripoint(key)).value or coords.tripoint_abs_ms(0, 0, 0)
end

local function dungeon_level()
    return checked(variables.get_global_number(level_key)).value or 0
end

local function position_of(creature)
    return checked(services.creatures.snapshot(creature)).position
end

local function update_map(position, name)
    local target = checked(services.overmap.tile_token(position:project_to("omt")))
    local update = checked(services.mapgen.update_token(id("update_mapgen", name)))
    -- The native update commits any successful placements even when another placement fails.
    checked(services.mapgen.run_update(target, update))
end

local function message(creature, text)
    if creature.subtype == "avatar" then
        services.messages.add(text, "neutral")
    end
end

local function teleport(creature, position)
    local moved = checked(services.relocation.teleport_creature(creature, position, { force = true }))
    if not moved.accepted then
        message(moved.handle, ccb.services.translate("Something is very wrong!"))
    end
    return moved.handle, moved.accepted
end

local function spawn(creature, monster, minimum, maximum, level, sign)
    checked(services.spawns.population(id("monster", monster), position_of(creature), {
        min_radius = 7,
        max_radius = 30,
        count = function()
            -- Native math rolls a real number, then truncates when constructing the spawn count.
            local count = math.modf(level + sign * services.random.native_float(minimum, maximum))
            return math.max(count, 0)
        end,
    }))
end

local function spawn_pair(creature, minimum, maximum, level)
    spawn(creature, "mon_bashing_globule", minimum, maximum, level, 1)
    spawn(creature, "mon_grasping_globule", minimum, maximum, level, 1)
end

local function enter(creature)
    local original = position_of(creature)
    local floor = coords.tripoint_abs_ms(original.x, original.y, 6)
    local roof = coords.tripoint_abs_ms(original.x, original.y, 7)
    store("original_loc", original)
    store("dungeon_loc", floor)
    store("dungeon_roof_loc", roof)

    local duration = services.time.infinite_duration()
    checked(services.world.schedule_location_revert(floor:project_to("omt"), duration, event_key))
    local place = checked(variables.get_global_string("place_name")).value
    local name = place and ccb.services.translate(place) or ccb.services.translate("Inside the Abyssal Hunger")
    checked(services.world.override_place_name(name, duration, event_key))
    checked(services.world.schedule_location_revert(roof:project_to("omt"), duration, event_key))
    update_map(roof, "abyssal_hunger_roof")
    update_map(floor, "abyssal_hunger_dungeon")
    creature = teleport(creature, point("dungeon_start"))

    store(level_key, 1)
    spawn_pair(creature, 1, 3, 1)
    message(creature, ccb.services.translate("You were devoured by the Abyssal Hunger!"))
    return creature
end

ccb.runtime.handler("enter_abyssal_hunger", function(craft)
    local character = craft.character
    for _ = 1, craft.batch do
        character = enter(character)
    end
end, 1)

ccb.runtime.handler("advance_abyssal_hunger", function(spell)
    -- A ground impact without a victim uses the same caster fallback as the old spell.
    local creature = spell.target_creature or spell.caster
    local previous_level = dungeon_level()
    local level = previous_level + 1
    store(level_key, level)
    local floor = point("dungeon_loc")
    update_map(floor, "abyssal_hunger_cleanup")
    creature = teleport(creature, point("dungeon_start"))
    if previous_level < 5 then
        update_map(floor, "abyssal_hunger_dungeon")
        spawn_pair(creature, 2, 4, level)
        spawn(creature, "mon_spewing_globule", 1, 2, level, -1)
        message(creature, ccb.services.translate("You move through the monster's innards and reach another empty space."))
    else
        update_map(floor, "abyssal_hunger_brain")
        spawn_pair(creature, 1, 2, level)
        spawn(creature, "mon_spewing_globule", 3, 4, level, -1)
        message(creature, ccb.services.translate("You reach the Abyssal Hunger's brain."))
    end
end, 1)

local function finish_cleanup()
    checked(services.world.reschedule_events(event_key, services.time.duration(0, "turn")))
    store(level_key, 0)
end

ccb.runtime.handler("take_abyssal_hunger_shard", function(examine)
    if dungeon_level() == 0 then
        return
    end
    update_map(point("dungeon_loc"), "abyssal_hunger_cleanup")
    local character, accepted = teleport(examine.character, point("original_loc"))
    if accepted then
        message(character, ccb.services.translate("You return to where you performed the ritual."))
    end
    finish_cleanup()
    checked(services.inventory.receive_item(character, id("item", "abyssal_hunger_shard"), 1))
end, 1)

ccb.runtime.handler("leave_abyssal_hunger_after_death", function()
    if dungeon_level() == 0 then
        return
    end
    local text = ccb.services.translate("It is unclear if you were slain by an immune system or digested but suffice to say, you are no more.")
    ccb.presentation.notice(text)
    services.activities.offer_interruption("")
    services.messages.add(text, "neutral")
    update_map(point("dungeon_loc"), "abyssal_hunger_cleanup")
    local accepted = services.relocation.teleport_deceased_avatar(point("original_loc"), { force = true })
    services.messages.add(accepted and ccb.services.translate("You return to where you performed the ritual.")
        or ccb.services.translate("Something is very wrong!"), "neutral")
    finish_cleanup()
end, 1)
ccb.runtime.on("avatar_death", "leave_abyssal_hunger_after_death")

content.add(content.Spell {
    id = "abyssal_hunger_next_level",
    name = ccb.content.text("abyssal hunger next level"),
    description = ccb.content.text("abyssal hunger next level"),
    shape = "blast",
    valid_targets = { "hostile", "ground", "self", "ally" },
}:lua_impact("advance_abyssal_hunger"))

local shard_location = content.Furniture {
    id = "f_shard_location",
    name = ccb.content.text("shard-filled brain chunk"),
    description = ccb.content.text("A chunk of brain matter holding some shards akin to the one you are looking for.  Examine to pick one."),
    symbol = "S",
    color = "i_dark_gray",
    move_cost_mod = -1,
    coverage = 100,
    required_str = -1,
}
for _, flag in ipairs { "NOCOLLIDE", "NO_PICKUP_ON_EXAMINE", "TRANSPARENT" } do
    shard_location:flag(flag)
end
content.add(shard_location:on_examine("take_abyssal_hunger_shard"))

content.add(content.Recipe {
    id = "bait_abyssal_hunger",
    name = ccb.content.text("bait the Abyssal Hunger"),
    description = ccb.content.text("Attract the attention of a titanic nether being, being swallowed in the process.  Getting out will be a grueling task but will reward you with the shard you are looking for."),
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    skill = "deduction",
    difficulty = 2,
    duration_moves = 180000,
    activity_level = 2,
    flags = { "SECRET" },
    scripted_output = true,
}:component("chunk_sulfur", 8)
    :component("meat", 20)
    :component_any {
        { id = "human_flesh", count = 20 },
        { id = "demihuman_flesh", count = 20 },
        { id = "mutant_human_flesh", count = 20 },
    }:component_any {
        { id = "mutant_meat", count = 20 },
        { id = "mutant_human_flesh", count = 20 },
    }:component("fae_meat", 20)
    :component("hard_liquor", 10, true)
    :on_complete("enter_abyssal_hunger"))
