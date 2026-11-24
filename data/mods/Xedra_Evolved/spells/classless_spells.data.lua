local ccb = require("ccb")

ccb.content.define_magic_type {
    id = "xedra_magic_generic",
    energy_source = "MANA",
}

ccb.content.define_magic_type {
    id = "xedra_dream_magic",
    energy_source = "MANA",
    get_level_formula = "xedra_dream_formula_get_level",
    exp_for_level_formula = "xedra_dream_formula_exp_for_level",
    casting_xp_formula = "xedra_dream_casting_xp_formula",
    failure_cost_fraction = 0.1,
    failure_experience_fraction = 1,
    max_book_level = 0,
}

ccb.content.define_spell {
    id = "dread_weight",
    name = ccb.content.text("Weight of Dread"),
    description = ccb.content.text("Everything around you faces an existential crisis and moves slower as a result.  Including things that you wouldn't expect to suffer from existential crises, like the undead.  The air around the targets' extremities chills dramatically.  Higher levels allow a bigger AoE, and longer effect."),
    effect = "attack",
    effect_data = "effect_dread_weight",
    skill = "deduction",
    shape = "blast",
    affected_bodyparts = { "foot_l", "foot_r", "arm_l", "arm_r" },
    valid_targets = { "hostile" },
    max_level = 20,
    min_damage = 10,
    max_damage = 30,
    damage_increment = 1.0,
    min_aoe = 2,
    max_aoe = 20,
    aoe_increment = 0.9,
    min_range = 5,
    max_range = 20,
    range_increment = 2.0,
    min_duration = 1000,
    max_duration = 5000,
    duration_increment = 200,
    spell_class = "NONE",
    flags = { "SOMATIC", "NO_PROJECTILE" },
    base_casting_time = 200,
    base_energy_cost = 400,
    magic_type = "xedra_magic_generic",
    difficulty = 3,
    damage_type = "cold",
}

ccb.content.define_spell {
    id = "blur",
    name = ccb.content.text("Blur"),
    description = ccb.content.text("The edges of your form seem to blur and distort, increasing the amount of attacks you might dodge in a given turn."),
    valid_targets = { "self" },
    effect = "spawn_item",
    effect_data = "blurred_aura",
    skill = "deduction",
    shape = "blast",
    magic_type = "xedra_magic_generic",
    spell_class = "NONE",
    flags = { "NO_LEGS" },
    difficulty = 4,
    max_level = 15,
    base_casting_time = 200,
    base_energy_cost = 400,
    min_duration = 21000,
    max_duration = 90000,
    duration_increment = 4600,
}

-- deal damage, give heal. nothing special.
ccb.content.define_spell {
    id = "damage_transfer",
    name = ccb.content.text("Damage Transfer"),
    description = ccb.content.text("Allows you to move some damage from your body to someone else.  Usually people don't like it, but who cares now?"),
    valid_targets = { "hostile" },
    flags = { "SOMATIC", "SILENT", "NO_PROJECTILE" },
    skill = "deduction",
    effect = "attack",
    shape = "blast",
    damage_type = "bash",
    min_damage = 5,
    max_damage = 25,
    damage_increment = 1,
    min_range = 1,
    max_range = 1,
    max_level = 20,
    difficulty = 6,
    base_casting_time = 200,
    magic_type = "xedra_magic_generic",
    base_energy_cost = 600,
    extra_spells = { { spell = "damage_transfer_heal", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "damage_transfer_heal",
    name = ccb.content.text_without_extraction("Damage Transfer Heal"),
    description = ccb.content.text_without_extraction("A spell that will heal you for a bit.  You can see it only in debug mode."),
    valid_targets = { "self" },
    flags = { "SILENT" },
    effect = "attack",
    shape = "blast",
    min_damage = -2,
    max_damage = -12,
    damage_increment = -0.5,
    max_level = 20,
}

ccb.content.define_spell {
    id = "fire_teleport",
    name = ccb.content.text("Pyroportation"),
    description = ccb.content.text("Transports you from one place to another, creating a huge fire explosion in the end."),
    effect = "short_range_teleport",
    shape = "blast",
    valid_targets = { "ground" },
    flags = { "SOMATIC", "SILENT", "NO_LEGS", "TARGET_TELEPORT" },
    skill = "deduction",
    min_range = 4,
    max_range = 12,
    range_increment = 0.3,
    min_aoe = 6,
    max_aoe = 3,
    aoe_increment = -0.1,
    max_level = 30,
    difficulty = 5,
    base_casting_time = 300,
    magic_type = "xedra_magic_generic",
    base_energy_cost = 900,
    energy_increment = -10,
    final_energy_cost = 600,
    extra_spells = { { spell = "fire_teleport_explosion", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "fire_teleport_explosion",
    name = ccb.content.text_without_extraction("Pyroportation Explosion"),
    description = ccb.content.text_without_extraction("Makes a pretty big fire explosion around you."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "hostile", "ground" },
    flags = { "IGNITE_FLAMMABLE", "LOUD" },
    max_level = 30,
    min_damage = 30,
    max_damage = 80,
    damage_increment = 1.7,
    min_aoe = 3,
    max_aoe = 6,
    aoe_increment = 0.1,
    damage_type = "heat",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "boann_retaliation_mark",
    name = ccb.content.text_without_extraction("Boann's retaliation targeting"),
    valid_targets = { "self", "hostile", "ground", "ally" },
    description = ccb.content.text_without_extraction("Intended to be hidden.  This is how Boann teleport away monsters that hit her."),
    flags = { "SILENT", "NO_EXPLOSION_SFX", "NO_FAIL" },
    message = "",
    effect = "attack",
    effect_data = "boann_retaliation_mark",
    min_range = 60,
    max_range = 60,
    min_duration = 500,
    max_duration = 500,
    shape = "blast",
}

ccb.content.define_spell {
    id = "call_daffodil_real",
    shape = "blast",
    effect = "summon",
    effect_data = "mon_fetch_daffodil_warrior",
    spell_class = "NONE",
    name = ccb.content.text_without_extraction("Call Daffodil"),
    description = ccb.content.text_without_extraction("Hidden spell that spawns the daffodil"),
    flags = { "NO_LEGS", "SILENT", "NO_EXPLOSION_SFX", "NO_FAIL", "NO_HANDS", "NON_MAGICAL" },
    valid_targets = { "ground" },
    min_damage = 5,
    max_damage = 5,
    min_range = 3,
    max_range = 3,
    min_aoe = 3,
    max_aoe = 3,
    min_duration = 8640000,
    max_duration = 8640000,
    difficulty = 0,
    max_level = 1,
}

ccb.content.define_spell {
    id = "call_daffodil",
    shape = "blast",
    spell_class = "NONE",
    name = "Call Daffodil",
    description = "A few daffodil warriors appear near you.  They will fight for you, but they will fade away after a day.",
    flags = { "NO_LEGS", "SILENT", "NO_EXPLOSION_SFX", "NO_FAIL", "NO_HANDS", "NON_MAGICAL" },
    valid_targets = { "self" },
    impact_handler = "w16b_sp_imp_xedra_evolved_517d1a97e0eb",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "boann_heal",
    name = ccb.content.text_without_extraction("Boann Heal"),
    description = ccb.content.text_without_extraction("Will heal injuries all over Boann's body."),
    valid_targets = { "self" },
    effect = "attack",
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX", "NO_FAIL", "SILENT" },
    teachable = false,
    shape = "blast",
    base_casting_time = 0,
    min_damage = -300,
    max_damage = -300,
    message = "",
    sound_description = "",
}

ccb.content.define_spell {
    id = "boann_retaliation",
    shape = "blast",
    name = ccb.content.text_without_extraction("Boann's retaliation"),
    description = ccb.content.text_without_extraction("Intended to be hidden.  Makes Boann teleport the player away, spawns some huntsmen and hounds then cure all her ailments and injuries if she survives being hit by the player."),
    message = "",
    flags = { "SILENT", "NO_EXPLOSION_SFX", "NO_FAIL" },
    valid_targets = { "self" },
    impact_handler = "w16b_sp_imp_xedra_evolved_46f11199f37d",
}

ccb.content.define_spell {
    id = "boann_banish_monsters_check",
    skill = "deduction",
    shape = "blast",
    spell_class = "NONE",
    damage_type = "pure",
    name = ccb.content.text_without_extraction("Boann's retaliation against monsters check"),
    description = ccb.content.text_without_extraction("Boann's about to retaliate against monsters, deleting them as they are \"teleported\" away.  You shouldn't see this"),
    teachable = false,
    flags = { "SILENT", "NO_FAIL", "NO_EXPLOSION_SFX" },
    valid_targets = { "self", "ally", "hostile" },
    min_range = 60,
    max_range = 60,
    min_aoe = 60,
    max_aoe = 60,
    base_casting_time = 0,
    impact_handler = "w16b_sp_imp_xedra_evolved_16049a32de34",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "boann_banish_monsters",
    name = ccb.content.text_without_extraction("Boann's retaliation against monsters"),
    description = ccb.content.text_without_extraction("Boann's retaliation against monsters, deleting them as they are \"teleported\" away.  You shouldn't see this"),
    teachable = false,
    valid_targets = { "self" },
    effect = "banishment",
    shape = "blast",
    spell_class = "NONE",
    damage_type = "pure",
    skill = "deduction",
    min_damage = 9999,
    max_damage = 9999,
    base_casting_time = 0,
    flags = { "SILENT", "NO_FAIL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "xedra_self_banish",
    name = ccb.content.text_without_extraction("Banish Self"),
    description = ccb.content.text_without_extraction("Banish the caster, killing them and destroying their body.  Having this spell is a bug, and casting it would be suicidal."),
    teachable = false,
    valid_targets = { "self" },
    effect = "banishment",
    shape = "blast",
    spell_class = "NONE",
    damage_type = "pure",
    min_damage = 9999,
    max_damage = 9999,
    base_casting_time = 0,
    flags = { "SILENT", "NO_FAIL", "PERCENT_DAMAGE" },
}

ccb.content.define_spell {
    id = "night_sight",
    skill = "deduction",
    shape = "blast",
    effect = "attack",
    effect_data = "night_sight",
    magic_type = "xedra_magic_generic",
    name = "Night Sight",
    description = "Gives you the power to see in the dark.",
    message = "Your eyes glow lavender for a moment.  Now your sight can pierce the darkest shadows.",
    valid_targets = { "self" },
    min_duration = 18000,
    duration_increment = 18000,
    max_duration = 1080000,
    base_energy_cost = 1200,
    difficulty = 6,
    max_level = 20,
    base_casting_time = 2000,
}
