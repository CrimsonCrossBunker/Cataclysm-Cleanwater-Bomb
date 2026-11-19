local ccb = require("ccb")
local services = ccb.services
local variables = services.variables
local perk_menu = services.types.id("mutation", "perk_ma_perk_menu")

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

local function check_experience(character)
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
end

local function give_perk_menu(character)
    if not character:is_valid() or checked(services.mutations.has(character, perk_menu)) then
        return
    end
    local _, set = actor_variables(character)
    set("ma_perks", 0)
    set("ma_exp_to_perk", 100)
    set("ma_exp_per_level", 300)
    set("ma_available_exp", 0)
    set("ma_current_level", 0)
    set("num_ma_perks", 0)
    checked(services.mutations.replace(character, perk_menu))
end

ccb.runtime.handler("martial_perks_check_experience", function(character)
    check_experience(character)
end)

ccb.runtime.handler("martial_perks_kill_experience", function(event)
    local character = event.actors.speaker or event.actors.killer or services.characters.avatar()
    if character:is_valid() then check_experience(character) end
end)
ccb.runtime.on("game:character_kills_monster", "martial_perks_kill_experience")

ccb.runtime.handler("martial_perks_avatar_new", function(event)
    if event.data.is_new_game or event.data.is_debug then return end
    give_perk_menu(event.actors.avatar_id or services.characters.avatar())
end)
ccb.runtime.on("game:game_avatar_new", "martial_perks_avatar_new")

ccb.runtime.handler("martial_perks_initialize", function()
    local avatar = services.characters.avatar()
    if not avatar:is_valid() or checked(services.mutations.has(avatar, perk_menu)) then return end
    services.messages.add(services.translate("Martial Mastery mod is active.  Interact with the \"Practice Martial Arts\" trait from the mutation menu to learn new techniques and perks."), "neutral")
    give_perk_menu(avatar)
end)
ccb.runtime.on("game:game_begin", "martial_perks_initialize")

ccb.runtime.handler("martial_perks_open_menu", function(payload)
    checked(services.characters.open_topic(payload.character, "TALK_MA_PERK_MENU_MAIN"))
end)
