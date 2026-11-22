local ccb = require("ccb")

ccb.content.define_item {
    id = "debug_item_damager",
    name = ccb.content.plural_text("debug item damager (simple)", "debug item damager (simple)"),
    description = "Deals 1 full bar of damage to an item you wield.",
    symbol = ";",
    color = "light_gray",
    category = "tools",
    mass = "1 g",
    volume = "1 ml",
    materials = { "plastic" },
    tool = {},
}

ccb.content.define_item {
    id = "debug_item_damager_adv",
    name = ccb.content.plural_text("debug item damager (advanced)", "debug item damager (advanced)"),
    description = "Deals damage to items you pick.",
    symbol = ";",
    color = "light_gray",
    category = "tools",
    mass = "1 g",
    volume = "1 ml",
    materials = { "plastic" },
    tool = {},
}

ccb.content.define_item {
    id = "debug_mortar",
    name = ccb.content.plural_text("debug explosion generator", "debug explosion generator"),
    description = "Causes explosion at overmap you pick.",
    symbol = ";",
    color = "light_gray",
    category = "tools",
    mass = "1 g",
    volume = "1 ml",
    materials = { "plastic" },
    tool = {},
}

ccb.content.define_item {
    id = "debug_apply_fault",
    name = ccb.content.plural_text("debug fault applier", "debug fault applier"),
    description = "Applies the fault on item by id.",
    symbol = ";",
    color = "light_gray",
    category = "tools",
    mass = "1 g",
    volume = "1 ml",
    materials = { "plastic" },
    tool = {},
}

ccb.content.define_item {
    id = "debug_dimension_traveller",
    name = ccb.content.plural_text("debug dimension traveller", "debug dimension traveller"),
    description = "Allows you to pick a dimension to teleport to.  Travellers are adviced to use Debug Phase Movement.  To teleport back to main dimension, just leave both empty.",
    symbol = ";",
    color = "light_gray",
    category = "tools",
    mass = "1 g",
    volume = "1 ml",
    materials = { "plastic" },
    tool = {},
}
