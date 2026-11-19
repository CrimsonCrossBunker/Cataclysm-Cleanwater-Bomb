local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mirror_image_rad_mage",
    name = ccb.content.text_without_extraction("Mirror Image Radiation Mage"),
    description = ccb.content.text_without_extraction("This spell summons duplicates of the radiation mage.  It's a bug if you have it."),
    valid_targets = { "ground" },
    effect = "summon",
    effect_data = "mon_mirror_image_rad_mage",
    shape = "blast",
    max_level = 2,
    min_damage = 3,
    max_damage = 5,
    damage_increment = 1,
    min_range = 4,
    max_range = 8,
    range_increment = 2,
    min_aoe = 3,
    max_aoe = 3,
    min_duration = 2000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "feral_rad_mage_rad_spell",
    name = ccb.content.text_without_extraction("Create Rads Radiation Mage"),
    description = ccb.content.text_without_extraction("This spell creates radiation gas around a target.  It's a bug if you have it."),
    valid_targets = { "hostile" },
    effect = "emit",
    effect_data = "emit_rad_cloud",
    shape = "blast",
    max_level = 10,
    min_range = 5,
    max_range = 15,
    range_increment = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "feral_rad_mage_summon_spell",
    name = ccb.content.text_without_extraction("Summon Zombie"),
    description = ccb.content.text_without_extraction("A spell for the feral rad mage to summon a zombie.  It's a bug if you have this."),
    valid_targets = { "hostile", "ground" },
    flags = { "WONDER", "NO_PROJECTILE" },
    max_level = 1,
    min_damage = 1,
    max_damage = 1,
    min_range = 10,
    max_range = 10,
    message = "",
    shape = "blast",
    effect = "attack",
    extra_spells = {
        { spell = "feral_animist_summon_zombie" },
        { spell = "feral_animist_summon_zombie" },
        { spell = "feral_animist_summon_zombie" },
        { spell = "feral_animist_summon_zombie" },
        { spell = "feral_animist_summon_zombie" },
        { spell = "feral_animist_summon_tough_zombie" },
        { spell = "feral_animist_summon_tough_zombie" },
        { spell = "feral_animist_summon_tough_zombie" },
        { spell = "feral_animist_summon_tough_zombie" },
        { spell = "feral_animist_summon_tough_zombie" },
        { spell = "feral_animist_summon_tough_zombie" },
        { spell = "feral_animist_summon_tough_zombie" },
        { spell = "feral_animist_summon_zombie_brute" },
        { spell = "feral_animist_summon_zombie_brute" },
        { spell = "feral_animist_summon_zombie_brute" },
        { spell = "feral_animist_summon_zombie_brute" },
        { spell = "feral_animist_summon_zombie_brute" },
        { spell = "feral_animist_summon_zombie_brute" },
        { spell = "feral_animist_summon_zombie_brute" },
        { spell = "feral_animist_summon_zombie_brute" },
        { spell = "feral_animist_summon_zombie_brute" },
        { spell = "feral_animist_summon_zombie_hulk" },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "feral_animist_summon_zombie",
    name = ccb.content.text_without_extraction("Summon Zombie"),
    description = ccb.content.text_without_extraction("A spell for the feral rad mage to summon a normal zombie.  It's a bug if you have this."),
    valid_targets = { "ground" },
    flags = { "HOSTILE_SUMMON", "LOUD", "NO_PROJECTILE" },
    min_damage = 1,
    max_damage = 1,
    min_aoe = 3,
    max_aoe = 5,
    min_range = 10,
    max_range = 10,
    min_duration = 30000,
    max_duration = 30000,
    shape = "blast",
    effect = "summon",
    effect_data = "mon_zombie",
    sound_description = ccb.content.text("a roar"),
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "feral_animist_summon_tough_zombie",
    name = ccb.content.text_without_extraction("Summon Tough Zombie"),
    description = ccb.content.text_without_extraction("A spell for the feral rad mage to summon a tough zombie brute.  It's a bug if you have this."),
    valid_targets = { "ground" },
    flags = { "HOSTILE_SUMMON", "LOUD", "NO_PROJECTILE" },
    min_damage = 1,
    max_damage = 1,
    min_aoe = 3,
    max_aoe = 5,
    min_range = 10,
    max_range = 10,
    min_duration = 30000,
    max_duration = 30000,
    shape = "blast",
    effect = "summon",
    effect_data = "mon_zombie_tough",
    sound_description = ccb.content.text("a roar"),
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "feral_animist_summon_zombie_brute",
    name = ccb.content.text_without_extraction("Summon Zombie Brute"),
    description = ccb.content.text_without_extraction("A spell for the feral rad mage to summon a zombie brute.  It's a bug if you have this."),
    valid_targets = { "ground" },
    flags = { "HOSTILE_SUMMON", "LOUD", "NO_PROJECTILE" },
    min_damage = 1,
    max_damage = 1,
    min_aoe = 3,
    max_aoe = 5,
    min_range = 10,
    max_range = 10,
    min_duration = 30000,
    max_duration = 30000,
    shape = "blast",
    effect = "summon",
    effect_data = "mon_zombie_brute",
    sound_description = ccb.content.text("a roar"),
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "feral_animist_summon_zombie_hulk",
    name = ccb.content.text_without_extraction("Radiation Mage Summon Zombie"),
    description = ccb.content.text_without_extraction("A spell for the feral rad mage to summon a zombie hulk.  They probably won't cast this--but good luck if they do."),
    valid_targets = { "ground" },
    flags = { "HOSTILE_SUMMON", "LOUD", "NO_PROJECTILE" },
    min_damage = 1,
    max_damage = 1,
    min_aoe = 3,
    max_aoe = 5,
    min_range = 10,
    max_range = 10,
    min_duration = 30000,
    max_duration = 30000,
    shape = "blast",
    effect = "summon",
    effect_data = "mon_zombie_hulk",
    sound_description = ccb.content.text("a roar"),
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "feral_rad_mage_swap_spell",
    name = ccb.content.text_without_extraction("Change Places with mirror image"),
    description = ccb.content.text_without_extraction("The spell for the feral radiation mage swapping places with a mirror image.  It's a bug if you have it."),
    valid_targets = { "ally" },
    targeted_monsters = { "mon_mirror_image_rad_mage" },
    flags = { "NO_LEGS", "LOUD", "SOMATIC", "SWAP_POS", "NO_PROJECTILE" },
    effect = "attack",
    shape = "blast",
    max_level = 20,
    min_range = 5,
    max_range = 15,
    range_increment = 1.0,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "dispel_magic_monster",
    name = ccb.content.text_without_extraction("Dispel Magic Monster"),
    description = ccb.content.text_without_extraction("Dispel magic for monsters so they'll only dispel their enemies"),
    valid_targets = { "hostile" },
    effect = "attack",
    effect_data = "effect_dispel_magic",
    shape = "blast",
    min_duration = 200,
    max_duration = 200,
    min_range = 3,
    max_range = 20,
    range_increment = 1.2,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "disjunction_monster",
    name = ccb.content.text_without_extraction("Disjunction Monster"),
    description = ccb.content.text_without_extraction("Disjunction for monsters so they'll only dispel their enemies"),
    valid_targets = { "hostile" },
    effect = "attack",
    effect_data = "effect_disjunction",
    shape = "blast",
    min_duration = 200,
    max_duration = 200,
    min_range = 3,
    max_range = 20,
    range_increment = 1.2,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "feral_animist_summon_spell",
    name = ccb.content.text_without_extraction("Feral Animist Summon Zombie"),
    description = ccb.content.text_without_extraction("A spell for the feral animist to summon a zombie.  It's a bug if you have this."),
    valid_targets = { "hostile", "ground" },
    flags = { "WONDER", "NO_PROJECTILE" },
    max_level = 1,
    min_damage = 1,
    max_damage = 1,
    min_range = 10,
    max_range = 10,
    message = "",
    shape = "blast",
    effect = "attack",
    extra_spells = {
        { spell = "feral_animist_summon_zombie" },
        { spell = "feral_animist_summon_zombie" },
        { spell = "feral_animist_summon_zombie" },
        { spell = "feral_animist_summon_zombie" },
        { spell = "feral_animist_summon_zombie" },
        { spell = "feral_animist_summon_zombie" },
        { spell = "feral_animist_summon_tough_zombie" },
        { spell = "feral_animist_summon_tough_zombie" },
        { spell = "feral_animist_summon_tough_zombie" },
        { spell = "feral_animist_summon_tough_zombie" },
        { spell = "feral_animist_summon_tough_zombie" },
        { spell = "feral_animist_summon_tough_zombie" },
        { spell = "feral_animist_summon_tough_zombie" },
        { spell = "feral_animist_summon_zombie_brute" },
        { spell = "feral_animist_summon_zombie_brute" },
        { spell = "feral_animist_summon_zombie_brute" },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "feral_animist_guardian_spirit",
    name = ccb.content.text_without_extraction("Guardian Spirit Monster enemy check"),
    description = ccb.content.text_without_extraction("Preps for using Guardian Spirit when a hostile target is detected."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "hostile" },
    max_level = 1,
    effect = "attack",
    extra_spells = { { spell = "feral_animist_guardian_spirit_self", self = true } },
    shape = "blast",
    min_range = 60,
    max_range = 60,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "feral_animist_guardian_spirit_self",
    name = ccb.content.text_without_extraction("Guardian Spirit Monster give Effect"),
    description = ccb.content.text_without_extraction("Grants the Guardian Spirit effect to a monster."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DURATION" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_feral_animist_guardian_spirit",
    shape = "blast",
    min_duration = 12000,
    max_duration = 42000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "feral_animist_inner_voice",
    name = ccb.content.text_without_extraction("Inner Voice Spirit Monster enemy check"),
    description = ccb.content.text_without_extraction("Preps for using Inner Voice when a hostile target is nearby"),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "hostile" },
    max_level = 1,
    effect = "attack",
    extra_spells = { { spell = "feral_animist_inner_voice_self", self = true } },
    shape = "blast",
    min_range = 60,
    max_range = 60,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "feral_animist_inner_voice_self",
    name = ccb.content.text_without_extraction("Inner Voice Monster give Effect"),
    description = ccb.content.text_without_extraction("Grants the Inner Voice effect to a monster."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DURATION" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_feral_animist_inner_voice",
    shape = "blast",
    min_duration = 30000,
    max_duration = 60000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "feral_high_animist_wrathful_spirits",
    name = ccb.content.text_without_extraction("Wrathful Spirits Monster enemy check"),
    description = ccb.content.text_without_extraction("Preps for using Wrathful Spirits when a hostile target is close."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "hostile" },
    max_level = 1,
    effect = "attack",
    extra_spells = { { spell = "feral_high_animist_wrathful_spirits_self", self = true } },
    shape = "blast",
    min_range = 4,
    max_range = 4,
}

-- NO_I18N
ccb.content.define_spell {
    id = "feral_high_animist_wrathful_spirits_self",
    name = ccb.content.text_without_extraction("Wrathful Spirits Summon"),
    description = ccb.content.text("Grant brief corporality to orphaned spirits and allow them to fight under your command."),
    valid_targets = { "ground" },
    min_damage = 2,
    max_damage = 6,
    damage_increment = 0.2,
    max_level = 30,
    difficulty = 1,
    effect = "summon",
    effect_data = "mon_magi_shadow_monster",
    shape = "blast",
    magic_type = "magiclysm_generic_magic",
    min_aoe = 3,
    max_aoe = 3,
    flags = { "SOMATIC", "VERBAL", "HOSTILE_SUMMON" },
    min_duration = 3600,
    max_duration = 12000,
    duration_increment = 280,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "summon_wolf_druid_monster",
    name = ccb.content.text_without_extraction("Summon Wolf Monster"),
    description = ccb.content.text_without_extraction("Call to the wilds for aid from some wolves.  This is the monster version."),
    valid_targets = { "hostile", "ground" },
    min_damage = 1,
    max_damage = 3,
    damage_increment = 0.08,
    min_range = 2,
    max_range = 7,
    min_aoe = 2,
    max_aoe = 2,
    range_increment = 0.2,
    max_level = 30,
    min_duration = 36000,
    max_duration = 1080000,
    duration_increment = 36000,
    base_energy_cost = 400,
    flags = { "SOMATIC", "VERBAL", "NO_LEGS", "HOSTILE_SUMMON" },
    shape = "blast",
    effect = "summon",
    effect_data = "mon_wolf_feral_druid",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "thornskin_druid_monster",
    name = ccb.content.text_without_extraction("Thornskin Monster"),
    description = ccb.content.text_without_extraction("Casts Thornskin  This is the monster version."),
    valid_targets = { "self" },
    max_level = 30,
    min_duration = 36000,
    max_duration = 1080000,
    duration_increment = 36000,
    flags = { "SOMATIC", "VERBAL", "NO_LEGS" },
    shape = "blast",
    effect = "attack",
    effect_data = "effect_feral_druid_thornskin",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "summon_earthshaper_golem_monster",
    name = ccb.content.text_without_extraction("Summon Earthshaper Golem"),
    description = ccb.content.text_without_extraction("Summon a golem from the earth.  This is the monster version."),
    valid_targets = { "hostile", "ground" },
    min_damage = 1,
    max_damage = 1,
    min_range = 2,
    max_range = 7,
    min_aoe = 2,
    max_aoe = 2,
    range_increment = 0.2,
    max_level = 30,
    min_duration = 36000,
    max_duration = 1080000,
    duration_increment = 36000,
    base_energy_cost = 400,
    flags = { "SOMATIC", "VERBAL", "NO_LEGS", "HOSTILE_SUMMON" },
    shape = "blast",
    effect = "summon",
    effect_data = "mon_eshaper_golem_feral_earthshaper",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "feral_magus_push_nearby_enemies_back_target",
    name = ccb.content.text_without_extraction("Feral Magus Repulsion Wave Starter"),
    description = ccb.content.text_without_extraction("Someday monsters will be smart enough to cast AoE spells without workarounds but it is not this day."),
    valid_targets = { "hostile" },
    flags = { "VERBAL", "SOMATIC" },
    effect = "noise",
    extra_spells = { { spell = "feral_magus_push_nearby_enemies_back" } },
    shape = "blast",
    spell_class = "MAGUS",
    min_range = 1,
}
