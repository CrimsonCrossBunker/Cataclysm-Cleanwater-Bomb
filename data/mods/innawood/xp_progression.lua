local ccb = require("ccb")
local services = ccb.services
local variables = services.variables

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function actor_variables(character)
    local function number(key)
        return checked(variables.get_number(character, key)).value or 0
    end
    local function set(key, value)
        checked(variables.set(character, key, value, { include_before = false }))
    end
    return number, set
end

local function award(character, amount)
    local number, set = actor_variables(character)
    set("bonus_exp", number("bonus_exp") + amount)
    for _, integration in ipairs {
        { "bombastic_perks", "bombastic_perks_check_experience" },
        { "perk_melee_system", "martial_perks_check_experience" },
        { "sorcerer", "sorcerer_check_experience" },
    } do
        if services.gameplay.mods.is_loaded(integration[1]) then
            ccb.runtime.call_character(integration[2], character)
        end
    end
end

ccb.runtime.handler("innawood_shard_reward", function(character)
    award(character, 25)
end)

ccb.runtime.handler("innawood_material_reward", function(character)
    local owed = checked(variables.get_global_number("owed_material_tokens")).value or 0
    award(character, owed * 2 / 5)
end)
