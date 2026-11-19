local ccb = require("ccb")

-- Heart Strike.  Alita's signature attack.
ccb.content.define_technique {
    id = "mma_tec_panzer_precise",
    name = ccb.content.text("Herzschlag"),
    messages = {
        ccb.content.text("You hit %s with a powerful vibro-punch"),
        ccb.content.text("<npcname> hits %s with a powerful vibro-punch"),
    },
    skills = { { id = "unarmed", level = 5 } },
    melee_allowed = true,
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    flat_bonuses = {
        { stat = "arpen", damage_type = "bash", scaling_stat = "per", scale = 1.0 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "per", scale = 1.0 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "per", scale = 1.0 },
    },
    mult_bonuses = {
        { stat = "movecost", scale = 1.2 },
        { stat = "damage", damage_type = "bash", scale = 1.5 },
        { stat = "damage", damage_type = "cut", scale = 1.5 },
        { stat = "damage", damage_type = "stab", scale = 1.5 },
    },
    attack_vectors = {
        "vector_null",
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}
