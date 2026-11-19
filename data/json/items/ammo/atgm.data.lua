local ccb = require("ccb")

ccb.content.define_item {
    id = "atgm_heat",
    price = "700 USD",
    survival_price = "50 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    name = ccb.content.plural_text("152mm ATGM HEAT", "152mm ATGM HEAT"),
    symbol = "=",
    color = "dark_gray",
    description = ccb.content.text("A tube-launched, optically tracked, wire-guided missile contained in a steel tube.  Designed to be highly effective against vehicles and structures."),
    ascii_picture = "atgm_heat",
    materials = { "steel", "powder" },
    volume = "15 L",
    length = "116 cm",
    mass = "22600 g",
    melee_damage = { bash = 1 },
    ammunition = {
        type = "atgm",
        casing = "atgm_spent",
        damage = { type = "bullet", amount = 2400, penetration = 600 },
        range = 100,
        recoil = 6000,
        effects = { "EXPLOSIVE_ATGMHEAT" },
    },
}
