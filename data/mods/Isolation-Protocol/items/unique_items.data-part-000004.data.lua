local ccb = require("ccb")

ccb.content.define_item {
    id = "iso_crossbow_sling",
    name = ccb.content.plural_text("crossbow sling", "crossbow slings"),
    description = ccb.content.text("A complex sling designed to carry a repeating crossbow while keeping it ready for use.  The sling is designed to be worn across the torso and can be quickly adjusted to bring the crossbow to bear."),
    mass = "320 g",
    volume = "500 ml",
    price = "80 USD",
    survival_price = "5 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "slingpack",
    color = "green",
    flags = { "OVERSIZE", "BELTED" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            min_item_volume = "500 ml",
            capacity = "7 L",
            mass_limit = "5 kg",
            max_item_length = "200 cm",
            moves = 50,
            allowed_flags = { "PRIMITIVE_RANGED_WEAPON" },
        },
    },
    armor = {
        thickness = 1,
        portions = {
            {
                encumbrance = { 3, 7 },
                coverage = 5,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    use_actions = { { kind = "holster" } },
}
