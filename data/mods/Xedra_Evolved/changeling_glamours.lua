local ccb = require("ccb")
local services = ccb.services
local runtime = ccb.runtime
local id = services.types.id

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function event_character(event)
    return event.actors.speaker or event.actors.character or event.actors.attacker or services.characters.avatar()
end

local function has_trait(character, trait)
    return checked(services.mutations.has_id_text(character, trait))
end

local function has_effect(character, effect)
    return checked(services.effects.has(character, id("effect", effect), id("body_part", "bp_null"), -1))
end

local function remove_effect(character, effect)
    checked(services.effects.remove(character, id("effect", effect)))
end

local function add_effect(character, effect, turns, options)
    local result = services.effects.add(character, id("effect", effect), services.time.duration_from_turns(turns), options)
    if not result.ok and result.error.code ~= "rejected" then checked(result) end
end

local disguises = {
    "CHANGELING_DISGUISE_AS_NATURE_BUSH", "CHANGELING_DISGUISE_AS_NATURE_TREE",
    "CHANGELING_DISGUISE_AS_NATURE_POND", "CHANGELING_DISGUISE_AS_NATURE_GRASS",
    "CHANGELING_DISGUISE_AS_NATURE_ROCK",
}

local function disguised(character)
    for _, trait in ipairs(disguises) do
        if has_trait(character, trait) then return true end
    end
    return false
end

local function clear_disguise(character)
    for _, trait in ipairs(disguises) do checked(services.mutations.erase(character, id("mutation", trait))) end
end

local running = "effect_changeling_summer_run_for_long_periods"
local feigning = "effect_changeling_winter_feign_death"
local frozen = "effect_changeling_autumn_freeze_in_place_self"
local combat_glamours = {
    "effect_changeling_invisibility", "effect_changeling_right_of_passage", running, feigning, frozen,
}

local function in_glamour(character)
    for _, effect in ipairs(combat_glamours) do
        if has_effect(character, effect) then return true end
    end
    return disguised(character)
end

runtime.handler("break_glamours_in_combat", function(event)
    local character = event_character(event)
    if in_glamour(character) then
        services.messages.add(services.translate("Effects are being removed"), "debug")
        for _, effect in ipairs(combat_glamours) do remove_effect(character, effect) end
        clear_disguise(character)
    end
    if has_trait(character, "BROWNIE_EASY_OVERLOOK") or has_trait(character, "BROWNIE_EASY_OVERLOOK2") then
        add_effect(character, "effect_brownie_attacked_someone", 5)
    end
end)
for _, event in ipairs({
    "character_melee_attacks_monster", "character_melee_attacks_character",
    "character_ranged_attacks_monster", "character_ranged_attacks_character", "character_takes_damage",
}) do
    runtime.on("game:" .. event, "break_glamours_in_combat")
end

runtime.handler("break_glamours_on_cast", function(event)
    local character = event_character(event)
    local checker = "effect_changeling_using_glamour_removes_checker"
    if not has_effect(character, checker) then return end
    if has_effect(character, running) or has_effect(character, feigning) or has_effect(character, frozen) then
        services.messages.add(services.translate("You cast a spell and effects are being removed"), "debug")
        remove_effect(character, checker)
        remove_effect(character, running)
        remove_effect(character, feigning)
        remove_effect(character, frozen)
    else
        remove_effect(character, checker)
    end
end)
runtime.on("game:spellcasting_finish", "break_glamours_on_cast")

local function end_disguise(character)
    if disguised(character) and character.subtype == "avatar" then
        services.messages.add(services.translate("The glamour disguising you fades."), "bad")
    end
    clear_disguise(character)
end

runtime.handler("break_glamours_on_move", function(event)
    local character = event_character(event)
    if has_effect(character, feigning) or has_effect(character, frozen) or disguised(character) then
        services.messages.add(services.translate("You moved and effects are being removed"), "debug")
        remove_effect(character, feigning)
        remove_effect(character, frozen)
        end_disguise(character)
    end
end)
runtime.on("game:avatar_moves", "break_glamours_on_move")
