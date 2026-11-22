local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mom_abjuration_stone_effects_psi_disruption",
    name = ccb.content.text_without_extraction("Abjuration Stone Psi Disruption"),
    description = ccb.content.text_without_extraction("Part of the Abjuration Stone that disrupts psi powers.  It's a bug if you have it."),
    teachable = false,
    valid_targets = { "self", "hostile", "ally" },
    flags = { "SILENT", "RANDOM_DURATION", "RANDOM_AOE", "NO_EXPLOSION_SFX" },
    effect = "attack",
    effect_data = "effect_psi_neutralized",
    shape = "blast",
    min_duration = 600,
    max_duration = 1800,
    min_aoe = 20,
    max_aoe = 25,
}

ccb.content.define_spell {
    id = "mom_abjuration_stone_effects",
    shape = "blast",
    name = ccb.content.text_without_extraction("Abjuration Stone Banishment"),
    description = ccb.content.text_without_extraction("Part of the Abjuration Stone that banishes Nether monsters.  It's a bug if you have it."),
    teachable = false,
    flags = { "SILENT", "RANDOM_DAMAGE", "RANDOM_AOE", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile", "ally" },
    targeted_species = { "NETHER", "NETHER_EMANATION", "NETHER_BURROWING" },
    min_aoe = 15,
    max_aoe = 25,
    impact_handler = "w16b_sp_imp_mindovermatter_490a29d2fa22",
    extra_spells = {
        {
            spell = "mom_abjuration_stone_effects_psi_disruption",
            self = true,
        },
    },
}
