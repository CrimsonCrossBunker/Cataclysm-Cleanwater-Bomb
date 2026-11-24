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

ccb.runtime.handler("xe_lotus_blossom_addiction_tick", function(payload)
    if services.random.native_int(0, 800) > addiction_rational(800, 20, payload.intensity) then
        return false
    end
    local character = payload.character
    if value(services.creatures.snapshot(character)).kind == "avatar" then
        local asleep = value(services.effects.has(character, services.types.id("effect", "sleep")))
        local text = services.snippets.native_random(asleep and "lotus_addiction_dream" or "lotus_addiction")
        if text and text ~= "" then
            services.messages.add(text, "warning")
        end
    end
    return true
end, 1)

do
    local definition = content.AddictionType {
        id = "lotus_blossom",
        name = "Lotus Eater",
        type_name = "lotus_eater",
        description = "You ate the lotus, you experienced the universe.  You washed the pain away.",
        craving_morale = "morale_craving_lotus_blossom",
    }
    definition:tick_policy("xe_lotus_blossom_addiction_tick")
    content.add(definition)
end

-- WAVE16B_START
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

ccb.runtime.handler("w16b_addict_xedra_evolved_a89f2e757f98", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, {})
    return E.H.run_eoc("EOC_BLOOD_ADDICTION", ctx) == true
end, 1)
do
    local definition = content.AddictionType {
        id = "human_blood",
        name = "Blood Hunger",
        type_name = "blood_hunger",
        description = "You suffer from a quite unnatural thirst for the blood of your fellow man.  Unfortunately, the supply has shrunk by about 99% from a few months ago.",
    }
    definition:tick_policy("w16b_addict_xedra_evolved_a89f2e757f98")
    content.add(definition)
end

ccb.runtime.handler("w16b_addict_xedra_evolved_6dba634799b7", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, {})
    return E.H.run_eoc("EOC_FAEWILD_ADDICTION", ctx) == true
end, 1)
do
    local definition = content.AddictionType {
        id = "faewild",
        name = "ælfadl",
        type_name = "faewild",
        description = "You consumed faewild until it has left its mark upon you.  You have become elf addled.",
        -- Upstream Xedra Evolved addictions.json referenced undefined morale_craving_faewild.
    }
    definition:tick_policy("w16b_addict_xedra_evolved_6dba634799b7")
    content.add(definition)
end
-- WAVE16B_END
