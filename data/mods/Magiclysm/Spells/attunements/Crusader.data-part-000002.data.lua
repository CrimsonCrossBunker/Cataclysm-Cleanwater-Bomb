local ccb = require("ccb")

ccb.content.define_technique {
    id = "RSTRIKE",
    name = ccb.content.text("Radiant Strike"),
    melee_allowed = true,
    crit_tec = true,
    messages = {
        ccb.content.text("Your sword bursts with radiant light, hitting everyone nearby"),
        ccb.content.text("<npcname>'s sword bursts with radiant light, hitting everyone nearby"),
    },
    aoe = "spin",
    description = ccb.content.text("Attack adjacent enemies, crit only"),
}
