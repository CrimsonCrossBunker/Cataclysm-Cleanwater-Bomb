local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "solar_spirit_flare_spell_sundeath_hit_monster",
    name = ccb.content.text_without_extraction("Solar spirit flare Sundeath damage"),
    description = ccb.content.text_without_extraction("Used because auras are not currently possible.  Causes enemies with the SUNDEATH flag to burn."),
    message = "",
    flags = { "SILENT", "NO_EXPLOSION_SFX", "NO_LEGS", "SPLIT_DAMAGE" },
    valid_targets = { "self" },
    teachable = false,
    skill = "deduction",
    max_level = 1,
    shape = "blast",
    effect = "attack",
    damage_type = "pure",
    min_damage = 60,
    max_damage = 120,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "viridian_cuirass_monster",
    name = ccb.content.text_without_extraction("Viridan Cuirass enemy check"),
    description = ccb.content.text_without_extraction("Preps for using Viridian Cuirass when a hostile target is detected."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "hostile" },
    max_level = 1,
    effect = "attack",
    extra_spells = { { spell = "viridian_cuirass_monster_self", self = true } },
    shape = "blast",
    min_range = 60,
    max_range = 60,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "viridian_cuirass_monster_self",
    name = ccb.content.text_without_extraction("Viridan Cuirass Monster Effect"),
    description = ccb.content.text_without_extraction("Grants the Viridian Cuirass effect to a monster."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DURATION" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_monster_viridian_cuirass",
    shape = "blast",
    min_duration = 36000,
    max_duration = 96000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "summon_bashing_vine_changeling_monster",
    name = ccb.content.text_without_extraction("Summon Tanglevine Monster"),
    description = ccb.content.text_without_extraction("Summons a Tanglevine if you are a changeling."),
    flags = { "HOSTILE_SUMMON", "NO_EXPLOSION_SFX", "RANDOM_DURATION", "RANDOM_DAMAGE" },
    valid_targets = { "ground", "self", "hostile" },
    max_level = 1,
    effect = "summon",
    effect_data = "mon_spring_changeling_bashing_vine",
    shape = "blast",
    min_damage = 2,
    max_damage = 4,
    min_aoe = 4,
    max_aoe = 4,
    min_range = 10,
    max_range = 10,
    range_increment = 1,
    min_duration = 3500,
    max_duration = 5500,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "punishing_summer_heat_monster",
    name = ccb.content.text_without_extraction("Punishing Summer Heat monster"),
    description = ccb.content.text_without_extraction("Monster casts Punishing Summer Heat."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION" },
    valid_targets = { "hostile" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_changeling_summer_slow_and_sweat_debuff",
    shape = "blast",
    min_range = 15,
    max_range = 15,
    min_duration = 2500,
    max_duration = 6500,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "fire_in_the_blood_monster",
    name = ccb.content.text_without_extraction("A Fire in the Blood enemy check"),
    description = ccb.content.text_without_extraction("Preps for using A Fire in the Blood when a hostile target is detected."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "hostile" },
    max_level = 1,
    effect = "attack",
    extra_spells = { { spell = "fire_in_the_blood_monster_self", self = true } },
    shape = "blast",
    min_range = 60,
    max_range = 60,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "fire_in_the_blood_monster_self",
    name = ccb.content.text_without_extraction("A Fire in the Blood effect"),
    description = ccb.content.text_without_extraction("Grants the A Fire in the Blood effect to a monster."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DURATION" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_monster_a_fire_in_the_blood",
    shape = "blast",
    min_duration = 4900,
    max_duration = 8400,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "touch_of_frailty_monster",
    name = ccb.content.text_without_extraction("Touch of Frailty monster"),
    description = ccb.content.text_without_extraction("Monster casts Touch of Frailty."),
    flags = { "SILENT", "NO_LEGS", "RANDOM_DURATION", "TOUCH_REQUIRED" },
    valid_targets = { "hostile" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_changeling_autumn_touch_of_frailty_monster",
    shape = "blast",
    min_range = 1,
    max_range = 1,
    min_duration = 1200,
    max_duration = 3800,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "swirl_autumn_leaves_monster",
    name = ccb.content.text_without_extraction("Swirl of Autumn Leaves enemy check"),
    description = ccb.content.text_without_extraction("Preps for using Swirl of Autumn Leaves when a hostile target is detected."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "hostile" },
    max_level = 1,
    effect = "attack",
    extra_spells = { { spell = "swirl_autumn_leaves_monster_self", self = true } },
    shape = "blast",
    min_range = 60,
    max_range = 60,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "swirl_autumn_leaves_monster_self",
    name = ccb.content.text_without_extraction("Swirl of Autumn Leaves Effect"),
    description = ccb.content.text_without_extraction("Grants the Viridian Cuirass effect to a monster."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DURATION" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_monster_swirl_of_autumn_leaves",
    shape = "blast",
    min_duration = 96000,
    max_duration = 270000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "winter_silence_spell_monster",
    name = ccb.content.text_without_extraction("Rime-Stilled Tongue enemy check"),
    description = ccb.content.text_without_extraction("Silences target."),
    message = "",
    flags = { "SOMATIC", "NO_LEGS", "RANDOM_DURATION" },
    valid_targets = { "hostile" },
    max_level = 1,
    shape = "blast",
    effect = "attack",
    effect_data = "effect_changeling_winter_silence",
    min_range = 20,
    max_range = 20,
    min_duration = 750,
    max_duration = 1800,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_feral_dreamer_dream_dagger_spell",
    name = ccb.content.text_without_extraction("Dream Dagger Monster"),
    description = ccb.content.text_without_extraction("This is a monster only spell."),
    valid_targets = { "self" },
    flags = { "NO_PROJECTILE", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION" },
    max_level = 20,
    teachable = false,
    effect = "attack",
    effect_data = "effect_xe_feral_dreamer_dream_dagger",
    shape = "blast",
    min_duration = 2400,
    max_duration = 9600,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_feral_dreamer_summon_shifter_spell",
    name = ccb.content.text_without_extraction("Summon Shifter"),
    description = ccb.content.text_without_extraction("Summons a shifter."),
    flags = { "HOSTILE_SUMMON", "RANDOM_DAMAGE", "NO_EXPLOSION_SFX" },
    valid_targets = { "ground", "self" },
    min_damage = 1,
    max_damage = 1,
    min_aoe = 2,
    max_aoe = 2,
    min_duration = 3000,
    max_duration = 6000,
    shape = "blast",
    effect = "summon",
    effect_data = "mon_shifter_feral",
}

ccb.content.define_spell {
    id = "mon_shabriri_blind_spell_reduce_anger",
    shape = "blast",
    name = ccb.content.text_without_extraction("Shabriri Blinding Spell Reduce Anger"),
    description = ccb.content.text_without_extraction("After we blind a target we're less annoyed at them."),
    message = "",
    teachable = false,
    flags = { "NO_PROJECTILE", "NO_HANDS", "NO_LEGS" },
    valid_targets = { "self" },
    impact_handler = "w16b_sp_imp_xedra_evolved_7097520b043a",
}
