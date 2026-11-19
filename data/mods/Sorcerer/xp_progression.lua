local ccb = require("ccb")
local state = require("spell_state")
local catalog = require("spell_catalog")
local services = ccb.services

local M = {}

local slots_by_level = {
    [1] = { 3, 2 },
    [2] = { 4, 2 },
    [3] = { 4, 3 },
    [4] = { 5, 3, 1 },
    [5] = { 5, 4, 2 },
    [6] = { 5, 4, 2, 1 },
    [7] = { 5, 5, 3, 2 },
    [8] = { 6, 5, 3, 2, 1 },
    [9] = { 6, 5, 4, 3, 2 },
    [10] = { 6, 5, 4, 3, 2, 1 },
    [11] = { 6, 5, 5, 4, 3, 2 },
    [12] = { 6, 5, 5, 4, 3, 2, 1 },
    [13] = { 6, 5, 5, 4, 4, 3, 2 },
    [14] = { 6, 5, 5, 4, 4, 3, 2, 1 },
    [15] = { 6, 5, 5, 4, 4, 4, 3, 2 },
    [16] = { 6, 5, 5, 4, 4, 4, 3, 2, 1 },
    [17] = { 6, 5, 5, 4, 4, 4, 3, 3, 2 },
    [18] = { 6, 5, 5, 4, 4, 4, 3, 3, 2, 1 },
    [19] = { 6, 5, 5, 4, 4, 4, 3, 3, 3, 2 },
    [20] = { 6, 5, 5, 4, 4, 4, 3, 3, 3, 3 },
}

function M.level_up(character)
    local level = state.number(character, "current_sorcerer_level") + 1
    state.set(character, "current_sorcerer_level", level)
    if level > 1 then
        state.set(character, "sorcerer_forget_spell_charge", 1)
    end

    local slots = slots_by_level[level]
    if slots then
        for tier, amount in ipairs(slots) do
            state.set(character, state.known_count_key(tier - 1) .. "_slots", amount)
        end
    elseif level >= 21 then
        local key = state.known_count_key(9) .. "_slots"
        state.set(character, key, state.number(character, key) + 1)
    end

    for _, spell in ipairs(catalog) do
        if state.number(character, state.slot_key(spell.id)) > 0 then
            local current = state.checked(services.spells.effective_level(character, spell.id))
            local target = math.max(state.number(character, "current_sorcerer_level"), current)
            state.set_spell_level(character, spell.id, target)
        end
    end

    state.checked(services.characters.open_topic(character, "TALK_SORCERER_MENU_MAIN"))
    local skill = state.checked(services.skills.level(character, "spellcraft"))
    local target = math.max(skill, state.number(character, "current_sorcerer_level"))
    state.checked(services.skills.set_level(character, services.types.id("skill", "spellcraft"),
        math.tointeger(math.modf(target))))
end

local function check_experience(character, maximum_levels)
    if not state.checked(services.mutations.has_id_text(character, "SORCERER")) then return end

    local function update_available()
        local available = state.checked(services.characters.kill_experience(character))
            + state.number(character, "bonus_exp") - state.number(character, "used_exp_sorcerer")
        state.set(character, "available_exp_sorcerer", available)
    end

    update_available()
    for _ = 1, maximum_levels do
        if not (state.number(character, "available_exp_sorcerer") > state.number(character, "exp_to_sorcerer_level")) then
            break
        end

        state.set(character, "used_exp_sorcerer",
            state.number(character, "used_exp_sorcerer") + state.number(character, "exp_to_sorcerer_level"))
        update_available()
        state.set(character, "exp_to_sorcerer_level",
            state.number(character, "exp_to_sorcerer_level") + state.number(character, "exp_per_sorcerer_level"))
        M.level_up(character)
    end
end

ccb.runtime.handler("sorcerer_check_experience", function(character)
    check_experience(character, 100)
end)

ccb.runtime.handler("sorcerer_kill_experience", function(event)
    local character = event.actors.speaker or event.actors.killer
    if character then
        check_experience(character, 1)
    end
end)
ccb.runtime.on("game:character_kills_monster", "sorcerer_kill_experience")

return M
