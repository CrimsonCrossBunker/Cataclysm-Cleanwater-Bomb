local ccb = require("ccb")

ccb.content.define_item {
    id = "fruit_leather",
    name = ccb.content.plural_text("fruit leather", "fruit leather"),
    conditional_names = {
        {
            kind = "COMPONENT_ID",
            key = "apple",
            name = ccb.content.plural_text("%s, apple", "%s, apple"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "apricot",
            name = ccb.content.plural_text("%s, apricot", "%s, apricot"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "banana",
            name = ccb.content.plural_text("%s, banana", "%s, banana"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "blackberries",
            name = ccb.content.plural_text("%s, blackberry", "%s, blackberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "blueberries",
            name = ccb.content.plural_text("%s, blueberry", "%s, blueberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "cherries",
            name = ccb.content.plural_text("%s, cherry", "%s, cherry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "chokeberries",
            name = ccb.content.plural_text("%s, chokeberries", "%s, chokeberries"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "crabapple",
            name = ccb.content.plural_text("%s, crabapple", "%s, crabapple"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "elderberries",
            name = ccb.content.plural_text("%s, elderberry", "%s, elderberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "grapefruit",
            name = ccb.content.plural_text("%s, grapefruit", "%s, grapefruit"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "grapes",
            name = ccb.content.plural_text("%s, grape", "%s, grape"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "guayaba",
            name = ccb.content.plural_text("%s, guava", "%s, guava"),
        },
        {
            kind = "COMPONENT_ID",
            key = "hobbleberries",
            name = ccb.content.plural_text("%s, hobbleberry", "%s, hobbleberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "huckleberries",
            name = ccb.content.plural_text("%s, huckleberry", "%s, huckleberry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "irradiated_apple",
            name = ccb.content.plural_text("%s, apple", "%s, apple"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "kiwi",
            name = ccb.content.plural_text("%s, kiwi", "%s, kiwi"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "lulo",
            name = ccb.content.plural_text("%s, lulo", "%s, lulo"),
        },
        {
            kind = "COMPONENT_ID",
            key = "m_stellatum_berries",
            name = ccb.content.plural_text("%s, Solomon's seal", "%s, Solomon's seal"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mango",
            name = ccb.content.plural_text("%s, mango", "%s, mango"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "maracuya",
            name = ccb.content.plural_text("%s, passionfruit", "%s, passionfruit"),
        },
        {
            kind = "COMPONENT_ID",
            key = "mayapple",
            name = ccb.content.plural_text("%s, mayapple", "%s, mayapple"),
        },
        {
            kind = "COMPONENT_ID",
            key = "melon_chunks",
            name = ccb.content.plural_text("%s, melon", "%s, melon"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mulberries",
            name = ccb.content.plural_text("%s, mulberry", "%s, mulberry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "nannyberries",
            name = ccb.content.plural_text("%s, nannyberries", "%s, nannyberries"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "orange",
            name = ccb.content.plural_text("%s, orange", "%s, orange"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "papaya",
            name = ccb.content.plural_text("%s, papaya", "%s, papaya"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "peach",
            name = ccb.content.plural_text("%s, peach", "%s, peach"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pear",
            name = ccb.content.plural_text("%s, pear", "%s, pear"),
        },
        {
            kind = "COMPONENT_ID",
            key = "pineapple_chunks",
            name = ccb.content.plural_text("%s, pineapple", "%s, pineapple"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "plums",
            name = ccb.content.plural_text("%s, plum", "%s, plum"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pomegranate",
            name = ccb.content.plural_text("%s, pomegranate", "%s, pomegranate"),
        },
        {
            kind = "COMPONENT_ID",
            key = "pumpkin_cut",
            name = ccb.content.plural_text("%s, pumpkin", "%s, pumpkin"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "raspberries",
            name = ccb.content.plural_text("%s, raspberry", "%s, raspberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "rose_hips_cut",
            name = ccb.content.plural_text("%s, rose hip", "%s, rose hip"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "strawberries",
            name = ccb.content.plural_text("%s, strawberry", "%s, strawberry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "tupelo_fruit",
            name = ccb.content.plural_text("%s, tupelo fruit", "%s, tupelo fruit"),
        },
        {
            kind = "COMPONENT_ID",
            key = "watermelon_wedge",
            name = ccb.content.plural_text("%s, watermelon", "%s, watermelon"),
        },
        {
            kind = "COMPONENT_ID",
            key = "wintergreen_berry",
            name = ccb.content.plural_text("%s, wintergreen berry", "%s, wintergreen berry"),
        },
    },
    mass = "34 g",
    color = "pink",
    default_container = "bag_plastic_small",
    symbol = "%",
    description = ccb.content.text("Dried strips of sugary fruit paste."),
    price = "32 cent",
    survival_price = "50 cent",
    materials = { { id = "dried_vegetable", portions = 10 }, { id = "fruit", portions = 1 } },
    volume = "50 ml",
    flags = { "EDIBLE_FROZEN" },
    stackable = true,
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        calories = 122,
        vitamins = {
            { id = "vitC", amount = 21 },
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 4 },
            { id = "fruit_allergen", amount = 1 },
        },
        fun = 3,
    },
}

ccb.content.define_item {
    id = "can_peach",
    name = ccb.content.plural_text("peaches in syrup", "peaches in syrup"),
    mass = "251 g",
    color = "yellow",
    default_container = "can_food",
    symbol = "%",
    sealed_container = true,
    description = ccb.content.text("Yellow cling peach slices packed in light syrup."),
    price = "96 cent",
    survival_price = "1 USD 50 cent",
    materials = { "fruit" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        shelf_life = "1 day 6 hours",
        kind = "FOOD",
        quench = 6,
        calories = 135,
        fun = 5,
        vitamins = {
            { id = "vitC", amount = "6 mg" },
            { id = "iron", amount = "900 μg" },
            { id = "calcium", amount = "7500 μg" },
            { id = "fruit_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "can_pineapple",
    name = ccb.content.plural_text("canned pineapple", "canned pineapple"),
    mass = "246 g",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("Canned pineapple rings in water.  Quite tasty."),
    price = "43 cent",
    survival_price = "75 cent",
    materials = { "fruit" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        quench = 5,
        calories = 78,
        fun = 7,
        vitamins = {
            { id = "vitC", amount = "18900 μg" },
            { id = "iron", amount = "1 mg" },
            { id = "calcium", amount = "36900 μg" },
            { id = "fruit_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "lemonade_powder",
    name = ccb.content.plural_text("lemonade drink mix", "lemonade drink mix"),
    mass = "19 g",
    color = "yellow",
    default_container = "bottle_plastic_small",
    symbol = "%",
    description = ccb.content.text("Tangy yellow powder that smells strongly of lemons.  Can be mixed with water to make lemonade."),
    display_type = "BY_WEIGHT",
    price = "1 cent",
    survival_price = "1 cent",
    materials = { { id = "powder", portions = 10 }, { id = "fruit", portions = 1 } },
    volume = "25 ml",
    flags = { "EDIBLE_FROZEN", "SOFT", "WATER_DISSOLVE" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        quench = -1,
        calories = 104,
        vitamins = { { id = "vitC", amount = 7 }, { id = "fruit_allergen", amount = 1 } },
        fun = 1,
    },
}

ccb.content.define_item {
    id = "orangeade_powder",
    name = ccb.content.plural_text("orangeade drink mix", "orangeade drink mix"),
    copy_from = "lemonade_powder",
    description = ccb.content.text("Can be mixed with water to make orange juice."),
    comestible = {},
}

ccb.content.define_item {
    id = "grapeade_powder",
    name = ccb.content.plural_text("grapeade drink mix", "grapeade drink mix"),
    copy_from = "lemonade_powder",
    description = ccb.content.text("Can be mixed with water to make grape juice."),
    comestible = {},
}

ccb.content.define_item {
    id = "jam_fruit",
    name = ccb.content.plural_text("fruit jam", "fruit jam"),
    conditional_names = {
        {
            kind = "COMPONENT_ID",
            key = "apple",
            name = ccb.content.plural_text("%s, apple", "%s, apple"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "apricot",
            name = ccb.content.plural_text("%s, apricot", "%s, apricot"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "banana",
            name = ccb.content.plural_text("%s, banana", "%s, banana"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "blackberries",
            name = ccb.content.plural_text("%s, blackberry", "%s, blackberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "blueberries",
            name = ccb.content.plural_text("%s, blueberry", "%s, blueberry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "chokeberries",
            name = ccb.content.plural_text("%s, chokeberries", "%s, chokeberries"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "cherries",
            name = ccb.content.plural_text("%s, cherry", "%s, cherry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "crabapple",
            name = ccb.content.plural_text("%s, crabapple", "%s, crabapple"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "elderberries",
            name = ccb.content.plural_text("%s, elderberry", "%s, elderberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "grapefruit",
            name = ccb.content.plural_text("%s, grapefruit", "%s, grapefruit"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "grapes",
            name = ccb.content.plural_text("%s, grape", "%s, grape"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "guayaba",
            name = ccb.content.plural_text("%s, guava", "%s, guava"),
        },
        {
            kind = "COMPONENT_ID",
            key = "hobbleberries",
            name = ccb.content.plural_text("%s, hobbleberry", "%s, hobbleberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "huckleberries",
            name = ccb.content.plural_text("%s, huckleberry", "%s, huckleberry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "irradiated_apple",
            name = ccb.content.plural_text("%s, apple", "%s, apple"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "kiwi",
            name = ccb.content.plural_text("%s, kiwi", "%s, kiwi"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "lulo",
            name = ccb.content.plural_text("%s, lulo", "%s, lulo"),
        },
        {
            kind = "COMPONENT_ID",
            key = "m_stellatum_berries",
            name = ccb.content.plural_text("%s, Solomon's seal", "%s, Solomon's seal"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mango",
            name = ccb.content.plural_text("%s, mango", "%s, mango"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "maracuya",
            name = ccb.content.plural_text("%s, passionfruit", "%s, passionfruit"),
        },
        {
            kind = "COMPONENT_ID",
            key = "mayapple",
            name = ccb.content.plural_text("%s, mayapple", "%s, mayapple"),
        },
        {
            kind = "COMPONENT_ID",
            key = "melon_chunks",
            name = ccb.content.plural_text("%s, melon", "%s, melon"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mulberries",
            name = ccb.content.plural_text("%s, mulberry", "%s, mulberry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "nannyberries",
            name = ccb.content.plural_text("%s, nannyberries", "%s, nannyberries"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "orange",
            name = ccb.content.plural_text("%s, orange", "%s, orange"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "papaya",
            name = ccb.content.plural_text("%s, papaya", "%s, papaya"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "peach",
            name = ccb.content.plural_text("%s, peach", "%s, peach"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pear",
            name = ccb.content.plural_text("%s, pear", "%s, pear"),
        },
        {
            kind = "COMPONENT_ID",
            key = "pineapple_chunks",
            name = ccb.content.plural_text("%s, pineapple", "%s, pineapple"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "plums",
            name = ccb.content.plural_text("%s, plum", "%s, plum"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pomegranate",
            name = ccb.content.plural_text("%s, pomegranate", "%s, pomegranate"),
        },
        {
            kind = "COMPONENT_ID",
            key = "pumpkin_cut",
            name = ccb.content.plural_text("%s, pumpkin", "%s, pumpkin"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "raspberries",
            name = ccb.content.plural_text("%s, raspberry", "%s, raspberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "rose_hips_cut",
            name = ccb.content.plural_text("%s, rose hip", "%s, rose hip"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "strawberries",
            name = ccb.content.plural_text("%s, strawberry", "%s, strawberry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "tupelo_fruit",
            name = ccb.content.plural_text("%s, tupelo fruit", "%s, tupelo fruit"),
        },
        {
            kind = "COMPONENT_ID",
            key = "watermelon_wedge",
            name = ccb.content.plural_text("%s, watermelon", "%s, watermelon"),
        },
        {
            kind = "COMPONENT_ID",
            key = "wintergreen_berry",
            name = ccb.content.plural_text("%s, wintergreen berry", "%s, wintergreen berry"),
        },
    },
    mass = "15 g",
    color = "red",
    default_container = "jar_glass_sealed",
    symbol = "~",
    description = ccb.content.text("Fresh fruit cooked with sugar to make it last longer."),
    display_type = "BY_VOLUME",
    price = "80 cent",
    survival_price = "75 cent",
    materials = { "fruit" },
    sealed_container = true,
    volume = "125 ml",
    phase = "liquid",
    flags = { "USE_EAT_VERB" },
    comestible = {
        shelf_life = "10 days",
        kind = "DRINK",
        calories = 35,
        servings = 8,
        fun = 10,
        vitamins = { { id = "fruit_allergen", amount = 1 } },
    },
}

-- most of the water weight and volume is lost
ccb.content.define_item {
    id = "dry_fruit",
    name = ccb.content.plural_text("dehydrated fruit", "dehydrated fruit"),
    conditional_names = {
        {
            kind = "COMPONENT_ID",
            key = "apple",
            name = ccb.content.plural_text("%s, apple", "%s, apple"),
        },
        {
            kind = "COMPONENT_ID",
            key = "irradiated_apple",
            name = ccb.content.plural_text("%s, apple", "%s, apple"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "apricot",
            name = ccb.content.plural_text("%s, apricot", "%s, apricot"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "banana",
            name = ccb.content.plural_text("%s, banana", "%s, banana"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "blackberries",
            name = ccb.content.plural_text("%s, blackberry", "%s, blackberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "blueberries",
            name = ccb.content.plural_text("%s, blueberry", "%s, blueberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "cherries",
            name = ccb.content.plural_text("%s, cherry", "%s, cherry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "chokeberries",
            name = ccb.content.plural_text("%s, chokeberries", "%s, chokeberries"),
        },
        {
            kind = "COMPONENT_ID",
            key = "cholla_bud",
            name = ccb.content.plural_text("%s, cholla bud", "%s, cholla bud"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "coconut",
            name = ccb.content.plural_text("%s, coconut", "%s, coconut"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "crabapple",
            name = ccb.content.plural_text("%s, crabapple", "%s, crabapple"),
        },
        {
            kind = "COMPONENT_ID",
            key = "cranberries",
            name = ccb.content.plural_text("%s, cranberry", "%s, cranberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "elderberries",
            name = ccb.content.plural_text("%s, elderberry", "%s, elderberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "grapefruit",
            name = ccb.content.plural_text("%s, grapefruit", "%s, grapefruit"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "grapes",
            name = ccb.content.plural_text("%s, grape", "%s, grape"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "guayaba",
            name = ccb.content.plural_text("%s, guava", "%s, guava"),
        },
        {
            kind = "COMPONENT_ID",
            key = "hobbleberries",
            name = ccb.content.plural_text("%s, hobbleberry", "%s, hobbleberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "huckleberries",
            name = ccb.content.plural_text("%s, huckleberry", "%s, huckleberry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "juice_pulp",
            name = ccb.content.plural_text("%s, juice pulp", "%s, juice pulp"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "kiwi",
            name = ccb.content.plural_text("%s, kiwi", "%s, kiwi"),
        },
        {
            kind = "COMPONENT_ID",
            key = "lemon",
            name = ccb.content.plural_text("%s, lemon", "%s, lemon"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "lulo",
            name = ccb.content.plural_text("%s, lulo", "%s, lulo"),
        },
        {
            kind = "COMPONENT_ID",
            key = "m_stellatum_berries",
            name = ccb.content.plural_text("%s, Solomon's seal", "%s, Solomon's seal"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mango",
            name = ccb.content.plural_text("%s, mango", "%s, mango"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "maracuya",
            name = ccb.content.plural_text("%s, passionfruit", "%s, passionfruit"),
        },
        {
            kind = "COMPONENT_ID",
            key = "mayapple",
            name = ccb.content.plural_text("%s, mayapple", "%s, mayapple"),
        },
        {
            kind = "COMPONENT_ID",
            key = "melon",
            name = ccb.content.plural_text("%s, melon", "%s, melon"),
        },
        {
            kind = "COMPONENT_ID",
            key = "melon_chunks",
            name = ccb.content.plural_text("%s, melon", "%s, melon"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mulberries",
            name = ccb.content.plural_text("%s, mulberry", "%s, mulberry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "nannyberries",
            name = ccb.content.plural_text("%s, nannyberries", "%s, nannyberries"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "orange",
            name = ccb.content.plural_text("%s, orange", "%s, orange"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "papaya",
            name = ccb.content.plural_text("%s, papaya", "%s, papaya"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "peach",
            name = ccb.content.plural_text("%s, peach", "%s, peach"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pear",
            name = ccb.content.plural_text("%s, pear", "%s, pear"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pineapple",
            name = ccb.content.plural_text("%s, pineapple", "%s, pineapple"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "plums",
            name = ccb.content.plural_text("%s, plum", "%s, plum"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pomegranate",
            name = ccb.content.plural_text("%s, pomegranate", "%s, pomegranate"),
        },
        {
            kind = "COMPONENT_ID",
            key = "pumpkin_cut",
            name = ccb.content.plural_text("%s, pumpkin", "%s, pumpkin"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "raspberries",
            name = ccb.content.plural_text("%s, raspberry", "%s, raspberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "rose_hips_cut",
            name = ccb.content.plural_text("%s, rose hip", "%s, rose hip"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "strawberries",
            name = ccb.content.plural_text("%s, strawberry", "%s, strawberry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "tupelo_fruit",
            name = ccb.content.plural_text("%s, tupelo fruit", "%s, tupelo fruit"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "watermelon",
            name = ccb.content.plural_text("%s, watermelon", "%s, watermelon"),
        },
        {
            kind = "COMPONENT_ID",
            key = "wintergreen_berry",
            name = ccb.content.plural_text("%s, wintergreen berry", "%s, wintergreen berry"),
        },
    },
    mass = "30 g",
    color = "magenta",
    symbol = "%",
    description = ccb.content.text("Dehydrated fruit flakes.  With proper storage, this dried food will remain edible for an incredibly long time.  They are useful for several cooking recipes."),
    display_type = "BY_WEIGHT",
    price = "9 USD",
    survival_price = "1 USD",
    materials = { { id = "dried_vegetable", portions = 10 }, { id = "fruit", portions = 1 } },
    volume = "100 ml",
    flags = { "EDIBLE_FROZEN" },
    stackable = true,
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        quench = -2,
        calories = 100,
        fun = 2,
        vitamins = { { id = "fruit_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "rehydrated_fruit",
    name = ccb.content.plural_text("rehydrated fruit", "rehydrated fruit"),
    conditional_names = {
        {
            kind = "COMPONENT_ID",
            key = "apple",
            name = ccb.content.plural_text("%s, apple", "%s, apple"),
        },
        {
            kind = "COMPONENT_ID",
            key = "irradiated_apple",
            name = ccb.content.plural_text("%s, apple", "%s, apple"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "apricot",
            name = ccb.content.plural_text("%s, apricot", "%s, apricot"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "banana",
            name = ccb.content.plural_text("%s, banana", "%s, banana"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "blackberries",
            name = ccb.content.plural_text("%s, blackberry", "%s, blackberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "blueberries",
            name = ccb.content.plural_text("%s, blueberry", "%s, blueberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "cherries",
            name = ccb.content.plural_text("%s, cherry", "%s, cherry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "chokeberries",
            name = ccb.content.plural_text("%s, chokeberries", "%s, chokeberries"),
        },
        {
            kind = "COMPONENT_ID",
            key = "cholla_bud",
            name = ccb.content.plural_text("%s, cholla bud", "%s, cholla bud"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "coconut",
            name = ccb.content.plural_text("%s, coconut", "%s, coconut"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "crabapple",
            name = ccb.content.plural_text("%s, crabapple", "%s, crabapple"),
        },
        {
            kind = "COMPONENT_ID",
            key = "cranberries",
            name = ccb.content.plural_text("%s, cranberry", "%s, cranberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "elderberries",
            name = ccb.content.plural_text("%s, elderberry", "%s, elderberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "grapefruit",
            name = ccb.content.plural_text("%s, grapefruit", "%s, grapefruit"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "grapes",
            name = ccb.content.plural_text("%s, grape", "%s, grape"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "guayaba",
            name = ccb.content.plural_text("%s, guava", "%s, guava"),
        },
        {
            kind = "COMPONENT_ID",
            key = "hobbleberries",
            name = ccb.content.plural_text("%s, hobbleberry", "%s, hobbleberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "huckleberries",
            name = ccb.content.plural_text("%s, huckleberry", "%s, huckleberry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "juice_pulp",
            name = ccb.content.plural_text("%s, juice pulp", "%s, juice pulp"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "kiwi",
            name = ccb.content.plural_text("%s, kiwi", "%s, kiwi"),
        },
        {
            kind = "COMPONENT_ID",
            key = "lemon",
            name = ccb.content.plural_text("%s, lemon", "%s, lemon"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "lulo",
            name = ccb.content.plural_text("%s, lulo", "%s, lulo"),
        },
        {
            kind = "COMPONENT_ID",
            key = "m_stellatum_berries",
            name = ccb.content.plural_text("%s, Solomon's seal", "%s, Solomon's seal"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mango",
            name = ccb.content.plural_text("%s, mango", "%s, mango"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "maracuya",
            name = ccb.content.plural_text("%s, passionfruit", "%s, passionfruit"),
        },
        {
            kind = "COMPONENT_ID",
            key = "mayapple",
            name = ccb.content.plural_text("%s, mayapple", "%s, mayapple"),
        },
        {
            kind = "COMPONENT_ID",
            key = "melon",
            name = ccb.content.plural_text("%s, melon", "%s, melon"),
        },
        {
            kind = "COMPONENT_ID",
            key = "melon_chunks",
            name = ccb.content.plural_text("%s, melon", "%s, melon"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mulberries",
            name = ccb.content.plural_text("%s, mulberry", "%s, mulberry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "nannyberries",
            name = ccb.content.plural_text("%s, nannyberries", "%s, nannyberries"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "orange",
            name = ccb.content.plural_text("%s, orange", "%s, orange"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "papaya",
            name = ccb.content.plural_text("%s, papaya", "%s, papaya"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "peach",
            name = ccb.content.plural_text("%s, peach", "%s, peach"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pear",
            name = ccb.content.plural_text("%s, pear", "%s, pear"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pineapple",
            name = ccb.content.plural_text("%s, pineapple", "%s, pineapple"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "plums",
            name = ccb.content.plural_text("%s, plum", "%s, plum"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pomegranate",
            name = ccb.content.plural_text("%s, pomegranate", "%s, pomegranate"),
        },
        {
            kind = "COMPONENT_ID",
            key = "pumpkin_cut",
            name = ccb.content.plural_text("%s, pumpkin", "%s, pumpkin"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "raspberries",
            name = ccb.content.plural_text("%s, raspberry", "%s, raspberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "rose_hips_cut",
            name = ccb.content.plural_text("%s, rose hip", "%s, rose hip"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "strawberries",
            name = ccb.content.plural_text("%s, strawberry", "%s, strawberry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "tupelo_fruit",
            name = ccb.content.plural_text("%s, tupelo fruit", "%s, tupelo fruit"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "watermelon",
            name = ccb.content.plural_text("%s, watermelon", "%s, watermelon"),
        },
        {
            kind = "COMPONENT_ID",
            key = "wintergreen_berry",
            name = ccb.content.plural_text("%s, wintergreen berry", "%s, wintergreen berry"),
        },
    },
    mass = "150 g",
    color = "pink",
    symbol = "%",
    description = ccb.content.text("Reconstituted fruit flakes, which are much more enjoyable to eat now that they have been rehydrated."),
    display_type = "BY_WEIGHT",
    price = "9 USD",
    survival_price = "50 cent",
    materials = { "fruit" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        shelf_life = "18 hours",
        kind = "FOOD",
        quench = 1,
        calories = 100,
        fun = 4,
        vitamins = { { id = "fruit_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "apple_sugar",
    name = ccb.content.plural_text("fruit slice", "fruit slice"),
    conditional_names = {
        {
            kind = "COMPONENT_ID",
            key = "apple",
            name = ccb.content.plural_text("%s, apple", "%s, apple"),
        },
        {
            kind = "COMPONENT_ID",
            key = "irradiated_apple",
            name = ccb.content.plural_text("%s, apple", "%s, apple"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "apricot",
            name = ccb.content.plural_text("%s, apricot", "%s, apricot"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "banana",
            name = ccb.content.plural_text("%s, banana", "%s, banana"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "blackberries",
            name = ccb.content.plural_text("%s, blackberry", "%s, blackberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "blueberries",
            name = ccb.content.plural_text("%s, blueberry", "%s, blueberry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "chokeberries",
            name = ccb.content.plural_text("%s, chokeberries", "%s, chokeberries"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "cherries",
            name = ccb.content.plural_text("%s, cherry", "%s, cherry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "crabapple",
            name = ccb.content.plural_text("%s, crabapple", "%s, crabapple"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "elderberries",
            name = ccb.content.plural_text("%s, elderberry", "%s, elderberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "grapefruit",
            name = ccb.content.plural_text("%s, grapefruit", "%s, grapefruit"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "grapes",
            name = ccb.content.plural_text("%s, grape", "%s, grape"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "guayaba",
            name = ccb.content.plural_text("%s, guava", "%s, guava"),
        },
        {
            kind = "COMPONENT_ID",
            key = "hobbleberries",
            name = ccb.content.plural_text("%s, hobbleberry", "%s, hobbleberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "huckleberries",
            name = ccb.content.plural_text("%s, huckleberry", "%s, huckleberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "kiwi",
            name = ccb.content.plural_text("%s, kiwi", "%s, kiwi"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "lulo",
            name = ccb.content.plural_text("%s, lulo", "%s, lulo"),
        },
        {
            kind = "COMPONENT_ID",
            key = "m_stellatum_berries",
            name = ccb.content.plural_text("%s, Solomon's seal", "%s, Solomon's seal"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mango",
            name = ccb.content.plural_text("%s, mango", "%s, mango"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "maracuya",
            name = ccb.content.plural_text("%s, passionfruit", "%s, passionfruit"),
        },
        {
            kind = "COMPONENT_ID",
            key = "mayapple",
            name = ccb.content.plural_text("%s, mayapple", "%s, mayapple"),
        },
        {
            kind = "COMPONENT_ID",
            key = "melon_chunks",
            name = ccb.content.plural_text("%s, melon", "%s, melon"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mulberries",
            name = ccb.content.plural_text("%s, mulberry", "%s, mulberry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "nannyberries",
            name = ccb.content.plural_text("%s, nannyberries", "%s, nannyberries"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "orange",
            name = ccb.content.plural_text("%s, orange", "%s, orange"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "papaya",
            name = ccb.content.plural_text("%s, papaya", "%s, papaya"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "peach",
            name = ccb.content.plural_text("%s, peach", "%s, peach"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pear",
            name = ccb.content.plural_text("%s, pear", "%s, pear"),
        },
        {
            kind = "COMPONENT_ID",
            key = "pineapple_chunks",
            name = ccb.content.plural_text("%s, pineapple", "%s, pineapple"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "plums",
            name = ccb.content.plural_text("%s, plum", "%s, plum"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pomegranate",
            name = ccb.content.plural_text("%s, pomegranate", "%s, pomegranate"),
        },
        {
            kind = "COMPONENT_ID",
            key = "pumpkin_cut",
            name = ccb.content.plural_text("%s, pumpkin", "%s, pumpkin"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "raspberries",
            name = ccb.content.plural_text("%s, raspberry", "%s, raspberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "rose_hips_cut",
            name = ccb.content.plural_text("%s, rose hip", "%s, rose hip"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "strawberries",
            name = ccb.content.plural_text("%s, strawberry", "%s, strawberry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "tupelo_fruit",
            name = ccb.content.plural_text("%s, tupelo fruit", "%s, tupelo fruit"),
        },
        {
            kind = "COMPONENT_ID",
            key = "watermelon_wedge",
            name = ccb.content.plural_text("%s, watermelon", "%s, watermelon"),
        },
        {
            kind = "COMPONENT_ID",
            key = "wintergreen_berry",
            name = ccb.content.plural_text("%s, wintergreen berry", "%s, wintergreen berry"),
        },
    },
    mass = "42 g",
    color = "red",
    default_container = "plastic_bag_vac",
    symbol = "%",
    description = ccb.content.text("Fruit slices soaked in a sugar syrup to preserve freshness and appearance."),
    price = "112 cent",
    materials = { "fruit" },
    volume = "62 ml",
    stackable = true,
    comestible = {
        shelf_life = "7 days 12 hours",
        kind = "FOOD",
        quench = 3,
        calories = 82,
        fun = 3,
        vitamins = { { id = "iron", amount = 2 }, { id = "fruit_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "apple_canned",
    name = ccb.content.plural_text("canned fruit", "canned fruit"),
    conditional_names = {
        {
            kind = "COMPONENT_ID",
            key = "apple",
            name = ccb.content.plural_text("%s, apple", "%s, apple"),
        },
        {
            kind = "COMPONENT_ID",
            key = "irradiated_apple",
            name = ccb.content.plural_text("%s, apple", "%s, apple"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "apricot",
            name = ccb.content.plural_text("%s, apricot", "%s, apricot"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "banana",
            name = ccb.content.plural_text("%s, banana", "%s, banana"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "blackberries",
            name = ccb.content.plural_text("%s, blackberry", "%s, blackberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "blueberries",
            name = ccb.content.plural_text("%s, blueberry", "%s, blueberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "cherries",
            name = ccb.content.plural_text("%s, cherry", "%s, cherry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "chokeberries",
            name = ccb.content.plural_text("%s, chokeberries", "%s, chokeberries"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "crabapple",
            name = ccb.content.plural_text("%s, crabapple", "%s, crabapple"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "elderberries",
            name = ccb.content.plural_text("%s, elderberry", "%s, elderberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "grapefruit",
            name = ccb.content.plural_text("%s, grapefruit", "%s, grapefruit"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "grapes",
            name = ccb.content.plural_text("%s, grape", "%s, grape"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "guayaba",
            name = ccb.content.plural_text("%s, guava", "%s, guava"),
        },
        {
            kind = "COMPONENT_ID",
            key = "hobbleberries",
            name = ccb.content.plural_text("%s, hobbleberry", "%s, hobbleberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "huckleberries",
            name = ccb.content.plural_text("%s, huckleberry", "%s, huckleberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "kiwi",
            name = ccb.content.plural_text("%s, kiwi", "%s, kiwi"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "lulo",
            name = ccb.content.plural_text("%s, lulo", "%s, lulo"),
        },
        {
            kind = "COMPONENT_ID",
            key = "m_stellatum_berries",
            name = ccb.content.plural_text("%s, Solomon's seal", "%s, Solomon's seal"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mango",
            name = ccb.content.plural_text("%s, mango", "%s, mango"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "maracuya",
            name = ccb.content.plural_text("%s, passionfruit", "%s, passionfruit"),
        },
        {
            kind = "COMPONENT_ID",
            key = "mayapple",
            name = ccb.content.plural_text("%s, mayapple", "%s, mayapple"),
        },
        {
            kind = "COMPONENT_ID",
            key = "melon_chunks",
            name = ccb.content.plural_text("%s, melon", "%s, melon"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mulberries",
            name = ccb.content.plural_text("%s, mulberry", "%s, mulberry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "nannyberries",
            name = ccb.content.plural_text("%s, nannyberries", "%s, nannyberries"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "orange",
            name = ccb.content.plural_text("%s, orange", "%s, orange"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "papaya",
            name = ccb.content.plural_text("%s, papaya", "%s, papaya"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "peach",
            name = ccb.content.plural_text("%s, peach", "%s, peach"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pear",
            name = ccb.content.plural_text("%s, pear", "%s, pear"),
        },
        {
            kind = "COMPONENT_ID",
            key = "pineapple_chunks",
            name = ccb.content.plural_text("%s, pineapple", "%s, pineapple"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "plums",
            name = ccb.content.plural_text("%s, plum", "%s, plum"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pomegranate",
            name = ccb.content.plural_text("%s, pomegranate", "%s, pomegranate"),
        },
        {
            kind = "COMPONENT_ID",
            key = "pumpkin_cut",
            name = ccb.content.plural_text("%s, pumpkin", "%s, pumpkin"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "raspberries",
            name = ccb.content.plural_text("%s, raspberry", "%s, raspberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "rose_hips_cut",
            name = ccb.content.plural_text("%s, rose hip", "%s, rose hip"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "strawberries",
            name = ccb.content.plural_text("%s, strawberry", "%s, strawberry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "tupelo_fruit",
            name = ccb.content.plural_text("%s, tupelo fruit", "%s, tupelo fruit"),
        },
        {
            kind = "COMPONENT_ID",
            key = "watermelon_wedge",
            name = ccb.content.plural_text("%s, watermelon", "%s, watermelon"),
        },
        {
            kind = "COMPONENT_ID",
            key = "wintergreen_berry",
            name = ccb.content.plural_text("%s, wintergreen berry", "%s, wintergreen berry"),
        },
    },
    mass = "136 g",
    color = "red",
    symbol = "%",
    description = ccb.content.text("This sodden mass of preserved fruit was boiled and canned in an earlier life.  Bland, mushy, and losing its color."),
    price = "110 cent",
    survival_price = "25 cent",
    sealed_container = true,
    materials = { "fruit" },
    volume = "125 ml",
    stackable = true,
    comestible = {
        shelf_life = "7 days 12 hours",
        kind = "FOOD",
        quench = 3,
        calories = 275,
        fun = 1,
        vitamins = {
            { id = "vitC", amount = 3 },
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 10 },
            { id = "fruit_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "pumpkin_yeast_bread",
    name = ccb.content.plural_text("pumpkin yeast bread", "pumpkin yeast bread"),
    mass = "15 g",
    color = "red",
    symbol = "%",
    description = ccb.content.text("A festive autumnal bread with a golden color in either rolls or sliced loaves of bread."),
    price = "9 cent",
    survival_price = "2 cent",
    materials = { "fruit" },
    volume = "60 ml",
    stackable = true,
    comestible = {
        shelf_life = "7 days 12 hours",
        kind = "FOOD",
        quench = -1,
        calories = 130,
        fun = 3,
        vitamins = {
            { id = "vitC", amount = 3 },
            { id = "calcium", amount = 2 },
            { id = "fruit_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "hardtack_pudding",
    looks_like = "biscuit",
    name = ccb.content.text("hardtack pudding"),
    mass = "115 g",
    color = "brown",
    default_container = "can_medium",
    symbol = "o",
    description = ccb.content.text("An old recipe from the American Civil War, designed to make hardtack more palatable.  The hardtack is crushed and combined with water and flour to make dough, followed by kneading in pieces of fruit.  The dough is then boiled into bread pudding chunks and topped with sweeteners.  Soldiers would call this a dessert."),
    price = "50 cent",
    survival_price = "1 USD",
    materials = { "fruit", "wheat" },
    volume = "250 ml",
    phase = "liquid",
    flags = { "EATEN_HOT", "USE_EAT_VERB" },
    comestible = {
        shelf_life = "5 days",
        kind = "DRINK",
        quench = 2,
        calories = 150,
        servings = 2,
        vitamins = {
            { id = "vitC", amount = 2 },
            { id = "iron", amount = 15 },
            { id = "wheat_allergen", amount = 1 },
            { id = "fruit_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "jerusalem_artichoke_fruitmash",
    looks_like = "veggy_salad",
    name = ccb.content.plural_text("Jerusalem artichoke fruit dessert", "Jerusalem artichoke fruit dessert"),
    mass = "80 g",
    color = "yellow",
    symbol = "o",
    description = ccb.content.text("Chopped Jerusalem artichoke combined with any fruit that is in season or at hand.  Surprisingly tasty."),
    price = "12 cent",
    survival_price = "25 cent",
    materials = { "fruit", "veggy" },
    volume = "80 ml",
    flags = { "USE_EAT_VERB", "NUTRIENT_OVERRIDE" },
    stackable = true,
    comestible = {
        shelf_life = "3 days",
        kind = "FOOD",
        quench = 2,
        calories = 200,
        fun = 4,
        vitamins = {
            { id = "vitC", amount = 2 },
            { id = "iron", amount = 15 },
            { id = "veggy_allergen", amount = 1 },
            { id = "fruit_allergen", amount = 1 },
        },
    },
}

-- this item is intended to generally be inherited from the fruit and alcohol used.
ccb.content.define_item {
    id = "brandied_fruit",
    name = ccb.content.plural_text("brandied fruit", "brandied fruit"),
    conditional_names = {
        {
            kind = "COMPONENT_ID",
            key = "apple",
            name = ccb.content.plural_text("%s, apple", "%s, apple"),
        },
        {
            kind = "COMPONENT_ID",
            key = "irradiated_apple",
            name = ccb.content.plural_text("%s, apple", "%s, apple"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "apricot",
            name = ccb.content.plural_text("%s, apricot", "%s, apricot"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "banana",
            name = ccb.content.plural_text("%s, banana", "%s, banana"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "blackberries",
            name = ccb.content.plural_text("%s, blackberry", "%s, blackberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "blueberries",
            name = ccb.content.plural_text("%s, blueberry", "%s, blueberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "cherries",
            name = ccb.content.plural_text("%s, cherry", "%s, cherry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "chokeberries",
            name = ccb.content.plural_text("%s, chokeberries", "%s, chokeberries"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "crabapple",
            name = ccb.content.plural_text("%s, crabapple", "%s, crabapple"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "elderberries",
            name = ccb.content.plural_text("%s, elderberry", "%s, elderberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "grapefruit",
            name = ccb.content.plural_text("%s, grapefruit", "%s, grapefruit"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "grapes",
            name = ccb.content.plural_text("%s, grape", "%s, grape"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "guayaba",
            name = ccb.content.plural_text("%s, guava", "%s, guava"),
        },
        {
            kind = "COMPONENT_ID",
            key = "hobbleberries",
            name = ccb.content.plural_text("%s, hobbleberry", "%s, hobbleberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "huckleberries",
            name = ccb.content.plural_text("%s, huckleberry", "%s, huckleberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "kiwi",
            name = ccb.content.plural_text("%s, kiwi", "%s, kiwi"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "lulo",
            name = ccb.content.plural_text("%s, lulo", "%s, lulo"),
        },
        {
            kind = "COMPONENT_ID",
            key = "m_stellatum_berries",
            name = ccb.content.plural_text("%s, Solomon's seal", "%s, Solomon's seal"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mango",
            name = ccb.content.plural_text("%s, mango", "%s, mango"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "maracuya",
            name = ccb.content.plural_text("%s, passionfruit", "%s, passionfruit"),
        },
        {
            kind = "COMPONENT_ID",
            key = "mayapple",
            name = ccb.content.plural_text("%s, mayapple", "%s, mayapple"),
        },
        {
            kind = "COMPONENT_ID",
            key = "melon_chunks",
            name = ccb.content.plural_text("%s, melon", "%s, melon"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mulberries",
            name = ccb.content.plural_text("%s, mulberry", "%s, mulberry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "nannyberries",
            name = ccb.content.plural_text("%s, nannyberries", "%s, nannyberries"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "orange",
            name = ccb.content.plural_text("%s, orange", "%s, orange"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "papaya",
            name = ccb.content.plural_text("%s, papaya", "%s, papaya"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "peach",
            name = ccb.content.plural_text("%s, peach", "%s, peach"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pear",
            name = ccb.content.plural_text("%s, pear", "%s, pear"),
        },
        {
            kind = "COMPONENT_ID",
            key = "pineapple_chunks",
            name = ccb.content.plural_text("%s, pineapple", "%s, pineapple"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "plums",
            name = ccb.content.plural_text("%s, plum", "%s, plum"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pomegranate",
            name = ccb.content.plural_text("%s, pomegranate", "%s, pomegranate"),
        },
        {
            kind = "COMPONENT_ID",
            key = "pumpkin_cut",
            name = ccb.content.plural_text("%s, pumpkin", "%s, pumpkin"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "raspberries",
            name = ccb.content.plural_text("%s, raspberry", "%s, raspberry"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "rose_hips_cut",
            name = ccb.content.plural_text("%s, rose hip", "%s, rose hip"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "strawberries",
            name = ccb.content.plural_text("%s, strawberry", "%s, strawberry"),
        },
        {
            kind = "COMPONENT_ID",
            key = "tupelo_fruit",
            name = ccb.content.plural_text("%s, tupelo fruit", "%s, tupelo fruit"),
        },
        {
            kind = "COMPONENT_ID",
            key = "watermelon_wedge",
            name = ccb.content.plural_text("%s, watermelon", "%s, watermelon"),
        },
        {
            kind = "COMPONENT_ID",
            key = "wintergreen_berry",
            name = ccb.content.plural_text("%s, wintergreen berry", "%s, wintergreen berry"),
        },
    },
    mass = "180 g",
    color = "red",
    default_container = "jar_3l_glass_sealed",
    symbol = "~",
    description = ccb.content.text("Whole fruits preserved in 40 proof or higher alcohol."),
    display_type = "BY_VOLUME",
    price = "50 cent",
    survival_price = "50 cent",
    materials = { "fruit", "alcohol" },
    volume = "250 ml",
    phase = "liquid",
    sealed_container = true,
    flags = { "USE_EAT_VERB", "EATEN_COLD" },
    comestible = {
        shelf_life = "365 days",
        kind = "DRINK",
        calories = 90,
        addiction = "alcohol",
        addiction_potential = 5,
        quench = -6,
        servings = 1,
        fun = 9,
        vitamins = {
            { id = "vitC", amount = 20 },
            { id = "fruit_allergen", amount = 1 },
            { id = "ethanol", amount = 5 },
        },
    },
}
