local ccb = require("ccb")

ccb.content.define_item {
    id = "bio_fuel_cell_blood",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Blood Power Generator CBM", "Blood Power Generator CBMs"),
    description = ccb.content.text("Using the latest advancement in technomancy this bionic is able to convert the innate energy stored in blood into bionic power.  The stronger the blood the better.  It can hold up to 100 mL of blood."),
    price = "4 kUSD 500 USD",
    mass = "500 g",
    bionic = { difficulty = 8 },
}

ccb.content.define_item {
    id = "bio_sneeze_beam",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Crystallized Mana Nose Replacement CBM", "Crystallized Mana Nose Replacement CBMs"),
    description = ccb.content.text("A large gem made with crystallized mana and some other stabilizing metals.  Comes with a specially designed power pack (installed into the skull) that does not interfere with your mana ley lines.  WARNING: for Technomancer use only.  By using this spell you are waiving all liability of Frikken Laser Beams Inc.  and its subsidiaries."),
    price = "4 kUSD 500 USD",
    mass = "750 g",
    volume = "177 ml",
    bionic = { difficulty = 8 },
}
