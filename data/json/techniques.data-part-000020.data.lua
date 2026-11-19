local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_krav_maga_break",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you wrestle free"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they wrestle free"),
    },
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    unarmed_allowed = true,
    defensive = true,
    grab_break = true,
}

ccb.content.define_technique {
    id = "tec_leopard_feint",
    name = ccb.content.text("Leopard Paw"),
    messages = {
        ccb.content.text("You paw aggressively at %s"),
        ccb.content.text("<npcname> paws aggressively at %s"),
    },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    defensive = true,
    miss_recovery = true,
}
