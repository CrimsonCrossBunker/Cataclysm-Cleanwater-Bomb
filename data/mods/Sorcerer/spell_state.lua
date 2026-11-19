local services = require("ccb").services
local variables = services.variables

local M = {}

function M.checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

function M.number(character, key)
    return M.checked(variables.get_number(character, key)).value or 0
end

function M.set(character, key, value)
    M.checked(variables.set(character, key, value, { include_before = false }))
end

function M.open_menu(character)
    M.checked(services.characters.open_topic(character, "TALK_SORCERER_MENU_MAIN"))
end

function M.slot_key(spell)
    return "used_spell_slot_for_" .. spell:gsub("-", "_")
end

function M.known_count_key(tier)
    return "sorcerer_level_" .. tier .. "_spells_known"
end

function M.adjust_known_count(character, slot, amount)
    local tier = slot < 1 and 0 or math.tointeger(slot)
    if tier and tier <= 9 then
        local key = M.known_count_key(tier)
        M.set(character, key, M.number(character, key) + amount)
    end
end

function M.set_spell_level(character, spell, level)
    local id = services.types.id("spell", spell)
    M.checked(services.spells.set_level(character, id, math.tointeger(math.modf(level))))
end

return M
