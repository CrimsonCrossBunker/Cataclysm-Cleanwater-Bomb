local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function has_item(character, item)
    return services.inventory.has_type(character, id("item", item)).value
end

local function carries_any(handler, items)
    ccb.runtime.handler(handler, function(context)
        for _, item in ipairs(items) do
            if has_item(context.speaker, item) then return true end
        end
        return false
    end)
end

ccb.runtime.handler("complete_mission_black_belt_goal", function(context)
    return services.skills.level(context.speaker, "melee").value >= 5
        and services.skills.level(context.speaker, "dodge").value >= 5
        and has_item(context.speaker, "judo_belt_black")
end)

ccb.runtime.handler("complete_mission_blacksmith_1", function(context)
    return services.inventory.has_items(context.speaker, id("item", "broken_kord"), 1, 0).value
end)

ccb.runtime.handler("complete_mission_build_camp_3", function(context)
    return services.inventory.has_items(context.speaker, id("item", "rope_6"), 6, 0).value
        or services.inventory.has_items(context.speaker, id("item", "rope_30"), 6, 0).value
        or services.inventory.has_items(context.speaker, id("item", "rope_makeshift_6"), 6, 0).value
        or services.inventory.has_items(context.speaker, id("item", "rope_makeshift_30"), 6, 0).value
end)

carries_any("complete_mission_build_camp_4", {
    "saw", "bow_saw", "misc_repairkit",
})

ccb.runtime.handler("complete_mission_clown", function(context)
    return services.skills.level(context.speaker, "speech").value >= 6
end)

ccb.runtime.handler("complete_mission_cosplay", function(context)
    return services.inventory.has_item_type_flag(context.speaker, id("json_flag", "COSPLAY_COSTUME")).value
end)

ccb.runtime.handler("complete_mission_find_liam", function(context)
    return services.variables.get_string(context.speaker, "talked_liam").value.value == "yes"
end)

carries_any("complete_mission_find_rifle", {
    "remmington_700", "modular_ar15", "remington700_270", "remington_700_308",
})

carries_any("complete_mission_game_master", {
    "dnd", "g_warhammer", "g_warhammer40k", "deck_of_cards",
    "chess", "checkers", "pictionary", "catan",
    "battleship", "clue",
})

carries_any("complete_mission_infected_start_find_antibiotics", {
    "strong_antibiotic", "antibiotic", "weak_antibiotic",
})

ccb.runtime.handler("complete_mission_investigate_trader", function()
    local progress = services.variables.get_global_number("freemerch_godco_trader_investigated", { strict = true })
    if not progress.ok then error(progress.error.message) end
    return (progress.value.value or 0) == 1
end)

ccb.runtime.handler("complete_mission_lost_sub", function(context)
    local whip = id("json_flag", "WHIP")
    return whip:is_valid() and services.inventory.wielded_matches(context.speaker, whip).value
end)

ccb.runtime.handler("complete_mission_mansion_start", function()
    return services.time.snapshot().turns_since_cataclysm >= services.time.duration(1, "day").turns
end)

ccb.runtime.handler("complete_mission_mutant_volunteer", function(context)
    return services.mutations.has_id_text(context.speaker, "CHANGING").value
end)

ccb.runtime.handler("complete_mission_patient", function()
    return services.time.snapshot().turns_since_cataclysm >= services.time.duration(7, "day").turns
end)

ccb.runtime.handler("complete_mission_portal_traveler", function(context)
    return services.mutations.has_id_text(context.speaker, "REALITY_GRASP").value
end)

carries_any("complete_mission_skates", {
    "roller_shoes_off", "roller_shoes_on", "roller_blades", "rollerskates",
})

ccb.runtime.handler("complete_mission_social_butterfly", function(context)
    return services.overmap.matches_location(
        services.creatures.snapshot(context.speaker).value.position:project_to("omt"), "FACTION_CAMP_ANY")
        and services.npcs.count_allies(false) >= 2
end)

carries_any("complete_mission_stylish", {
    "gown", "tux",
})

carries_any("complete_mission_urban_samurai", {
    "katana", "qt_katana", "mc_katana", "ch_katana",
    "hc_katana", "lc_katana",
})

ccb.runtime.handler("complete_mission_warrener_isherwood", function(context)
    return services.variables.get_string(context.speaker, "u_met_an_isherwood").value.value == "yes"
end)

ccb.runtime.handler("complete_mission_free_merchants_hub_delivery_1", function(context)
    return services.variables.get_string(context.speaker, "dialogue_intercom_completed_free_merchants_hub_delivery_1").value.value == "yes"
end)

ccb.runtime.handler("complete_mission_old_guard_rep_3", function(context)
    return services.variables.get_string(context.speaker, "missions_old_guard_u_scouted_exodii").value.value == "yes"
end)
