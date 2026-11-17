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

ccb.runtime.handler("bombastic_perks_check_experience", function(character)
    local number, set = actor_variables(character)
    local function available()
        set("available_exp", checked(services.characters.kill_experience(character))
            + number("bonus_exp") - number("used_exp"))
    end
    available()
    -- A single award retains the native 100-step leveling pass.
    for _ = 1, 100 do
        if not (number("available_exp") > number("exp_to_perk")) then break end
        set("num_perks", number("num_perks") + 1)
        set("bperk_leveled_up", 1)
        set("used_exp", number("used_exp") + number("exp_to_perk"))
        available()
        set("exp_to_perk", number("exp_to_perk") + number("exp_per_level"))
        set("current_level", number("current_level") + 1)
        set("perks_toward_playstyle", number("perks_toward_playstyle") + 1)
        if number("perks_toward_playstyle") >= number("perks_toward_playstyle_setting") then
            set("playstyle_perks_available", number("playstyle_perks_available") + 1)
            set("perks_toward_playstyle", number("perks_toward_playstyle") - number("perks_toward_playstyle_setting"))
        end
    end
    if number("bperk_leveled_up") == 1 then
        set("bperk_leveled_up", 0)
        if number("no_notifications") ~= 1 then
            checked(services.characters.open_topic(character, "TALK_PERK_MENU_MAIN"))
        end
    end
end)
