local ccb = require("ccb")

ccb.content.define_item {
    id = "oatmeal",
    name = ccb.content.plural_text("oatmeal", "oatmeal"),
    mass = "35 g",
    volume = "75 ml",
    color = "light_gray",
    default_container = "box_small",
    symbol = "%",
    description = ccb.content.text("Dry flakes of flattened grain.  Tasty and nutritious when cooked, it also doubles as food for horses while dry."),
    display_type = "BY_WEIGHT",
    price = "87 cent",
    survival_price = "12 cent",
    materials = { "wheat" },
    flags = { "EDIBLE_FROZEN", "NUTRIENT_OVERRIDE", "RAW" },
    stackable = true,
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        quench = -15,
        calories = 131,
        cooks_like = "oatmeal_cooked",
        vitamins = {
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 10 },
            { id = "wheat_allergen", amount = 1 },
        },
        fun = -8,
    },
}

-- mass and quench obtained by weighing some actual oatmeal.
ccb.content.define_item {
    id = "oatmeal_cooked",
    name = ccb.content.plural_text("cooked oatmeal", "cooked oatmeal"),
    mass = "256 g",
    color = "light_gray",
    symbol = "%",
    description = ccb.content.text("A filling and nutritious New England classic that has sustained pioneers and captains of industry alike."),
    price = "5 USD",
    survival_price = "50 cent",
    materials = { "wheat" },
    volume = "250 ml",
    flags = { "EATEN_HOT", "NUTRIENT_OVERRIDE" },
    stackable = true,
    comestible = {
        shelf_life = "10 days",
        kind = "FOOD",
        quench = 45,
        calories = 151,
        fun = 2,
        vitamins = {
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 10 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

-- Copied from the quench value of regular oatmeal.
ccb.content.define_item {
    id = "oatmeal_deluxe",
    name = ccb.content.plural_text("deluxe cooked oatmeal", "deluxe cooked oatmeal"),
    mass = "306 g",
    color = "light_gray",
    symbol = "%",
    description = ccb.content.text("A filling and nutritious New England classic that has been improved with the addition of extra wholesome ingredients."),
    price = "275 cent",
    survival_price = "37 cent",
    materials = { "wheat" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    comestible = {
        shelf_life = "10 days",
        kind = "FOOD",
        calories = 112,
        quench = 45,
        fun = 3,
        vitamins = {
            { id = "vitC", amount = 30 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 10 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

-- mass and quench copied from oatmeal
ccb.content.define_item {
    id = "grits",
    name = ccb.content.plural_text("grits", "grits"),
    mass = "256 g",
    color = "yellow",
    default_container = "box_small",
    symbol = "%",
    description = ccb.content.text("Boiled cornmeal, a simple type of porridge."),
    price = "1 USD 20 cent",
    survival_price = "50 cent",
    materials = { "wheat" },
    volume = "250 ml",
    flags = { "EATEN_HOT", "NUTRIENT_OVERRIDE" },
    comestible = {
        kind = "FOOD",
        shelf_life = "5 days",
        calories = 154,
        quench = 45,
        vitamins = { { id = "iron", amount = 2 }, { id = "wheat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "oat_pulp",
    name = ccb.content.plural_text("oat pulp", "oat pulp"),
    looks_like = "granola",
    mass = "40 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Pulp left over after making oat milk.  It's gritty and incredibly bland."),
    display_type = "BY_WEIGHT",
    price = "10 cent",
    survival_price = "50 cent",
    materials = { "wheat" },
    volume = "125 ml",
    flags = { "EDIBLE_FROZEN" },
    comestible = {
        shelf_life = "300 days",
        kind = "FOOD",
        calories = 149,
        fun = -8,
        vitamins = { { id = "calcium", amount = 1 }, { id = "wheat_allergen", amount = 1 } },
    },
}

-- Someone needs to look at the mass and volume compared to the ingredients.
ccb.content.define_item {
    id = "cheese_grits",
    name = ccb.content.plural_text("cheese grits", "cheese grits"),
    mass = "275 g",
    color = "yellow",
    default_container = "box_small",
    symbol = "%",
    description = ccb.content.text("Boiled cornmeal with cheese to add a little more flavor."),
    price = "1 USD 20 cent",
    survival_price = "50 cent",
    materials = { "wheat" },
    volume = "250 ml",
    flags = { "EATEN_HOT", "NUTRIENT_OVERRIDE" },
    comestible = {
        kind = "FOOD",
        shelf_life = "5 days",
        calories = 275,
        quench = 45,
        vitamins = {
            { id = "iron", amount = 7 },
            { id = "vitC", amount = 7 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

-- 10 cm diameter, 1 cm thickness, 0.92 density
ccb.content.define_item {
    id = "pancakes",
    name = ccb.content.text("pancake"),
    mass = "70 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Fluffy and delicious pancakes with real maple syrup."),
    price = "137 cent",
    survival_price = "12 cent",
    materials = { { id = "wheat", portions = 10 }, { id = "milk", portions = 1 } },
    volume = "78 ml",
    flags = { "EATEN_HOT" },
    comestible = {
        shelf_life = "10 days",
        kind = "FOOD",
        calories = 121,
        fun = 3,
        vitamins = {
            { id = "calcium", amount = 6 },
            { id = "iron", amount = 4 },
            { id = "wheat_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "fruit_pancakes",
    copy_from = "pancakes",
    name = ccb.content.text("fruit pancake"),
    mass = "80 g",
    volume = "92 ml",
    color = "brown",
    description = ccb.content.text("Fluffy and delicious pancakes with real maple syrup, made sweeter and healthier with the addition of wholesome fruit."),
    price = "6 USD 50 cent",
    survival_price = "75 cent",
    comestible = {
        calories = 113,
        fun = 4,
        vitamins = {
            { id = "vitC", amount = 30 },
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 3 },
        },
    },
}

ccb.content.define_item {
    id = "blood_pancakes",
    copy_from = "pancakes",
    name = ccb.content.text("blodplättar"),
    mass = "80 g",
    color = "dark_gray",
    description = ccb.content.text("Blodplättar is not your average pancake.  It does not taste of blood at all and it tastes like a crispier black pudding."),
    price = "5 USD 50 cent",
    survival_price = "50 cent",
    materials = { { id = "wheat", portions = 10 }, { id = "blood", portions = 1 } },
    comestible = {
        shelf_life = "2 days 12 hours",
        calories = 243,
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "wheat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "frenchtoast",
    name = ccb.content.plural_text("French toast", "French toast"),
    mass = "42 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Slices of bread dipped in a milk and egg mixture then fried."),
    price = "3 USD",
    survival_price = "50 cent",
    materials = { { id = "wheat", portions = 10 }, { id = "milk", portions = 1 }, { id = "egg", portions = 1 } },
    volume = "125 ml",
    flags = { "EATEN_HOT" },
    comestible = {
        shelf_life = "10 days",
        kind = "FOOD",
        calories = 110,
        fun = 8,
        vitamins = {
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 5 },
            { id = "wheat_allergen", amount = 1 },
            { id = "egg_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "waffles",
    name = ccb.content.text("waffle"),
    mass = "75 g",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("Hey it's waffle time, it's waffle time.  Won't you have some waffles of mine?"),
    price = "5 USD 50 cent",
    survival_price = "2 USD",
    materials = { { id = "wheat", portions = 10 }, { id = "milk", portions = 1 } },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    comestible = {
        shelf_life = "10 days",
        kind = "FOOD",
        calories = 458,
        fun = 5,
        vitamins = {
            { id = "calcium", amount = 15 },
            { id = "iron", amount = 9 },
            { id = "wheat_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "fruit_waffles",
    name = ccb.content.text("fruit waffle"),
    mass = "156 g",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("Crunchy and delicious waffles with real maple syrup, made sweeter and healthier with the addition of wholesome fruit."),
    price = "6 USD",
    survival_price = "2 USD 50 cent",
    materials = {
        { id = "wheat", portions = 10 },
        { id = "fruit", portions = 1 },
        { id = "milk", portions = 1 },
    },
    volume = "375 ml",
    flags = { "EATEN_HOT" },
    comestible = {
        shelf_life = "10 days",
        kind = "FOOD",
        calories = 446,
        fun = 6,
        vitamins = {
            { id = "vitC", amount = 120 },
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 2 },
            { id = "wheat_allergen", amount = 1 },
            { id = "fruit_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "crackers",
    name = ccb.content.text("cracker"),
    mass = "56 g",
    color = "brown",
    default_container = "box_small",
    symbol = "%",
    description = ccb.content.text("Dry and salty, these crackers will leave you quite thirsty."),
    price = "13 cent",
    survival_price = "75 cent",
    materials = { "wheat" },
    volume = "125 ml",
    flags = { "EDIBLE_FROZEN" },
    comestible = {
        shelf_life = "90 days",
        kind = "FOOD",
        quench = -4,
        calories = 280,
        vitamins = {
            { id = "calcium", amount = 5 },
            { id = "iron", amount = 12 },
            { id = "wheat_allergen", amount = 1 },
        },
        fun = 2,
    },
}

ccb.content.define_item {
    id = "snack_bread",
    name = ccb.content.text("wheat snack bread"),
    copy_from = "crackers",
    description = ccb.content.text("Wheat Snack Bread, a delicious snack made from wheat."),
    comestible = { quench = 0 },
}

ccb.content.define_item {
    id = "oyster_crackers",
    name = ccb.content.text("oyster cracker"),
    copy_from = "crackers",
    mass = "25 g",
    default_container = "plastic_bag_vac",
    description = ccb.content.text("These bite-sized crackers go well with soups, but will make you thirsty on their own."),
    looks_like = "crackers",
    price = "6 cent",
    survival_price = "37 cent",
    volume = "31 ml",
    comestible = { vitamins = { { id = "calcium", amount = 1 }, { id = "iron", amount = 4 } } },
}

-- these vitamins are only for pies that may spawn.  generally they will be inherited from the fruit used.
ccb.content.define_item {
    id = "pie",
    name = ccb.content.plural_text("slice of fruit pie", "slices of fruit pie"),
    mass = "125 g",
    color = "brown",
    default_container = "box_small",
    symbol = "%",
    description = ccb.content.text("A delicious baked pie with a sweet fruit filling."),
    price = "156 cent",
    survival_price = "1 USD",
    materials = { "wheat", "fruit" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    comestible = {
        shelf_life = "3 days",
        kind = "FOOD",
        quench = 5,
        calories = 296,
        fun = 3,
        vitamins = {
            { id = "vitC", amount = 6 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 3 },
            { id = "wheat_allergen", amount = 1 },
            { id = "fruit_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "pizza_cheese",
    name = ccb.content.plural_text("slice of cheese pizza", "slices of cheese pizza"),
    mass = "170 g",
    color = "yellow",
    default_container = "box_small",
    symbol = "%",
    description = ccb.content.text("A delicious pizza with molten cheese on top."),
    price = "247 cent",
    survival_price = "150 cent",
    materials = { { id = "wheat", portions = 10 }, { id = "milk", portions = 1 } },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        calories = 452,
        fun = 10,
        vitamins = {
            { id = "vitC", amount = 4 },
            { id = "calcium", amount = 25 },
            { id = "iron", amount = 23 },
            { id = "wheat_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "granola",
    name = ccb.content.plural_text("granola", "granola"),
    mass = "32 g",
    color = "brown",
    default_container = "bag_plastic_small",
    symbol = "%",
    description = ccb.content.text("A tasty and nutritious mixture of oats, honey, and other ingredients that has been baked until crisp."),
    price = "87 cent",
    survival_price = "112 cent",
    materials = { { id = "wheat", portions = 10 }, { id = "fruit", portions = 1 } },
    volume = "62 ml",
    flags = { "EDIBLE_FROZEN" },
    comestible = {
        shelf_life = "180 days",
        kind = "FOOD",
        quench = -2,
        calories = 157,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 7 },
            { id = "wheat_allergen", amount = 1 },
            { id = "fruit_allergen", amount = 1 },
        },
        fun = 3,
    },
}

ccb.content.define_item {
    id = "pie_maple",
    name = ccb.content.plural_text("slice of maple pie", "slices of maple pie"),
    mass = "74 g",
    color = "brown",
    default_container = "box_small",
    symbol = "%",
    description = ccb.content.text("A sweet and delicious baked pie with pure maple syrup."),
    price = "231 cent",
    survival_price = "187 cent",
    materials = { { id = "wheat", portions = 10 }, { id = "milk", portions = 1 } },
    volume = "125 ml",
    flags = { "EATEN_HOT" },
    comestible = {
        shelf_life = "3 days",
        kind = "FOOD",
        quench = 4,
        calories = 300,
        fun = 6,
        vitamins = {
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 8 },
            { id = "wheat_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "noodles_fast",
    name = ccb.content.plural_text("fast noodles", "fast noodles"),
    mass = "81 g",
    color = "yellow",
    default_container = "bag_plastic_small",
    symbol = "%",
    description = ccb.content.text("So-called ramen noodles.  Can be eaten raw."),
    price = "2 USD",
    survival_price = "1 USD",
    materials = { "wheat" },
    volume = "160 ml",
    flags = { "EDIBLE_FROZEN" },
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        healthy = -1,
        calories = 356,
        vitamins = {
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 18 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "cloutie_dumpling",
    name = ccb.content.plural_text("cloutie dumplings", "cloutie dumplings"),
    mass = "91 g",
    color = "brown",
    default_container = "box_small",
    symbol = "%",
    description = ccb.content.text("This traditional Scottish treat is a sweet and filling little boiled cake studded with dried fruit."),
    price = "1 USD 95 cent",
    survival_price = "1 USD 25 cent",
    materials = { "wheat", "fruit" },
    volume = "250 ml",
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        quench = -1,
        calories = 330,
        fun = 9,
        vitamins = {
            { id = "vitC", amount = 2 },
            { id = "calcium", amount = 6 },
            { id = "iron", amount = 8 },
            { id = "wheat_allergen", amount = 1 },
            { id = "fruit_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "brioche",
    name = ccb.content.text("brioche"),
    mass = "77 g",
    color = "brown",
    default_container = "box_small",
    symbol = "%",
    description = ccb.content.text("Filling bread buns, taste good with tea on a Sunday morning breakfast."),
    price = "91 cent",
    survival_price = "83 cent",
    materials = { { id = "wheat", portions = 10 }, { id = "milk", portions = 1 } },
    volume = "125 ml",
    flags = { "EATEN_HOT" },
    comestible = {
        shelf_life = "10 days",
        kind = "FOOD",
        calories = 260,
        fun = 6,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 4 },
            { id = "wheat_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "sponge_cake",
    name = ccb.content.plural_text("slice of sponge cake", "slices of sponge cake"),
    description = ccb.content.text("Plain, fluffy cake for the proletariat."),
    default_container = "box_small",
    mass = "68 g",
    volume = "187 ml",
    price = "1250 cent",
    survival_price = "75 cent",
    materials = { "wheat", "egg" },
    symbol = "%",
    color = "brown",
    flags = { "EATEN_HOT" },
    comestible = {
        kind = "FOOD",
        calories = 278,
        fun = 4,
        shelf_life = "17 days",
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 5 },
            { id = "wheat_allergen", amount = 1 },
            { id = "egg_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "space_cake",
    name = ccb.content.plural_text("slice of space cake", "slices of space cake"),
    description = ccb.content.text("This cake's destiny is to take you on a gnarly trip."),
    default_container = "box_small",
    mass = "68 g",
    volume = "187 ml",
    price = "1250 cent",
    survival_price = "4 USD",
    materials = { "wheat", "egg" },
    symbol = "%",
    color = "brown",
    flags = { "EATEN_HOT" },
    comestible = {
        kind = "FOOD",
        calories = 278,
        fun = 18,
        shelf_life = "17 days",
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 5 },
            { id = "wheat_allergen", amount = 1 },
            { id = "egg_allergen", amount = 1 },
            { id = "cannabis", amount = 10 },
        },
    },
}

ccb.content.define_item {
    id = "brownie",
    name = ccb.content.text("brownie"),
    copy_from = "sponge_cake",
    description = ccb.content.text("A rich chocolate brownie, just like how grandma used to bake them."),
    survival_price = "4 USD",
    mass = "45 g",
    comestible = { calories = 292, fun = 7 },
}

ccb.content.define_item {
    id = "brownie_weed",
    name = ccb.content.text("'special' brownie"),
    description = ccb.content.text("This is definitely not how grandma used to bake them."),
    default_container = "box_small",
    mass = "68 g",
    volume = "187 ml",
    price = "1250 cent",
    survival_price = "4 USD",
    materials = { "wheat", "egg" },
    symbol = "%",
    color = "brown",
    flags = { "EATEN_HOT" },
    comestible = {
        kind = "FOOD",
        calories = 278,
        fun = 18,
        shelf_life = "17 days",
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 5 },
            { id = "wheat_allergen", amount = 1 },
            { id = "egg_allergen", amount = 1 },
            { id = "cannabis", amount = 10 },
        },
    },
}
