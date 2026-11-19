local ccb = require("ccb")

ccb.content.define_harvest {
    id = "mango_harv",
    drops = { { output = "mango", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "papaya_harv",
    drops = { { output = "papaya", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "pomegranate_harv",
    drops = { { output = "pomegranate", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "melon_harv",
    drops = { { output = "melon", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "kiwi_harv",
    drops = { { output = "kiwi", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "coconut_harv",
    drops = { { output = "coconut", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "pineapple_harv",
    drops = { { output = "pineapple", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "banana_harv",
    drops = { { output = "banana", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "orange_harv",
    drops = { { output = "orange", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "lemon_harv",
    drops = { { output = "lemon", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "grapefruit_harv",
    drops = { { output = "grapefruit", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "watermelon_harv",
    drops = { { output = "watermelon", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "cactus_harv",
    drops = {
        { output = "cholla_bud", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } },
        { output = "cactus_pad", base_quantity = { 1, 2 }, skill_quantity = { 0, 0.5 } },
    },
}

-- no bones or organs, copied from meatslug
ccb.content.define_harvest {
    id = "echinoderm",
    drops = {
        { output = "echinoderm", category = "flesh", mass_ratio = 0.4 },
        { output = "fat", category = "flesh", mass_ratio = 0.1 },
        { output = "fat", category = "offal", mass_ratio = 0.1 },
    },
}

-- no bones or organs, copied from meatslug
ccb.content.define_harvest {
    id = "cnidarian",
    drops = {
        { output = "cnidarian", category = "flesh", mass_ratio = 0.4 },
        { output = "fat", category = "flesh", mass_ratio = 0.1 },
        { output = "fat", category = "offal", mass_ratio = 0.1 },
    },
}
