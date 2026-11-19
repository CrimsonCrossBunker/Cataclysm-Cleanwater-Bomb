local ccb = require("ccb")

ccb.content.define_item {
    id = "sourdough_starter_uncovered",
    category = "food",
    name = ccb.content.plural_text("sourdough starter", "sourdough starter"),
    description = ccb.content.text("A precious mix of flour, water, molds, and bacteria from the air.  When you add flour and water to it, after a few hours it froths and rises."),
    mass = "100 g",
    volume = "100 ml",
    price = "50 cent",
    survival_price = "10 cent",
    materials = { "wheat" },
    symbol = "%",
    color = "yellow",
    flags = { "SOFT" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        fun = -1,
        calories = 192,
        vitamins = { { id = "wheat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "sourdough_bread",
    name = ccb.content.plural_text("sourdough bread", "sourdough bread"),
    mass = "56 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Healthy and filling, with a sharper taste and thicker crust than yeast-only bread."),
    price = "95 cent",
    survival_price = "50 cent",
    materials = { "wheat" },
    looks_like = "bread",
    volume = "75 ml",
    flags = { "EATEN_HOT", "EDIBLE_FROZEN" },
    stackable = true,
    comestible = {
        shelf_life = "8 days",
        kind = "FOOD",
        calories = 174,
        fun = 2,
        vitamins = {
            { id = "calcium", amount = 5 },
            { id = "iron", amount = 10 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "flatbread",
    name = ccb.content.plural_text("flatbread", "flatbread"),
    mass = "15 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Simple unleavened bread."),
    price = "11 cent",
    survival_price = "50 cent",
    materials = { "wheat" },
    volume = "60 ml",
    flags = { "EATEN_HOT", "EDIBLE_FROZEN" },
    stackable = true,
    comestible = {
        shelf_life = "11 days 16 hours",
        kind = "FOOD",
        calories = 234,
        vitamins = {
            { id = "calcium", amount = 5 },
            { id = "iron", amount = 12 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "frybread",
    name = ccb.content.plural_text("frybread", "frybread"),
    mass = "15 g",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("Delicious fried flatbread.  While it's not pre-contact food, it's a popular treat in many Native American households, especially as an ingredient for Indian tacos at Powwows or for Thanksgiving."),
    price = "3 cent",
    survival_price = "16 cent",
    materials = { "wheat" },
    volume = "60 ml",
    flags = { "EATEN_HOT", "EDIBLE_FROZEN" },
    stackable = true,
    comestible = {
        shelf_life = "7 days",
        kind = "FOOD",
        calories = 175,
        vitamins = {
            { id = "calcium", amount = 5 },
            { id = "iron", amount = 12 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "bread",
    name = ccb.content.plural_text("bread", "bread"),
    description = ccb.content.text("A humble piece of bread, one of the single most important staple foods of human civilization since the dawn of agriculture."),
    materials = { "wheat" },
    mass = "58 g",
    volume = "200 ml",
    price = "23 cent",
    survival_price = "50 cent",
    symbol = "%",
    color = "brown",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "10 days",
        kind = "FOOD",
        calories = 77,
        fun = 1,
        vitamins = {
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 6 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "bread_garlic",
    looks_like = "bread",
    name = ccb.content.plural_text("garlic bread", "garlic bread"),
    mass = "15 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Bread cooked with garlic, oil, and seasonings."),
    price = "6 cent",
    survival_price = "7 cent",
    materials = { "wheat" },
    volume = "60 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "10 days",
        kind = "FOOD",
        calories = 298,
        quench = -2,
        fun = 3,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 14 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "toast",
    name = ccb.content.plural_text("toast", "toast"),
    copy_from = "bread",
    description = ccb.content.text("A slice of bread with heat applied to crisp it up.  It's a bit dry and would likely go better with some toppings."),
    comestible = { shelf_life = "14 days", fun = 2, quench = -2 },
}

ccb.content.define_item {
    id = "buttered_toast",
    name = ccb.content.plural_text("buttered toast", "buttered toast"),
    copy_from = "toast",
    description = ccb.content.text("A slice of toast with butter spread on top to make it taste better."),
    materials = { { id = "milk", portions = 1 }, { id = "wheat", portions = 10 } },
    comestible = { vitamins = { { id = "wheat_allergen", amount = 1 }, { id = "milk_allergen", amount = 1 } } },
    inheritance = { offset = { fun = 4 } },
}

ccb.content.define_item {
    id = "jam_toast",
    name = ccb.content.plural_text("jam toast", "jam toast"),
    copy_from = "toast",
    description = ccb.content.text("A slice of toast with jam added, to make it less dry and to add more flavor."),
    materials = { { id = "fruit", portions = 1 }, { id = "wheat", portions = 10 } },
    comestible = {
        shelf_life = "7 days",
        vitamins = { { id = "wheat_allergen", amount = 1 }, { id = "fruit_allergen", amount = 1 } },
    },
    inheritance = { offset = { fun = 3 } },
}

ccb.content.define_item {
    id = "peanut_butter_toast",
    name = ccb.content.plural_text("peanut butter toast", "peanut butter toast"),
    copy_from = "toast",
    description = ccb.content.text("A slathering of peanut butter gives more heartiness and calories to a slice of toast."),
    comestible = {},
    inheritance = { offset = { fun = 3, quench = -2 } },
}

ccb.content.define_item {
    id = "toad_in_a_hole",
    name = ccb.content.plural_text("toad in a hole", "toad in a hole"),
    copy_from = "toast",
    description = ccb.content.text("A cooked egg served inside a piece of toast, not to be confused with the English recipe of the same name."),
    materials = { "wheat", "egg" },
    comestible = { vitamins = { { id = "wheat_allergen", amount = 1 }, { id = "egg_allergen", amount = 1 } } },
    inheritance = { add = { flags = { "EATEN_HOT", "FREEZERBURN" } }, offset = { fun = 4 } },
}

ccb.content.define_item {
    id = "PBJ_Toast",
    name = ccb.content.plural_text("PBJ toast", "PBJ toast"),
    copy_from = "toast",
    description = ccb.content.text("A slice of toast with peanut butter and jelly on top, with added butter for flavor."),
    materials = {
        { id = "fruit", portions = 1 },
        { id = "milk", portions = 1 },
        { id = "wheat", portions = 10 },
    },
    comestible = {
        vitamins = {
            { id = "wheat_allergen", amount = 1 },
            { id = "fruit_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
    inheritance = { offset = { fun = 7 } },
}

ccb.content.define_item {
    id = "cornbread",
    name = ccb.content.plural_text("cornbread", "cornbread"),
    mass = "15 g",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("Healthy and filling cornbread, a Native American recipe that quickly became a staple of U.S. cuisine."),
    price = "37 cent",
    survival_price = "50 cent",
    materials = { "veggy" },
    volume = "60 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "30 days",
        kind = "FOOD",
        calories = 198,
        fun = 2,
        vitamins = {
            { id = "calcium", amount = 8 },
            { id = "iron", amount = 6 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "johnnycake",
    name = ccb.content.text("johnnycake"),
    mass = "49 g",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("A dense and tasty fried bread treat."),
    price = "45 cent",
    survival_price = "50 cent",
    materials = { { id = "junk", portions = 1 }, { id = "wheat", portions = 10 } },
    volume = "41 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "20 days",
        kind = "FOOD",
        calories = 159,
        fun = 2,
        vitamins = {
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 7 },
            { id = "wheat_allergen", amount = 1 },
            { id = "junk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "tortilla_corn",
    name = ccb.content.text("corn tortilla"),
    mass = "24 g",
    color = "brown",
    default_container = "bag_plastic",
    symbol = "%",
    description = ccb.content.text("A round, thin flatbread made from finely ground corn flour."),
    price = "4 cent",
    survival_price = "4 cent",
    materials = { "veggy" },
    volume = "20 ml",
    flags = { "EATEN_HOT", "EDIBLE_FROZEN" },
    stackable = true,
    comestible = {
        shelf_life = "20 days",
        kind = "FOOD",
        calories = 52,
        fun = 1,
        vitamins = {
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "tortilla_flour",
    name = ccb.content.text("flour tortilla"),
    mass = "18 g",
    color = "brown",
    default_container = "bag_plastic",
    symbol = "%",
    description = ccb.content.text("A round, thin flatbread made from finely ground wheat flour."),
    price = "4 cent",
    survival_price = "4 cent",
    materials = { "wheat" },
    volume = "20 ml",
    flags = { "EATEN_HOT", "EDIBLE_FROZEN" },
    stackable = true,
    comestible = {
        shelf_life = "15 days",
        kind = "FOOD",
        calories = 135,
        fun = 1,
        vitamins = {
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "hardtack_cracker",
    name = ccb.content.plural_text("hardtack cracker", "hardtack cracker"),
    mass = "420 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("A dry, virtually tasteless bread cracker capable of remaining edible without spoilage for vast lengths of time.  So hard it is inedible by itself.  Usually broken into smaller pieces for consumption."),
    price = "6 cent",
    survival_price = "7 cent",
    materials = { "wheat" },
    volume = "420 ml",
    flags = { "INEDIBLE" },
    stackable = true,
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        quench = -12,
        calories = 1680,
        vitamins = {
            { id = "calcium", amount = 12 },
            { id = "iron", amount = 90 },
            { id = "wheat_allergen", amount = 1 },
        },
        fun = -4,
    },
}

ccb.content.define_item {
    id = "hardtack",
    name = ccb.content.plural_text("hardtack", "hardtack"),
    mass = "70 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("A dry, virtually tasteless bread product capable of remaining edible without spoilage for vast lengths of time.  So hard it is inedible by itself."),
    price = "6 cent",
    survival_price = "7 cent",
    materials = { "wheat" },
    volume = "70 ml",
    flags = { "INEDIBLE" },
    stackable = true,
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        quench = -2,
        calories = 280,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 15 },
            { id = "wheat_allergen", amount = 1 },
        },
        fun = -4,
    },
}

ccb.content.define_item {
    id = "soggy_hardtack",
    name = ccb.content.plural_text("soggy hardtack", "soggy hardtack"),
    mass = "75 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("A soggy, virtually tasteless bread product that has soaked up enough water that it won't hurt your teeth when you chew it."),
    price = "6 cent",
    survival_price = "7 cent",
    materials = { "wheat" },
    volume = "70 ml",
    flags = { "EDIBLE_FROZEN" },
    stackable = true,
    comestible = {
        shelf_life = "5 days",
        kind = "FOOD",
        calories = 280,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 15 },
            { id = "wheat_allergen", amount = 1 },
        },
        fun = -1,
    },
}

ccb.content.define_item {
    id = "biscuit",
    name = ccb.content.text("biscuit"),
    mass = "30 g",
    color = "brown",
    default_container = "box_small",
    symbol = "%",
    description = ccb.content.text("Hardtack's much more palatable descendant, thanks in large part to the addition of milk in the recipe.  Crumbly on the outside, soft on the inside, and delicious all the way through."),
    price = "5 cent",
    survival_price = "25 cent",
    materials = { "wheat" },
    volume = "25 ml",
    flags = { "EATEN_HOT", "EDIBLE_FROZEN" },
    stackable = true,
    comestible = {
        shelf_life = "7 days 12 hours",
        kind = "FOOD",
        calories = 148,
        fun = 3,
        vitamins = {
            { id = "calcium", amount = 11 },
            { id = "iron", amount = 9 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

-- avg bread density is 0.25
-- this item will generally inherit its values, so it is essentially a copy of bread
ccb.content.define_item {
    id = "wastebread",
    name = ccb.content.plural_text("wastebread", "wastebread"),
    mass = "15 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("Flour is a commodity these days and to deal with that, most survivors resort to mixing it with leftovers of other ingredients and baking it all into bread.  It's filling, and that's what matters."),
    price = "20 cent",
    survival_price = "2 cent",
    materials = { { id = "junk", portions = 1 }, { id = "wheat", portions = 10 } },
    volume = "60 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "41 days",
        kind = "FOOD",
        quench = -3,
        calories = 80,
        fun = -1,
        vitamins = {
            { id = "calcium", amount = 12 },
            { id = "wheat_allergen", amount = 1 },
            { id = "junk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "brown_bread",
    name = ccb.content.plural_text("brown bread", "brown bread"),
    mass = "45 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Sweet bread made with molasses, with a consistency closer to cake."),
    price = "136 cent",
    survival_price = "1 USD",
    materials = { "wheat" },
    volume = "48 ml",
    flags = { "EATEN_HOT", "EATEN_COLD" },
    stackable = true,
    comestible = {
        shelf_life = "10 days",
        kind = "FOOD",
        calories = 130,
        fun = 3,
        vitamins = {
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 4 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "hallula",
    name = ccb.content.plural_text("hallula", "hallula"),
    mass = "45 g",
    color = "brown",
    default_container = "bag_plastic",
    symbol = "%",
    description = ccb.content.text("A type of bread popular in Chile and Bolivia.  Prepared using animal tallow or oil, it resembles a large, round scone.  In the pre-Cataclysm world, it would usually be filled with savory ingredients."),
    price = "136 cent",
    survival_price = "2 USD",
    materials = { "wheat" },
    volume = "48 ml",
    flags = { "EATEN_HOT", "EATEN_COLD" },
    stackable = true,
    comestible = {
        shelf_life = "10 days",
        kind = "FOOD",
        calories = 61,
        fun = 4,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 6 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}
