local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_brawl_break_melee",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you force yourself free"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they break free"),
    },
    skills = { { id = "melee", level = 6 } },
    melee_allowed = true,
    defensive = true,
    grab_break = true,
}

ccb.content.define_technique {
    id = "tec_brawl_break_unarmed",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you force yourself free"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they break free"),
    },
    skills = { { id = "unarmed", level = 6 } },
    unarmed_allowed = true,
    defensive = true,
    grab_break = true,
}

ccb.content.define_technique {
    id = "tec_brawl_feint_melee",
    name = ccb.content.text("Feint"),
    messages = {
        ccb.content.text("You fake a strike at %s"),
        ccb.content.text("<npcname> fakes a strike at %s"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_brawl_feint_unarmed",
    name = ccb.content.text("Feint"),
    messages = {
        ccb.content.text("You fake a strike at %s"),
        ccb.content.text("<npcname> fakes a strike at %s"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    defensive = true,
    miss_recovery = true,
}

ccb.content.define_technique {
    id = "tec_brawl_disarm_melee",
    name = ccb.content.text("Disarm"),
    messages = {
        ccb.content.text("You knock %s's weapon away"),
        ccb.content.text("<npcname> knock %s's weapon away"),
    },
    skills = { { id = "melee", level = 6 } },
    melee_allowed = true,
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
    id = "tec_brawl_disarm_unarmed",
    name = ccb.content.text("Disarm"),
    messages = {
        ccb.content.text("You knock %s's weapon away"),
        ccb.content.text("<npcname> knock %s's weapon away"),
    },
    skills = { { id = "unarmed", level = 6 } },
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
    attack_vectors = { "vector_grasp" },
}
