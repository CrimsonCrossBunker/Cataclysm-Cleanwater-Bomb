local ccb = require("ccb")

ccb.content.define_item {
    id = "bio_mana_to_bionic_power",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Corporeal Ley Tap CBM", "Corporeal Ley Tap CBMs"),
    description = ccb.content.text("For those who have no use for their mana, this bionic allows the user to convert mana directly into bionic power.  Though the conversion rate is inefficient, mana is free."),
    price = "5 kUSD 500 USD",
    mass = "500 g",
    bionic = { difficulty = 6 },
}
