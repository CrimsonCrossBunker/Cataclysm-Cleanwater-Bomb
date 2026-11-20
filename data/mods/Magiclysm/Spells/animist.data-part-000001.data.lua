local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    abstract = "summon_abstract_zombie",
    name = ccb.content.text_without_extraction("Abstract Summon Zombie"),
    description = ccb.content.text_without_extraction("Abstract of Summon Undead spell."),
    valid_targets = { "ground" },
    min_damage = 1,
    max_damage = 1,
    max_level = 35,
    effect = "summon",
    shape = "blast",
    min_range = 3,
    max_range = 3,
    min_aoe = 2,
    max_aoe = 2,
    flags = { "CONJURATION_SPELL", "SILENT", "NO_EXPLOSION_SFX", "NO_CORPSE_QUIET" },
    min_duration = 36000,
    max_duration = 1080000,
    duration_increment = 36000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "summon_zombie",
    copy_from = "summon_abstract_zombie",
    name = ccb.content.text_without_extraction("Summon Zombie"),
    description = ccb.content.text_without_extraction("Summon a zombie.  Part of Summon Undead spell."),
    valid_targets = { "ground" },
    effect = "summon",
    effect_data = "mon_zombie",
    max_level = 35,
    min_duration = 216000,
    max_duration = 216000,
    duration_increment = 36000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "summon_tough_zombie",
    copy_from = "summon_abstract_zombie",
    name = ccb.content.text_without_extraction("Summon Tough Zombie"),
    description = ccb.content.text_without_extraction("Summon a tough zombie.  Part of Summon Undead spell."),
    valid_targets = { "ground" },
    effect = "summon",
    effect_data = "mon_zombie_tough",
    max_level = 35,
    min_duration = 468000,
    max_duration = 468000,
    duration_increment = 36000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "summon_zombie_brute",
    copy_from = "summon_abstract_zombie",
    name = ccb.content.text_without_extraction("Summon Zombie Brute"),
    description = ccb.content.text_without_extraction("Summon a zombie brute.  Part of Summon Undead spell."),
    valid_targets = { "ground" },
    effect = "summon",
    effect_data = "mon_zombie_brute",
    max_level = 35,
    min_duration = 720000,
    max_duration = 720000,
    duration_increment = 36000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "summon_skeleton",
    copy_from = "summon_abstract_zombie",
    name = ccb.content.text_without_extraction("Summon Skeleton Zombie"),
    description = ccb.content.text_without_extraction("Summon a skeleton zombie.  Part of Summon Undead spell."),
    valid_targets = { "ground" },
    effect = "summon",
    effect_data = "mon_skeleton",
    max_level = 35,
    min_duration = 972000,
    max_duration = 972000,
    duration_increment = 36000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "summon_skeleton_brute",
    copy_from = "summon_abstract_zombie",
    name = ccb.content.text_without_extraction("Summon Skeletal Brute"),
    description = ccb.content.text_without_extraction("Summon a skeletal brute.  Part of Summon Undead spell."),
    valid_targets = { "ground" },
    effect = "summon",
    effect_data = "mon_skeleton_brute",
    max_level = 35,
    min_duration = 1260000,
    max_duration = 1260000,
    duration_increment = 36000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "summon_skeleton_hulk",
    copy_from = "summon_abstract_zombie",
    name = ccb.content.text_without_extraction("Summon Skeletal Juggernaut"),
    description = ccb.content.text_without_extraction("Summon a skeletal juggernaut.  Part of Summon Undead spell."),
    valid_targets = { "ground" },
    effect = "summon",
    effect_data = "mon_skeleton_hulk",
    max_level = 35,
    min_duration = 1260000,
    max_duration = 1260000,
    duration_increment = 36000,
}
