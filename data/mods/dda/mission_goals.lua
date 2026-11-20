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

ccb.runtime.handler("complete_mission_godco_helena_visit_merchants", function(context)
    return services.variables.get_string(context.speaker, "general_meeting_u_met_Gavin").value.value == "yes"
end)

ccb.runtime.handler("complete_mission_science_rep_1", function(context)
    return has_item(context.speaker, "microcentrifuge")
        or has_item(context.speaker, "centrifuge")
end)

ccb.runtime.handler("complete_mission_prove_you_are_a_survivor", function()
    return services.time.snapshot().turns_since_cataclysm >= services.time.duration(10, "day").turns
end)

ccb.runtime.handler("complete_mission_ranch_doctor_supplies", function(context)
    return services.inventory.has_items(context.speaker, id("item", "book_binder"), 10, 0).value
        and services.inventory.has_items(context.speaker, id("item", "paper"), 500, 0).value
end)

ccb.runtime.handler("complete_mission_get_inhaler_inhaler", function(context)
    return has_item(context.speaker, "inhaler")
end)

ccb.runtime.handler("complete_mission_ranch_doctor_medical_anesthetic", function(context)
    return services.inventory.has_items(context.speaker, id("item", "anesthetic"), 3000, 0).value
        and services.variables.get_string(context.speaker, "mission_tacoma_ranch_doctor_anesthetic_scavengers_helped").value.value == "yes"
        and services.variables.get_string(context.speaker, "mission_tacoma_ranch_doctor_anesthetic_scrappers_helped").value.value == "yes"
end)

ccb.runtime.handler("complete_mission_beggar_2_permission", function(context)
    return services.variables.get_string(context.speaker, "mission_Dave_Permission").value.value == "yes"
end)

ccb.runtime.handler("complete_mission_lighthouse_man_5", function(context)
    return services.variables.get_string(context.speaker, "global_safe_space_lighthouse_fixed").value.value == "ready"
end)

ccb.runtime.handler("complete_mission_refugee_boris_cleanup", function(context)
    local result = services.variables.get_number(context.speaker, "mission_cleanup_promises_Boris_mission_1", { strict = true })
    if not result.ok then error(result.error.message) end
    return (result.value.value or 0) >= 5
end)

ccb.runtime.handler("complete_mission_learn_about_cattail_jelly_swag_bag", function(context)
    return has_item(context.speaker, "swag_bag")
        and services.inventory.has_items(context.speaker, services.types.id("item", "cattail_stalk"), 60, 0).value
        and services.skills.level(context.speaker, "survival").value >= 1
end)
