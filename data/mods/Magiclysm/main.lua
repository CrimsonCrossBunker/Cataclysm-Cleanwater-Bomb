local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

if content.is_mod_active("innawood") then
    local blocked = content.Blacklist { kind = "monster" }
    blocked:entry("mon_plasticgolem"):entry("mon_irongolem")
    content.add(blocked)
end

ccb.runtime.handler("initialize_default_spellcasting", function()
    local avatar = services.characters.avatar()
    local trait = services.types.id("mutation", "SPELLCASTING_DEFAULT_TRAIT")
    local existing = services.mutations.has(avatar, trait)
    if not existing.ok then
        error(existing.error.message)
    end
    if not existing.value then
        local applied = services.mutations.replace(avatar, trait)
        if not applied.ok then
            error(applied.error.message)
        end
    end
end, 1)
ccb.runtime.on("game:game_begin", "initialize_default_spellcasting")

require("nested_recipes")

require("morale_types")

require("flags")
require("monster_flags")

require("speech")

require("ammunition_types")

require("tool_qualities")

require("vitamins")
