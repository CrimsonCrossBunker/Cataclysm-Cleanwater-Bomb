local content = require("ccb").content

do
    local spell = content.Spell {
        id = "void_spider_gore",
        name = "Great Gore Heap",
        description = "Calls foul chunks of gore and acid from the great heap.",
        valid_targets = { "ground", "self", "ally" },
        effect = "attack",
        shape = "blast",
        damage_type = "bash",
        min_damage = 1,
        max_damage = 1,
        flags = { "LOUD", "RANDOM_TARGET", "RANDOM_DAMAGE", "RANDOM_AOE", "NO_EXPLOSION_SFX", "SILENT" },
        base_casting_time = 100,
        min_aoe = 2,
        max_aoe = 4,
        min_range = 20,
        max_range = 20,
    }
    for _, extra in ipairs { "void_spider_acid", "void_spider_gore_repeat", "void_spider_acid", "void_spider_gore_repeat" } do
        spell:extra_spell { id = extra }
    end
    content.add(spell)
end

content.add(content.Spell {
    id = "void_spider_gore_repeat",
    name = "Gore Heap - gore",
    description = "A single bit of gore from the heap.",
    valid_targets = { "ground" },
    effect = "attack",
    shape = "blast",
    message = "",
    damage_type = "bash",
    min_damage = 1,
    max_damage = 5,
    flags = { "LOUD", "RANDOM_TARGET", "RANDOM_DAMAGE", "RANDOM_AOE" },
    base_casting_time = 100,
    min_aoe = 1,
    max_aoe = 2,
    min_range = 10,
    max_range = 30,
    field = "fd_gibs_flesh",
    field_chance = 2,
    min_field_intensity = 1,
    max_field_intensity = 3,
})

content.add(content.Spell {
    id = "void_spider_acid",
    name = "Gore Heap - acid",
    description = "A single bit of acid from the heap.",
    valid_targets = { "hostile", "ground", "self", "ally" },
    effect = "attack",
    shape = "blast",
    message = "",
    damage_type = "bash",
    min_damage = 1,
    max_damage = 3,
    flags = { "LOUD", "RANDOM_TARGET", "RANDOM_DAMAGE", "RANDOM_AOE" },
    base_casting_time = 100,
    min_aoe = 1,
    max_aoe = 1,
    min_range = 10,
    max_range = 30,
    field = "fd_acid",
    field_chance = 2,
    min_field_intensity = 1,
    max_field_intensity = 3,
})

local emptiness = content.TerrainTransform { id = "cavern_emptiness" }
emptiness:terrain {
    inputs = { "t_nether_basalt" },
    results = { { "t_nether_glass_floor_basalt", 1 } },
}
content.add(emptiness)

content.add(content.Spell {
    id = "void_spider_empty",
    name = "Void spider emptiness",
    description = "Constantly empties the area around the spider.",
    valid_targets = { "ally", "self", "hostile", "ground" },
    flags = { "SILENT", "NO_EXPLOSION_SFX", "IGNORE_WALLS" },
    effect = "ter_transform",
    effect_data = "cavern_emptiness",
    shape = "blast",
    min_aoe = 12,
    max_aoe = 12,
})

content.add(content.Spell {
    id = "place_void_spider",
    name = "Place Void Spider",
    description = "Spawns a void spider.",
    flags = { "SILENT", "HOSTILE_SUMMON", "PERMANENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "ground" },
    max_level = 1,
    min_damage = 1,
    max_damage = 1,
    min_range = 0,
    max_range = 0,
    min_aoe = 10,
    max_aoe = 10,
    base_casting_time = 3,
    shape = "blast",
    effect = "summon",
    effect_data = "mon_void_spider",
})
