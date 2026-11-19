local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "MAGIC_CASCADE",
    name = ccb.content.text_without_extraction("Artifact magic cascade"),
    description = ccb.content.text_without_extraction("Fires bursts of low damage ranged attacks."),
    message = ccb.content.text("Burning ash whirls around you."),
    valid_targets = { "self" },
    extra_spells = {
        { spell = "MAGIC_CASCADE_MISSILE" },
        { spell = "MAGIC_CASCADE_MISSILE" },
        { spell = "MAGIC_CASCADE_MISSILE" },
    },
    effect = "attack",
    shape = "blast",
    flags = { "NO_EXPLOSION_SFX" },
    base_casting_time = 100,
}
