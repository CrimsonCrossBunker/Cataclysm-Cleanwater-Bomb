local ccb = require("ccb")
local services = ccb.services
local variables = services.variables

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function number(key, fallback)
    return checked(variables.get_global_number(key)).value or fallback or 0
end

local function set(key, value)
    checked(variables.set_global(key, value, { include_before = false }))
end

ccb.runtime.handler("portal_storm_worsen", function()
    local choice = services.random.weighted_index({ 3, 3, 3, 3 })
    if choice == 1 then
        set("ps_base_str", math.min(number("ps_base_str") + 1, 8))
    elseif choice == 2 then
        set("ps_min_length", math.min(4 * 3600, number("ps_min_length", 2 * 3600) + 900))
        set("ps_max_length", math.min(6 * 3600, number("ps_max_length", 4 * 3600) + 900))
    elseif choice == 3 then
        if number("ps_base_str") >= 1 then set("ps_base_str", math.min(number("ps_base_str") - 1, 8)) end
    elseif number("ps_min_length") >= 900 then
        set("ps_min_length", number("ps_min_length") - 900)
        set("ps_max_length", number("ps_max_length") - 900)
    end
end)
