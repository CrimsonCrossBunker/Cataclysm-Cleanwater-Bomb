local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    abstract = "summon_abstract_swarm",
    name = ccb.content.text_without_extraction("Abstract Summon Swarm"),
    description = ccb.content.text_without_extraction("Abstract of Summon Undead Swarm spell."),
    valid_targets = { "ground" },
    min_damage = 3,
    max_damage = 3,
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
    id = "summon_zombie_dog",
    copy_from = "summon_abstract_swarm",
    name = ccb.content.text_without_extraction("Summon Zombie Dog"),
    description = ccb.content.text_without_extraction("Summon a zombie dog.  Part of Summon Undead Swarm spell."),
    valid_targets = { "ground" },
    effect = "summon",
    effect_data = "mon_zombie_dog",
    max_level = 35,
    min_duration = 144000,
    max_duration = 144000,
    duration_increment = 36000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "summon_dog_skeleton",
    copy_from = "summon_abstract_swarm",
    name = ccb.content.text_without_extraction("Summon Skeletal Dog"),
    description = ccb.content.text_without_extraction("Summon a skeletal dog.  Part of Summon Undead Swarm spell."),
    valid_targets = { "ground" },
    effect = "summon",
    effect_data = "mon_dog_skeleton",
    max_level = 35,
    min_duration = 324000,
    max_duration = 324000,
    duration_increment = 36000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "summon_zougar",
    copy_from = "summon_abstract_swarm",
    name = ccb.content.text_without_extraction("Summon Decayed Pouncer"),
    description = ccb.content.text_without_extraction("Summon a decayed pouncer.  Part of Summon Undead Swarm spell."),
    valid_targets = { "ground" },
    effect = "summon",
    effect_data = "mon_zougar",
    max_level = 35,
    min_duration = 504000,
    max_duration = 504000,
    duration_increment = 36000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "summon_wolf_skeleton",
    copy_from = "summon_abstract_swarm",
    name = ccb.content.text_without_extraction("Summon Skeletal Wolf"),
    description = ccb.content.text_without_extraction("Summon a skeletal wolf.  Part of Summon Undead Swarm spell."),
    valid_targets = { "ground" },
    effect = "summon",
    effect_data = "mon_wolf_skeleton",
    max_level = 35,
    min_duration = 684000,
    max_duration = 684000,
    duration_increment = 36000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "summon_dog_zombie_brute",
    copy_from = "summon_abstract_swarm",
    name = ccb.content.text_without_extraction("Summon Barghest"),
    description = ccb.content.text_without_extraction("Summon a barghest.  Part of Summon Undead Swarm spell."),
    valid_targets = { "ground" },
    effect = "summon",
    effect_data = "mon_dog_zombie_brute",
    max_level = 35,
    min_duration = 864000,
    max_duration = 864000,
    duration_increment = 36000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "summon_dog_skeleton_brute",
    copy_from = "summon_abstract_swarm",
    name = ccb.content.text_without_extraction("Summon Boneplate Wolf"),
    description = ccb.content.text_without_extraction("Summon a boneplate wolf.  Part of Summon Undead Swarm spell."),
    valid_targets = { "ground" },
    effect = "summon",
    effect_data = "mon_dog_skeleton_brute",
    max_level = 35,
    min_duration = 1044000,
    max_duration = 1044000,
    duration_increment = 36000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "summon_dog_zombie_hulk",
    copy_from = "summon_abstract_swarm",
    name = ccb.content.text_without_extraction("Summon Hulking Horror"),
    description = ccb.content.text_without_extraction("Summon a Hulking Horror.  Part of Summon Undead Swarm spell."),
    valid_targets = { "ground" },
    effect = "summon",
    effect_data = "mon_dog_zombie_hulk",
    max_level = 35,
    min_duration = 1260000,
    max_duration = 1260000,
    duration_increment = 36000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "summon_zougar_hunter",
    copy_from = "summon_abstract_swarm",
    name = ccb.content.text_without_extraction("Summon Spearcat Hunter"),
    description = ccb.content.text_without_extraction("Summon a spearcat hunter.  Part of Summon Undead Swarm spell."),
    valid_targets = { "ground" },
    effect = "summon",
    effect_data = "mon_zougar_hunter",
    max_level = 35,
    min_duration = 1260000,
    max_duration = 1260000,
    duration_increment = 36000,
}
