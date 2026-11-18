local ccb = require("ccb")
local services = ccb.services
local state = require("portal_storm_state")

ccb.runtime.handler("void_spider_death", function()
    ccb.tasks.after_avatar_turn(0, "void_spider_killed_due")
    ccb.tasks.after_avatar_turn(1200, "void_spider_lair_exit_due")
end)

ccb.runtime.handler("void_spider_killed_due", function(payload)
    state.set("void_spider_killed", 1)
    services.random.native_int(0, 0)
    state.checked(services.variables.set(payload.character, "general_talk_killed_a_void_spider", "yes",
        { include_before = false }))
    services.native_events.emit("u_var_changed", { "general_talk_killed_a_void_spider", "yes" })
end)

ccb.runtime.handler("void_spider_lair_exit_transport", function(character)
    local result = state.checked(services.relocation.travel_to_dimension("default",
        { npc_travel_radius = 0, npc_travel_filter = "none", item_travel_radius = -1 }))
    state.message(character, result.accepted
        and services.translate("The emptiness seems to expand into endlessness.")
        or services.translate("Nothing seems to change."))
    local destination = services.overmap.find_target(state.position(character):project_to("omt"),
        "nether_glass_deep", { z = -10, min_distance = 1 }):project_to("ms")
    local location = services.world.find_location(destination, nil)
    state.set("nether_glass", location.position)
    state.checked(services.relocation.teleport_character(character, location.position, { force = true }))
    local elevator = services.overmap.find_target(state.position(character):project_to("omt"),
        "microlab_portal_elevator_physics_glass")
    state.update_map(elevator:project_to("ms"), "microlab_portal_elevator_physics_shift")
end)

ccb.runtime.handler("void_spider_lair_exit_due", function(payload)
    local character = payload.character
    state.message(character, services.translate("The cavern folds itself beyond perception."), "neutral", true)
    ccb.runtime.call_character("void_spider_lair_exit_transport", character)
end)

local monster = ccb.content.Monster {
    id = "mon_void_spider",
    name = ccb.content.text("unformed weaver"),
    description = ccb.content.text("It stalks thin slices of reality like gossamer threads, each a narrow conduit between worlds unknown and its kaleidoscopic maw."),
    default_faction = "nether",
    volume_ml = 1800000,
    weight_grams = 750000,
    hp = 900,
    symbol = "S",
    speed = 80,
    morale = 50,
    aggression = 100,
    grab_strength = 2,
    melee_dice = 4,
    melee_sides = 4,
    melee_skill = 8,
    vision_night = 40,
    dodge = 8,
    bleed_rate = 10,
    death_corpse_type = "NO_CORPSE",
    death_message = ccb.content.text("The %s dissolves into inert shadows."),
}
monster:attack("void_spider_control", 2)
monster:weakpoint_family("prof_wp_netherium_abomination")
monster:weakpoint_set("wps_void_spider")
monster:on_death("void_spider_death")
for damage, amount in pairs { bash = 1000, cut = 1000, bullet = 1000, electric = 30, stab = 1000, acid = 100 } do
    monster:armor(damage, amount)
end
for _, flag in ipairs {
    "SEES", "HEARS", "GOODHEARING", "HAS_MIND", "SMELLS", "DESTROYS", "WARM", "FIREPROOF",
    "NIGHT_INVISIBILITY", "ALWAYS_SEES_YOU", "ALWAYS_VISIBLE", "NO_BREATHE", "PRIORITIZE_TARGETS",
    "ARTHROPOD_BLOOD", "HARDTOSHOOT",
} do
    monster:flag(flag)
end
ccb.content.register(monster)
