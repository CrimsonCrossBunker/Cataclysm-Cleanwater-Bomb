local ccb = require("ccb")

ccb.content.define_technique {
    id = "CLAWS_SHAPESHIFTER",
    name = ccb.content.text("Claw Slash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You slash at %s with your claws"),
        ccb.content.text("<npcname> slashes at %s with their claws"),
    },
    unarmed_allowed = true,
    weighting = 3,
    reach_ok = false,
    attack_vectors = { "vector_punch" },
    flat_bonuses = {
        { stat = "damage", damage_type = "cut", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
}

ccb.content.define_technique {
    id = "CLAWS_SHAPESHIFTER_RENDING",
    name = ccb.content.text("Claw Rending Slash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You slash %s, tearing open bleeding wounds"),
        ccb.content.text("<npcname> slashes %s, tearing open bleeding wounds"),
    },
    unarmed_allowed = true,
    weighting = 0,
    crit_ok = true,
    reach_ok = false,
    attack_vectors = { "vector_punch" },
    effects = {
        {
            id = "bleed",
            chance = 100,
            duration_turns = 600,
            on_damage = true,
            message = ccb.content.text("%s is bleeding!"),
        },
    },
    flat_bonuses = {
        { stat = "damage", damage_type = "cut", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
}

ccb.content.define_technique {
    id = "CLAWS_SHAPESHIFTER_REDHANDED_RAGE_KNOCKBACK",
    name = ccb.content.text("Red-Handed Rage Claw Knockback"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You slash %s with a brutal strike, knocking them to the ground"),
        ccb.content.text("<npcname> slashes %swith a brutal strike, knocking them to the ground"),
    },
    unarmed_allowed = true,
    weighting = 1,
    crit_ok = true,
    reach_ok = false,
    attack_vectors = { "vector_punch" },
    knockback_dist = 1,
    knockback_spread = 1,
    knockback_follow = true,
    down_dur = 2,
    flat_bonuses = {
        { stat = "damage", damage_type = "cut", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_claws_shapeshifter_redhanded_rage_knockback",
    condition_description = ccb.content.text("Needs X"),
}

ccb.content.define_technique {
    id = "CLAWS_SHAPESHIFTER_REDHANDED_RAGE_AOE_SLASH",
    name = ccb.content.text("Red-Handed Rage Claw AoE"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You slash %s in a wide arc, hitting multiple target"),
        ccb.content.text("<npcname> slashes %s in a wide arc, hitting multiple targets"),
    },
    unarmed_allowed = true,
    weighting = 1,
    crit_ok = true,
    reach_ok = false,
    attack_vectors = { "vector_punch" },
    aoe = "spin",
    flat_bonuses = {
        { stat = "damage", damage_type = "cut", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_claws_shapeshifter_redhanded_rage_aoe_slash",
}

ccb.content.define_technique {
    id = "CLAWS_SHAPESHIFTER_CRIT",
    name = ccb.content.text("Critical Claw Slash"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You brutally slash %s with your claws"),
        ccb.content.text("<npcname> brutally slashes to %s with their claws"),
    },
    unarmed_allowed = true,
    reach_ok = false,
    crit_ok = true,
    crit_tec = true,
    attack_vectors = { "vector_punch" },
    flat_bonuses = {
        { stat = "damage", damage_type = "cut", scaling_stat = "unarmed", scale = 4.4 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.24 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "unarmed", scale = 1 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "unarmed", scale = 1 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
}

-- Separate to avoid Natural Stance requirement
ccb.content.define_technique {
    id = "FANGS_BITE_SHAPESHIFTER",
    name = ccb.content.text("Fang Bite"),
    melee_allowed = true,
    messages = { ccb.content.text("You bite %s"), ccb.content.text("<npcname> bites %s") },
    unarmed_allowed = true,
    weighting = 2,
    reach_ok = false,
    attack_vectors = { "vector_bite" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
}

ccb.content.define_technique {
    id = "FANGS_BITE_SHAPESHIFTER_CRIT",
    name = ccb.content.text("Critical Fang Bite"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You deliver a wicked bite to %s"),
        ccb.content.text("<npcname> delivers a wicked bite to %s"),
    },
    unarmed_allowed = true,
    reach_ok = false,
    crit_tec = true,
    attack_vectors = { "vector_bite" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 4.4 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.24 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "unarmed", scale = 1 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "unarmed", scale = 1 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
}

-- Separate from above for the higher weight
ccb.content.define_technique {
    id = "FANGS_BITE_SHAPESHIFTER_WOLF_FORM",
    name = ccb.content.text("Fang Bite"),
    melee_allowed = true,
    messages = { ccb.content.text("You bite %s"), ccb.content.text("<npcname> bites %s") },
    unarmed_allowed = true,
    weighting = 6,
    reach_ok = false,
    attack_vectors = { "vector_bite" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 1.0 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.06 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
}

ccb.content.define_technique {
    id = "FANGS_BITE_SHAPESHIFTER_WOLF_CRIT",
    name = ccb.content.text("Critical Fang Bite"),
    melee_allowed = true,
    messages = {
        ccb.content.text("You deliver a wicked bite to %s"),
        ccb.content.text("<npcname> delivers a wicked bite to %s"),
    },
    unarmed_allowed = true,
    reach_ok = false,
    crit_tec = true,
    attack_vectors = { "vector_bite" },
    flat_bonuses = {
        { stat = "damage", damage_type = "stab", scaling_stat = "unarmed", scale = 4.4 },
        { stat = "damage", damage_type = "bash", scaling_stat = "str", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 0.24 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "unarmed", scale = 1 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "unarmed", scale = 1 },
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
}
