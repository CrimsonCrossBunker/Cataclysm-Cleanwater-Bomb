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
