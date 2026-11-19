local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_thick_skull",
    category = "armor",
    name = ccb.content.plural_text("thick skull", "thick skull"),
    description = ccb.content.text("You've taken so many hits to the head that your skull's gotten thicker."),
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "bone" },
    symbol = "x",
    color = "magenta",
    flags = { "INTEGRATED", "UNBREAKABLE", "PERSONAL", "ZERO_WEIGHT", "SOFT" },
    armor = {
        thickness = 3,
        portions = {
            {
                covers = { "head" },
                subparts = { "head_forehead", "head_crown", "head_nape", "head_ear_r", "head_ear_l" },
                coverage = 100,
                encumbrance = 1,
            },
        },
    },
}
