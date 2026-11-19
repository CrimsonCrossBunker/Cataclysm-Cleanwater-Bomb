local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "cold_snap_freeze",
    name = ccb.content.text_without_extraction("Cold Snap Freeze"),
    description = ccb.content.text_without_extraction("Freezes the target monster in place."),
    effect = "mod_moves",
    shape = "blast",
    max_level = 35,
    min_damage = -50,
    max_damage = -400,
    damage_increment = -10,
    valid_targets = { "hostile" },
    flags = { "EVOCATION_SPELL", "SILENT" },
}

ccb.content.define_spell {
    id = "summon_winter_wolf",
    name = ccb.content.text("Winter Wolf's Call"),
    description = ccb.content.text("Summon your personal pack of winter wolves to freeze and maul your foes."),
    valid_targets = { "ground" },
    min_damage = 1,
    max_damage = 3,
    damage_increment = 0.08,
    max_level = 35,
    difficulty = 7,
    spell_class = "TUNDRA_MAGE",
    effect = "summon",
    effect_data = "mon_winter_wolf",
    extra_spells = { { spell = "eoc_summon_setup", self = true } },
    shape = "blast",
    magic_type = "magiclysm_conjuration_magic",
    base_energy_cost = 600,
    base_casting_time = 300,
    min_range = 5,
    max_range = 7,
    range_increment = 0.2,
    min_aoe = 2,
    max_aoe = 2,
    flags = {
        "CONJURATION_SPELL",
        "SOMATIC",
        "VERBAL",
        "CONCENTRATE",
        "MUST_HAVE_CLASS_TO_LEARN",
        "NO_CORPSE_QUIET",
    },
    min_duration = 36000,
    max_duration = 180000,
    duration_increment = 5000,
}
