local ccb = require("ccb")

ccb.content.define_mutation {
    id = "VAMPIRE_SACRIFICE",
    name = ccb.content.text_without_extraction("sacrificial mark"),
    points = 0,
    player_display = false,
    valid = false,
    purifiable = false,
    description = ccb.content.text_without_extraction("You're not supposed to see this.  Tracks that you are killing your best friend ever"),
    enchantments = { "sacrificial_marked" },
}
