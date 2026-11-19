local ccb = require("ccb")

ccb.content.define_item {
    id = "grenade_belt",
    name = ccb.content.text("grenade machine gun belt"),
    description = ccb.content.text("An ammo belt consisting of metal linkages which separate from the belt upon firing.  This one holds grenade cartridges and is too bulky to be worn like other ammo belts."),
    volume = "10 L",
    mass = "7800 g",
    price = "0 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_BELT", "MAG_DESTROY" },
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_grenade = 50 }, rigid = true } },
    magazine = { ammunition = { "ammo_grenade" }, capacity = 50, count = 25, linkage = "ammolinkgrenade" },
}
