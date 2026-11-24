local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_blindness",
    name = ccb.content.text_without_extraction("Death Blinding"),
    description = ccb.content.text_without_extraction("Blinding flash on death."),
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "self", "ally", "hostile", "ground" },
    effect = "attack",
    effect_data = "effect_photokin_blind",
    shape = "blast",
    max_level = 1,
    min_duration = 500,
    max_duration = 500,
    min_aoe = 3,
    max_aoe = 3,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_blind_oneineight",
    name = ccb.content.text_without_extraction("Photokinetic Radical Death"),
    valid_targets = { "ally", "ground", "hostile" },
    description = ccb.content.text_without_extraction("1/4 chance to release a blinding flash."),
    flags = { "WONDER", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "attack",
    min_damage = 0,
    max_damage = 0,
    extra_spells = {
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_blindness", self = true },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_blind_oneinfour",
    name = ccb.content.text_without_extraction("Photokinetic Beacon Death"),
    valid_targets = { "ally", "ground", "hostile" },
    description = ccb.content.text_without_extraction("1/2 chance to release a blinding flash."),
    flags = { "WONDER", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "attack",
    min_damage = 0,
    max_damage = 0,
    extra_spells = {
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_blindness", self = true },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_explosion_oneineight",
    name = ccb.content.text_without_extraction("Pyrokinetic Burner Death"),
    valid_targets = { "ally", "ground", "hostile" },
    description = ccb.content.text_without_extraction("1/4 chance to burst into flames."),
    flags = { "WONDER", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "noise",
    min_damage = 1,
    max_damage = 1,
    extra_spells = {
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_conflagration", self = true },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_explosion_oneinfour",
    name = ccb.content.text_without_extraction("Pyrokinetic Inferno Death"),
    valid_targets = { "ally", "ground", "hostile" },
    description = ccb.content.text_without_extraction("1/2 chance to burst into flames."),
    flags = { "WONDER", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "noise",
    min_damage = 1,
    max_damage = 1,
    extra_spells = {
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_conflagration", self = true },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_telekeinetic_hit_oneinfive",
    name = ccb.content.text_without_extraction("Telekinetic Death"),
    valid_targets = { "ally", "ground", "hostile" },
    description = ccb.content.text_without_extraction("1/5 chance to knock targets down."),
    flags = { "WONDER" },
    shape = "blast",
    effect = "noise",
    min_damage = 1,
    max_damage = 1,
    extra_spells = {
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_knockdown", self = true },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_telekeinetic_hit_oneinthree",
    name = ccb.content.text_without_extraction("Telekinetic Death"),
    valid_targets = { "ally", "ground", "hostile" },
    description = ccb.content.text_without_extraction("1/3 chance to knock targets down."),
    flags = { "WONDER" },
    shape = "blast",
    effect = "noise",
    min_damage = 1,
    max_damage = 1,
    extra_spells = {
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_knockdown", self = true },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_knockdown",
    name = ccb.content.text_without_extraction("Telekinetic Wave"),
    valid_targets = { "ally", "ground", "hostile" },
    description = ccb.content.text_without_extraction("Knocks everyone near the feral telekinetic down."),
    flags = { "NO_EXPLOSION_SFX", "SILENT", "RANDOM_DURATION" },
    shape = "blast",
    effect = "attack",
    effect_data = "downed",
    min_aoe = 6,
    min_duration = 100,
    max_duration = 300,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_psychic_scream",
    name = ccb.content.text_without_extraction("Psychic Scream"),
    valid_targets = { "ally", "ground", "hostile" },
    description = ccb.content.text_without_extraction("Possibly stuns and blinds if the player is near the telepath when they die."),
    flags = { "NO_EXPLOSION_SFX", "SILENT", "IGNORE_WALLS", "PERCENTAGE_DAMAGE" },
    shape = "blast",
    effect = "attack",
    damage_type = "psi_telepathic_damage",
    max_level = 30,
    min_damage = 5,
    max_damage = 15,
    damage_increment = 0.5,
    min_aoe = 1,
    max_aoe = 30,
    aoe_increment = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teleport_summon_monster",
    name = ccb.content.text_without_extraction("[Ψ]Breach Monster"),
    description = ccb.content.text_without_extraction("Summons Nether creatures when the target dies.  It's a bug if you have it."),
    message = ccb.content.text("The air nearby fractures and something comes through!"),
    valid_targets = { "self", "ally", "hostile", "ground" },
    flags = {
        "RANDOM_DAMAGE",
        "RANDOM_AOE",
        "SPAWN_GROUP",
        "PERMANENT",
        "HOSTILE_SUMMON",
        "SPAWN_WITH_DEATH_DROPS",
        "NO_EXPLOSION_SFX",
    },
    effect = "summon",
    effect_data = "GROUP_NETHER_BREACH",
    shape = "blast",
    max_level = 10,
    min_damage = 1,
    max_damage = 3,
    min_range = 3,
    min_aoe = 2,
    max_aoe = 6,
    min_duration = 9999999999999999999,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "delete_nullifying_fields_monster",
    name = ccb.content.text_without_extraction("[Ψ]Delete Nullifying Fields Monster"),
    description = ccb.content.text_without_extraction("This cleans up the nullifying fields after a zombie null dies.  It's a bug if you have it."),
    valid_targets = { "ground", "hostile", "ally", "self" },
    flags = { "SILENT", "NO_EXPLOSION_SFX", "IGNORE_WALLS" },
    effect = "ter_transform",
    effect_data = "ter_null_zombie_delete_fields",
    shape = "blast",
    max_level = 1,
    min_aoe = 12,
    max_aoe = 12,
}
