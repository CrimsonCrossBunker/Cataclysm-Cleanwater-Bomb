local ccb = require("ccb")

ccb.content.define_item {
    id = "kevlar_shears",
    name = ccb.content.plural_text("pair of Kevlar cutters", "pairs of Kevlar cutters"),
    description = ccb.content.text("These are a pair of heavy-duty shears with a blade suitable for cutting particularly tough materials, from polyaramid fabrics to tough plastics and thin metals.  The blades feature a flat shearing edge and a fine serration."),
    ascii_picture = "scissors",
    mass = "113 g",
    volume = "145 ml",
    price = "35 USD",
    survival_price = "3 USD 50 cent",
    accuracy = -1,
    materials = { "steel", "plastic" },
    symbol = ",",
    color = "yellow",
    qualities = {
        { id = "CUT", level = 2 },
        { id = "BUTCHER", level = 5 },
        { id = "FABRIC_CUT", level = 2 },
        { id = "SHEAR", level = 1 },
    },
    flags = { "BELT_CLIP", "SHEATH_KNIFE" },
    weapon_categories = { "SHIVS" },
    melee_damage = { stab = 10 },
    tool = {},
}
