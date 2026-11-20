local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "boann_heal",
    name = ccb.content.text_without_extraction("Boann Heal"),
    description = ccb.content.text_without_extraction("Will heal injuries all over Boann's body."),
    valid_targets = { "self" },
    effect = "attack",
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX", "NO_FAIL", "SILENT" },
    teachable = false,
    shape = "blast",
    base_casting_time = 0,
    min_damage = -300,
    max_damage = -300,
    message = "",
    sound_description = "",
}
