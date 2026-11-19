local ccb = require("ccb")

-- $500 per.  Cheap!
ccb.content.define_item {
    id = "m235tpa",
    price = "2 kUSD",
    name = ccb.content.text("M74 rocket"),
    symbol = "=",
    color = "dark_gray",
    description = ccb.content.text("A 66mm incendiary rocket, used in the M202 FLASH rocket launcher.  Its warhead is filled with a thickened pyrophoric agent, which burns at 2200 degrees Fahrenheit."),
    ascii_picture = "m235tpa",
    materials = { "steel", "powder" },
    volume = "2 L",
    length = "53 cm",
    survival_price = "80 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    mass = "1338 g",
    ammunition = {
        type = "m235",
        damage = { type = "bullet", amount = 60, penetration = 10 },
        range = 70,
        dispersion = 150,
        recoil = 150,
        count = 4,
        effects = { "COOKOFF", "PYROPHORIC", "TRAIL" },
    },
}

ccb.content.define_item {
    id = "66mm_HEAT",
    price = "2 kUSD",
    name = ccb.content.plural_text("66mm HEAT", "66mm HEAT"),
    symbol = "=",
    color = "dark_gray",
    description = ccb.content.text("A 66mm high-explosive anti-tank round.  It could blow through up to two feet of concrete."),
    ascii_picture = "66mm_HEAT",
    materials = { "steel", "powder" },
    volume = "250 ml",
    length = "508 mm",
    survival_price = "80 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    mass = "2131 g",
    ammunition = {
        type = "66mm",
        damage = { type = "stab", amount = 2500, penetration = 400 },
        range = 80,
        dispersion = 30,
        recoil = 225,
        effects = { "COOKOFF", "EXPLOSIVE_66mmHEAT", "TRAIL" },
    },
}
