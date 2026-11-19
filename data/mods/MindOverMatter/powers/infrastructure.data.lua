local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teleport_damage_type_blink",
    name = ccb.content.text_without_extraction("[Ψ]Blink"),
    description = ccb.content.text_without_extraction("Blink used by Teleporter damage."),
    message = "",
    teachable = false,
    valid_targets = { "none" },
    skill = "metaphysics",
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_AOE" },
    max_level = 20,
    effect = "short_range_teleport",
    shape = "blast",
    min_aoe = 1,
    max_aoe = 5,
    aoe_increment = 0.25,
    min_range = 5,
    max_range = 15,
    range_increment = 1,
}
