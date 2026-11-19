local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_perk_fore_stunned",
    name = ccb.content.text("Brutal Swing (Stunned target)"),
    required_char_flags_all = { "MELEE_PERK_FORE" },
    weapon_damage = { { type = "bash", minimum = 15 } },
    melee_allowed = true,
    crit_ok = true,
    knockback_dist = 3,
    weighting = 100,
    messages = {
        ccb.content.text("You send %s reeling with a brutal strike"),
        ccb.content.text("<npcname> sends %s reeling"),
    },
    description = ccb.content.text("Three tile knockback"),
    attack_vectors = { "vector_null" },
    when = "allow_tec_perk_fore_stunned",
}
