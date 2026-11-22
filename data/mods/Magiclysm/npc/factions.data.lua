local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "MARK_FOR_DEATH_VALZAIN",
    player_display = false,
    name = ccb.content.text_without_extraction("Forge Lord Wrath"),
    points = 0,
    description = ccb.content.text_without_extraction("Makes sure all the Forge Lord mobs shoot you on sight."),
    valid = false,
    purifiable = false,
    species_anger = { FORGE_LORD = 95 },
}

ccb.content.define_spell {
    id = "SPELL_FORGE_LOCKDOWN",
    shape = "blast",
    name = ccb.content.text_without_extraction("SPELL_FORGE_LOCKDOWN"),
    description = ccb.content.text_without_extraction("SPELL_FORGE_LOCKDOWN"),
    flags = { "SILENT", "NO_EXPLOSION_SFX", "NO_PROJECTILE", "NO_FAIL", "IGNORE_WALLS" },
    valid_targets = { "hostile", "ally", "ground" },
    min_range = 50,
    max_range = 50,
    impact_handler = "w16b_sp_imp_magiclysm_a843d3eb9713",
    extra_spells = {
        { spell = "summon_forgehounds" },
    },
}
