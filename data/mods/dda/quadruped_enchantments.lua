local ccb = require("ccb")
local content = ccb.content

local function can_move_on_all_fours(state)
    local flags = state.character_flags
    return flags.QUADRUPED_CROUCH and flags.THRESH_ALLOWS_QUADRUPEDAL_MOVEMENT
        and (not state.armed or state.wielded_flags.NO_UNWIELD)
end

local inputs = {
    character_flags = { "QUADRUPED_CROUCH", "THRESH_ALLOWS_QUADRUPEDAL_MOVEMENT", "QUADRUPED_RUN" },
    wielded_flags = { "NO_UNWIELD" },
    move_mode = true,
    armed = true,
}

ccb.runtime.handler("quadruped_full_movement", function(ctx)
    local state = ctx.character_inputs
    return can_move_on_all_fours(state) and state.character_flags.QUADRUPED_RUN
        and (state.move_mode == "crouch" or state.move_mode == "run")
end)

ccb.runtime.handler("quadruped_half_movement", function(ctx)
    local state = ctx.character_inputs
    return can_move_on_all_fours(state) and not state.character_flags.QUADRUPED_RUN
        and state.move_mode == "crouch"
end)

-- Full quadrupeds bear weight on all four limbs and can run on all fours.
content.add(content.Enchantment {
    id = "ench_quadruped_movement_full",
    condition_handler = "quadruped_full_movement",
    load_character_inputs = inputs,
}
    :value("MOVE_COST", { multiply = -0.15 })
    :value("CARRY_WEIGHT", { multiply = 0.35 })
    :effect("natural_stance", 1)
    :effect("quadruped_full", 1))

-- Front-paw quadrupeds benefit only while crouch-walking.
content.add(content.Enchantment {
    id = "ench_quadruped_movement_half",
    condition_handler = "quadruped_half_movement",
    load_character_inputs = inputs,
}
    :value("MOVE_COST", { multiply = -0.5 })
    :effect("quadruped_half", 1))
