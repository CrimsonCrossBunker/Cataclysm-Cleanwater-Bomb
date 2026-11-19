local ccb = require("ccb")

ccb.content.define_harvest {
    id = "wildcotton_harv",
    drops = {
        { output = "cotton_boll", base_quantity = { 1, 3 } },
        { output = "withered", base_quantity = { 1, 2 } },
    },
}

ccb.content.define_harvest {
    id = "wildsbeet_harv",
    drops = { { output = "sugar_beet", base_quantity = { 1, 2 } } },
}

ccb.content.define_harvest {
    id = "wildweed_harv",
    drops = {
        { output = "cannabis", base_quantity = { 1, 4 } },
        { output = "seed_weed", base_quantity = { 2, 6 } },
    },
}

ccb.content.define_harvest {
    id = "wildcorn_harv",
    drops = {
        { output = "corn", base_quantity = { 2, 6 } },
        { output = "withered", base_quantity = { 1, 2 } },
    },
}

ccb.content.define_harvest {
    id = "wildpumpkin_harv",
    drops = {
        { output = "pumpkin", base_quantity = { 4, 12 } },
        { output = "withered", base_quantity = { 1, 2 } },
    },
}

ccb.content.define_harvest {
    id = "wildbeans_harv",
    drops = {
        { output = "raw_beans", base_quantity = { 4, 12 } },
        { output = "withered", base_quantity = { 1, 2 } },
    },
}
