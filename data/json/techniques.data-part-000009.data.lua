local ccb = require("ccb")

-- Humanoids of similar size
ccb.content.define_technique {
    id = "tec_precise",
    name = ccb.content.text("Precise Strike"),
    melee_allowed = true,
    crit_tec = true,
    messages = { ccb.content.text("You jab deftly at %s"), ccb.content.text("<npcname> jabs deftly at %s") },
    stun_dur = 2,
    attack_vectors = { "vector_null" },
    when = "allow_tec_precise",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned humanoid</info> target of <info>similar or smaller</info> size"),
}

-- Humanoids of similar size
ccb.content.define_technique {
    id = "tec_aikido_blockthrow",
    name = ccb.content.text("Counter Throw (block)"),
    messages = {
        ccb.content.text("You smoothly throw %s"),
        ccb.content.text("<npcname> blocks and smoothly throws %s"),
    },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    melee_allowed = true,
    required_buffs_all = { "buff_aikido_onblock" },
    crit_ok = true,
    down_dur = 1,
    knockback_dist = 1,
    mult_bonuses = { { stat = "movecost", scale = 0.7 } },
    attack_vectors = { "vector_grasp" },
    when = "allow_tec_aikido_blockthrow",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size, may fail on targets <info>grabbing you</info>"),
}

-- Humanoids of similar size
ccb.content.define_technique {
    id = "tec_aikido_dodgethrow",
    name = ccb.content.text("Counter Throw (dodge)"),
    messages = {
        ccb.content.text("You smoothly throw %s"),
        ccb.content.text("<npcname> dodges and smoothly throws %s"),
    },
    unarmed_allowed = true,
    melee_allowed = true,
    required_buffs_all = { "buff_aikido_ondodge" },
    crit_ok = true,
    down_dur = 1,
    knockback_dist = 1,
    mult_bonuses = { { stat = "movecost", scale = 0.7 } },
    attack_vectors = { "vector_grasp" },
    when = "allow_tec_aikido_blockthrow",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size, may fail on targets <info>grabbing you</info>"),
}

-- Humanoids of similar size
ccb.content.define_technique {
    id = "tec_aikido_blockdisarm",
    name = ccb.content.text("Disarming Throw (block)"),
    messages = {
        ccb.content.text("You smoothly disarm %s"),
        ccb.content.text("<npcname> blocks and smoothly disarms %s"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    melee_allowed = true,
    required_buffs_all = { "buff_aikido_onblock" },
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
    down_dur = 1,
    knockback_dist = 1,
    mult_bonuses = { { stat = "movecost", scale = 0.7 } },
    attack_vectors = { "vector_grasp" },
    when = "allow_tec_aikido_blockthrow",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size, may fail on targets <info>grabbing you</info>"),
}

-- Humanoids of similar size
ccb.content.define_technique {
    id = "tec_aikido_dodgedisarm",
    name = ccb.content.text("Disarming Throw (dodge)"),
    messages = {
        ccb.content.text("You smoothly disarm %s"),
        ccb.content.text("<npcname> dodges and smoothly disarms %s"),
    },
    skills = { { id = "unarmed", level = 4 } },
    unarmed_allowed = true,
    melee_allowed = true,
    required_buffs_all = { "buff_aikido_ondodge" },
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
    down_dur = 1,
    knockback_dist = 1,
    mult_bonuses = { { stat = "movecost", scale = 0.7 } },
    attack_vectors = { "vector_grasp" },
    when = "allow_tec_aikido_blockthrow",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size, may fail on targets <info>grabbing you</info>"),
}
