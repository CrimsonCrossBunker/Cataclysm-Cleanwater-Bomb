local ccb = require("ccb")

ccb.content.define_mutation {
    id = "HUMAN_BUILD",
    name = ccb.content.text("Human"),
    types = { "HERITAGE" },
    purifiable = false,
    mixed_effect = false,
    points = 1,
    visibility = 2,
    description = ccb.content.text("Elves might say you are short-lived, and goblins might say you are strong, but the one thing humans really are is tenacious.  Hopefully that will serve you well after the Cataclysm."),
    empathize_with = { "GOBLIN", "RAVENFOLK", "LIZARDFOLK", "ELF", "DWARF", "HUMAN" },
    flags = { "HERITAGE" },
}
