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

ccb.content.define_spell {
    id = "summon_undead_swarm",
    components = "spell_components_rune_animist_3",
    shape = "blast",
    spell_class = "ANIMIST",
    magic_type = "magiclysm_conjuration_magic",
    name = "Summon Undead Swarm",
    description = "A group of undead animals rises from the depths of the earth to fight for you.  The type of undead you summon get deadlier with increasing spell level.",
    flags = { "CONJURATION_SPELL", "SOMATIC", "VERBAL", "CONCENTRATE", "CONSUMES_RUNES" },
    valid_targets = { "self" },
    min_damage = 1,
    max_damage = 1,
    min_duration = 36000,
    duration_increment = 36000,
    max_duration = 1080000,
    base_energy_cost = 600,
    difficulty = 3,
    max_level = 35,
    base_casting_time = 3000,
    impact_handler = "w16b_sp_imp_magiclysm_ef45c13b909d",
    extra_spells = {
        { spell = "eoc_summon_setup", self = true },
    },
}
