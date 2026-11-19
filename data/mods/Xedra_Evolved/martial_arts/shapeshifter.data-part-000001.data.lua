local ccb = require("ccb")

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
