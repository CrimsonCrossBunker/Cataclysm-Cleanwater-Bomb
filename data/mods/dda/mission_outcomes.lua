local ccb = require("ccb")

ccb.runtime.handler("mark_dialogue_bem_completed_bem_jabberwock", function(context)
    ccb.services.variables.set_string_notifying(context.character, "dialogue_bem_completed_bem_jabberwock", "yes")
end)

ccb.runtime.handler("mark_proven_worth_to_old_guard_representative", function(context)
    ccb.services.variables.set_string_notifying(context.character, "proven_worth_to_old_guard_representative", "yes")
end)

local function morale_reward(handler, bonus, duration_hours, decay_hours)
    ccb.runtime.handler(handler, function(context)
        ccb.services.morale.add(context.character, ccb.services.types.id("morale", "morale_feeling_good"),
            bonus, 50, { duration = ccb.services.time.duration(duration_hours, "hour"),
                decay_start = ccb.services.time.duration(decay_hours, "hour") })
    end)
end

morale_reward("morale_mission_assassin_convict_prison", 20, 4, 2)
morale_reward("morale_mission_assassin_convict_prison_island1", 30, 6, 3)
morale_reward("morale_mission_assassin_convict_prison_island2", 40, 6, 3)
morale_reward("morale_mission_assassination", 20, 6, 3)
morale_reward("morale_mission_dog_lover", 10, 3, 2)
morale_reward("morale_mission_helicopter_pilot", 10, 2, 1)
morale_reward("morale_mission_helicopter_refuel", 20, 6, 3)
morale_reward("morale_mission_hunter", 25, 8, 6)
morale_reward("morale_mission_mafia_boss", 20, 8, 6)
morale_reward("morale_mission_ninja", 20, 8, 4)
morale_reward("morale_mission_otaku", 30, 24, 12)
morale_reward("morale_mission_black_belt_goal", 20, 6, 3)
morale_reward("morale_mission_clown", 20, 4, 2)
morale_reward("morale_mission_cosplay", 15, 2, 1)
morale_reward("morale_mission_find_rifle", 20, 8, 4)
morale_reward("morale_mission_game_master", 10, 2, 1)
morale_reward("morale_mission_infected_start_find_antibiotics", 40, 8, 1)
morale_reward("morale_mission_lost_sub", 20, 6, 3)
morale_reward("morale_mission_mansion_start", 25, 8, 4)
morale_reward("morale_mission_mutant_volunteer", 50, 48, 24)
morale_reward("morale_mission_patient", 30, 48, 24)
morale_reward("morale_mission_portal_traveler", 50, 168, 24)
morale_reward("morale_mission_skates", 15, 2, 1)
morale_reward("morale_mission_social_butterfly", 20, 4, 2)
morale_reward("morale_mission_stylish", 10, 3, 2)
morale_reward("morale_mission_urban_samurai", 20, 12, 8)

ccb.runtime.handler("reward_mission_get_safe_box", function(context)
    local services = ccb.services
    local id = services.types.id
    local choice = services.random.weighted_index({ 5, 10, 6 })
    if choice == 1 then
        local receipt = services.inventory.receive_item(context.character, id("item", "katana"), 1)
        if not receipt.ok then error(receipt.error.message) end
        if context.giver then
            local giver = services.creatures.snapshot(context.giver)
            if giver.ok and giver.value.display_name ~= "" then
                ccb.presentation.notice(services.format(services.translate("%1$s gives you a %2$s."),
                    { giver.value.display_name, receipt.value.name }))
            end
        end
    elseif choice == 2 then
        local receipt = services.inventory.receive_group(context.character, id("item_group", "modular_deagle_44"))
        if not receipt.ok then error(receipt.error.message) end
    elseif choice == 3 then
        local receipt = services.inventory.receive_group(context.character, id("item_group", "modular_m4a1"))
        if not receipt.ok then error(receipt.error.message) end
    end
end)
