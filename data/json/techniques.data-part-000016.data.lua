local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_judo_break",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you break their feeble grapple"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they break its feeble grapple"),
    },
    skills = { { id = "unarmed", level = 1 } },
    unarmed_allowed = true,
    melee_allowed = true,
    defensive = true,
    grab_break = true,
}
