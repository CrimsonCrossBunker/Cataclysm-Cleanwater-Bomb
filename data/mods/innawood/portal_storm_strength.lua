local ccb = require("ccb")
local services = ccb.services
local variables = services.variables

local portal_dependent = services.types.id("mutation", "PORTAL_DEPENDENT")

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

local function should_set_milder_storms(character)
    return character and character:is_valid()
        and not checked(services.mutations.has(character, portal_dependent))
        and number("ps_min_woc") < 45 * 86400
end

ccb.runtime.handler("innawood_milder_portal_storms_due", function(payload)
    local character = payload.character
    if not should_set_milder_storms(character) then return end
    set("ps_min_woc", 45 * 86400)
    set("ps_max_woc", 90 * 86400)
    set("ps_min_length", 15 * 60)
    set("ps_max_length", 75 * 60)
end)

ccb.runtime.handler("innawood_milder_portal_storms_ready", function(event)
    local character = event.actors.character
    if should_set_milder_storms(character)
        and not ccb.tasks.has_character_turn(character, "innawood_milder_portal_storms_due") then
        ccb.tasks.after_character_turn(character, 1, "innawood_milder_portal_storms_due")
    end
end)
ccb.runtime.on("character_ready", "innawood_milder_portal_storms_ready")
