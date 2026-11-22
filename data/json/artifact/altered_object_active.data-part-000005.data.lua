local ccb = require("ccb")

ccb.content.define_spell {
    id = "MAGIC_CASCADE_MISSILE",
    shape = "blast",
    effect = "attack",
    field = "fd_plasma",
    damage_type = "bash",
    name = ccb.content.text_without_extraction("Magic cascade Missile"),
    description = ccb.content.text_without_extraction("A single attack from magic cascade."),
    message = "",
    flags = { "LOUD", "RANDOM_TARGET", "RANDOM_CRITTER", "RANDOM_DAMAGE" },
    valid_targets = { "hostile", "ally" },
    field_chance = 2,
    min_field_intensity = 3,
    max_field_intensity = 3,
    min_damage = { handler = "wave14a_dda_stat_5", fallback = 0 },
    max_damage = { handler = "wave14a_dda_stat_6", fallback = 0 },
    min_range = 40,
    max_range = 6,
    base_casting_time = 100,
}
