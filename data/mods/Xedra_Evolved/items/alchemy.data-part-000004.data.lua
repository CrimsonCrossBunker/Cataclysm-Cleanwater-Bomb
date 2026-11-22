local ccb = require("ccb")

ccb.content.define_item {
    id = "spiritshow_dust",
    name = ccb.content.plural_text("spirit show dust", "spirit show dust"),
    description = ccb.content.text("A key ingredient for Victorian seances led by actual occultists.  This dust summons spirits from beyond to walk the earth again for a short time.  The spirits it summons are mindless and disappear upon being touched."),
    mass = "20 g",
    volume = "250 ml",
    symbol = "~",
    default_container = "flask_glass",
    color = "light_blue",
    flags = { "EATEN_COLD", "NO_AUTO_CONSUME", "NUTRIENT_OVERRIDE", "SINGLE_USE" },
    materials = { "powder" },
    price = "25 USD",
    comestible = { quench = -1, calories = 0, fun = -1, kind = "MED" },
    use_actions = { { kind = "cast_spell", spell = "ghost_inflatable", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "nether_snare",
    name = "snaring pentagram trap",
    description = "A metallic pentagram full of mystic symbols.  Will trap creatures from other dimensions if they wander into it.",
    symbol = "*",
    color = "dark_gray",
    category = "traps",
    mass = "1 kg",
    volume = "1000 ml",
    length = "60 cm",
    price = "250 USD",
    survival_price = "5 USD",
    flags = { "SINGLE_USE" },
    materials = { "lead" },
    properties = { capture_species = "NETHER" },
    use_actions = {
        {
            kind = "place_trap",
            trap = "tr_nether_snare",
            moves = 150,
            practice = 2,
            done_message = "You set the pentagram snare.",
        },
    },
    tool = {},
}
