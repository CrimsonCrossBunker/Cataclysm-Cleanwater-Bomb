local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_tiger_break",
    name = ccb.content.text("Grab Break"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you are too powerful to be caged"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they are too powerful to be caged"),
    },
    unarmed_allowed = true,
    defensive = true,
    grab_break = true,
}
