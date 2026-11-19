local ccb = require("ccb")

-- Tileset whitelist for flame or chemical throwers.
ccb.content.define_item {
    id = "pressurized_tank",
    name = ccb.content.text("8 L pressurized fuel tank"),
    description = ccb.content.text("A pressurized 8 L canister designed to feed a flamethrower.  A date code stamped into the aluminum indicates that this was made in the 1970's."),
    mass = "11600 g",
    volume = "13935 ml",
    length = "630 mm",
    price = "50 USD",
    survival_price = "2 USD 50 cent",
    materials = { "aluminum" },
    symbol = "#",
    color = "light_green",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { flammable = 8000 }, watertight = true } },
    magazine = { ammunition = { "flammable" }, reload_time = 3 },
}

ccb.content.define_item {
    id = "pressurized_tank_modern",
    looks_like = "pressurized_tank",
    name = ccb.content.text("9 L pressurized fuel tank"),
    description = ccb.content.text("A 9 L pressurized carbon fiber cylinder designed to feed a flamethrower."),
    mass = "9800 g",
    volume = "15677 ml",
    length = "630 mm",
    price = "200 USD",
    survival_price = "7 USD 50 cent",
    materials = { "carbonfiber" },
    symbol = "#",
    color = "light_gray",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { flammable = 9000 }, watertight = true } },
    magazine = { ammunition = { "flammable" }, reload_time = 3 },
}
