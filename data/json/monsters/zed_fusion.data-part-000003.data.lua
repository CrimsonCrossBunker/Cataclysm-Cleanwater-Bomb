local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "CLONE_DAMAGE",
    name = ccb.content.text_without_extraction("Daitya Clone Damage"),
    description = ccb.content.text_without_extraction("Damages daitya when clone is created."),
    message = ccb.content.text("Stale golden light floods the world, and reality stands still."),
    valid_targets = { "self" },
    effect = "attack",
    shape = "blast",
    min_damage = 72,
    max_damage = 72,
    damage_type = "pure",
    flags = { "NO_EXPLOSION_SFX" },
    base_casting_time = 100,
}
