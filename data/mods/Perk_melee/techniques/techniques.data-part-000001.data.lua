local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_perk_stagger_strike",
    name = ccb.content.text("Staggering Strike"),
    weapon_damage = { { type = "bash", minimum = 12 } },
    melee_allowed = true,
    crit_ok = true,
    stun_dur = 3,
    weighting = 1,
    required_char_flags_all = { "MELEE_PERK_STAGGER_STRIKE" },
    messages = {
        ccb.content.text("You deliver a stunning strike to %s"),
        ccb.content.text("<npcname> delivers a stunning strike to %s"),
    },
    description = ccb.content.text("Stun for 1 turn"),
    attack_vectors = { "vector_null" },
    mult_bonuses = { { stat = "movecost", scale = 0.5 } },
    when = "allow_tec_perk_stagger_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned</info> target of <info>similar or smaller</info> size."),
}
