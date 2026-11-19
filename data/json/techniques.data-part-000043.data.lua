local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_leopard_pounce",
    name = ccb.content.text("Leopard Pounce"),
    messages = {
        ccb.content.text("You leap and pounce on %s"),
        ccb.content.text("<npcname> leaps and pounces on %s"),
    },
    unarmed_allowed = true,
    required_buffs_all = { "buff_leopard_oncrit" },
    crit_tec = true,
    down_dur = 1,
    mult_bonuses = {
        { stat = "movecost", scale = 0.8 },
        { stat = "damage", damage_type = "bash", scale = 2.0 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_leopard_pounce",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>identical or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_swordsmanship_ringen",
    name = ccb.content.text("Grab"),
    messages = {
        ccb.content.text("You wrestle %s to the ground"),
        ccb.content.text("<npcname> wrestles %s to the ground"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    required_buffs_all = { "buff_swordsmanship_onpause" },
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 0.5 },
        { stat = "damage", damage_type = "cut", scale = 0.5 },
        { stat = "damage", damage_type = "stab", scale = 0.33 },
    },
    crit_tec = true,
    down_dur = 2,
    attack_vectors = { "vector_null" },
    when = "allow_tec_boxing_counter",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}
