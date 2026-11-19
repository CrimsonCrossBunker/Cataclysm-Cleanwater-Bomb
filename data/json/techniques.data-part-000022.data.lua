local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_crane_break",
    name = ccb.content.text("Crane Flap"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you swing your arms and break free"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they flap free"),
    },
    skills = { { id = "unarmed", level = 3 } },
    unarmed_allowed = true,
    defensive = true,
    grab_break = true,
}
