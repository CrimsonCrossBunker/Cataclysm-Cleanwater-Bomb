local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function addiction_rational(max_value, scale, intensity)
    return (max_value / math.max(1, max_value - (scale * intensity))) - 1
end

ccb.runtime.handler("dda_mutagen_addiction_tick", function(payload)
    local character = payload.character
    local intensity = payload.intensity
    local avatar = value(services.creatures.snapshot(character)).kind == "avatar"
    local morale_mutagen = services.types.id("morale", "morale_craving_mutagen")
    local acted = false

    if value(services.mutations.has_id_text(character, "MUT_JUNKIE")) then
        if services.random.native_int(0, 600) <= addiction_rational(600, 50, intensity) then
            if avatar then
                if services.random.native_int(0, 6) < intensity then
                    services.messages.add("You so miss the exquisite rainbow of post-humanity.", "warning")
                else
                    services.messages.add(
                        "Your body is SOO booorrrring.  Just a little sip to liven things up?",
                        "warning"
                    )
                end
            end
            value(services.morale.add(character, morale_mutagen, -20, -200))
            acted = true
        end

        local focus = value(services.characters.snapshot(character)).focus
        if focus > 40 and services.random.native_int(0, 800) <= addiction_rational(800, 20, intensity) then
            value(services.needs.set(character, { focus = focus - intensity }))
            if avatar then
                services.messages.add(
                    "You daydream what it'd be like if you were *different*.  Different is good.",
                    "warning"
                )
            end
            acted = true
        end
    else
        if services.random.native_int(0, 500) <= addiction_rational(500, 15, intensity) then
            if avatar then
                if services.random.native_int(0, 6) < intensity then
                    services.messages.add("You haven't had any mutagen lately.", "warning")
                else
                    services.messages.add("You could use some new parts…", "warning")
                end
            end
            value(services.morale.add(character, morale_mutagen, -5, -50))
            acted = true
        end
    end

    return acted
end, 1)

do
    local definition = content.AddictionType {
        id = "mutagen",
        name = "Mutation Withdrawal",
        type_name = "mutation",
        description = "You've gotten a taste for mutating and the chemicals that cause it.  But you can stop, yeah, any time you want.",
        craving_morale = "morale_craving_mutagen",
    }
    definition:tick_policy("dda_mutagen_addiction_tick")
    content.add(definition)
end

-- WAVE16B_START
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

ccb.runtime.handler("w16b_addict_dda_4f582819d2e9", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, {})
    return E.H.run_eoc("EOC_CAFFEINE_ADDICTION", ctx) == true
end, 1)
do
    local definition = content.AddictionType {
        id = "caffeine",
        name = "Caffeine Withdrawal",
        type_name = "caffeine",
        description = "Strength - 1;   Slight sluggishness;   Occasional cravings.",
        sated_turns = 21600,
        satisfying_effects = { "caffeine_eff" },
        craving_morale = "morale_craving_caffeine",
    }
    definition:tick_policy("w16b_addict_dda_4f582819d2e9")
    content.add(definition)
end

ccb.runtime.handler("w16b_addict_dda_f3636d05013c", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, {})
    return E.H.run_eoc("EOC_SLEEP_ADDICTION", ctx) == true
end, 1)
do
    local definition = content.AddictionType {
        id = "sleeping pill",
        name = "Sleeping Pill Dependence",
        type_name = "sleeping pills",
        description = "You may find it difficult to sleep without medication.",
        sated_turns = 21600,
        satisfying_effects = { "took_antihistamine", "took_xanax", "valium" },
    }
    definition:tick_policy("w16b_addict_dda_f3636d05013c")
    content.add(definition)
end

ccb.runtime.handler("w16b_addict_dda_b0c29d9e8f66", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, {})
    return E.H.run_eoc("EOC_MARLOSS_R_ADDICTION", ctx) == true
end, 1)
do
    local definition = content.AddictionType {
        id = "marloss_r",
        name = "Marloss Longing",
        type_name = "Marloss berries",
        description = "You should try some of those pink berries.",
        sated_turns = 28800,
        craving_morale = "morale_craving_marloss",
    }
    definition:tick_policy("w16b_addict_dda_b0c29d9e8f66")
    content.add(definition)
end

ccb.runtime.handler("w16b_addict_dda_e3b1241b12e7", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, {})
    return E.H.run_eoc("EOC_MARLOSS_B_ADDICTION", ctx) == true
end, 1)
do
    local definition = content.AddictionType {
        id = "marloss_b",
        name = "Marloss Desire",
        type_name = "Marloss seeds",
        description = "You should try some of those cyan seeds.",
        sated_turns = 28800,
        craving_morale = "morale_craving_marloss",
    }
    definition:tick_policy("w16b_addict_dda_e3b1241b12e7")
    content.add(definition)
end

ccb.runtime.handler("w16b_addict_dda_bcfa2171cdc0", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, {})
    return E.H.run_eoc("EOC_MARLOSS_Y_ADDICTION", ctx) == true
end, 1)
do
    local definition = content.AddictionType {
        id = "marloss_y",
        name = "Marloss Cravings",
        type_name = "Marloss gel",
        description = "You should try some of that golden gel.",
        sated_turns = 28800,
        craving_morale = "morale_craving_marloss",
    }
    definition:tick_policy("w16b_addict_dda_bcfa2171cdc0")
    content.add(definition)
end
-- WAVE16B_END
