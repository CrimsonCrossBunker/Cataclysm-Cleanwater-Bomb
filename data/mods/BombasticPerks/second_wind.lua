local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local stamina_key = "perk_second_wind_max_stamina"

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function active(character)
    return checked(services.effects.has(character, id("effect", "effect_perk_second_wind_currently_active")))
end

ccb.runtime.handler("second_wind_turn", function(activity)
    local character = activity.character
    if active(character) then
        local needs = checked(services.needs.get(character))
        local stored = checked(services.variables.get_number(character, stamina_key)).value or 0
        local stamina = math.modf(needs.stamina + stored * (1 / 30))
        checked(services.needs.set(character, { stamina = stamina }))
    end
end, 1)

ccb.runtime.handler("interrupt_second_wind", function(event)
    local character = event.actors.character
    if character and checked(services.mutations.has_id_text(character, "perk_second_wind")) and active(character) then
        checked(services.effects.remove(character, id("effect", "effect_perk_second_wind_currently_active")))
        checked(services.activities.cancel(character))
    end
end, 1)
ccb.runtime.on("game:character_takes_damage", "interrupt_second_wind")

ccb.runtime.handler("record_second_wind_stamina", function(event)
    local character = event.actors.character
    if character and checked(services.mutations.has_id_text(character, "perk_second_wind")) then
        local stamina = checked(services.needs.get(character)).stamina
        checked(services.variables.set(character, stamina_key, stamina, { include_before = false }))
    end
end, 1)
ccb.runtime.on("game:character_wakes_up", "record_second_wind_stamina")

ccb.content.add(ccb.content.ActivityType {
    id = "ACT_PERK_SECOND_WIND",
    verb = ccb.content.text("catching your breath"),
    based_on = "time",
    activity_level = 1,
}:on_turn("second_wind_turn"))
