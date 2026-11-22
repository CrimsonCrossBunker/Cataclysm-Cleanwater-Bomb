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
