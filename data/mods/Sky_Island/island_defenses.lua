local ccb = require("ccb")
local services = ccb.services
local content = ccb.content
local state = require("raid_state")

ccb.runtime.handler("sky_island_spell_caster", function(condition)
    if not condition.has_speaker then return true end
    local speaker = condition.speaker
    if speaker.subtype == "avatar" or speaker.subtype == "npc" or speaker.subtype == "character" then
        return not state.has_trait(speaker, "awayfromhome")
    end
    return true
end)

ccb.runtime.handler("sky_island_evict_hostile", function(impact)
    local target = impact.target_creature
    if not target then return end
    local options = { remove_corpse = true, suppress_message = true }
    if target.subtype == "monster" then
        state.checked(services.monsters.die(target, options))
    else
        state.checked(services.characters.die(target, options))
    end
end)

do
    local spell = content.Spell {
        id = "island_hostile_eviction",
        name = content.text("Evict Hostile"),
        description = content.text("Designate a hostile for the island to banish.  Only works on the island."),
        teachable = false,
        valid_targets = { "hostile" },
        spell_class = "NONE",
        flags = { "NO_FAIL", "NO_LEGS", "NO_HANDS", "NON_MAGICAL", "IGNORE_WALLS", "NO_PROJECTILE" },
        difficulty = 0,
        min_range = 100,
        max_range = 100,
        base_casting_time = 0,
        shape = "blast",
    }
    spell:caster_when("sky_island_spell_caster", "")
    spell:lua_impact("sky_island_evict_hostile")
    content.add(spell)
end

do
    local spell = content.Spell {
        id = "island_close_tear_and_portal",
        name = content.text("Close Breach"),
        description = content.text("Designate a tear in reality or a portal for the island to close.  Only works on the island."),
        teachable = false,
        valid_targets = { "ground" },
        spell_class = "NONE",
        flags = { "NO_FAIL", "NO_LEGS", "NO_HANDS", "NON_MAGICAL", "IGNORE_WALLS", "NO_PROJECTILE" },
        difficulty = 0,
        min_damage = 1,
        max_damage = 1,
        min_range = 100,
        max_range = 100,
        base_casting_time = 0,
        effect = "ter_transform",
        effect_data = "ter_close_tears_and_portals",
        shape = "blast",
    }
    spell:caster_when("sky_island_spell_caster", "")
    content.add(spell)
end

local transform = content.TerrainTransform { id = "ter_close_tears_and_portals" }
transform:field {
    inputs = { "fd_fatigue" }, results = { { "fd_null", 1 } },
    message = content.text("The tear in reality vanishes in a shower of sparks!"),
}
transform:trap {
    inputs = { "tr_portal" }, results = { { "tr_glass", 1 } },
    message = content.text("Sparks appear across the portal and it shatters into shards of glass!"),
}
content.add(transform)
