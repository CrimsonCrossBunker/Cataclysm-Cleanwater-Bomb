local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "xe_nether_sorcery_summoning_successful_control",
    name = ccb.content.text_without_extraction("Control Summon"),
    description = ccb.content.text_without_extraction("This spell is used if the summoning control is successful."),
    message = "",
    valid_targets = { "ground", "ally", "hostile" },
    flags = { "SILENT" },
    spell_class = "XE_NETHER_SORCERY",
    magic_type = "xe_nether_sorcery",
    effect = "charm_monster",
    shape = "blast",
    energy_source = "STAMINA",
    max_level = 15,
    difficulty = 60,
    skill = "magic",
    min_aoe = 3,
    max_aoe = 3,
    min_damage = 10000,
    max_damage = 10000,
    min_range = 40,
    max_range = 40,
    min_duration = 7200000,
    max_duration = 14400000,
    duration_increment = 720000,
    targeted_species = { "SUMMONED_CREATURE" },
}
