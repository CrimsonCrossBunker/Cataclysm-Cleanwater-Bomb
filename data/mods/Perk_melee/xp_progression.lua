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

ccb.runtime.handler("martial_perks_check_experience", function(character)
    local number, set = actor_variables(character)
    local function available()
        set("ma_available_exp", checked(services.characters.kill_experience(character))
            + number("bonus_exp") - number("ma_used_exp"))
    end
    available()
    for _ = 1, 100 do
        if not (number("ma_available_exp") > number("ma_exp_to_perk")) then break end
        set("num_ma_perks", number("num_ma_perks") + 1)
        set("melee_perk_leveled_up", 1)
        set("ma_used_exp", number("ma_used_exp") + number("ma_exp_to_perk"))
        available()
        set("ma_exp_to_perk", number("ma_exp_to_perk") + number("ma_exp_per_level"))
        set("ma_current_level", number("ma_current_level") + 1)
    end
    if number("melee_perk_leveled_up") == 1 then
        set("melee_perk_leveled_up", 0)
        if character.subtype == "avatar" then
            services.messages.add(services.translate("Your experience with martial arts has increased!"), "neutral")
        end
        checked(services.characters.open_topic(character, "TALK_MA_PERK_MENU_MAIN"))
    end
end)
