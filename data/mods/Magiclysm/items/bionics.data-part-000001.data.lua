local ccb = require("ccb")

ccb.content.define_item {
    id = "bio_see_wizards_eyes",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Witchfinder Eyes CBM", "Witchfinder Eyes CBMs"),
    description = ccb.content.text("A series of rune-inscribed implants around the eyes allow the user of this bionic to see the ley lines in the bodies of those who frequently use magic, effectively detecting nearby wizards even through obstructing terrain."),
    price = "7 kUSD 500 USD",
    mass = "500 g",
    bionic = { difficulty = 7 },
}
