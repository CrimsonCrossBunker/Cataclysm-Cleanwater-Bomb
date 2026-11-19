local ccb = require("ccb")

ccb.content.define_item {
    id = "iotv_neck_plate",
    category = "armor",
    name = ccb.content.text("ballistic collar"),
    description = ccb.content.text("Front and back nylon collar assemblies with armor inserts for neck protection.  Designed to be attached to heavy military body armor."),
    mass = "621 g",
    volume = "488 ml",
    price = "600 USD",
    survival_price = "600 USD",
    symbol = ",",
    materials = { "vacuum_carbide", "nylon" },
    color = "dark_gray",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY", "CANT_WEAR" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.5 },
                    { id = "vacuum_carbide", coverage = 100, thickness = 1 },
                },
                encumbrance = 0,
                coverage = 30,
                covers = { "head" },
                subparts = { "head_throat", "head_nape" },
                volume_encumbrance = 0,
            },
        },
    },
}
