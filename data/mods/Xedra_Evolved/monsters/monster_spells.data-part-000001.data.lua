local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_guilt",
    name = ccb.content.text_without_extraction("Death Guilt"),
    description = ccb.content.text_without_extraction("Feeling guilty over killing a monster."),
    valid_targets = { "hostile" },
    flags = { "SILENT", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "guilt",
    effect_data = "NULL",
    min_damage = 50,
    max_damage = 50,
    min_duration = 180000,
    max_duration = 180000,
    min_range = 5,
    max_range = 5,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "kill_summoned_creature_monster",
    name = ccb.content.text_without_extraction("Summoned Dispel Monster"),
    description = ccb.content.text_without_extraction("Destroys a summoned monster, cast by monsters."),
    message = "",
    valid_targets = { "hostile" },
    flags = { "SILENT", "NO_PROJECTILE", "PERCENTAGE_DAMAGE", "NO_EXPLOSION_SFX" },
    effect = "attack",
    damage_type = "pure",
    shape = "blast",
    min_damage = 300,
    max_damage = 300,
    min_range = 5,
    max_range = 25,
    range_increment = 1,
    targeted_species = { "SUMMONED_CREATURE" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_shadowman",
    name = ccb.content.text_without_extraction("Shadowman Death"),
    valid_targets = { "ground", "ally", "hostile", "self" },
    description = ccb.content.text_without_extraction("Eliminates any dream shadows in the area."),
    max_level = 1,
    teachable = false,
    effect = "banishment",
    shape = "blast",
    targeted_monsters = { "mon_dream_shadowbeast", "mon_dream_shadow" },
    damage_type = "pure",
    min_damage = 407,
    max_damage = 407,
    min_aoe = 60,
    max_aoe = 60,
    extra_spells = { { spell = "CLOSE_DREAMWOUND_SHADOW", self = true } },
    flags = { "NO_PROJECTILE", "NO_HANDS", "NO_LEGS", "NO_FAIL", "SILENT", "IGNORE_WALLS", "NO_EXPLOSION_SFX" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "CLOSE_DREAMWOUND_SHADOW",
    name = ccb.content.text_without_extraction("Close Dreamwound Shadow"),
    description = ccb.content.text_without_extraction("Closes a shadowy wound between reality and dreams."),
    message = "",
    min_aoe = 60,
    max_aoe = 60,
    valid_targets = { "ground" },
    flags = { "IGNORE_WALLS", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "ter_transform",
    effect_data = "ter_shadowman_close_wound",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "shadowman_teleport",
    name = ccb.content.text_without_extraction("Shadowman Teleport"),
    description = ccb.content.text_without_extraction("Teleports the monster."),
    effect = "short_range_teleport",
    shape = "blast",
    valid_targets = { "none" },
    flags = { "SOMATIC", "SILENT", "NO_LEGS", "NO_EXPLOSION_SFX" },
    min_range = 2,
    max_range = 12,
    min_aoe = 2,
    max_aoe = 12,
    base_casting_time = 100,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "dream_shadowman_teleport",
    name = ccb.content.text_without_extraction("Shadowman Teleport"),
    description = ccb.content.text_without_extraction("An explosive movement of shadowy knives."),
    extra_spells = { { spell = "shadowman_teleport", self = true } },
    valid_targets = { "hostile", "ground", "self", "ally" },
    effect = "attack",
    shape = "blast",
    flags = { "LOUD", "RANDOM_DAMAGE", "RANDOM_AOE", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    base_casting_time = 100,
    min_damage = 8,
    max_damage = 24,
    damage_type = "xe_shadow_damage",
    min_aoe = 4,
    max_aoe = 8,
    min_range = 2,
    max_range = 6,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_shadow_damage_reduction",
    name = ccb.content.text_without_extraction("Shadow DR Monster enemy check"),
    description = ccb.content.text_without_extraction("Preps for using Shadow Damage Reduction when a hostile target is detected."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "hostile" },
    max_level = 1,
    effect = "attack",
    extra_spells = { { spell = "spell_shadow_damage_reduction_self", self = true } },
    shape = "blast",
    min_range = 60,
    max_range = 60,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_shadow_damage_reduction_self",
    name = ccb.content.text_without_extraction("Shadow DR Monster Effect"),
    description = ccb.content.text_without_extraction("Grants the effect for a shadow to gain damage resistance to bash and bullets.."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DURATION" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_monster_shadow_damage_reduction",
    shape = "blast",
    min_duration = 9000,
    max_duration = 27000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_firebird_explosion",
    name = ccb.content.text_without_extraction("Firebird Explosion"),
    valid_targets = { "hostile", "ground" },
    description = ccb.content.text_without_extraction("A fireball caused by a zealous firebird."),
    flags = { "RANDOM_DAMAGE", "RANDOM_AOE" },
    effect = "attack",
    extra_spells = { { spell = "mon_firebird_explosion_self", self = true } },
    damage_type = "heat",
    shape = "blast",
    min_aoe = 2,
    max_aoe = 5,
    min_damage = 50,
    max_damage = 120,
    min_range = 1,
    max_range = 1,
    field = "fd_fire",
    field_chance = 2,
    min_field_intensity = 1,
    max_field_intensity = 2,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_firebird_explosion_self",
    name = ccb.content.text_without_extraction("Firebird Explosion Self"),
    valid_targets = { "self" },
    description = ccb.content.text_without_extraction("A fireball caused by a zealous firebird that consumes itself.  Damage type pure to actually hurt them since they're immune to heat."),
    effect = "attack",
    damage_type = "pure",
    shape = "blast",
    min_damage = 500,
    max_damage = 500,
    field = "fd_fire",
    field_chance = 1,
    min_field_intensity = 3,
    max_field_intensity = 3,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_dream_drainer_heal",
    name = ccb.content.text_without_extraction("Trade dreams for health"),
    description = ccb.content.text_without_extraction("Absorbs some collective dross and heals damage to the mosquito."),
    teachable = false,
    valid_targets = { "self" },
    min_damage = -5,
    max_damage = -20,
    damage_increment = -3.0,
    max_level = 5,
    min_range = 0,
    max_range = 0,
    effect = "attack",
    shape = "blast",
    base_casting_time = 100,
    skill = "deduction",
    flags = { "NO_HANDS", "NO_EXPLOSION_SFX" },
    spell_class = "EATER",
    difficulty = 4,
    energy_source = "NONE",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_dream_drainer_armor",
    name = ccb.content.text_without_extraction("Endurance"),
    description = ccb.content.text_without_extraction("Let the dreams take the blows.  Don't let the world kill you."),
    teachable = false,
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "effect_dream_drainer_armor",
    shape = "blast",
    flags = { "NO_LEGS", "SILENT", "NO_HANDS", "NO_EXPLOSION_SFX" },
    skill = "deduction",
    energy_source = "MANA",
    spell_class = "EATER",
    difficulty = 5,
    max_level = 5,
    min_duration = 2000,
    max_duration = 2000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_dream_drainer_spear",
    name = ccb.content.text_without_extraction("Pierce"),
    description = ccb.content.text_without_extraction("Throw a long ethereal spear out of your proboscis or finger."),
    teachable = false,
    valid_targets = { "hostile", "ground" },
    flags = { "NO_LEGS", "NO_HANDS", "SILENT" },
    skill = "deduction",
    difficulty = 4,
    max_level = 5,
    effect = "attack",
    shape = "cone",
    damage_type = "stab",
    min_damage = 10,
    max_damage = 25,
    damage_increment = 3,
    min_range = 3,
    max_range = 12,
    range_increment = 0.3,
    energy_source = "NONE",
    spell_class = "EATER",
    min_aoe = 3,
    max_aoe = 3,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_dream_drainer_speed",
    name = ccb.content.text_without_extraction("Rush"),
    description = ccb.content.text_without_extraction("Fly.  Fly as fast as you can.  Don't stop."),
    teachable = false,
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "effect_dream_drainer_speed",
    shape = "blast",
    flags = { "NO_LEGS", "NO_HANDS", "SILENT" },
    skill = "deduction",
    spell_class = "EATER",
    difficulty = 5,
    min_duration = 2000,
    max_duration = 2000,
    max_level = 5,
    energy_source = "NONE",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_dream_drainer_bash",
    name = ccb.content.text_without_extraction("Point Blank"),
    description = ccb.content.text_without_extraction("A straight hit with your leg.  Using additional energy you could probably break a wall with such a powerful strike."),
    teachable = false,
    valid_targets = { "hostile", "ground" },
    effect = "attack",
    shape = "blast",
    flags = { "LOUD" },
    difficulty = 4,
    damage_type = "bash",
    max_level = 5,
    min_damage = 20,
    max_damage = 50,
    damage_increment = 6,
    min_bash_scaling = 2,
    max_bash_scaling = 10,
    bash_scaling_increment = 1,
    min_range = 1,
    max_range = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_luna_attuned_revenant_beam",
    name = ccb.content.text_without_extraction("Lunar Line"),
    description = ccb.content.text_without_extraction("Create a line of pure destruction.  Doesn't hurt the player that much because that spell will be spammed all over the fight."),
    valid_targets = { "hostile", "ground" },
    flags = { "LOUD", "RANDOM_DAMAGE", "IGNORE_WALLS", "NO_FAIL" },
    energy_source = "NONE",
    spell_class = "EATER",
    effect = "attack",
    shape = "line",
    damage_type = "bash",
    max_level = 1,
    difficulty = 4,
    min_range = 40,
    max_range = 40,
    min_damage = 26,
    max_damage = 34,
    min_aoe = 1,
    max_aoe = 1,
    message = "",
    sound_description = ccb.content.text("A crackling sound!"),
    extra_spells = { { spell = "XE_line_bash" } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_luna_attuned_revenant_moon_withdrawal",
    name = ccb.content.text_without_extraction("Weakened by the lack of light"),
    description = ccb.content.text_without_extraction("No more moonlight, no more power."),
    teachable = false,
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "effect_moon_withdrawal",
    shape = "blast",
    flags = { "NO_LEGS", "NO_HANDS", "SILENT", "NO_EXPLOSION_SFX" },
    skill = "deduction",
    spell_class = "EATER",
    difficulty = 5,
    min_duration = 1000,
    max_duration = 1000,
    max_level = 5,
    energy_source = "NONE",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_luna_attuned_revenant_lash_out",
    name = ccb.content.text_without_extraction("Lasing-Out Lunar Line"),
    description = ccb.content.text_without_extraction("Create a line of pure destruction.  Weakened to account for the massive spam."),
    valid_targets = { "self", "ground", "hostile" },
    flags = { "LOUD", "RANDOM_DAMAGE", "IGNORE_WALLS", "NO_FAIL", "RANDOM_TARGET" },
    energy_source = "NONE",
    spell_class = "EATER",
    effect = "attack",
    shape = "line",
    damage_type = "bash",
    max_level = 1,
    difficulty = 4,
    min_range = 40,
    max_range = 40,
    min_damage = 6,
    max_damage = 14,
    min_aoe = 1,
    max_aoe = 1,
    message = "",
    sound_description = ccb.content.text("A crackling sound!"),
    extra_spells = { { spell = "XE_line_bash" } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "small_globule_spawn",
    name = ccb.content.text_without_extraction("Summon small globule"),
    description = ccb.content.text_without_extraction("Summons a small globule."),
    flags = { "HOSTILE_SUMMON", "RANDOM_DAMAGE", "NO_EXPLOSION_SFX" },
    valid_targets = { "ground", "self" },
    min_damage = 1,
    max_damage = 1,
    min_aoe = 4,
    max_aoe = 4,
    min_duration = 3000,
    max_duration = 3000,
    shape = "blast",
    effect = "summon",
    effect_data = "mon_small_globule",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_nuckalavee_toxic_breath",
    name = ccb.content.text_without_extraction("Nuckalavee Toxic Breath"),
    description = ccb.content.text_without_extraction("The Nuckalavee breathes out toxic gas.  It's a bug if you have it."),
    effect = "attack",
    shape = "cone",
    valid_targets = { "self", "ally", "hostile", "ground" },
    max_level = 20,
    min_damage = 0,
    max_damage = 0,
    min_aoe = 30,
    max_aoe = 30,
    min_range = 6,
    max_range = 6,
    field = "fd_toxic_gas",
    field_chance = 1,
    min_field_intensity = 2,
    max_field_intensity = 3,
    damage_type = "cold",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_sevenoclock_pacify",
    name = ccb.content.text_without_extraction("Pacify the Nineteenth Hour"),
    description = ccb.content.text_without_extraction("Makes the Man of the Nineteenth Hour calm down."),
    valid_targets = { "hostile" },
    flags = { "NO_LEGS", "NO_PROJECTILE" },
    effect = "targeted_polymorph",
    effect_data = "mon_sevenoclock_passive",
    shape = "blast",
    spell_class = "NONE",
    base_casting_time = 10,
    difficulty = 0,
    max_level = 1,
    min_damage = 9999,
    max_damage = 9999,
    damage_type = "pure",
    min_range = 30,
    max_range = 30,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_sevenoclock_activate",
    name = ccb.content.text_without_extraction("Anger the Nineteenth Hour"),
    description = ccb.content.text_without_extraction("Makes the Man of the Nineteenth Hour ready to attack all those who do not sleep."),
    valid_targets = { "hostile" },
    flags = { "NO_LEGS", "NO_PROJECTILE" },
    effect = "targeted_polymorph",
    effect_data = "mon_sevenoclock_active",
    shape = "blast",
    spell_class = "NONE",
    base_casting_time = 10,
    difficulty = 0,
    max_level = 1,
    min_damage = 9999,
    max_damage = 9999,
    damage_type = "pure",
    min_range = 30,
    max_range = 30,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_shield_sleepers",
    name = ccb.content.text_without_extraction("Shield the sleepers"),
    description = ccb.content.text_without_extraction("Ensures an eventless sleep to those who sleep nearby."),
    message = "",
    valid_targets = { "ally", "hostile" },
    effect = "attack",
    effect_data = "effect_sleep_shield_check",
    shape = "blast",
    min_duration = 3000,
    max_duration = 3000,
    min_aoe = 15,
    max_aoe = 15,
    min_range = 1,
    max_range = 1,
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "wild_hunt_illumination_spell",
    name = ccb.content.text_without_extraction("Witchfire monster"),
    description = ccb.content.text_without_extraction("Illuminate the target so the hounds can get them."),
    valid_targets = { "ally", "hostile" },
    flags = { "SOMATIC", "VERBAL", "NO_LEGS", "RANDOM_DURATION" },
    effect = "attack",
    effect_data = "effect_wild_hunt_illumination",
    shape = "blast",
    min_duration = 6000,
    max_duration = 18000,
    min_range = 30,
    max_range = 30,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "wild_hunt_hound_baying",
    name = ccb.content.text_without_extraction("Wild Hunt Hound Baying Self"),
    description = ccb.content.text_without_extraction("Supernaturally disorients the target of the dog's baying."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "hostile" },
    max_level = 1,
    effect = "attack",
    effect_data = "wild_hunt_dazed",
    extra_spells = { { spell = "wild_hunt_hound_baying_self", self = true } },
    shape = "blast",
    min_range = 25,
    max_range = 25,
    min_duration = 15000,
    max_duration = 45000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "wild_hunt_hound_baying_self",
    name = ccb.content.text_without_extraction("Wild Hunt Hound Baying Self"),
    description = ccb.content.text_without_extraction("Causes noise when the hound spots you."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DAMAGE" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "noise",
    shape = "blast",
    min_damage = 20,
    max_damage = 35,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "BLOODBAG_DAZE_SELF",
    name = ccb.content.text_without_extraction("Bloodbag daze self"),
    description = ccb.content.text_without_extraction("This gives the dazed effect to the entralled victims when they spawns, as monsters cannot spawn with effects as of writting this."),
    flags = { "NO_EXPLOSION_SFX", "SILENT", "NO_FAIL", "NO_LEGS", "NO_HANDS" },
    valid_targets = { "self" },
    shape = "blast",
    effect = "attack",
    effect_data = "dazed",
    spell_class = "NONE",
    energy_source = "NONE",
    max_level = 1,
    min_duration = 3000000,
    max_duration = 3000000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "werewolf_hyper_regeneration_monster",
    name = ccb.content.text_without_extraction("Shadow Pack Regeneration Self"),
    description = ccb.content.text_without_extraction("For monster werewolves to regenerate faster."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DURATION" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_werewolf_lunar_renewal_monster",
    shape = "blast",
    min_duration = 600,
    max_duration = 1800,
}
