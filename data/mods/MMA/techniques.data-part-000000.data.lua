local ccb = require("ccb")

ccb.content.define_technique {
    id = "mma_tec_desert_wind_strike",
    name = ccb.content.text("Burning Blade"),
    messages = {
        ccb.content.text("You unleash a fiery attack against %s"),
        ccb.content.text("<npcname> unleash a fiery attack against %s"),
    },
    melee_allowed = true,
    flat_bonuses = { { stat = "damage", damage_type = "heat", scale = 3.0 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_desert_wind_crit",
    name = ccb.content.text("Inferno Blade"),
    messages = {
        ccb.content.text("You strike %s with powerful inferno"),
        ccb.content.text("<npcname> strikes %s with powerful inferno"),
    },
    skills = { { id = "melee", level = 1 } },
    melee_allowed = true,
    crit_tec = true,
    flat_bonuses = { { stat = "damage", damage_type = "heat", scale = 7.0 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_desert_wind_impale",
    name = ccb.content.text("Firesnake"),
    messages = {
        ccb.content.text("You strike through %s with a snaking flame"),
        ccb.content.text("<npcname> strikes through %s with a snaking flame"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    crit_ok = true,
    aoe = "impale",
    flat_bonuses = { { stat = "damage", damage_type = "heat", scale = 7.0 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_desert_wind_spin",
    name = ccb.content.text("Ring of Fire"),
    messages = {
        ccb.content.text("You become a flaming blur as you strike %s and those around you"),
        ccb.content.text("<npcname> becomes a flaming blur as they strike %s and those around them"),
    },
    skills = { { id = "melee", level = 5 } },
    melee_allowed = true,
    crit_tec = true,
    aoe = "spin",
    flat_bonuses = { { stat = "damage", damage_type = "heat", scale = 10.0 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_desert_wind_wide",
    name = ccb.content.text("Flashing Sun"),
    messages = {
        ccb.content.text("You carve an arc through %s and those nearby"),
        ccb.content.text("<npcname> carve an arc through %s and those nearby"),
    },
    skills = { { id = "melee", level = 2 } },
    melee_allowed = true,
    aoe = "wide",
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_diamond_mind_strike",
    name = ccb.content.text("Insightful Strike"),
    messages = {
        ccb.content.text("You spot %s's weakpoint and strike"),
        ccb.content.text("<npcname> spot %s's weakpoint and strike"),
    },
    skills = { { id = "melee", level = 1 } },
    melee_allowed = true,
    flat_bonuses = { { stat = "damage", damage_type = "stab", scaling_stat = "int", scale = 0.5 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_diamond_mind_crit",
    name = ccb.content.text("Greater Insightful Strike"),
    messages = {
        ccb.content.text("You spot %s's weakpoint and strike"),
        ccb.content.text("<npcname> spot %s's weakpoint and strike"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    crit_tec = true,
    flat_bonuses = { { stat = "damage", damage_type = "stab", scaling_stat = "int", scale = 1.0 } },
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_hylian_spin",
    name = ccb.content.text("Spin Attack"),
    messages = {
        ccb.content.text("You unleash a spin attack against %s and those nearby"),
        ccb.content.text("<npcname> unleashes a spin attack against %s and those nearby"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    required_buffs_any = { "mma_buff_hylian_onpause", "mma_buff_hylian_spin" },
    crit_ok = true,
    aoe = "spin",
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_hylian_wide",
    name = ccb.content.text("Spin Attack"),
    messages = {
        ccb.content.text("You unleash a spin attack against %s and those nearby"),
        ccb.content.text("<npcname> unleashes a spin attack against %s and those nearby"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    required_buffs_any = { "mma_buff_hylian_onpause", "mma_buff_hylian_spin" },
    crit_ok = true,
    aoe = "wide",
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "mma_tec_iron_heart_disarm",
    name = ccb.content.text("Disarming Strike"),
    messages = {
        ccb.content.text("You skillfully disarm %s"),
        ccb.content.text("<npcname> skillfully disarms %s"),
    },
    unarmed_allowed = true,
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
    id = "mma_tec_iron_heart_feint",
    name = ccb.content.text("Lightning Recovery"),
    messages = {
        ccb.content.text("You miss %s but recover in the blink of an eye"),
        ccb.content.text("<npcname> misses %s but recovers in the blink of an eye"),
    },
    skills = { { id = "melee", level = 1 } },
    melee_allowed = true,
    defensive = true,
    miss_recovery = true,
    attack_vectors = { "vector_null" },
}
