local ccb = require("ccb")

ccb.content.define_item {
    id = "chilly-p",
    copy_from = "spice",
    name = ccb.content.plural_text("chili powder", "chili powder"),
    description = ccb.content.text("Chili P, yo!  Not edible on its own, but it could be used to make seasoning."),
    color = "red",
    comestible = {},
}

ccb.content.define_item {
    id = "garlic_powder",
    copy_from = "spice",
    name = ccb.content.plural_text("garlic powder", "garlic powder"),
    description = ccb.content.text("Garlic that has been dehydrated and ground into a powder.  A must-have seasoning in any pantry."),
    display_type = "BY_WEIGHT",
    mass = "1 g",
    color = "white",
    comestible = {},
}

-- hot sauces are very salty, hence the negative quench
ccb.content.define_item {
    id = "hot_sauce",
    default_container = "bottle_plastic_small",
    name = ccb.content.plural_text("hot sauce", "hot sauce"),
    description = ccb.content.text("Flamin' hot sauce.  It'd be a bad idea to drink it on its own.  You should probably wash your hands after handling it, too."),
    display_type = "BY_VOLUME",
    mass = "5 g",
    volume = "250 ml",
    materials = { { id = "water", portions = 10 }, { id = "veggy", portions = 1 } },
    symbol = "~",
    color = "red",
    phase = "liquid",
    comestible = { kind = "DRINK", servings = 50, quench = -2, calories = 5, freezing_point = -30 },
}

ccb.content.define_item {
    id = "cinnamon",
    copy_from = "spice",
    name = ccb.content.plural_text("cinnamon", "cinnamon"),
    description = ccb.content.text("Ground cinnamon bark with a sweet but slightly spicy aroma."),
    display_type = "BY_WEIGHT",
    color = "brown",
    comestible = {},
}

ccb.content.define_item {
    id = "curry_powder",
    copy_from = "spice",
    name = ccb.content.plural_text("curry powder", "curry powder"),
    description = ccb.content.text("A blend of spices meant to be used in some South Asian dishes.  Can't be eaten raw, why would you even try that?"),
    display_type = "BY_WEIGHT",
    color = "red",
    comestible = {},
}

ccb.content.define_item {
    id = "pepper",
    copy_from = "spice",
    name = ccb.content.plural_text("black pepper", "black pepper"),
    description = ccb.content.text("Ground black spice berries with a pungent aroma."),
    display_type = "BY_WEIGHT",
    color = "dark_gray",
    comestible = {},
}

ccb.content.define_item {
    id = "spicebush_berries",
    copy_from = "spice",
    name = ccb.content.plural_text("spicebush berries", "spicebush berries"),
    description = ccb.content.text("Small, red berries with a pungent aroma.  It is said they are comparable to allspice, but also boasting their own flavor profile."),
    color = "red",
    comestible = { smoking_result = "spicebush_berries_smoked", shelf_life = "4 days" },
}

ccb.content.define_item {
    id = "spicebush_berries_smoked",
    copy_from = "spice",
    name = ccb.content.plural_text("dry spicebush berries", "dry spicebush berries"),
    description = ccb.content.text("These formerly red berries now have a stronger aroma after being dehydrated."),
    color = "brown",
    comestible = {},
}

ccb.content.define_item {
    id = "salt",
    copy_from = "spice",
    name = ccb.content.plural_text("salt", "salt"),
    display_type = "BY_WEIGHT",
    description = ccb.content.text("Yuck!  You surely wouldn't want to eat this.  It's good for preserving meat and cooking, though."),
    materials = { "salt" },
    stackable = true,
    color = "white",
    comestible = {},
}

ccb.content.define_item {
    id = "seasoning_italian",
    copy_from = "spice",
    name = ccb.content.plural_text("Italian seasoning", "Italian seasoning"),
    description = ccb.content.text("A fragrant mix of dried oregano, basil, thyme and other spices."),
    display_type = "BY_WEIGHT",
    color = "green",
    comestible = {},
}

ccb.content.define_item {
    id = "seasoning_salt",
    copy_from = "salt",
    name = ccb.content.plural_text("seasoned salt", "seasoned salt"),
    description = ccb.content.text("Salt mixed with a fragrant blend of secret herbs and spices."),
    display_type = "BY_WEIGHT",
    materials = { "salt" },
    color = "brown",
    comestible = {},
}

-- Our recipes have traditionally been standardized against sugar units of 5 mg. Refer also to the sugar_standard item group for more sugar-related items and their ratios to one another. Density is now accurate.
ccb.content.define_item {
    id = "sugar",
    name = ccb.content.plural_text("sugar", "sugar"),
    stackable = true,
    mass = "5 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("Sweet, sweet sugar.  Bad for your teeth and surprisingly not very tasty on its own."),
    display_type = "BY_WEIGHT",
    price = "5 cent",
    survival_price = "4 cent",
    materials = { "sugar" },
    volume = "6 ml",
    flags = { "EDIBLE_FROZEN", "NUTRIENT_OVERRIDE", "WATER_DISSOLVE" },
    comestible = { kind = "FOOD", calories = 19 },
}

ccb.content.define_item {
    id = "sprinkles",
    name = ccb.content.plural_text("sprinkles", "sprinkles"),
    mass = "4 g",
    copy_from = "sugar",
    default_container = "bottle_plastic_small",
    description = ccb.content.text("Known as nonpareils, sprinkles, jimmies, sugar strands or 'hundreds-and-thousands', these colorful balls, rods or flakes of sugar and starch are intended for use decorating soft surfaces of sweets.  Like sugar, they are bad for your teeth and surprisingly not very tasty on their own."),
    display_type = "BY_WEIGHT",
    price = "6 cent",
    survival_price = "3 cent",
    volume = "4 ml",
    comestible = { calories = 20 },
}

ccb.content.define_item {
    id = "wild_herbs",
    name = ccb.content.plural_text("wild herbs", "wild herbs"),
    stackable = true,
    mass = "7 g",
    color = "green",
    symbol = "%",
    description = ccb.content.text("A tasty collection of wild herbs including violet, sassafras, mint, clover, purslane, and fireweed."),
    display_type = "BY_WEIGHT",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "veggy" },
    volume = "2 ml",
    flags = { "EDIBLE_FROZEN", "RAW" },
    comestible = {
        kind = "FOOD",
        quench = -1,
        calories = 9,
        fun = -1,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "soysauce",
    symbol = "~",
    color = "brown",
    name = ccb.content.plural_text("soy sauce", "soy sauce"),
    stackable = true,
    description = ccb.content.text("Salty fermented soybean sauce."),
    display_type = "BY_VOLUME",
    price = "1 USD 90 cent",
    survival_price = "25 cent",
    mass = "24 g",
    volume = "250 ml",
    materials = { { id = "water" } },
    default_container = "bottle_glass",
    phase = "liquid",
    comestible = { calories = 17, kind = "DRINK", quench = -20, servings = 10, fun = -15, freezing_point = -30 },
}

ccb.content.define_item {
    id = "thyme",
    name = ccb.content.plural_text("thyme", "thyme"),
    display_type = "BY_WEIGHT",
    stackable = true,
    description = ccb.content.text("A stalk of thyme.  Smells delicious."),
    mass = "40 g",
    color = "magenta",
    symbol = ",",
    materials = { "veggy" },
    volume = "250 ml",
    price = "0 cent",
    survival_price = "10 cent",
    comestible = { kind = "FOOD", calories = 9, fun = -4, vitamins = { { id = "veggy_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "mustard_powder",
    copy_from = "spice",
    name = ccb.content.plural_text("mustard powder", "mustard powder"),
    description = ccb.content.text("A fragrant yellow powder.  Not edible in this form."),
    display_type = "BY_WEIGHT",
    color = "yellow",
    comestible = {},
}

ccb.content.define_item {
    id = "artificial_sweetener",
    copy_from = "sugar",
    name = ccb.content.plural_text("artificial sweetener", "artificial sweetener"),
    description = ccb.content.text("Sweet, sweet sugar?  No, it is bitter-sweet artificial sweetener.  No calories, no worries."),
    display_type = "BY_WEIGHT",
    materials = { "powder" },
    comestible = { calories = 0 },
}
