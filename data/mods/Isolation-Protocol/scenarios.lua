local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local variables = services.variables

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

ccb.runtime.handler("scenario_fractal_facility_due", function()
    checked(variables.set_global("SAFEPOINT_INTERVAL", 5, { include_before = false }))
    checked(variables.set_global("ISO_CURRENT_LEVEL", 1, { include_before = false }))
end)

ccb.runtime.handler("scenario_fractal_facility_start", function(payload)
    ccb.tasks.after_character_turn(payload.character, 0, "scenario_fractal_facility_due")
end)

content.replace(content.Scenario {
    id = "fractal_facility",
    inherits = "fractal_facility",
    on_start = "scenario_fractal_facility_start",
})

local last_scion_slots = { "one", "two", "three", "four", "five", "six" }

ccb.runtime.handler("init_last_scion_variables", function()
    local avatar = services.characters.avatar()
    if not checked(services.mutations.has_id_text(avatar, "iso_eldritch_sorcery")) then
        return
    end
    for _, slot in ipairs(last_scion_slots) do
        checked(variables.set(avatar, "last_scion_spell_name_slot_" .. slot, "Nothing", { include_before = false }))
        checked(variables.set(avatar, "last_scion_spell_id_slot_" .. slot, "spell_feline_leap",
            { include_before = false }))
    end
    checked(variables.set(avatar, "new_last_scion_spell_level", 0, { include_before = false }))
    checked(variables.set(avatar, "last_scion_number_of_spell_slots", 2, { include_before = false }))
end, 1)
ccb.runtime.on("game:game_start", "init_last_scion_variables")
