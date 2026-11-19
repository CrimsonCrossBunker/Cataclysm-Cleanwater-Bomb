local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_crane_feint",
    name = ccb.content.text("Crane Wing"),
    messages = {
        ccb.content.text("You raise your arms intimidatingly at %s"),
        ccb.content.text("<npcname> performs the Crane Wing at %s"),
    },
    unarmed_allowed = true,
    defensive = true,
    miss_recovery = true,
}
