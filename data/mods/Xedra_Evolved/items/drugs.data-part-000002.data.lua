local ccb = require("ccb")

-- NO_I18N
ccb.content.define_item {
    id = "elemental_mana_draught",
    name = ccb.content.plural_text("elemental mana draught", "elemental mana draughts"),
    description = ccb.content.text_without_extraction("Converting"),
    mass = "245 g",
    volume = "250ml",
    symbol = "~",
    default_container = "flask_glass",
    color = "light_blue",
    flags = { "EATEN_COLD", "NO_AUTO_CONSUME", "NUTRIENT_OVERRIDE" },
    phase = "liquid",
    price = "25 USD",
    comestible = { quench = 1, calories = 0, servings = 1, fun = -1, kind = "DRINK", freezing_point = 4 },
    use_actions = { { kind = "cast_spell", spell = "potion_recover_mana_xe", no_fail = true, level = 0 } },
}
