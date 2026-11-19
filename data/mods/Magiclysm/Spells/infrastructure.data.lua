local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "blood_mage_healing",
    name = ccb.content.text_without_extraction("Blood Mage Healing Effect"),
    description = ccb.content.text_without_extraction("Heals the caster."),
    valid_targets = { "self" },
    min_damage = -1,
    max_damage = -1,
    effect = "attack",
    shape = "blast",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "boreal_mage_cold_damage",
    name = ccb.content.text_without_extraction("Boreal Mage Cold Damage"),
    description = ccb.content.text_without_extraction("AoE cold attack around the player.  If you are seeing this spell, you have debugged it in."),
    valid_targets = { "hostile" },
    flags = {
        "SILENT",
        "NO_PROJECTILE",
        "NO_EXPLOSION_SFX",
        "SPLIT_DAMAGE",
        "RANDOM_DAMAGE",
        "RANDOM_DURATION",
    },
    effect = "attack",
    effect_data = "boreal_mage_slow_chilled",
    shape = "blast",
    min_damage = 3,
    max_damage = 10,
    min_aoe = 3,
    max_aoe = 3,
    min_duration = 500,
    max_duration = 600,
    damage_type = "cold",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "FIRE_ELEMENTAL_BURNBACK",
    name = ccb.content.text_without_extraction("Fire Elemental Burnback"),
    description = ccb.content.text_without_extraction("The burnback effect from the Fire Elemental Attunement."),
    effect = "attack",
    shape = "blast",
    min_damage = 5,
    max_damage = 5,
    flags = { "SILENT", "NO_PROJECTILE", "SPLIT_DAMAGE" },
    valid_targets = { "hostile" },
    damage_type = "heat",
    min_range = 2,
    max_range = 2,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "GAIAS_CHOSEN_THORNS",
    name = ccb.content.text_without_extraction("Gaia's Chosen Thorns"),
    description = ccb.content.text_without_extraction("The thorns effect from the Gaia's Chosen Attunement."),
    effect = "attack",
    shape = "blast",
    flags = { "SILENT", "RANDOM_DAMAGE", "SPLIT_DAMAGE" },
    min_damage = 3,
    max_damage = 12,
    valid_targets = { "hostile" },
    damage_type = "cut",
    min_range = 1,
    max_range = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "glacier_mage_attack",
    name = ccb.content.text_without_extraction("Glacier Mage Attack"),
    description = ccb.content.text_without_extraction("Deal some damage to a monster you attack."),
    valid_targets = { "hostile" },
    flags = { "SILENT", "NO_PROJECTILE", "RANDOM_DAMAGE", "RANDOM_DURATION", "NO_EXPLOSION_SFX" },
    effect = "attack",
    effect_data = "ice_age_eff",
    min_range = 1,
    max_range = 1,
    min_damage = 19,
    max_damage = 31,
    min_duration = 150,
    max_duration = 900,
    shape = "blast",
    damage_type = "bash",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "glacier_mage_bash_damage",
    name = ccb.content.text_without_extraction("Glacier Mage Bash AoE"),
    description = ccb.content.text_without_extraction("Deal some bash damage around the player."),
    valid_targets = { "hostile" },
    flags = { "SILENT", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    effect = "attack",
    shape = "blast",
    min_damage = 13,
    max_damage = 13,
    min_aoe = 1,
    max_aoe = 1,
    damage_type = "bash",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "golemancer_block",
    name = ccb.content.text_without_extraction("Golemancer's block"),
    description = ccb.content.text_without_extraction("Block huge damage in the next 1 second."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "golemancer_block",
    shape = "blast",
    flags = { "NO_LEGS", "SILENT", "NO_EXPLOSION_SFX" },
    min_duration = 150,
    max_duration = 150,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "ICE_ELEMENTAL_COLD_DAMAGE",
    name = ccb.content.text_without_extraction("Ice Elemental Cold Damage"),
    description = ccb.content.text_without_extraction("The cold damage effect from the Ice Elemental Attunement."),
    effect = "attack",
    shape = "blast",
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX", "SPLIT_DAMAGE" },
    min_damage = 5,
    max_damage = 5,
    valid_targets = { "hostile" },
    damage_type = "cold",
    min_range = 2,
    max_range = 2,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "permafrost_mage_moves_substract",
    name = ccb.content.text_without_extraction("Permafrost Mage Moves Subtract"),
    description = ccb.content.text_without_extraction("Subtract some moves from monster that attack you."),
    valid_targets = { "hostile" },
    flags = { "SILENT", "RANDOM_DAMAGE", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "mod_moves",
    min_damage = -75,
    max_damage = -225,
    min_range = 2,
    max_range = 2,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "radiation_mage_clairvoyance",
    name = ccb.content.text_without_extraction("Radiation Mage Clairvoyance"),
    description = ccb.content.text_without_extraction("Emit clairvoyance around the player."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "ally", "hostile", "ground", "self" },
    flags = { "SILENT", "IGNORE_WALLS", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    min_aoe = 4,
    max_aoe = 4,
    field = "fd_clairvoyant",
    min_field_intensity = 1,
    max_field_intensity = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mind_read",
    name = ccb.content.text_without_extraction("Mind Reading"),
    description = ccb.content.text_without_extraction("You can predict some movements of your enemies (just slowdown in fact).  If you are seeing this spell, you have debugged it in."),
    valid_targets = { "hostile" },
    flags = { "SILENT", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    effect = "attack",
    shape = "blast",
    effect_data = "mind_reading",
    min_damage = 0,
    max_damage = 0,
    min_duration = 500,
    max_duration = 500,
    min_aoe = 7,
    max_aoe = 7,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "soul_pressure",
    name = ccb.content.text_without_extraction("Soul Pressure"),
    description = ccb.content.text_without_extraction("This is a spell that represents the Soulfire putting a burning pressure on nearby opponents.  If you are seeing this spell, you have debugged it in."),
    valid_targets = { "hostile" },
    flags = { "SILENT", "NO_PROJECTILE", "NO_EXPLOSION_SFX", "SPLIT_DAMAGE" },
    effect = "attack",
    shape = "blast",
    min_damage = 9,
    max_damage = 9,
    min_aoe = 3,
    max_aoe = 3,
    damage_type = "heat",
    sound_description = ccb.content.text("a grunt and a sizzle"),
    sound_id = "fire_spell",
    sound_variant = "weak",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "STORM_ELEMENTAL_ZAPBACK",
    name = ccb.content.text_without_extraction("Storm Elemental Zapback"),
    description = ccb.content.text_without_extraction("The zapback effect from the Storm Elemental Attunement."),
    effect = "attack",
    shape = "blast",
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    min_damage = 5,
    max_damage = 5,
    valid_targets = { "hostile" },
    damage_type = "electric",
    min_range = 2,
    max_range = 2,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "solar_blinding",
    name = ccb.content.text_without_extraction("Solar Blinding"),
    description = ccb.content.text_without_extraction("Make your enemies blind for a short time."),
    valid_targets = { "hostile" },
    flags = { "SILENT", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    effect = "attack",
    effect_data = "blind",
    shape = "blast",
    min_damage = 2,
    max_damage = 2,
    min_range = 1,
    max_range = 1,
    min_duration = 200,
    max_duration = 200,
    damage_type = "pure",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "tundra_mage_aoe",
    name = ccb.content.text_without_extraction("Tundra Mage Slowdown DoT AoE"),
    description = ccb.content.text_without_extraction("Deal some cold DoT around the player, and slowdown monsters nearby."),
    valid_targets = { "hostile" },
    flags = { "SILENT", "NO_PROJECTILE", "NO_EXPLOSION_SFX", "SPLIT_DAMAGE" },
    effect = "attack",
    effect_data = "freeze_aura",
    shape = "blast",
    min_dot = 1,
    max_dot = 1,
    min_duration = 600,
    max_duration = 600,
    min_aoe = 4,
    max_aoe = 4,
    damage_type = "cold",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "void_claws",
    name = ccb.content.text_without_extraction("Void Claws"),
    description = ccb.content.text_without_extraction("This is a spell that causes a DoT effect whenever you hit."),
    valid_targets = { "hostile" },
    flags = { "SILENT", "NO_PROJECTILE", "NO_EXPLOSION_SFX", "SPLIT_DAMAGE" },
    effect = "attack",
    shape = "blast",
    min_dot = 8,
    max_dot = 8,
    min_damage = 3,
    max_damage = 3,
    min_range = 1,
    max_range = 1,
    min_duration = 300,
    max_duration = 300,
    damage_type = "biological",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "wither_mage_withering",
    name = ccb.content.text_without_extraction("Withering"),
    description = ccb.content.text_without_extraction("Give some stats when you attack your enemies."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "withering_eff",
    shape = "blast",
    flags = { "SILENT", "RANDOM_DURATION", "NO_EXPLOSION_SFX" },
    min_duration = 800,
    max_duration = 1600,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "wither_mage_bio_damage",
    name = ccb.content.text_without_extraction("Wither Mage bio DoT AoE"),
    description = ccb.content.text_without_extraction("Deal some toxic DoT around the player."),
    valid_targets = { "hostile" },
    flags = { "SILENT", "NO_PROJECTILE", "NO_EXPLOSION_SFX", "SPLIT_DAMAGE" },
    effect = "attack",
    shape = "blast",
    min_dot = 1,
    max_dot = 1,
    min_duration = 1500,
    max_duration = 1500,
    min_aoe = 4,
    max_aoe = 4,
    damage_type = "biological",
}
