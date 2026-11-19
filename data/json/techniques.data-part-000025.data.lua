local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_dragon_tail",
    name = ccb.content.text("Dragon Tail"),
    messages = {
        ccb.content.text("You sweep %s with a quick Dragon Tail"),
        ccb.content.text("<npcname> sweeps %s with a quick Dragon Tail sweep"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    crit_tec = true,
    down_dur = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.4 },
        { stat = "damage", damage_type = "cut", scale = 1.4 },
        { stat = "damage", damage_type = "stab", scale = 1.4 },
    },
    attack_vectors = { "vector_foot_heel" },
    when = "allow_tec_brawl_trip",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar</info> size"),
}

ccb.content.define_technique {
    id = "tec_dragon_strike",
    name = ccb.content.text("Dragon Strike"),
    messages = {
        ccb.content.text("You descend upon %s with a powerful Dragon Strike"),
        ccb.content.text("<npcname> descends upon %s with a powerful Dragon Strike"),
    },
    skills = { { id = "unarmed", level = 5 } },
    unarmed_allowed = true,
    crit_tec = true,
    stun_dur = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.5 },
        { stat = "damage", damage_type = "cut", scale = 1.5 },
        { stat = "damage", damage_type = "stab", scale = 1.5 },
    },
    attack_vectors = {
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
    },
    when = "allow_tec_dragon_strike",
    condition_description = ccb.content.text("* Only works on a <info>downed</info> target"),
}
