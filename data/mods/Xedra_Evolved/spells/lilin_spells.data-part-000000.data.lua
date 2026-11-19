local ccb = require("ccb")

ccb.content.define_spell {
    id = "lilin_strix_leap_spell",
    name = ccb.content.text("Strix Leap"),
    description = ccb.content.text("You squat down, build up tension in your legs, then with a mighty beat of your wings, you leap."),
    message = "",
    valid_targets = { "ground" },
    flags = { "SILENT", "NO_LEGS", "NO_HANDS", "NO_EXPLOSION_SFX" },
    teachable = false,
    skill = "deduction",
    effect = "dash",
    shape = "cone",
    min_damage = 0,
    max_damage = 0,
    damage_increment = 0,
    damage_type = "bash",
    min_range = 5,
    max_range = 5,
}
