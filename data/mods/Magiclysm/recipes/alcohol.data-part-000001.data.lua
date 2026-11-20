local ccb = require("ccb")

ccb.content.define_item {
    id = "brew_dragonfire",
    copy_from = "brew_vodka",
    name = ccb.content.plural_text("dragonfire wort", "dragonfire wort"),
    description = ccb.content.text("Unfermented dragonfire.  Made from dragonail, this will make a truly sharp drink.  You need to put it in a fermenting vat to brew it."),
    materials = {
        { id = "water", portions = 757 },
        { id = "veggy", portions = 180 },
        { id = "yeast", portions = 1 },
    },
    flags = { "TRADER_AVOID", "NUTRIENT_OVERRIDE" },
    phase = "liquid",
    subtype_order = { "brewing", "comestible" },
    brewing = { duration = "7 days", products = { "wash_dragonfire", "yeast" } },
    comestible = { servings = 1, kind = "DRINK", vitamins = {} },
}

ccb.content.define_item {
    id = "brew_goldbrew",
    copy_from = "brew_whiskey",
    name = ccb.content.plural_text("goldbrew wort", "goldbrew wort"),
    description = ccb.content.text("Unfermented goldbrew.  Smells like unrequited love and endless yearning.  You need to put it in a fermenting vat to brew it."),
    materials = {
        { id = "water", portions = 757 },
        { id = "veggy", portions = 180 },
        { id = "sugar", portions = 50 },
        { id = "yeast", portions = 1 },
    },
    flags = { "TRADER_AVOID", "NUTRIENT_OVERRIDE" },
    phase = "liquid",
    subtype_order = { "brewing", "comestible" },
    brewing = { duration = "7 days", products = { "wash_goldbrew", "yeast" } },
    comestible = { servings = 1, kind = "DRINK", vitamins = {} },
}
