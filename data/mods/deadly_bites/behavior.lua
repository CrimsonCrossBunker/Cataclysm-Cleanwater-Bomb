local ccb = require("ccb")
local behavior = {}

local function value(result)
    if not result.ok then
        error(result.error and result.error.message or "Deadly Virus operation failed")
    end
    return result.value
end

local function effect(id)
    return ccb.services.types.id("effect", id)
end

local recovery_messages = {
    [2] = "You seem to be feeling a little better, but the prickling sensation remains.",
    [3] = "You no longer feel uncomfortably itchy, but your skin is still concerningly pale.",
    [4] = "Some of the lesions on your skin have begun to heal, but the itchiness remains.",
}

function behavior.take_antiviral(context)
    local character = context.character
    if character == nil then
        return 0
    end
    local medicine = effect("antivirals")
    local virus = effect("zombie_virus")
    local covered = value(ccb.services.effects.has(character, medicine))
    local recovery_message
    if not covered then
        local infection = ccb.services.effects.get(character, virus)
        if infection.ok then
            local intensity = infection.value.intensity
            if recovery_messages[intensity] then
                -- The antiviral effect blocks adding zombie_virus, including
                -- changes to an existing infection. Treat it before protection.
                value(ccb.services.effects.add(character, virus,
                    ccb.services.time.duration(1, "turn"),
                    { permanent = true, intensity = intensity - 1 }))
                recovery_message = recovery_messages[intensity]
            end
        elseif not infection.error or infection.error.code ~= "not_found" then
            value(infection)
        end
    end
    -- Native dur_add_perc preserves repeat-dose stacking and the one-day cap.
    value(ccb.services.effects.add(character, medicine,
        ccb.services.time.duration(16, "hour")))
    context:message(ccb.services.translate("You take an antiviral."), "info")
    if recovery_message then
        context:message(ccb.services.translate(recovery_message), "good")
    end
    -- The native medication-use path consumes exactly one dose.
    return 1
end

function behavior.begin_infected(context)
    local character = context.character
    value(ccb.services.effects.add(character, effect("zombie_virus"),
        ccb.services.time.duration(1, "turn"),
        { permanent = true, intensity = 1 }))
    local mission = value(ccb.services.missions.reserve(
        ccb.services.types.id("mission", "MISSION_INFECTED_START_FIND_ANTIVIRALS")))
    value(ccb.services.missions.assign(character, mission.token))
end

return behavior
