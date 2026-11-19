local ccb = require("ccb")

ccb.content.define_technique {
    id = "WHIP_DISARM",
    name = ccb.content.text("Disarm"),
    melee_allowed = true,
    disarms = true,
    messages = {
        ccb.content.text("You disarm %s using your whip"),
        ccb.content.text("<npcname> disarms %s using their whip"),
    },
    description = ccb.content.text("Unwield target's weapon"),
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
    id = "tec_feint",
    name = ccb.content.text("Feint"),
    melee_allowed = true,
    defensive = true,
    miss_recovery = true,
    messages = { ccb.content.text("You feint at %s"), ccb.content.text("<npcname> feints at %s") },
}

ccb.content.define_technique {
    id = "tec_break",
    name = ccb.content.text("Grab Break"),
    melee_allowed = true,
    defensive = true,
    grab_break = true,
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you break its grab"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they break its grab"),
    },
}
