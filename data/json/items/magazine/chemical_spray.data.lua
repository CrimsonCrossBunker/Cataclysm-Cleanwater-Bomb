local ccb = require("ccb")

ccb.content.define_item {
    id = "pressurized_tank_chem",
    looks_like = "pressurized_tank",
    name = ccb.content.text("2 L pressurized chemical tank"),
    description = ccb.content.text("A makeshift pressurized 2 L canister designed to feed a makeshift chemical thrower."),
    mass = "800 g",
    volume = "2 L",
    price = "50 USD",
    survival_price = "50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { chemical_spray = 800 },
            watertight = true,
        },
    },
    magazine = { ammunition = { "chemical_spray" }, reload_time = 3 },
}
