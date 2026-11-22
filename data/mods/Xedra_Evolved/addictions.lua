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
