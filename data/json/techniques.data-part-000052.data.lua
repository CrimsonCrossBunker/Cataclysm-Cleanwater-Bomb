local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_pankration_break",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you wrestle free"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they wrestle free"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    defensive = true,
    grab_break = true,
}
