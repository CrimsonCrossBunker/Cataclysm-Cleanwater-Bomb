local ccb = require("ccb")

-- Metal linkages are small, but this belt has 50 linkages, so volume and weight should still have some substance.
-- Tileset whitelist for explosive launchers.
ccb.content.define_item {
    id = "belt40mm",
    name = ccb.content.text("40x53mm grenade belt"),
    description = ccb.content.text("An ammo belt consisting of metal linkages which disintegrate upon firing.  This one holds 40x53mm grenades and is too bulky to be worn like other ammo belts."),
    volume = "200 ml",
    mass = "200 g",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_BELT", "MAG_DESTROY" },
    pockets = { { kind = "MAGAZINE", ammunition = { ["40x53mm"] = 50 } } },
    magazine = { ammunition = { "40x53mm" }, capacity = 50, count = 25, linkage = "ammolink40mm" },
}
