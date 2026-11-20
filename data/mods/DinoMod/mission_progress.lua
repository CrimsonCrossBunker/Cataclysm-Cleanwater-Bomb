local ccb = require("ccb")

local variables = ccb.services.variables

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

ccb.runtime.handler("mark_mission_flag_Yos_chemistry", function(context)
    variables.set_string_notifying(context.character, "mission_flag_Yos_chemistry", "yes")
end)

ccb.runtime.handler("set_mission_flag_Yos_chemistry_to_in_progress", function(context)
    variables.set_string_notifying(context.character, "mission_flag_Yos_chemistry", "in_progress")
end)

ccb.runtime.handler("advance_counter_DinoLab_DinoLab_power_by_2", function(context)
    local current = checked(variables.get_number(context.character, "counter_DinoLab_DinoLab_power", { strict = true })).value or 0
    checked(variables.set(context.character, "counter_DinoLab_DinoLab_power", current + 2, { include_before = false }))
end)
