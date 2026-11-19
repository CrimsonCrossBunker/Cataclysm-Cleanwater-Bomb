local ccb = require("ccb")
local services = ccb.services

if not ccb.content.is_mod_active("magiclysm") then
    return
end

local id = services.types.id
local magiclysm = id("mod", "magiclysm")
local all_spells = { mod = magiclysm }
local without_runes = { mod = magiclysm, flag_blacklist = "CONSUMES_RUNES" }
local concentration = { mod = magiclysm, flag_blacklist = "CONSUMES_RUNES", flag_whitelist = "CONCENTRATE" }
local silent = { mod = magiclysm, flag_blacklist = "CONSUMES_RUNES", flag_whitelist = "SILENT" }
local no_hands = { mod = magiclysm, flag_blacklist = "CONSUMES_RUNES", flag_whitelist = "NO_HANDS" }

local perks = {
    { "careful", { "casting_time", 2, all_spells }, { "difficulty", -5, all_spells } },
    { "efficient", { "cost", -0.25, all_spells }, { "difficulty", 5, all_spells } },
    { "extended", { "duration", 1, without_runes }, { "difficulty", 4, without_runes } },
    { "intuitive", { "concentration", -1, concentration }, { "cost", 0.2, concentration } },
    { "quicken", { "casting_time", -0.95, without_runes }, { "cost", 1, without_runes } },
    { "reach", { "range", 1, without_runes }, { "cost", 0.5, without_runes } },
    { "silent", { "sound", -1, without_runes }, { "cost", 0.2, without_runes }, { "cost", -0.2, silent } },
    { "still", { "somatic_difficulty", -1, without_runes }, { "cost", 0.2, without_runes }, { "cost", -0.2, no_hands } },
    { "widen", { "aoe", 1, without_runes }, { "cost", 0.5, without_runes } },
}

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

ccb.runtime.handler("apply_metamagic_casting", function(event)
    local character = event.actors.character or services.characters.avatar()
    for _, perk in ipairs(perks) do
        local mutation = "perk_metamagic_" .. perk[1]
        if value(services.mutations.has(character, id("mutation", mutation)))
            and value(services.variables.get_string(character, mutation .. "_deactivated")).value ~= "yes" then
            for i = 2, #perk do
                local adjustment = perk[i]
                value(services.spells.adjust_casting(character, adjustment[1], adjustment[2], adjustment[3]))
            end
        end
    end
end)
ccb.runtime.on("game:opens_spellbook", "apply_metamagic_casting")
