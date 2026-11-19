local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "ierde_trap_target_local_terrain_bash",
    name = ccb.content.text_without_extraction("Lithic Gaol Local Bash"),
    description = ccb.content.text_without_extraction("Damages ground before the stone fangs come out, to represent the fangs destroying furniture.  It's a bug if you have it."),
    valid_targets = { "ground" },
    spell_class = "IERDE",
    flags = { "SILENT", "RANDOM_DAMAGE", "NO_PROJECTILE" },
    effect = "bash",
    shape = "blast",
    damage_type = "bash",
    min_damage = 20,
    max_damage = 50,
    min_aoe = 1,
    max_aoe = 1,
}

ccb.content.define_spell {
    id = "ierde_summon_earth_spirit",
    name = ccb.content.text("Calling the Children of the Stones"),
    description = ccb.content.text("A lesser earth elemental is summoned to support you."),
    valid_targets = { "ground" },
    skill = "deduction",
    spell_class = "IERDE",
    teachable = false,
    min_damage = 1,
    max_damage = 8,
    damage_increment = 0.5,
    min_range = 1,
    max_range = 15,
    range_increment = 1,
    min_aoe = 2,
    max_aoe = 2,
    max_level = 35,
    difficulty = 3,
    effect = "summon",
    effect_data = "GROUP_GENIUS_IERDE_LESSER",
    shape = "blast",
    magic_type = "xe_fey_magick",
    base_energy_cost = 200,
    base_casting_time = 3000,
    flags = { "SOMATIC", "VERBAL", "SPAWN_GROUP", "SPAWN_GROUP" },
    min_duration = 36000,
    max_duration = 1080000,
    duration_increment = 36000,
}
