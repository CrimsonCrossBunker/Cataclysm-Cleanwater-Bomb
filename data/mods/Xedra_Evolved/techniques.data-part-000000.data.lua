local ccb = require("ccb")

-- NO_I18N
ccb.content.define_technique {
    id = "tec_devil_tail_puncture",
    name = ccb.content.text_without_extraction("TAIL_SHOT"),
    messages = {
        ccb.content.text("Your devil tail shoots itself into %s, penetrating its body like a bullet"),
        ccb.content.text("<npcname>'s devil tail shoots itself into %s, penetrating its body like a bullet"),
    },
    unarmed_allowed = true,
    melee_allowed = true,
    weighting = 2,
    crit_ok = true,
    repeat_min = 1,
    repeat_max = 1,
    block_counter = true,
    dodge_counter = true,
    flat_bonuses = {
        { stat = "damage", damage_type = "bullet", scale = 45 },
        { stat = "damage", damage_type = "cut", scale = -1 },
    },
    effects = {
        {
            id = "bleed",
            chance = 100,
            duration_turns = 2000,
            on_damage = true,
            message = ccb.content.text("%s is bleeding heavily!"),
        },
    },
}

-- NO_I18N
ccb.content.define_technique {
    id = "tec_devil_tail_wide",
    name = ccb.content.text_without_extraction("TAIL_SWEEP"),
    messages = {
        ccb.content.text("Your devil tail makes a fast move, heavily cutting everybody in front"),
        ccb.content.text("<npcname>'s devil tail makes a fast move, heavily cutting everybody in front"),
    },
    unarmed_allowed = true,
    melee_allowed = true,
    weighting = 2,
    crit_ok = true,
    repeat_min = 1,
    repeat_max = 1,
    block_counter = true,
    dodge_counter = true,
    aoe = "wide",
    flat_bonuses = { { stat = "damage", damage_type = "cut", scale = 1.5 } },
    effects = {
        {
            id = "bleed",
            chance = 100,
            duration_turns = 2000,
            on_damage = true,
            message = ccb.content.text("%s is bleeding heavily!"),
        },
    },
}

-- not an actual grab, but would be nice to be so
-- NO_I18N
ccb.content.define_technique {
    id = "tec_devil_tail_grab",
    name = ccb.content.text_without_extraction("TAIL_GRAB"),
    messages = {
        ccb.content.text("Your devil tail grabs %s and throws them to the ground"),
        ccb.content.text("<npcname>'s devil tail grabs %s and throws them to the ground"),
    },
    unarmed_allowed = true,
    melee_allowed = true,
    weighting = 2,
    crit_ok = true,
    repeat_min = 1,
    repeat_max = 1,
    block_counter = true,
    dodge_counter = true,
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 15 },
        { stat = "damage", damage_type = "cut", scale = -1 },
    },
    effects = {
        {
            id = "downed",
            chance = 100,
            duration_turns = 5,
            message = ccb.content.text("You smash %s and make him fall"),
        },
    },
}
