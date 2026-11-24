local ccb = require("ccb")

-- Less fun than vodka.
ccb.content.define_item {
    id = "dragonfire",
    looks_like = "water",
    name = ccb.content.plural_text("dragonfire", "dragonfire"),
    mass = "36 g",
    color = "light_cyan",
    default_container = "bottle_glass",
    symbol = "~",
    description = ccb.content.text("A beverage made from dragonails.  It has a distinct, almost unpleasant taste that makes your throat burn."),
    price = "49 USD",
    survival_price = "2 USD 50 cent",
    materials = { "alcohol" },
    volume = "250 ml",
    phase = "liquid",
    flags = { "EATEN_COLD", "NUTRIENT_OVERRIDE", "NO_AUTO_CONSUME" },
    comestible = {
        addiction = "alcohol",
        kind = "DRINK",
        quench = -10,
        healthy = -1,
        addiction_potential = 5,
        calories = 79,
        servings = 7,
        vitamins = { { id = "ethanol", amount = 15 } },
        freezing_point = -30,
        fun = 10,
    },
}

-- slightly more fun than your average alcoholic drink
ccb.content.define_item {
    id = "goldbrew",
    name = ccb.content.plural_text("goldbrew", "goldbrew"),
    mass = "36 g",
    color = "yellow",
    default_container = "bottle_glass",
    symbol = "~",
    description = ccb.content.text("Goldbrew, made from golden reeds.  Smells like wanderlust and wistful contemplation."),
    price = "21 USD",
    survival_price = "2 USD 50 cent",
    materials = { "alcohol" },
    volume = "250 ml",
    flags = { "EATEN_COLD", "NO_AUTO_CONSUME" },
    phase = "liquid",
    comestible = {
        addiction = "alcohol",
        kind = "DRINK",
        quench = -12,
        healthy = -1,
        addiction_potential = 5,
        calories = 79,
        vitamins = { { id = "ethanol", amount = 16 } },
        freezing_point = -30,
        servings = 7,
        fun = 18,
    },
}

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

ccb.content.define_item {
    id = "wash_dragonfire",
    copy_from = "wash_vodka",
    name = ccb.content.plural_text("dragonfire wash", "dragonfire wash"),
    description = ccb.content.text("Fermented, but not distilled dragonfire.  Basically undrinkable until properly distilled."),
    comestible = { fun = -8 },
}

ccb.content.define_item {
    id = "wash_goldbrew",
    copy_from = "wash_whiskey",
    name = ccb.content.plural_text("goldbrew wash", "goldbrew wash"),
    description = ccb.content.text("Fermented, but not distilled goldbrew.  Even unrefined, this is a nice, aromatic drink."),
    comestible = { fun = 4 },
}
