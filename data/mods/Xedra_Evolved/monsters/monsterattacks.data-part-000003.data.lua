local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "shifting",
    name = ccb.content.text_without_extraction("Duplicator Shifting"),
    description = ccb.content.text_without_extraction("Constantly teleports you around."),
    message = "",
    effect = "short_range_teleport",
    shape = "blast",
    valid_targets = { "self", "ground", "none" },
    flags = { "SILENT", "RANDOM_TARGET" },
    min_aoe = 4,
    max_aoe = 4,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "duplicate_shifter",
    name = ccb.content.text_without_extraction("Summon Shifter (Monster Version)"),
    description = ccb.content.text_without_extraction("Summon a shifter.  Monster version, the creature exists for 1-2 seconds.  Mostly decorative effect to show 'glitchiness'."),
    message = "",
    valid_targets = { "ground" },
    min_damage = 1,
    max_damage = 1,
    effect = "summon",
    effect_data = "mon_shifter",
    shape = "blast",
    min_aoe = 1,
    max_aoe = 1,
    flags = { "NO_EXPLOSION_SFX", "RANDOM_DURATION" },
    min_duration = 100,
    max_duration = 200,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "sapient_light_damage",
    name = ccb.content.text_without_extraction("Sapient Damage"),
    description = ccb.content.text_without_extraction("Deal some damage.  You can't see it except in debug mode."),
    message = "",
    effect = "attack",
    shape = "cone",
    valid_targets = { "hostile", "ground", "item" },
    flags = { "SILENT", "IGNORE_WALLS", "RANDOM_AOE", "RANDOM_DAMAGE", "SPLIT_DAMAGE" },
    min_damage = 60,
    max_damage = 150,
    min_bash_scaling = 3,
    max_bash_scaling = 4,
    min_range = 9,
    max_range = 9,
    min_aoe = 25,
    max_aoe = 50,
    damage_type = "pure",
    sound_description = ccb.content.text("a loud whisper"),
    extra_spells = { { spell = "sapient_light_damage_player" } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "sapient_light_damage_player",
    name = ccb.content.text_without_extraction("Sapient Player Damage"),
    description = ccb.content.text_without_extraction("Deal 34% of player's HP damage to player.  You can't see it except in debug mode."),
    message = "",
    effect = "attack",
    shape = "cone",
    valid_targets = { "ally" },
    flags = { "SILENT", "IGNORE_WALLS", "PERCENTAGE_DAMAGE", "NO_EXPLOSION_SFX" },
    min_damage = 34,
    max_damage = 34,
    min_bash_scaling = 5.3,
    max_bash_scaling = 17.6,
    min_range = 9,
    max_range = 9,
    min_aoe = 50,
    max_aoe = 50,
    damage_type = "pure",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "duplicator_spawn_pawn",
    name = ccb.content.text_without_extraction("Summon Duplicator Pawn"),
    description = ccb.content.text_without_extraction("Summon 1 short life pawn."),
    message = "",
    flags = { "PERMANENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "ground" },
    min_damage = 1,
    max_damage = 1,
    min_aoe = 3,
    max_aoe = 3,
    shape = "blast",
    effect = "summon",
    effect_data = "mon_duplicator_pawn",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "ophanim_death",
    name = ccb.content.text_without_extraction("Ophanim Death"),
    description = ccb.content.text_without_extraction("AoE cut damage, when ophanim dies."),
    message = "",
    valid_targets = { "self", "hostile", "ground" },
    effect = "attack",
    shape = "blast",
    min_damage = 45,
    max_damage = 99,
    damage_type = "cut",
    flags = { "SILENT", "RANDOM_DAMAGE", "RANDOM_AOE" },
    min_aoe = 7,
    max_aoe = 10,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "zombie_monochrome_reset_hp",
    name = ccb.content.text_without_extraction("Reset HP"),
    description = ccb.content.text_without_extraction("Heals 100% of health.  Players should not have this spell."),
    message = "",
    effect = "attack",
    shape = "blast",
    valid_targets = { "ally", "self" },
    flags = { "SILENT", "IGNORE_WALLS", "PERCENTAGE_DAMAGE", "NO_EXPLOSION_SFX" },
    min_damage = -200,
    max_damage = -200,
    min_range = 0,
    max_range = 0,
    damage_type = "pure",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "xedra_monster_erosion_attack",
    name = ccb.content.text_without_extraction("Monster Erosion - Attack"),
    description = ccb.content.text_without_extraction("This causes the dot when attacking targets with the erosion buff.  Having the spell is a bug.  Monster version"),
    valid_targets = { "hostile", "ground", "none" },
    flags = {
        "SILENT",
        "NO_PROJECTILE",
        "NO_EXPLOSION_SFX",
        "RANDOM_DAMAGE",
        "RANDOM_DURATION",
        "SPLIT_DAMAGE",
    },
    message = ccb.content.text("monster erosion attack"),
    effect = "attack",
    shape = "blast",
    min_dot = 5,
    max_dot = 5,
    min_range = 10,
    max_range = 10,
    min_duration = 1000,
    max_duration = 1000,
    damage_type = "pure",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "xedra_monster_erosion_buff",
    name = ccb.content.text_without_extraction("Monster Erosion - Buff"),
    description = ccb.content.text_without_extraction("This gives the monster the erosion buff.  Having the spell is a bug.  Monster version"),
    valid_targets = { "self" },
    flags = { "SILENT", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    effect = "attack",
    effect_data = "effect_xedra_monster_erosion",
    shape = "blast",
    min_duration = 100000,
    max_duration = 100000,
    min_range = 0,
    max_range = 0,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "xedra_death_boomer_monochrome",
    name = ccb.content.text_without_extraction("Monochrome Boomer Death"),
    description = ccb.content.text_without_extraction("Time explosion."),
    valid_targets = { "ground", "hostile", "ally", "self" },
    flags = { "NO_EXPLOSION_SFX" },
    min_aoe = 1,
    max_aoe = 2,
    aoe_increment = 1,
    max_level = 1,
    min_duration = 180000,
    max_duration = 180000,
    shape = "blast",
    effect = "attack",
    effect_data = "effect_xedra_time_freeze",
    field_chance = 1,
    field = "fd_frozen_time",
    min_field_intensity = 10,
    max_field_intensity = 10,
    extra_spells = { { spell = "death_explosion", self = true } },
}
