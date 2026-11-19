local ccb = require("ccb")

ccb.content.define_item {
    id = "string_dimension_hypercube",
    category = "artifacts",
    name = ccb.content.plural_text("transparent hypercube", "transparent hypercubes"),
    description = ccb.content.text("A transparent cube within a cube.  It seems to be made of clear plastic or glass, but it feels quite solid, despite also seeming weightless.  Impossibly, the inside seems larger than the outside - as you tilt it here and there, you can peer into its depths.  It's full of stars."),
    materials = { "anomaly" },
    symbol = "[",
    volume = "500 ml",
    length = "8 cm",
    mass = "0 g",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "125000 ml",
            mass_limit = "125000 g",
            max_item_length = "50 cm",
            weight_multiplier = 0.5,
            volume_multiplier = 0.5,
            rigid = true,
        },
    },
    flags = { "ZERO_WEIGHT", "TARDIS" },
    artifact = { enchantments = { "ITEM_ENCH_dda_string_dimension_hypercube_0" } },
}
