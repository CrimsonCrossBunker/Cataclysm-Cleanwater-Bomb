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

ccb.content.define_item {
    id = "bio_see_wizards_eyes",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Witchfinder Eyes CBM", "Witchfinder Eyes CBMs"),
    description = ccb.content.text("A series of rune-inscribed implants around the eyes allow the user of this bionic to see the ley lines in the bodies of those who frequently use magic, effectively detecting nearby wizards even through obstructing terrain."),
    price = "7 kUSD 500 USD",
    mass = "500 g",
    bionic = { difficulty = 7 },
}

ccb.content.define_item {
    id = "bio_mana_to_bionic_power",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Corporeal Ley Tap CBM", "Corporeal Ley Tap CBMs"),
    description = ccb.content.text("For those who have no use for their mana, this bionic allows the user to convert mana directly into bionic power.  Though the conversion rate is inefficient, mana is free."),
    price = "5 kUSD 500 USD",
    mass = "500 g",
    bionic = { difficulty = 6 },
}

ccb.content.define_item {
    id = "bio_ley_energy_blaster",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Levinbolt Projector CBM", "Levinbolt Projector CBMs"),
    description = ccb.content.text("The ultimate in concealable personal defense, thin filaments are implanted along the ley lines in both of your arms leading to embedded mana crystals in your hands, allowing you to launch blasts of pure magical energy at nearby targets.  The only disadvantage is that it draws on your own personal mana supply rather than bionic power."),
    price = "3 kUSD",
    mass = "500 g",
    bionic = { difficulty = 4 },
}
