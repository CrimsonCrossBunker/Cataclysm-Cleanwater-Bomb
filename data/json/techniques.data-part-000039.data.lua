local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_krav_maga_crit",
    name = ccb.content.text("Cheap Shot"),
    messages = {
        ccb.content.text("You hit %s where it hurts"),
        ccb.content.text("<npcname> hits %s with a cheap shot"),
    },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    unarmed_allowed = true,
    crit_tec = true,
    weighting = 2,
    stun_dur = 1,
    attack_vectors = {
        "vector_null",
        "vector_headbutt",
        "vector_punch",
        "vector_slime_punch",
        "vector_paw_rat_punch",
        "vector_little_paw_punch",
        "vector_elbow",
        "vector_foot_toes",
        "vector_hoof_kick",
        "vector_avian_talons",
        "vector_digitigrade_paws",
        "vector_shin",
        "vector_knee",
    },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_krav_maga_takedown",
    name = ccb.content.text("Takedown"),
    messages = {
        ccb.content.text("You force %s to the ground"),
        ccb.content.text("<npcname> forces %s to the ground"),
    },
    skills = { { id = "unarmed", level = 3 } },
    melee_allowed = true,
    unarmed_allowed = true,
    crit_ok = true,
    weighting = 2,
    down_dur = 1,
    attack_vectors = { "vector_grasp" },
    when = "allow_tec_boxing_counter",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_krav_maga_disarm",
    name = ccb.content.text("Bone Breaker"),
    messages = {
        ccb.content.text("*CRACK!* You brutally maim %s's arm"),
        ccb.content.text("*CRACK!* <npcname> brutally maims %s's arm"),
    },
    skills = { { id = "unarmed", level = 5 } },
    unarmed_allowed = true,
    weighting = 3,
    crit_tec = true,
    effects = {
        {
            id = "maimed_arm",
            chance = 100,
            duration_turns = 44000,
            on_damage = true,
            message = ccb.content.text("The arm of %s is mangled beyond recognition!"),
        },
    },
    flat_bonuses = { { stat = "arpen", damage_type = "bash", scaling_stat = "str", scale = 1.0 } },
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 2.0 } },
    attack_vectors = { "vector_arm_grapple" },
    when = "allow_tec_krav_maga_disarm",
    condition_description = ccb.content.text("* Only works on a <info>downed</info> and <info>stunned</info> humanoid target"),
}
