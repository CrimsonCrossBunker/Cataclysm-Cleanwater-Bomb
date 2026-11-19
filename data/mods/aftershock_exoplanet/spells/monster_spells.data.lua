local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
-- duration is in moves
ccb.content.define_spell {
    id = "isohypsa_buff",
    name = ccb.content.text_without_extraction("Isohypsa Coordination"),
    description = ccb.content.text_without_extraction("Increases the speed of simpler Wraitheon drones."),
    valid_targets = { "self", "ally" },
    targeted_monsters = {
        "mon_chickenbot",
        "mon_tankbot",
        "afs_mon_sentinel_lx",
        "mon_uica_imaginifer_police",
        "mon_advbot_laser",
        "mon_wraitheon_irradiant",
        "mon_wraitheon_kaburaya",
        "mon_wraitheon_isohypsa",
        "mon_advbot_emp",
    },
    flags = { "NO_HANDS", "NO_LEGS" },
    effect = "attack",
    effect_data = "afs_isohypsa_overwatch",
    shape = "blast",
    affected_bodyparts = { "torso" },
    base_casting_time = 100,
    base_energy_cost = 100,
    energy_source = "MANA",
    difficulty = 1,
    max_level = 1,
    min_aoe = 40,
    max_aoe = 40,
    min_range = 10,
    max_range = 10,
    min_duration = 500,
    max_duration = 500,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "afs_heat_drain",
    name = ccb.content.text_without_extraction("Heat Drain"),
    description = ccb.content.text_without_extraction("Spews a burst of very cold air."),
    valid_targets = { "hostile", "ground" },
    max_level = 10,
    min_damage = 0,
    max_damage = 0,
    min_range = 1,
    max_range = 1,
    min_aoe = 1,
    max_aoe = 10,
    aoe_increment = 1,
    effect = "attack",
    shape = "blast",
    field = "afs_heat_drain_field",
    min_field_intensity = 3,
    max_field_intensity = 3,
    field_chance = 1,
    flags = { "NO_HANDS", "NO_LEGS" },
}
