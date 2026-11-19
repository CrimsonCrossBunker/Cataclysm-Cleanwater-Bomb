local ccb = require("ccb")

ccb.content.define_item {
    id = "protein_drink",
    name = ccb.content.plural_text("protein drink", "protein drink"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("soylent green drink", "soylent green drink"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("sapient green drink", "sapient green drink"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("perturbing %s", "perturbing %s"),
        },
    },
    description = ccb.content.text("A thin slurry of refined protein mixed with water.  While quite nutritious, it is not particularly tasty."),
    display_type = "BY_VOLUME",
    mass = "278 g",
    volume = "250 ml",
    price = "2 USD",
    survival_price = "25 cent",
    symbol = "~",
    color = "light_gray",
    phase = "liquid",
    default_container = "bottle_plastic",
    sealed_container = false,
    materials = { "water" },
    flags = { "EATEN_COLD" },
    comestible = {
        kind = "DRINK",
        servings = 1,
        shelf_life = "2 days",
        calories = 100,
        quench = 40,
        fun = -1,
        vitamins = { { id = "calcium", amount = "73 mg" } },
    },
}

-- 1 g of protein powder is 0.959 ml, 1 serving is 28g and 27ml
ccb.content.define_item {
    id = "protein_powder",
    name = ccb.content.plural_text("protein powder", "protein powder"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("soylent green powder", "soylent green powder"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("sapient green powder", "sapient green powder"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("perturbing %s", "perturbing %s"),
        },
    },
    description = ccb.content.text("Raw, refined protein.  While quite nutritious, it is impossible to enjoy in its pure form, try adding water."),
    display_type = "BY_VOLUME",
    mass = "28 g",
    volume = "27 ml",
    price = "122 cent",
    survival_price = "11 cent",
    flags = { "EDIBLE_FROZEN" },
    materials = { "powder" },
    symbol = "%",
    color = "white",
    default_container = "bottle_plastic_small",
    comestible = { kind = "FOOD", calories = 100, freezing_point = -274, vitamins = {} },
}

-- Inspired by, but not based on, a true story
ccb.content.define_item {
    id = "protein_bar_evac",
    name = ccb.content.text("protein ration"),
    description = ccb.content.text("SoyPelusa ran a highly successful crowdfunding campaign for their signature protein bar, dubbed \"DaiZoom.\"\n\nA person can live on one of these bars, three times a day, presumably forever.  After backers received their product, a single flaw was found: most consumers found starvation preferable to the flavor.  Warehouses of the product went unsold as the company went bankrupt, providing the perfect opportunity for FEMA to scoop them up and stock the evac shelters.\n\nNow, you hold a piece of famous crowdfunding history in your hands.  How exciting."),
    mass = "180 g",
    volume = "170 ml",
    price = "5 USD",
    survival_price = "50 cent",
    flags = { "EDIBLE_FROZEN" },
    materials = { "fruit", "veggy" },
    symbol = "%",
    color = "green",
    default_container = "wrapper_pr",
    comestible = {
        kind = "FOOD",
        fun = -2,
        quench = -2,
        calories = 800,
        vitamins = {
            { id = "calcium", amount = 32 },
            { id = "iron", amount = 32 },
            { id = "vitC", amount = 32 },
            { id = "bad_food", amount = 5 },
            { id = "veggy_allergen", amount = 1 },
            { id = "fruit_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "protein_shake",
    copy_from = "protein_drink",
    name = ccb.content.plural_text("protein shake", "protein shake"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("soylent green shake", "soylent green shake"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("sapient green shake", "sapient green shake"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("perturbing %s", "perturbing %s"),
        },
    },
    description = ccb.content.text("A thick and tasty beverage made from pure refined protein and nutritious fruit."),
    display_type = "BY_VOLUME",
    materials = { "fruit" },
    volume = "500 ml",
    comestible = { calories = 150, fun = 4, servings = 2, quench = 20 },
    inheritance = {
        add = { vitamins = { { id = "vitC", amount = "20 mg" }, { id = "fruit_allergen", amount = 1 } } },
    },
}

ccb.content.define_item {
    id = "protein_shake_fortified",
    copy_from = "protein_shake",
    name = ccb.content.plural_text("fortified protein shake", "fortified protein shake"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("fortified soylent green shake", "fortified soylent green shake"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("fortified sapient green shake", "fortified sapient green shake"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("perturbing %s", "perturbing %s"),
        },
    },
    description = ccb.content.text("A thick and tasty beverage made from pure refined protein and nutritious fruit.  It has been supplemented with extra vitamins and minerals."),
    display_type = "BY_VOLUME",
    comestible = {
        vitamins = {
            { id = "calcium", amount = "175 mg" },
            { id = "iron", amount = "940 μg" },
            { id = "vitC", amount = "20 mg" },
        },
    },
}

ccb.content.define_item {
    id = "milk_fortified",
    name = ccb.content.plural_text("fortified milk", "fortified milk"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("soylent milk", "soylent milk"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("sapient-enhanced milk", "sapient-enhanced milk"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("freaky %s", "freaky %s"),
        },
    },
    description = ccb.content.text("Milk enriched with protein powder, it's extra healthy and doesn't taste too bad."),
    display_type = "BY_VOLUME",
    mass = "286 g",
    volume = "250 ml",
    price = "3 USD",
    survival_price = "75 cent",
    symbol = "~",
    color = "white",
    phase = "liquid",
    default_container = "bottle_plastic",
    sealed_container = false,
    materials = { "milk" },
    flags = { "EATEN_COLD" },
    comestible = {
        kind = "DRINK",
        servings = 1,
        shelf_life = "1 day",
        calories = 232,
        quench = 22,
        fun = 1,
        vitamins = {
            { id = "vitC", amount = 4 },
            { id = "calcium", amount = 32 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "protein_smoothie",
    copy_from = "milk_fortified",
    name = ccb.content.plural_text("protein smoothie", "protein smoothie"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("soylent smoothie", "soylent smoothie"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("sapient green smoothie", "sapient green smoothie"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("perturbing %s", "perturbing %s"),
        },
    },
    description = ccb.content.text("A thick and tasty smoothie made from pure refined protein and nutritious fruit mixed into milk."),
    display_type = "BY_VOLUME",
    materials = { "fruit", "milk" },
    volume = "500 ml",
    comestible = { calories = 165, fun = 5, servings = 2, quench = 18 },
}

-- Flavors inspired by No Nuts! protein bars
ccb.content.define_item {
    id = "protein_bar_zero",
    name = ccb.content.text("protein bar"),
    description = ccb.content.text("A dairy-free, nut-free, zero-allergen protein bar."),
    mass = "48 g",
    volume = "44 ml",
    price = "2 USD",
    survival_price = "20 cent",
    flags = { "EDIBLE_FROZEN" },
    materials = { "veggy" },
    symbol = "%",
    color = "green",
    default_container = "wrapper_bar",
    variants = {
        {
            id = "chips",
            name = ccb.content.text("protein bar"),
            description = ccb.content.text("This one is drizzled with chocolate and chocolate chips on top."),
            append = true,
            weight = 12,
        },
        {
            id = "vanilla",
            name = ccb.content.text("protein bar"),
            description = ccb.content.text("This one is vanilla flavored."),
            append = true,
            weight = 6,
        },
        {
            id = "cinnamon",
            name = ccb.content.text("protein bar"),
            description = ccb.content.text("This one is flavored like a cinnamon roll."),
            append = true,
            weight = 6,
        },
        {
            id = "caramel",
            name = ccb.content.text("protein bar"),
            description = ccb.content.text("This one is bound together by caramel, and has a chocolate coated underside."),
            append = true,
            weight = 3,
        },
    },
    comestible = {
        kind = "FOOD",
        fun = 6,
        quench = -2,
        calories = 250,
        shelf_life = "420 days",
        vitamins = {
            { id = "calcium", amount = 6 },
            { id = "iron", amount = 10 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

-- Flavors inspired by Perfect Bar
ccb.content.define_item {
    id = "protein_bar_peanut",
    copy_from = "protein_bar_zero",
    description = ccb.content.text("A dairy-free protein bar.  Contains peanuts."),
    variants = {
        {
            id = "chocolate",
            name = ccb.content.text("protein bar"),
            description = ccb.content.text("This one is full of smooth peanut butter, with an outer coating of chocolate."),
            append = true,
            weight = 6,
        },
        {
            id = "chips",
            name = ccb.content.text("protein bar"),
            description = ccb.content.text("This one is a mix of chocolate chips and peanut butter."),
            append = true,
            weight = 6,
        },
        {
            id = "pb",
            name = ccb.content.text("protein bar"),
            description = ccb.content.text("This one is mostly just plain peanut butter that's been heavily sweetened."),
            append = true,
            weight = 6,
        },
        {
            id = "cookie",
            name = ccb.content.text("protein bar"),
            description = ccb.content.text("This one has the soft consistency of cookie dough, filled with chocolate chips."),
            append = true,
            weight = 3,
        },
    },
    comestible = {
        vitamins = {
            { id = "iron", amount = 10 },
            { id = "nut_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

-- Flavors inspired by Quest Nutrition protein bars
ccb.content.define_item {
    id = "protein_bar_milk",
    copy_from = "protein_bar_zero",
    description = ccb.content.text("A nut-free protein bar.  Contains whey."),
    materials = { "fruit", "veggy" },
    variants = {
        {
            id = "strawberry",
            name = ccb.content.text("protein bar"),
            description = ccb.content.text("This one is flavored like strawberry shortcake, with a pink drizzle over a white coating."),
            append = true,
            weight = 6,
        },
        {
            id = "raspberry",
            name = ccb.content.text("protein bar"),
            description = ccb.content.text("This one is white chocolate raspberry flavored, with a red and white coating."),
            append = true,
            weight = 6,
        },
        {
            id = "blueberry",
            name = ccb.content.text("protein bar"),
            description = ccb.content.text("This one is flavored like a blueberry muffin.  You can see dried blueberries throughout the bar."),
            append = true,
            weight = 6,
        },
        {
            id = "lemon",
            name = ccb.content.text("protein bar"),
            description = ccb.content.text("This one is flavored like lemon cake, with a sugary white drizzle over a yellow coating."),
            append = true,
            weight = 6,
        },
        {
            id = "bday",
            name = ccb.content.text("protein bar"),
            description = ccb.content.text("This one has a white coating covered in sprinkles to resemble a birthday cake.  Happy birthday?"),
            append = true,
            weight = 1,
        },
    },
    comestible = {
        vitamins = {
            { id = "calcium", amount = 10 },
            { id = "milk_allergen", amount = 1 },
            { id = "fruit_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}
