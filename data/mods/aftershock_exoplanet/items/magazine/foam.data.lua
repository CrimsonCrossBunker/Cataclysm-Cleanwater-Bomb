local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_foam_tank",
    looks_like = "pressurized_tank_chem",
    name = ccb.content.text("pressurized foam tank"),
    description = ccb.content.text("A pressurized 5L canister designed to feed an industrial foam gun."),
    mass = "500 g",
    volume = "5 L",
    price = "50 USD",
    survival_price = "50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_BULKY", "NO_UNLOAD" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { afs_foam = 30 }, watertight = true } },
    magazine = { ammunition = { "afs_foam" }, capacity = 30, reload_time = 3 },
}
