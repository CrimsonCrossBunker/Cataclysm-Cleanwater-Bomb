local ccb = require("ccb")

-- they bring the boys to the yard
ccb.content.define_item {
    id = "milkshake",
    name = ccb.content.plural_text("milkshake", "milkshake"),
    description = ccb.content.text("An all-natural cold beverage made with milk and sweeteners.  Tastes great when frozen."),
    display_type = "BY_VOLUME",
    mass = "137 g",
    volume = "125 ml",
    default_container = "styrofoam_cup",
    symbol = "~",
    color = "white",
    price = "2 USD 50 cent",
    survival_price = "1 USD",
    materials = { "milk" },
    phase = "liquid",
    flags = { "MELTS" },
    comestible = {
        kind = "DRINK",
        shelf_life = "1 day",
        calories = 150,
        quench = 30,
        fun = 20,
        servings = 1,
        vitamins = { { id = "calcium", amount = 12 }, { id = "milk_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "milkshake_fastfood",
    copy_from = "milkshake",
    name = ccb.content.plural_text("fast food milkshake", "fast food milkshake"),
    description = ccb.content.text("A milkshake made by freezing a premade mix.  Incredibly sweet."),
    price = "2 USD 75 cent",
    survival_price = "1 USD",
    materials = { { id = "milk", portions = 10 }, { id = "junk", portions = 1 } },
    comestible = {
        calories = 175,
        fun = 23,
        healthy = -1,
        vitamins = { { id = "junk_allergen", amount = 1 }, { id = "milk_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "milkshake_choc",
    name = ccb.content.plural_text("chocolate milkshake", "chocolate milkshake"),
    copy_from = "milkshake",
    description = ccb.content.text("An all-natural cold beverage made with chocolate milk and sweeteners.  Tastes great when frozen."),
    color = "brown",
    comestible = { calories = 170 },
}

ccb.content.define_item {
    id = "milkshake_deluxe",
    copy_from = "milkshake",
    name = ccb.content.plural_text("deluxe milkshake", "deluxe milkshake"),
    description = ccb.content.text("This milkshake has been enhanced with the addition of candy or fruit."),
    price = "4 USD",
    survival_price = "1 USD 50 cent",
    materials = { { id = "milk", portions = 10 }, { id = "junk", portions = 1 } },
    comestible = {
        calories = 265,
        quench = 40,
        fun = 25,
        healthy = -1,
        vitamins = { { id = "junk_allergen", amount = 1 }, { id = "milk_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "milkshake_deluxe_choc",
    name = ccb.content.plural_text("deluxe chocolate milkshake", "deluxe chocolate milkshake"),
    copy_from = "milkshake_deluxe",
    description = ccb.content.text("This chocolate milkshake has been enhanced with the addition of candy or fruit."),
    comestible = { calories = 285 },
}

ccb.content.define_item {
    id = "frozen_lemonade",
    name = ccb.content.plural_text("frozen lemonade", "frozen lemonade"),
    copy_from = "milkshake",
    description = ccb.content.text("An all-natural cold beverage made with lemonade and sweeteners.  Tastes great when frozen."),
    color = "white",
    materials = { { id = "water", portions = 10 }, { id = "fruit", portions = 1 } },
    comestible = {
        calories = 220,
        vitamins = { { id = "vitC", amount = 6 }, { id = "fruit_allergen", amount = 1 } },
    },
}

-- had to make it a liquid, its not perfect but the alternative is barehanding loose ice soaked in liquid with no containers
ccb.content.define_item {
    id = "snowcone",
    name = ccb.content.text("snow cone"),
    conditional_names = {
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "apple_cider",
            name = ccb.content.plural_text("apple cider %s", "apple cider %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "apple",
            name = ccb.content.plural_text("apple %s", "apple %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "apricot",
            name = ccb.content.plural_text("apricot %s", "apricot %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "banana",
            name = ccb.content.plural_text("banana %s", "banana %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "blackberries",
            name = ccb.content.plural_text("blackberry %s", "blackberry %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "blueberries",
            name = ccb.content.plural_text("blueberry %s", "blueberry %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "cherries",
            name = ccb.content.plural_text("cherry %s", "cherry %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "choc",
            name = ccb.content.plural_text("chocolate %s", "chocolate %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "coconut",
            name = ccb.content.plural_text("coconut %s", "coconut %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "coffee",
            name = ccb.content.plural_text("coffee %s", "coffee %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "cola",
            name = ccb.content.plural_text("cola %s", "cola %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "cran",
            name = ccb.content.plural_text("cranberry %s", "cranberry %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "creamsoda",
            name = ccb.content.plural_text("cream soda %s", "cream soda %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "drink_pinitacolada",
            name = ccb.content.plural_text("piña colada %s", "piña colada %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "elderberries",
            name = ccb.content.plural_text("elderberry %s", "elderberry %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "foodplace_zero_drink",
            name = ccb.content.plural_text("refreshing™ %s", "refreshing™ %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "grapefruit",
            name = ccb.content.plural_text("grapefruit %s", "grapefruit %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "grape",
            name = ccb.content.plural_text("grape %s", "grape %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "grenadine_syrup",
            name = ccb.content.plural_text("grenadine %s", "grenadine %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "guayaba",
            name = ccb.content.plural_text("guava %s", "guava %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "huckleberries",
            name = ccb.content.plural_text("huckleberry %s", "huckleberry %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "irradiated_apple",
            name = ccb.content.plural_text("apple %s", "apple %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "kiwi",
            name = ccb.content.plural_text("kiwi %s", "kiwi %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "lemonade",
            name = ccb.content.plural_text("lemon %s", "lemon %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "lemonlime",
            name = ccb.content.plural_text("lemon-lime soda %s", "lemon-lime soda %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "lulo",
            name = ccb.content.plural_text("lulo %s", "lulo %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "m_stellatum_berries",
            name = ccb.content.plural_text("solomon's seal %s", "solomon's seal %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mango",
            name = ccb.content.plural_text("mango %s", "mango %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "maracuya",
            name = ccb.content.plural_text("passionfruit %s", "passionfruit %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "melon_chunks",
            name = ccb.content.plural_text("melon %s", "melon %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mulberries",
            name = ccb.content.plural_text("mulberry %s", "mulberry %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "orangesoda",
            name = ccb.content.plural_text("orange soda %s", "orange soda %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "oj",
            name = ccb.content.plural_text("orange %s", "orange %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "papaya",
            name = ccb.content.plural_text("papaya %s", "papaya %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "peach",
            name = ccb.content.plural_text("peach %s", "peach %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pear",
            name = ccb.content.plural_text("pear %s", "pear %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "pineapple_juice",
            name = ccb.content.plural_text("pineapple %s", "pineapple %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "plums",
            name = ccb.content.plural_text("plum %s", "plum %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pomegranate",
            name = ccb.content.plural_text("pomegranate %s", "pomegranate %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pumpkin",
            name = ccb.content.plural_text("pumpkin %s", "pumpkin %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "raspberries",
            name = ccb.content.plural_text("raspberry %s", "raspberry %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "rootbeer",
            name = ccb.content.plural_text("root beer %s", "root beer %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "rose_hips",
            name = ccb.content.plural_text("rose hip %s", "rose hip %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "spezi",
            name = ccb.content.plural_text("spezi %s", "spezi %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "strawberries",
            name = ccb.content.plural_text("strawberry %s", "strawberry %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "sweet_water",
            name = ccb.content.plural_text("slightly sweet %s", "slightly sweet %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "syrup",
            name = ccb.content.plural_text("maple syrup %s", "maple syrup %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "tea",
            name = ccb.content.plural_text("tea %s", "tea %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "watermelon",
            name = ccb.content.plural_text("watermelon %s", "watermelon %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "wintergreen",
            name = ccb.content.plural_text("wintergreen berry %s", "wintergreen berry %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "zerocola",
            name = ccb.content.plural_text("cola %s", "cola %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "zeroorange",
            name = ccb.content.plural_text("orange soda %s", "orange soda %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "zerotropical",
            name = ccb.content.plural_text("lemon-lime soda %s", "lemon-lime soda %s"),
        },
    },
    mass = "240 g",
    volume = "250 ml",
    color = "cyan",
    default_container = "cup_plastic",
    symbol = "~",
    description = ccb.content.text("A summer treat of chopped ice and sweet flavoring!"),
    price = "3 USD 50 cent",
    survival_price = "50 cent",
    materials = { "water" },
    phase = "liquid",
    flags = { "MELTS" },
    comestible = {
        shelf_life = "1 days",
        kind = "FOOD",
        calories = 0,
        quench = 40,
        servings = 1,
        fun = 6,
        vitamins = {},
    },
}

ccb.content.define_item {
    id = "snowcone_alcoholic",
    name = ccb.content.text("snow cone"),
    conditional_names = {
        {
            kind = "COMPONENT_ID",
            key = "brandy",
            name = ccb.content.plural_text("brandy %s", "brandy %s"),
        },
        { kind = "COMPONENT_ID", key = "gin", name = ccb.content.plural_text("gin %s", "gin %s") },
        {
            kind = "COMPONENT_ID",
            key = "moonshine",
            name = ccb.content.plural_text("moonshine %s", "moonshine %s"),
        },
        { kind = "COMPONENT_ID", key = "rum", name = ccb.content.plural_text("rum %s", "rum %s") },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "sake",
            name = ccb.content.plural_text("sake %s", "sake %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "sherry",
            name = ccb.content.plural_text("sherry %s", "sherry %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "tequila",
            name = ccb.content.plural_text("tequila %s", "tequila %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "vodka",
            name = ccb.content.plural_text("vodka %s", "vodka %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "whiskey",
            name = ccb.content.plural_text("whiskey %s", "whiskey %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "wine",
            name = ccb.content.plural_text("wine %s", "wine %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "apple_cider",
            name = ccb.content.plural_text("apple cider %s", "apple cider %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "apple",
            name = ccb.content.plural_text("apple %s", "apple %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "apricot",
            name = ccb.content.plural_text("apricot %s", "apricot %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "banana",
            name = ccb.content.plural_text("banana %s", "banana %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "blackberries",
            name = ccb.content.plural_text("blackberry %s", "blackberry %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "blueberries",
            name = ccb.content.plural_text("blueberry %s", "blueberry %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "cherries",
            name = ccb.content.plural_text("cherry %s", "cherry %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "choc",
            name = ccb.content.plural_text("chocolate %s", "chocolate %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "coconut",
            name = ccb.content.plural_text("coconut %s", "coconut %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "coffee",
            name = ccb.content.plural_text("coffee %s", "coffee %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "cola",
            name = ccb.content.plural_text("cola %s", "cola %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "cran",
            name = ccb.content.plural_text("cranberry %s", "cranberry %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "creamsoda",
            name = ccb.content.plural_text("fizzy cream %s", "fizzy cream %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "drink_pinitacolada",
            name = ccb.content.plural_text("piña colada %s", "piña colada %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "elderberries",
            name = ccb.content.plural_text("elderberry %s", "elderberry %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "foodplace_zero_drink",
            name = ccb.content.plural_text("refreshing™ %s", "refreshing™ %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "grapefruit",
            name = ccb.content.plural_text("grapefruit %s", "grapefruit %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "grape",
            name = ccb.content.plural_text("grape %s", "grape %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "grenadine_syrup",
            name = ccb.content.plural_text("grenadine %s", "grenadine %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "guayaba",
            name = ccb.content.plural_text("guava %s", "guava %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "huckleberries",
            name = ccb.content.plural_text("huckleberry %s", "huckleberry %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "irradiated_apple",
            name = ccb.content.plural_text("apple %s", "apple %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "kiwi",
            name = ccb.content.plural_text("kiwi %s", "kiwi %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "lemonade",
            name = ccb.content.plural_text("lemon %s", "lemon %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "lemonlime",
            name = ccb.content.plural_text("fizzy lemon-lime %s", "fizzy lemon-lime %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "lulo",
            name = ccb.content.plural_text("lulo %s", "lulo %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "m_stellatum_berries",
            name = ccb.content.plural_text("solomon's seal %s", "solomon's seal %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mango",
            name = ccb.content.plural_text("mango %s", "mango %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "maracuya",
            name = ccb.content.plural_text("passionfruit %s", "passionfruit %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "melon_chunks",
            name = ccb.content.plural_text("melon %s", "melon %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mulberries",
            name = ccb.content.plural_text("mulberry %s", "mulberry %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "orangesoda",
            name = ccb.content.plural_text("fizzy orange %s", "fizzy orange %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "oj",
            name = ccb.content.plural_text("orange %s", "orange %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "papaya",
            name = ccb.content.plural_text("papaya %s", "papaya %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "peach",
            name = ccb.content.plural_text("peach %s", "peach %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pear",
            name = ccb.content.plural_text("pear %s", "pear %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "pineapple_juice",
            name = ccb.content.plural_text("pineapple %s", "pineapple %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "plums",
            name = ccb.content.plural_text("plum %s", "plum %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pomegranate",
            name = ccb.content.plural_text("pomegranate %s", "pomegranate %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pumpkin",
            name = ccb.content.plural_text("pumpkin %s", "pumpkin %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "raspberries",
            name = ccb.content.plural_text("raspberry %s", "raspberry %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "rootbeer",
            name = ccb.content.plural_text("root beer %s", "root beer %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "rose_hips",
            name = ccb.content.plural_text("rose hip %s", "rose hip %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "spezi",
            name = ccb.content.plural_text("spezi %s", "spezi %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "strawberries",
            name = ccb.content.plural_text("strawberry %s", "strawberry %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "sweet_water",
            name = ccb.content.plural_text("slightly sweet %s", "slightly sweet %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "syrup",
            name = ccb.content.plural_text("maple syrup %s", "maple syrup %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "tea",
            name = ccb.content.plural_text("tea %s", "tea %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "watermelon",
            name = ccb.content.plural_text("watermelon %s", "watermelon %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "wintergreen",
            name = ccb.content.plural_text("wintergreen berry %s", "wintergreen berry %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "zerocola",
            name = ccb.content.plural_text("cola %s", "cola %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "zeroorange",
            name = ccb.content.plural_text("fizzy orange %s", "fizzy orange %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "zerotropical",
            name = ccb.content.plural_text("fizzy lemon-lime %s", "fizzy lemon-lime %s"),
        },
    },
    mass = "240 g",
    volume = "250 ml",
    color = "cyan",
    default_container = "cup_plastic",
    symbol = "~",
    description = ccb.content.text("Combining snow cones and alcohol, what could go wrong?"),
    price = "3 USD 50 cent",
    survival_price = "1 USD",
    materials = { "water", "alcohol" },
    phase = "liquid",
    flags = { "MELTS", "NO_AUTO_CONSUME" },
    comestible = {
        addiction = "alcohol",
        shelf_life = "1 days",
        kind = "FOOD",
        healthy = -1,
        addiction_potential = 3,
        calories = 0,
        servings = 1,
        fun = 6,
        vitamins = { { id = "ethanol", amount = 5 } },
    },
}

-- not technically a drink, but is quasi-liquid enough that it'd get all over everything if you carried it
ccb.content.define_item {
    id = "icecream",
    name = ccb.content.plural_text("serving of ice cream", "servings of ice cream"),
    description = ccb.content.text("A sweet, frozen food made with milk and liberal amounts of sugar."),
    display_type = "BY_VOLUME",
    mass = "70 g",
    volume = "250 ml",
    default_container = "plastic_bucket",
    symbol = "~",
    color = "white",
    price = "2 USD 50 cent",
    survival_price = "3 USD",
    materials = { { id = "ice_cream", portions = 10 }, { id = "milk", portions = 1 } },
    phase = "liquid",
    flags = { "MELTS" },
    comestible = {
        kind = "FOOD",
        shelf_life = "1 day",
        calories = 325,
        fun = 15,
        healthy = -1,
        servings = 2,
        vitamins = { { id = "calcium", amount = 9 }, { id = "milk_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "icecream_artificial",
    copy_from = "icecream",
    name = ccb.content.plural_text("serving of dairy dessert", "servings of dairy dessert"),
    description = ccb.content.text("Government regulations dictate that since this isn't *technically* ice cream, it can be called a dairy dessert instead.  You can't really taste the difference."),
    price = "2 USD",
    survival_price = "1 USD",
    materials = {
        { id = "ice_cream", portions = 10 },
        { id = "milk", portions = 1 },
        { id = "junk", portions = 1 },
    },
    comestible = { vitamins = { { id = "junk_allergen", amount = 1 }, { id = "milk_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "icecream_choc",
    name = ccb.content.plural_text("serving of chocolate ice cream", "servings of chocolate ice cream"),
    copy_from = "icecream",
    description = ccb.content.text("A sweet, frozen food made with chocolate milk and liberal amounts of sugar."),
    color = "brown",
    comestible = { calories = 345 },
}

-- based on Hoodsie cups, a popular brand in New England
ccb.content.define_item {
    id = "sundae_cup",
    name = ccb.content.text("sundae cup"),
    copy_from = "icecream_artificial",
    description = ccb.content.text("A small cup of frozen dairy dessert that is half chocolate, half vanilla, and all delicious."),
    default_container = "cup_plastic",
    mass = "25 g",
    volume = "88 ml",
    color = "brown",
    comestible = { calories = 121 },
}

ccb.content.define_item {
    id = "icecream_candy",
    copy_from = "icecream",
    name = ccb.content.plural_text("serving of candy ice cream", "servings of candy ice cream"),
    description = ccb.content.text("Ice cream with bits of chocolate, caramel, or other sweet candy mixed in."),
    price = "3 USD",
    survival_price = "3 USD",
    materials = {
        { id = "ice_cream", portions = 10 },
        { id = "milk", portions = 1 },
        { id = "junk", portions = 1 },
    },
    comestible = {
        fun = 20,
        calories = 330,
        vitamins = {
            { id = "calcium", amount = 8 },
            { id = "iron", amount = 4 },
            { id = "junk_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "icecream_fruit",
    copy_from = "icecream",
    name = ccb.content.plural_text("serving of fruity ice cream", "servings of fruity ice cream"),
    description = ccb.content.text("Small bits of sweet fruit have been tossed into this ice cream."),
    price = "3 USD",
    survival_price = "3 USD",
    materials = {
        { id = "ice_cream", portions = 10 },
        { id = "milk", portions = 1 },
        { id = "fruit", portions = 1 },
    },
    comestible = {
        calories = 224,
        fun = 17,
        vitamins = {
            { id = "vitC", amount = 6 },
            { id = "calcium", amount = 8 },
            { id = "iron", amount = 1 },
            { id = "fruit_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "icecream_custard",
    copy_from = "icecream",
    name = ccb.content.plural_text("serving of frozen custard", "servings of frozen custard"),
    description = ccb.content.text("A treat made famous on Coney Island, made like ice cream but with egg yolk added in.  Its storing temperature is warmer, and it lasts a little longer than regular ice cream."),
    price = "3 USD",
    survival_price = "3 USD",
    materials = {
        { id = "ice_cream", portions = 10 },
        { id = "milk", portions = 1 },
        { id = "egg", portions = 1 },
    },
    comestible = {
        shelf_life = "2 days",
        calories = 328,
        vitamins = {
            { id = "calcium", amount = 8 },
            { id = "egg_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "icecream_yogurt",
    copy_from = "icecream",
    name = ccb.content.plural_text("serving of frozen yogurt", "servings of frozen yogurt"),
    description = ccb.content.text("Tarter than ice cream, this is made with yogurt and other dairy products, and is generally lower-fat compared to ice cream."),
    price = "2 USD 75 cent",
    survival_price = "1 USD",
    mass = "80 g",
    materials = { { id = "ice_cream", portions = 10 }, { id = "milk", portions = 1 } },
    comestible = {
        calories = 127,
        vitamins = {
            { id = "vitC", amount = 4 },
            { id = "calcium", amount = 10 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "icecream_sorbet",
    copy_from = "icecream",
    name = ccb.content.plural_text("serving of sorbet", "servings of sorbet"),
    description = ccb.content.text("A simple frozen dessert made from water and fruit juice."),
    price = "1 USD 75 cent",
    survival_price = "1 USD",
    mass = "106 g",
    materials = { "water", "fruit" },
    comestible = {
        shelf_life = "14 days",
        calories = 116,
        quench = 8,
        fun = 10,
        vitamins = { { id = "fruit_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "icecream_gelato",
    copy_from = "icecream",
    name = ccb.content.plural_text("serving of gelato", "servings of gelato"),
    description = ccb.content.text("Italian-style ice cream.  It is denser and less airy, giving it a richer flavor and texture."),
    price = "3 USD",
    survival_price = "2 USD",
    mass = "90 g",
    materials = { { id = "ice_cream", portions = 10 }, { id = "milk", portions = 1 } },
    comestible = {
        calories = 240,
        fun = 13,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 2 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}
