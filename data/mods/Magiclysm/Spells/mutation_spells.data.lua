local ccb = require("ccb")

ccb.content.define_spell {
    id = "spell_ravenfolk_leap",
    name = ccb.content.text("Wing Leap"),
    description = ccb.content.text("You launch yourself into a powerful wing-assisted leap."),
    valid_targets = { "ground" },
    flags = { "SILENT", "NO_LEGS", "NO_HANDS", "NO_EXPLOSION_SFX" },
    effect = "dash",
    shape = "cone",
    min_damage = 0,
    max_damage = 0,
    damage_type = "bash",
    min_range = 6,
    max_range = 6,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_ravenfolk_screech",
    name = ccb.content.text_without_extraction("Ravenfolk Screech"),
    description = ccb.content.text_without_extraction("You let out a loud raven's cry."),
    message = "",
    valid_targets = { "ground" },
    flags = { "SILENT", "NO_LEGS", "NO_HANDS", "NO_EXPLOSION_SFX" },
    effect = "noise",
    shape = "blast",
    min_damage = 30,
    max_damage = 30,
    damage_type = "bash",
}
