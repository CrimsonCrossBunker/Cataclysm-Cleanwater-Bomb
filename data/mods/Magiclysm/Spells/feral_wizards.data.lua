local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "feral_stormshaper_summon_stormhammer_spell",
    name = ccb.content.text_without_extraction("Call Stormhammer Monster"),
    description = ccb.content.text_without_extraction("Summon a stormhammer by effect.  You should never see this."),
    valid_targets = { "self" },
    max_level = 20,
    flags = { "SOMATIC", "NO_LEGS" },
    shape = "blast",
    effect = "attack",
    effect_data = "effect_feral_stormshaper_stormhammer",
    extra_spells = { { spell = "feral_stormshaper_summon_stormhammer_spell_internal_cooldown", self = true } },
    min_duration = 36000,
    max_duration = 1080000,
    duration_increment = 36000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "feral_stormshaper_summon_stormhammer_spell_internal_cooldown",
    name = ccb.content.text_without_extraction("Call Stormhammer Monster Cooldown"),
    description = ccb.content.text_without_extraction("Designed to make any future stormhammers have a much longer cooldown than the first one so that dispelling them is tactically advantageous.  You shouldn't see this."),
    valid_targets = { "self" },
    flags = { "SOMATIC", "NO_LEGS", "RANDOM_DURATION" },
    shape = "blast",
    effect = "attack",
    effect_data = "effect_feral_stormshaper_stormhammer_cooldown",
    min_duration = 12000,
    max_duration = 36000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "feral_technomancer_bless_spell",
    name = ccb.content.text_without_extraction("Bless Self"),
    description = ccb.content.text_without_extraction("Cast bless on yourself if you're a feral.  You should never see this."),
    valid_targets = { "self" },
    max_level = 20,
    flags = { "VERBAL", "SOMATIC", "NO_LEGS" },
    shape = "blast",
    effect = "attack",
    effect_data = "effect_feral_technomancer_bless",
    min_duration = 6000,
    max_duration = 30000,
    duration_increment = 1200,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "feral_invisibility",
    name = ccb.content.text_without_extraction("Feral invisibilty"),
    description = ccb.content.text_without_extraction("Cast invisibility on yourself if you're a feral.  You should never see this."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "invisibility",
    shape = "blast",
    flags = { "ENHANCEMENT_SPELL", "SILENT", "SOMATIC", "RANDOM_DURATION" },
    min_duration = 1250,
    max_duration = 6000,
    duration_increment = 250,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "feral_animated_blade",
    name = ccb.content.text_without_extraction("Feral Animated Blade"),
    description = ccb.content.text_without_extraction("This spell conjures flying animated blades that will cut you down to size.  Into small pieces that is."),
    valid_targets = { "hostile", "ground" },
    flags = { "SOMATIC", "VERBAL", "CONCENTRATE", "RANDOM_DAMAGE", "RANDOM_DURATION", "HOSTILE_SUMMON" },
    effect = "summon",
    effect_data = "mon_animated_blade_feral",
    shape = "blast",
    max_level = 25,
    min_damage = 1,
    max_damage = 2,
    min_range = 1,
    max_range = 5,
    range_increment = 0.25,
    min_aoe = 3,
    max_aoe = 3,
    min_duration = 2000,
    max_duration = 5000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "feral_synaptic_stimulation",
    name = ccb.content.text_without_extraction("Feral Synaptic Stimulation"),
    description = ccb.content.text_without_extraction("This spell stimulates the synapses in your brain if you're a feral."),
    valid_targets = { "self" },
    flags = { "ENHANCEMENT_SPELL", "NO_LEGS", "VERBAL", "NO_PROJECTILE" },
    effect = "attack",
    effect_data = "synaptic_stim",
    shape = "blast",
    spell_class = "TECHNOMANCER",
    energy_source = "MANA",
    max_level = 20,
    min_duration = 6000,
    max_duration = 180000,
    duration_increment = 8700,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "feral_laze",
    name = ccb.content.text_without_extraction("Laze"),
    description = ccb.content.text_without_extraction("You concentrate and release a focused beam of photons at a target, also known as a laser.  Also you are a monster"),
    valid_targets = { "hostile", "ground", "ally" },
    flags = { "EVOCATION_SPELL", "NO_LEGS", "LOUD", "SOMATIC", "NO_PROJECTILE" },
    effect = "attack",
    shape = "line",
    max_level = 20,
    base_casting_time = 100,
    casting_time_increment = -1.0,
    final_casting_time = 80,
    base_energy_cost = 150,
    energy_increment = -2.0,
    final_energy_cost = 110,
    min_damage = 15,
    max_damage = 60,
    damage_increment = 2.5,
    damage_type = "light",
    min_range = 10,
    max_range = 25,
    range_increment = 1.0,
    field = "fd_laser",
    min_field_intensity = 2,
    max_field_intensity = 2,
    field_chance = 1,
}
