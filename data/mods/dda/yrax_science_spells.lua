local content = require("ccb").content

content.add(content.Spell {
    id = "yrax_science_team",
    name = "Yrax science team",
    description = "Summons yrax science drones.",
    flags = { "PERMANENT", "HOSTILE_SUMMON", "SPAWN_GROUP" },
    valid_targets = { "ground", "self" },
    max_level = 1,
    min_damage = 1, max_damage = 1,
    min_range = 10, max_range = 10,
    min_aoe = 1, max_aoe = 1,
    base_casting_time = 3,
    shape = "blast",
    effect = "summon",
    effect_data = "GROUP_YRAX_SCIENCE_DRONES",
}:extra_spell { id = "yrax_teleport_plasma" })

content.add(content.Spell {
    id = "yrax_teleport_plasma",
    name = "Distanglement",
    description = "Spacetime combusts as the yrax force passage.",
    valid_targets = { "hostile", "ground", "self", "ally" },
    effect = "attack",
    shape = "blast",
    message = "",
    damage_type = "heat",
    min_damage = 0, max_damage = 0,
    flags = { "LOUD", "RANDOM_DAMAGE", "RANDOM_AOE" },
    base_casting_time = 100,
    min_aoe = 1, max_aoe = 2,
    min_range = 1, max_range = 1,
    field = "fd_plasma",
    field_chance = 2,
    min_field_intensity = 3, max_field_intensity = 3,
})
