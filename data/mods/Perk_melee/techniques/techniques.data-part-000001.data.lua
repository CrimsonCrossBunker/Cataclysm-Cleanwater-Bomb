local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_perk_fore",
    name = ccb.content.text("Brutal Swing"),
    required_char_flags_all = { "MELEE_PERK_FORE" },
    weapon_damage = { { type = "bash", minimum = 15 } },
    melee_allowed = true,
    crit_ok = true,
    knockback_dist = 3,
    weighting = -4,
    messages = {
        ccb.content.text("You send %s reeling with a brutal strike"),
        ccb.content.text("<npcname> sends %s reeling"),
    },
    description = ccb.content.text("Three tile knockback"),
    attack_vectors = { "vector_null" },
}
