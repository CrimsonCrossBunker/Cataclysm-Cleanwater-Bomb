local ccb = require("ccb")

ccb.content.define_spell {
    id = "afs_electrokin_zap_attacked",
    shape = "blast",
    effect = "attack",
    damage_type = "electric",
    name = ccb.content.text_without_extraction("Electrokinetic aura thorns"),
    description = ccb.content.text_without_extraction("Do electrical damage to a monster that attacked you.  If you have this directly its a bug."),
    flags = { "RANDOM_DAMAGE" },
    valid_targets = { "hostile" },
    min_damage = { handler = "wave14a_aftershock_exoplanet_stat_8", fallback = 0 },
    max_damage = { handler = "wave14a_aftershock_exoplanet_stat_9", fallback = 0 },
    min_range = 1,
    max_range = 1,
}
