local ccb = require("ccb")

ccb.content.define_item {
    id = "maple_candy",
    name = ccb.content.plural_text("maple syrup candy", "maple syrup candy"),
    mass = "18 g",
    color = "brown",
    default_container = "bag_plastic_small",
    symbol = "%",
    description = ccb.content.text("A handful of golden, translucent leaf candies made with pure maple syrup.  They melt slowly in your mouth as you savor the taste of real maple."),
    price = "3 USD",
    survival_price = "25 cent",
    materials = { "junk" },
    volume = "50 ml",
    flags = { "EDIBLE_FROZEN" },
    stackable = true,
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        quench = -1,
        healthy = -1,
        calories = 54,
        fun = 10,
        vitamins = { { id = "junk_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "grahmcrackers",
    name = ccb.content.text("graham cracker"),
    mass = "31 g",
    color = "brown",
    default_container = "box_small",
    symbol = "%",
    description = ccb.content.text("These dry, sugary crackers will leave you thirsty, but they go well with some chocolate and marshmallows."),
    price = "13 cent",
    survival_price = "37 cent",
    materials = { "wheat", "junk" },
    volume = "93 ml",
    flags = { "EDIBLE_FROZEN" },
    stackable = true,
    comestible = {
        shelf_life = "90 days",
        kind = "FOOD",
        quench = -4,
        calories = 110,
        vitamins = {
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 6 },
            { id = "wheat_allergen", amount = 1 },
            { id = "junk_allergen", amount = 1 },
        },
        fun = 2,
    },
}

ccb.content.define_item {
    id = "grahmcrackers_roe",
    name = ccb.content.plural_text("graham cracker chunks", "graham cracker chunks"),
    copy_from = "grahmcrackers",
    description = ccb.content.text("These dry, sugary cracker pellets will leave you thirsty, and they're not the right size to make s'mores with.  Made by SugarRush!"),
    comestible = {},
}

-- dimensions are picked from oreo
ccb.content.define_item {
    id = "cookies",
    name = ccb.content.text("cookie"),
    mass = "11 g",
    color = "brown",
    default_container = "box_snack",
    symbol = "%",
    description = ccb.content.text("A sweet, delicious cookie, just like grandma used to bake."),
    price = "9 cent",
    survival_price = "7 cent",
    materials = { "wheat", "junk" },
    volume = "58 ml",
    flags = { "EDIBLE_FROZEN" },
    stackable = true,
    comestible = {
        shelf_life = "60 days",
        kind = "FOOD",
        quench = -1,
        calories = 160,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 6 },
            { id = "wheat_allergen", amount = 1 },
            { id = "junk_allergen", amount = 1 },
        },
        fun = 7,
    },
}

ccb.content.define_item {
    id = "cookies_egg",
    name = ccb.content.text("cookie egg"),
    copy_from = "cookies",
    description = ccb.content.text("A sweet, delicious cookie, shaped like an egg.  Made by SugarRush!"),
    comestible = {},
}

ccb.content.define_item {
    id = "syrup",
    name = ccb.content.plural_text("maple syrup", "maple syrup"),
    mass = "21 g",
    color = "brown",
    default_container = "bottle_glass",
    symbol = "%",
    description = ccb.content.text("Boiling the sap of a maple tree has concentrated it into this sweet, delicious maple syrup."),
    display_type = "BY_VOLUME",
    price = "6 USD",
    survival_price = "7 USD 50 cent",
    materials = { { id = "sugar", portions = 66 }, { id = "water", portions = 34 } },
    volume = "250 ml",
    phase = "liquid",
    comestible = {
        kind = "FOOD",
        quench = 1,
        calories = 54,
        servings = 16,
        fun = 5,
        vitamins = { { id = "calcium", amount = 2 }, { id = "junk_allergen", amount = 1 } },
        freezing_point = -57,
    },
}

ccb.content.define_item {
    id = "beet_syrup",
    name = ccb.content.plural_text("sugar beet syrup", "sugar beet syrup"),
    color = "brown",
    default_container = "bottle_glass",
    symbol = "%",
    description = ccb.content.text("A thick syrup produced from shredded sugar beets.  Useful in cooking as a sweetener."),
    display_type = "BY_VOLUME",
    price = "15 USD",
    survival_price = "3 USD 50 cent",
    materials = { { id = "sugar", portions = 78 }, { id = "water", portions = 22 } },
    mass = "11 g",
    volume = "125 ml",
    phase = "liquid",
    comestible = {
        kind = "FOOD",
        quench = 3,
        calories = 34,
        vitamins = { { id = "iron", amount = 34 }, { id = "junk_allergen", amount = 1 } },
        servings = 16,
    },
}

ccb.content.define_item {
    id = "syrup_simple",
    name = ccb.content.plural_text("simple syrup", "simple syrup"),
    mass = "21 g",
    color = "light_gray",
    default_container = "bottle_glass",
    symbol = "%",
    description = ccb.content.text("A simple syrup, made of just sugar and water.  Used usually as a sweetener for stuff like cocktails."),
    display_type = "BY_VOLUME",
    price = "6 USD",
    survival_price = "7 USD 50 cent",
    materials = { { id = "sugar", portions = 66 }, { id = "water", portions = 34 } },
    volume = "250 ml",
    phase = "liquid",
    comestible = {
        shelf_life = "30 days",
        kind = "FOOD",
        quench = 16,
        calories = 34,
        servings = 16,
        fun = -1,
        vitamins = { { id = "junk_allergen", amount = 1 } },
        freezing_point = -57,
    },
}

ccb.content.define_item {
    id = "syrup_corn",
    name = ccb.content.plural_text("corn syrup", "corn syrup"),
    mass = "21 g",
    color = "yellow",
    default_container = "bottle_glass",
    symbol = "%",
    description = ccb.content.text("A syrup made from corn."),
    display_type = "BY_VOLUME",
    price = "6 USD",
    survival_price = "7 USD 50 cent",
    materials = { { id = "sugar", portions = 80 }, { id = "water", portions = 20 } },
    volume = "250 ml",
    phase = "liquid",
    comestible = {
        kind = "FOOD",
        quench = 1,
        calories = 60,
        servings = 16,
        vitamins = { { id = "junk_allergen", amount = 1 } },
        freezing_point = -57,
    },
}

ccb.content.define_item {
    id = "jihelucake",
    name = ccb.content.plural_text("slice of birthday cake", "slices of birthday cake"),
    mass = "38 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("A slice of delicious sponge cake with white buttercream icing and covered in sprinkles!  Part of the words \"Happy Birthday\" are written on top in frosting."),
    price = "10 cent",
    survival_price = "16 cent",
    materials = { "wheat", "junk" },
    volume = "166 ml",
    stackable = true,
    comestible = {
        shelf_life = "52 hours",
        kind = "FOOD",
        calories = 280,
        vitamins = {
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 6 },
            { id = "wheat_allergen", amount = 1 },
            { id = "junk_allergen", amount = 1 },
        },
        fun = 15,
    },
}

ccb.content.define_item {
    id = "cake2",
    name = ccb.content.plural_text("slice of chocolate cake", "slices of chocolate cake"),
    copy_from = "jihelucake",
    description = ccb.content.text("Delicious chocolate cake.  It has all the icing.  All of it."),
    comestible = { shelf_life = "4 days", calories = 280 },
}

ccb.content.define_item {
    id = "cake3",
    name = ccb.content.text("slice of guff cake"),
    copy_from = "jihelucake",
    description = ccb.content.text("A slice of cake coated in the thickest icing you've ever seen.  Someone has written \"guff\" on every slice."),
    comestible = { shelf_life = "4 days", calories = 295, quench = -5, fun = 20 },
}
