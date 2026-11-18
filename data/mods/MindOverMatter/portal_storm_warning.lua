local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local variables = services.variables

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function actual(character)
    local position = checked(services.creatures.snapshot(character)).position
    local location = services.world.find_location(position, nil, { min_radius = 30, max_radius = 75 })
    if location.found then checked(variables.set_global("portal_storm_center", location.position, { include_before = false })) end
    ccb.runtime.call_character("portal_storm_finish_early", character)
end

ccb.runtime.handler("mom_portal_warning_due", function(payload)
    -- The native delayed action does not repeat its original storm/premonition gate.
    actual(payload.character)
end)

ccb.runtime.handler("portal_storm_begin_early", function(character)
    local weather = services.weather.current().weather.value
    if weather == "portal_storm" or weather == "early_portal_storm"
        or (checked(variables.get_global_number("cause_portal_storm")).value or 0) == 1
        or (checked(variables.get_global_number("cause_early_portal_storm")).value or 0) == 1 then return end
    if not checked(services.effects.has(character, id("effect", "effect_clair_premonition"))) then
        actual(character)
        return
    end
    if character.subtype == "avatar" then
        local text = services.translate("The air hums like a wire stretched taut and on the verge of breaking.  Any moment, something is going to snap.")
        ccb.presentation.notice(text)
        services.activities.offer_interruption("")
        services.messages.add(text, "bad")
    end
    local level = checked(services.spells.effective_level(character, "clair_danger_sense"))
        + checked(services.spells.effective_level(character, "clair_danger_sense_knack"))
    local delay = math.tointeger(math.modf(level * 15 + 15))
    ccb.tasks.after_character_turn(character, delay, "mom_portal_warning_due")
end)
