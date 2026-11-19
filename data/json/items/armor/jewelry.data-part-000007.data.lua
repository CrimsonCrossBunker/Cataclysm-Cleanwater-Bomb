local ccb = require("ccb")

ccb.content.define_item {
    id = "wooden_hair_beads",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.plural_text("wooden hair beads", "sets of wooden hair beads"),
    description = ccb.content.text("An assortment of wooden beads used to decorate locs or braids."),
    mass = "6 g",
    volume = "10 ml",
    materials = { "wood" },
    symbol = ".",
    color = "brown",
    armor = {},
}
