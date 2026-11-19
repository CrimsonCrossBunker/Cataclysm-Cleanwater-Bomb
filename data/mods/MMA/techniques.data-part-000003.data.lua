local ccb = require("ccb")

ccb.content.define_technique {
    id = "mma_tec_shii_cho_disarm",
    name = ccb.content.text("Disarming Slash"),
    messages = {
        ccb.content.text("You disarm %s with a quick flick of your weapon"),
        ccb.content.text("<npcname> disarms %s with a quick flick of their weapon"),
    },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    crit_ok = true,
    disarms = true,
    effects = {
        {
            id = "disarmed",
            chance = 100,
            duration_turns = 400,
            on_damage = true,
            message = ccb.content.text("The weapon of %s has been forced out of their hands!"),
        },
    },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_shii_cho_wide",
    name = ccb.content.text("Sarlacc Sweep"),
    messages = {
        ccb.content.text("You quickly sweep through %s and those nearby"),
        ccb.content.text("<npcname> quickly sweeps through %s and those nearby"),
    },
    skills = { { id = "melee", level = 5 } },
    melee_allowed = true,
    crit_ok = true,
    aoe = "wide",
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_stone_dragon_hammer",
    name = ccb.content.text("Mountain Hammer"),
    messages = {
        ccb.content.text("You crush %s with the weight of your Mountain Hammer"),
        ccb.content.text("<npcname> crushes %s with the weight of their Mountain Hammer"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    unarmed_allowed = true,
    flat_bonuses = {
        { stat = "arpen", damage_type = "bash", scaling_stat = "str", scale = 0.5 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "str", scale = 0.5 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "str", scale = 0.5 },
    },
    attack_vectors = { "vector_null", "vector_wrist" },
}
