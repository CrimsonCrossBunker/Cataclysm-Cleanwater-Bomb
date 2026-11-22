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

ccb.content.define_item {
    id = "mp3_reverberation",
    copy_from = "mp3",
    name = ccb.content.plural_text("red mp3 player (off)", "red mp3 players (off)"),
    description = "A light-red mp3 player, you feel the text on the screen says \"TRAVEL // JOURNEY\".  Under that, \"Let's go on an adventure!\"\nThe screen is dark, it's powered off.",
    color = "light_red",
    category = "artifacts",
    variables = { warm_up = 10 },
    pockets = {},
    faults = {},
    use_actions = {
        {
            kind = "mp3",
            target = "mp3_on_reverberation",
            activate = true,
            message = "You put in the earbuds and turn on the device.",
        },
    },
    tool = { charges_per_use = 0, power_draw = "0 W" },
    inheritance = {
        remove = {
            flags = { "WATER_BREAK_ACTIVE", "ELECTRONIC" },
        },
    },
}
