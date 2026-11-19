local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "constructed_hammer_attack",
    name = ccb.content.text_without_extraction("Smash A Target"),
    description = ccb.content.text_without_extraction("Deal some damage.  You can't see it except in debug mode."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "hostile", "ground" },
    flags = { "SILENT", "IGNORE_WALLS", "NO_EXPLOSION_SFX", "RANDOM_DAMAGE" },
    min_damage = 360,
    max_damage = 500,
    min_bash_scaling = 1,
    max_bash_scaling = 1,
    min_range = 1,
    max_range = 1,
    message = "",
    damage_type = "bash",
    sound_description = ccb.content.text("a smash"),
}
