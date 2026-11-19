local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teleport_blink_real",
    copy_from = "teleport_blink",
    name = ccb.content.text_without_extraction("[Ψ]Blink Real"),
    description = ccb.content.text_without_extraction("The actual spell that blinks you.  You should not see this"),
    message = "",
    valid_targets = { "none" },
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_AOE" },
    effect = "short_range_teleport",
    min_aoe = 1,
    max_aoe = 5,
    min_range = 5,
    max_range = 15,
    range_increment = 1,
}
