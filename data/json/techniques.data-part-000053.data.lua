local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_pankration_grabknee",
    name = ccb.content.text("Grab and Knee"),
    messages = { ccb.content.text("You grab and knee %s"), ccb.content.text("<npcname> grabs and knees %s") },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    weighting = 3,
    mult_bonuses = { { stat = "movecost", scale = 0.5 } },
    attack_vectors = { "vector_knee" },
    when = "allow_tec_dragon_strike",
    condition_description = ccb.content.text("* Only works on a <info>downed</info> target"),
}

ccb.content.define_technique {
    id = "tec_pankration_grabdisarm",
    name = ccb.content.text("Arm Lock"),
    messages = {
        ccb.content.text("You disarm %s with an arm lock"),
        ccb.content.text("<npcname> disarms %s with an arm lock"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    crit_ok = true,
    weighting = 3,
    disarms = true,
    effects = {
        {
            id = "disarmed",
            chance = 100,
            duration_turns = 400,
            on_damage = true,
            message = ccb.content.text("The hand of %s is forced open!"),
        },
    },
    flat_bonuses = { { stat = "arpen", damage_type = "bash", scaling_stat = "str", scale = 1.0 } },
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 1.25 } },
    attack_vectors = { "vector_arm_grapple" },
    when = "allow_tec_dragon_strike",
    condition_description = ccb.content.text("* Only works on a <info>downed</info> target"),
}

-- Humanoids of similar size
ccb.content.define_technique {
    id = "tec_pankration_grabthrow",
    name = ccb.content.text("Grab and Throw"),
    messages = { ccb.content.text("You grab and throw %s"), ccb.content.text("<npcname> grabs and throws %s") },
    skills = { { id = "unarmed", level = 5 } },
    unarmed_allowed = true,
    weighting = 3,
    crit_tec = true,
    down_dur = 2,
    knockback_dist = 2,
    knockback_spread = 2,
    mult_bonuses = { { stat = "damage", damage_type = "bash", scale = 2.0 } },
    attack_vectors = { "vector_grasp" },
    when = "allow_tec_aikido_blockthrow",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size, may fail on targets <info>grabbing you</info>"),
}

ccb.content.define_technique {
    id = "tec_silat_hamstring",
    name = ccb.content.text("Hamstring"),
    messages = {
        ccb.content.text("You ground %s with a low blow"),
        ccb.content.text("<npcname> grounds %s with a low blow"),
    },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    crit_tec = true,
    down_dur = 2,
    attack_vectors = { "vector_null" },
    when = "allow_tec_boxing_counter",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_silat_precise",
    name = ccb.content.text("Vicious Precision"),
    messages = {
        ccb.content.text("You viciously wound %s"),
        ccb.content.text("<npcname> viciously wounds %s"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    crit_ok = true,
    weighting = 2,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.33 },
        { stat = "damage", damage_type = "cut", scale = 1.33 },
        { stat = "damage", damage_type = "stab", scale = 1.33 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_tec_dragon_strike",
    condition_description = ccb.content.text("* Only works on a <info>downed</info> target"),
}

ccb.content.define_technique {
    id = "tec_silat_dirty",
    name = ccb.content.text("Dirty Hit"),
    messages = {
        ccb.content.text("You hit %s with a dirty blow"),
        ccb.content.text("<npcname> delivers a dirty blow to %s"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    crit_tec = true,
    stun_dur = 2,
    attack_vectors = { "vector_null" },
    when = "allow_tec_crane_strike",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size"),
}

ccb.content.define_technique {
    id = "tec_silat_brutal",
    name = ccb.content.text("Silat Brutality"),
    messages = {
        ccb.content.text("You brutally tear into %s"),
        ccb.content.text("<npcname> brutally tears into %s"),
    },
    skills = { { id = "melee", level = 5 } },
    melee_allowed = true,
    crit_ok = true,
    weighting = 2,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.33 },
        { stat = "damage", damage_type = "cut", scale = 1.33 },
        { stat = "damage", damage_type = "stab", scale = 1.33 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_tec_venom_snake_tail",
    condition_description = ccb.content.text("* Only works on a <info>stunned</info> target"),
}
