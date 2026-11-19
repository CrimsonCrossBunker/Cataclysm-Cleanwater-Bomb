local ccb = require("ccb")

ccb.content.define_item {
    id = "hyde_formula",
    name = ccb.content.plural_text("Hyde Formula", "Hyde Formula"),
    description = ccb.content.text("This is a transmutation potion that will bring your best attributes to the forefront."),
    color = "green_yellow",
    copy_from = "life_extension_potion",
    comestible = { calories = 50, on_consume = "drink_hyde_formula" },
}

ccb.content.define_item {
    id = "plant_imbuement",
    name = ccb.content.plural_text("Imbuement of the Trees", "Imbuement of the Trees"),
    description = ccb.content.text("In a wooden bowl, Faewild and Dreamdross are mixed together along with ground-up leaves.  The mixture has fae and human blood added to it and parts from the plant fae and then all mixed again until it's a uniform blend.  The resulting mixture will eventually dissolve into a deep green liquid."),
    mass = "50 g",
    volume = "250 ml",
    price = "150 cent",
    survival_price = "200 USD",
    materials = { "water" },
    symbol = "!",
    color = "light_cyan",
    default_container = "flask_glass",
    flags = { "NO_INGEST", "WATER_DISSOLVE", "EDIBLE_FROZEN", "SINGLE_USE" },
    comestible = { kind = "MED", quench = 2, healthy = 7, fun = -30, on_consume = "drink_plant_imbuement" },
}

ccb.content.define_item {
    id = "earth_imbuement",
    name = ccb.content.plural_text("Imbuement of the Earth", "Imbuement of the Earth"),
    description = ccb.content.text("."),
    mass = "50 g",
    volume = "250 ml",
    price = "150 cent",
    survival_price = "200 USD",
    materials = { "water" },
    symbol = "!",
    color = "light_cyan",
    default_container = "flask_glass",
    flags = { "NO_INGEST", "WATER_DISSOLVE", "EDIBLE_FROZEN", "SINGLE_USE" },
    comestible = { kind = "MED", quench = 2, healthy = 7, fun = -30, on_consume = "drink_earth_imbuement" },
}

ccb.content.define_item {
    id = "water_imbuement",
    name = ccb.content.plural_text("Imbuement of the Waters", "Imbuement of the Waters"),
    description = ccb.content.text("."),
    mass = "50 g",
    volume = "250 ml",
    price = "150 cent",
    survival_price = "200 USD",
    materials = { "water" },
    symbol = "!",
    color = "light_cyan",
    default_container = "flask_glass",
    flags = { "NO_INGEST", "WATER_DISSOLVE", "EDIBLE_FROZEN", "SINGLE_USE" },
    comestible = { kind = "MED", quench = 2, healthy = 7, fun = -30, on_consume = "drink_water_imbuement" },
}

ccb.content.define_item {
    id = "air_imbuement",
    name = ccb.content.plural_text("Imbuement of the Winds", "Imbuement of the Winds"),
    description = ccb.content.text("."),
    mass = "50 g",
    volume = "250 ml",
    price = "150 cent",
    survival_price = "200 USD",
    materials = { "water" },
    symbol = "!",
    color = "light_cyan",
    default_container = "flask_glass",
    flags = { "NO_INGEST", "WATER_DISSOLVE", "EDIBLE_FROZEN", "SINGLE_USE" },
    comestible = { kind = "MED", quench = 2, healthy = 7, fun = -30, on_consume = "drink_air_imbuement" },
}

ccb.content.define_item {
    id = "fire_imbuement",
    name = ccb.content.plural_text("Imbuement of the Flames", "Imbuement of the Flames"),
    description = ccb.content.text("Heat Faewild and Dreamdross over a roaring fire and the mix in the ashes until you have a thick paste.  That paste is mixed with parts taken from the Fair Folk and united with a dollop of fae, and human blood.  The resulting mixture will eventually dissolve into a scarlet liquid that shines with its own light."),
    mass = "50 g",
    volume = "250 ml",
    price = "150 cent",
    survival_price = "200 USD",
    materials = { "water" },
    symbol = "!",
    color = "light_cyan",
    default_container = "flask_glass",
    light = 5,
    flags = { "NO_INGEST", "WATER_DISSOLVE", "EDIBLE_FROZEN", "SINGLE_USE" },
    comestible = { kind = "MED", quench = 2, healthy = 7, fun = -30, on_consume = "drink_fire_imbuement" },
}

ccb.content.define_item {
    id = "doll_imbuement",
    name = ccb.content.plural_text("Imbuement of Parchment", "Imbuement of Parchment"),
    description = ccb.content.text("While looking in a mirror, Faewild and Dreamdross are ground to dust.  That dust is mixed with parts taken from the Fair Folk and united with a dollop of fae, and human blood.  The resulting mixture will eventually dissolve into what almost looks like liquid porcelain."),
    mass = "50 g",
    volume = "250 ml",
    price = "150 cent",
    survival_price = "200 USD",
    materials = { "water" },
    symbol = "!",
    color = "light_cyan",
    default_container = "flask_glass",
    flags = { "NO_INGEST", "WATER_DISSOLVE", "EDIBLE_FROZEN", "SINGLE_USE" },
    comestible = { kind = "MED", quench = 2, healthy = 7, fun = -30, on_consume = "drink_doll_imbuement" },
}
