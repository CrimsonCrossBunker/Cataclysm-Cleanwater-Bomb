local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "xedra_eater_erosion_attack",
    name = ccb.content.text_without_extraction("Erosion - Attack"),
    description = ccb.content.text_without_extraction("This causes the dot when attacking targets with the erosion buff.  Having the spell is a bug."),
    valid_targets = { "hostile" },
    flags = { "SILENT", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    effect = "attack",
    shape = "blast",
    min_dot = { handler = "scaled_xedra_eater_erosion_attack_min_dot", fallback = 1.0 },
    max_dot = { handler = "scaled_xedra_eater_erosion_attack_min_dot", fallback = 1.0 },
    min_range = 1,
    max_range = 1,
    min_duration = { handler = "scaled_xedra_eater_erosion_attack_min_duration", fallback = 0.0 },
    max_duration = { handler = "scaled_xedra_eater_erosion_attack_min_duration", fallback = 0.0 },
    damage_type = "biological",
}
