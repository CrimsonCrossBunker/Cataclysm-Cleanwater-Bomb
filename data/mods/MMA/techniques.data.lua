local ccb = require("ccb")

ccb.content.define_technique {
    id = "mma_tec_tiger_claw_break",
    name = ccb.content.text("Wolverine Stance"),
    messages = {
        ccb.content.text("You were almost grabbed by %s, but you thrash your way to freedom"),
        ccb.content.text("<npcname> was almost grabbed by %s, but they thrash their way to freedom"),
    },
    melee_allowed = true,
    unarmed_allowed = true,
    defensive = true,
    grab_break = true,
}
