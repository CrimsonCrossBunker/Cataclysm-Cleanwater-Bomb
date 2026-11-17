local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local state = require("portal_storm_state")
local M = {}

local dependent_rewards = {
    [0] = {
        message = function()
            return services.translate("You feel invigorated by what you just experienced, so…  What is this feeling of regret for leaving that place?")
        end,
        bonus = 20,
        max_bonus = 40,
        duration_minutes = 120,
        decay_minutes = 60,
    },
    [1] = {
        message = function()
            return services.translate("You feel like the shackles of your body are loosening a little.  The world seems to accept your distorted presence for now.  You wonder if what you currently feel would have been greater if only you had gone deeper…")
        end,
        bonus = 20,
        max_bonus = 40,
        duration_minutes = 180,
        decay_minutes = 80,
        effect_days = 2,
        intensity = 0,
    },
    [2] = {
        message = function()
            return services.translate("You suddenly feel in calm, your body a little faster, and your surroundings less hostile than what you remember.  Before this new sensation passes away though, you hear a little voice in your head saying \"deeper…\"")
        end,
        bonus = 20,
        max_bonus = 40,
        duration_minutes = 240,
        decay_minutes = 100,
        effect_days = 5,
        intensity = 2,
    },
    [3] = {
        message = function()
            return services.translate("You return to your reality with a sense of ecstasy, your body feels great, your shackles have come loose and you feel powerful because of it.  But you can feel it, this exhilarating feeling is only the beginning, you need to go deeper…")
        end,
        bonus = 25,
        max_bonus = 40,
        duration_minutes = 260,
        decay_minutes = 120,
        effect_days = 8,
        intensity = 3,
    },
    [4] = {
        message = function()
            return services.translate("You feel in communion with the world around you, the world is no longer rejecting you, at least for now, YOU are rejecting IT.  Your whole body craves for what you could have gained if only you had gone a little deeper…")
        end,
        bonus = 25,
        max_bonus = 40,
        duration_minutes = 280,
        decay_minutes = 140,
        effect_days = 11,
        intensity = 4,
    },
}

local dependent_choices = {
    [0] = { grades = { 0, 1, 2 }, weights = { 16, 3, 1 } },
    [1] = { grades = { 0, 1, 2 }, weights = { 6, 12, 2 } },
    [2] = { grades = { 0, 1, 2, 3 }, weights = { 1, 5, 12, 2 } },
    [3] = { grades = { 1, 2, 3, 4 }, weights = { 2, 5, 12, 1 } },
    [4] = { grades = { 2, 3, 4 }, weights = { 2, 6, 12 } },
}

local effects = { "weakened_inertia", "warped_viewpoint", "weakened_gravity" }

function M.reward(character)
    local level = state.number("portal_dungeon_level")
    if level < 15 then return end
    local effect = effects[services.random.weighted_index({ 1, 1, 1 })]
    state.add_effect(character, effect, (level + services.random.native_float(-1, 1))
        * services.time.duration(1, "day").turns)
    if not state.checked(services.mutations.has(character, id("mutation", "PORTAL_DEPENDENT"))) then return end
    local choices = dependent_choices[math.min(4, math.floor(state.number("portal_dungeon_level")))]
    if not choices then return end
    local reward = dependent_rewards[choices.grades[services.random.weighted_index(choices.weights)]]
    state.message(character, reward.message(), "good")
    state.checked(services.morale.add(character, id("morale", "morale_feeling_good"),
        reward.bonus, reward.max_bonus, {
            duration = services.time.duration(reward.duration_minutes, "minute"),
            decay_start = services.time.duration(reward.decay_minutes, "minute"),
        }))
    if reward.effect_days then
        state.add_effect(character, "pd_strengthened_reality",
            services.time.duration(reward.effect_days, "day").turns, reward.intensity)
    end
end

function M.exit(character)
    if state.number("portal_dungeon_level") == 0 then return character end
    state.update_map(state.point("dungeon_loc"), "portal_dungeon_cleanup")
    local moved = state.checked(services.relocation.teleport_avatar(character,
        state.point("original_loc"), { force = true }))
    character = moved.handle
    if moved.accepted then
        state.message(character, services.translate("You are safely back in the apocalypse."))
    else
        state.message(character, services.translate("Something is very wrong!"))
    end
    M.reward(character)
    state.set("portal_dungeon_level", 0)
    state.checked(services.world.reschedule_events("portal_dungeon", services.time.duration(0, "turn")))
    return character
end

return M
