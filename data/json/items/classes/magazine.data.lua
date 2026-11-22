local ccb = require("ccb")

ccb.content.define_item {
    id = "magazine_belt",
    abstract = true,
    name = "ammo belt",
    description = "An ammo belt consisting of metal linkages which disintegrate upon firing.",
    symbol = "#",
    color = "light_gray",
    volume = "0 ml",
    price = "0 cent",
    flags = { "MAG_BELT", "MAG_DESTROY", "BELTED", "OVERSIZE", "WATER_FRIENDLY", "ZERO_WEIGHT" },
    materials = { "steel" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_upper" },
                coverage = 10,
                encumbrance = 10,
                materials = {
                    { id = "steel", thickness = 0.1, coverage = 100 },
                },
            },
        },
    },
    magazine = {},
    subtype_order = { "armor", "magazine" },
}
