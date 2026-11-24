local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "assassin_teleport",
    name = ccb.content.text_without_extraction("Assassin Teleport"),
    description = ccb.content.text_without_extraction("This is a sub-spell for Assassin Strike.  It teleports you."),
    effect = "short_range_teleport",
    shape = "blast",
    valid_targets = { "none" },
    flags = { "CONVEYANCE_SPELL", "SILENT" },
    min_range = 8,
    max_range = 8,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "assassin_toxic_smoke",
    name = ccb.content.text_without_extraction("Assassin Toxic Smoke"),
    description = ccb.content.text_without_extraction("This is a sub-spell for Assassin Strike.  It generates toxic smoke in an area."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "ground", "hostile" },
    field = "fd_toxic_gas",
    min_field_intensity = 2,
    max_field_intensity = 3,
    min_aoe = 4,
    max_aoe = 4,
}

ccb.content.define_spell {
    id = "assassin_strike",
    name = ccb.content.text("Assassin Strike"),
    description = ccb.content.text("You strike a poisonous blow and disappear in a puff of toxic smoke."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "hostile" },
    flags = { "CONVEYANCE_SPELL", "RANDOM_DAMAGE", "MUST_HAVE_CLASS_TO_LEARN", "TOUCH_REQUIRED" },
    min_damage = { handler = "scaled_assassin_strike_min_damage", fallback = 14.0 },
    max_damage = { handler = "scaled_assassin_strike_max_damage", fallback = 21.0 },
    min_range = 1,
    max_range = 1,
    damage_type = "poison",
    min_dot = 35,
    max_dot = 490,
    dot_increment = 13,
    max_level = 35,
    min_duration = 500,
    max_duration = 500,
    spell_class = "WITHER_MAGE",
    base_casting_time = 30,
    magic_type = "magiclysm_conveyance_magic",
    base_energy_cost = 1200,
    difficulty = 8,
    extra_spells = {
        { spell = "assassin_toxic_smoke", self = true },
        { spell = "assassin_teleport" },
        { spell = "eoc_conveyance_setup", self = true },
    },
}

ccb.content.define_spell {
    id = "life_drain",
    name = ccb.content.text("Life Drain"),
    description = ccb.content.text("This spell takes some of a target's life; part of it comes to you in a less-potent form."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "hostile", "ally" },
    flags = { "RESTORATION_SPELL", "RANDOM_DAMAGE", "LOUD", "VERBAL", "NO_LEGS", "NO_PROJECTILE" },
    min_damage = { handler = "scaled_life_drain_min_damage", fallback = 4.0 },
    max_damage = { handler = "scaled_life_drain_max_damage", fallback = 9.0 },
    min_range = 4,
    max_range = 16,
    range_increment = 0.35,
    damage_type = "necrotic",
    max_level = 35,
    spell_class = "WITHER_MAGE",
    base_casting_time = 300,
    magic_type = "magiclysm_restoration_magic",
    base_energy_cost = 550,
    final_energy_cost = 250,
    energy_increment = -8.6,
    difficulty = 7,
    extra_spells = {
        { spell = "life_drain_stamina", self = true },
        { spell = "eoc_restoration_setup", self = true },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "life_drain_stamina",
    name = ccb.content.text_without_extraction("Life Drain Stamina"),
    description = ccb.content.text_without_extraction("Gives you a bit of stamina.  Subspell; you aren't allowed to see it except in debug mode."),
    effect = "recover_energy",
    effect_data = "STAMINA",
    flags = { "RESTORATION_SPELL" },
    valid_targets = { "self" },
    shape = "blast",
    min_damage = 500,
    max_damage = 2500,
    damage_increment = 60,
    max_level = 35,
    energy_source = "NONE",
}
