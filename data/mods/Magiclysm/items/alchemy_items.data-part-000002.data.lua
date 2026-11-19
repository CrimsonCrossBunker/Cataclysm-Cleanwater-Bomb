local ccb = require("ccb")

ccb.content.define_item {
    id = "potion_starter",
    copy_from = "mixed_alcohol_strong",
    name = ccb.content.plural_text("potion starter", "potion starter"),
    description = ccb.content.text("Strong alcohol, infused with mana and concentrated into a liquid that can stabilize spells into liquid form.  You can still drink it, if you want."),
    comestible = {},
}

ccb.content.define_item {
    id = "potion_starter_superior",
    copy_from = "chem_ethanol",
    name = ccb.content.plural_text("superior potion starter", "superior potion starter"),
    description = ccb.content.text("Pure ethanol saturated with magical energy.  The sheer power concentrated within causes the surface of the potion to ripple continuously."),
    comestible = { kind = "DRINK", servings = 1 },
}

ccb.content.define_item {
    id = "adrenal_gland_large",
    copy_from = "meat",
    name = ccb.content.text("large adrenal gland"),
    description = ccb.content.text("An organ located above the kidneys responsible for secretion of adrenaline, cortisol, and aldosterone.  This one is huge, whether by nature or mutation."),
    price = "20 USD",
    comestible = { smoking_result = "null" },
}

ccb.content.define_item {
    id = "dragon_essence",
    symbol = "~",
    color = "light_red",
    name = ccb.content.plural_text("dragon essence", "dragon essence"),
    description = ccb.content.text("This is the magical essence from a dragon, distilled into a concentrated form."),
    volume = "250 ml",
    mass = "300 g",
    flags = { "TRADER_AVOID", "INEDIBLE" },
    default_container = "flask_glass",
    phase = "liquid",
    comestible = { kind = "DRINK", servings = 1, freezing_point = -73 },
}
