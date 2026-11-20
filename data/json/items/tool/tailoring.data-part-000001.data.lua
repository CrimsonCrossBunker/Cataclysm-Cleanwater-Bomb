local ccb = require("ccb")

ccb.content.define_item {
    id = "kevlar_shears",
    name = ccb.content.plural_text("Kevlar shears", "Kevlar shears"),
    description = ccb.content.text("A pair of heavy-duty shears suitable for cutting particularly tough materials, from polyaramid fabrics to tough plastics and thin metals.  The blades feature flat shearing edges and fine serrations."),
    ascii_picture = "scissors",
    mass = "113 g",
    volume = "145 ml",
    price = "35 USD",
    survival_price = "3 USD 50 cent",
    accuracy = { grip = "solid", length = "hand", surface = "line", balance = "neutral" },
    materials = { "steel", "plastic" },
    symbol = ",",
    color = "yellow",
    qualities = { { id = "CUT", level = 2 }, { id = "BUTCHER", level = 5 }, { id = "FABRIC_CUT", level = 2 } },
    flags = { "BELT_CLIP", "SHEATH_KNIFE", "ALLOWS_BODY_BLOCK" },
    weapon_categories = { "SHIVS" },
    melee_damage = { stab = 10 },
    tool = {},
}
