local ccb = require("ccb")

ccb.content.define_item {
    id = "egg_chicken",
    name = ccb.content.text("chicken egg"),
    mass = "50 g",
    color = "brown",
    symbol = "o",
    description = ccb.content.text("A nutritious egg laid by a bird."),
    price = "44 cent",
    survival_price = "50 cent",
    materials = { "egg" },
    volume = "50 ml",
    flags = { "FREEZERBURN", "RAW" },
    stackable = true,
    comestible = {
        shelf_life = "11 days",
        kind = "FOOD",
        quench = 4,
        calories = 71,
        fun = -8,
        vitamins = {
            { id = "iron", amount = "900 μg" },
            { id = "calcium", amount = "28 mg" },
            { id = "egg_allergen", amount = 1 },
        },
        rot_spawn = { monster = "mon_chicken_chick", chance = 70 },
    },
}

ccb.content.define_item {
    id = "egg_bird_unfert",
    copy_from = "egg_chicken",
    name = ccb.content.text("unfertilized bird egg"),
    description = ccb.content.text("A nutritious egg laid by a bird.  This one is unfertilized and probably from a farm."),
    comestible = {},
    inheritance = { add = { rot_spawn = { chance = 0 } } },
}

ccb.content.define_item {
    id = "egg_grouse",
    name = ccb.content.text("ruffed grouse egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "13 days" },
    inheritance = {
        add = { rot_spawn = { monster = "mon_grouse_chick" } },
        scale = { volume = 0.73, mass = 0.73, calories = 0.73 },
    },
}

ccb.content.define_item {
    id = "egg_pigeon",
    name = ccb.content.text("feral pigeon egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "9 days" },
    inheritance = {
        add = { rot_spawn = { monster = "mon_pigeon_chick" } },
        scale = { volume = 0.3, mass = 0.3, calories = 0.3 },
    },
}

ccb.content.define_item {
    id = "egg_crow",
    name = ccb.content.text("American crow egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "9 days" },
    inheritance = {
        add = { rot_spawn = { monster = "mon_crow_chick" } },
        scale = { volume = 0.34, mass = 0.34, calories = 0.34 },
    },
}

ccb.content.define_item {
    id = "egg_raven",
    name = ccb.content.text("raven egg"),
    copy_from = "egg_crow",
    comestible = { shelf_life = "11 days" },
    inheritance = { add = { rot_spawn = { monster = "mon_raven_chick" } } },
}

ccb.content.define_item {
    id = "egg_bluejay",
    name = ccb.content.text("blue jay egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "9 days" },
    inheritance = {
        add = { rot_spawn = { monster = "mon_bluejay_chick" } },
        scale = { volume = 0.18, mass = 0.18, calories = 0.18 },
    },
}

ccb.content.define_item {
    id = "egg_cardinal",
    name = ccb.content.text("cardinal egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "7 days" },
    inheritance = {
        add = { rot_spawn = { monster = "mon_cardinal_chick" } },
        scale = { volume = 0.09, mass = 0.09, calories = 0.09 },
    },
}

ccb.content.define_item {
    id = "egg_robin",
    name = ccb.content.text("American robin egg"),
    copy_from = "egg_chicken",
    description = ccb.content.text("A nutritious egg laid by a robin.  The shell is colored a distinctive light blue."),
    color = "light_blue",
    comestible = { shelf_life = "6 days" },
    inheritance = {
        add = { rot_spawn = { monster = "mon_robin_chick" } },
        scale = { volume = 0.15, mass = 0.15, calories = 0.15 },
    },
}

ccb.content.define_item {
    id = "egg_sparrow",
    name = ccb.content.text("sparrow egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "7 days" },
    inheritance = {
        add = { rot_spawn = { monster = "mon_sparrow_chick" } },
        scale = { volume = 0.06, mass = 0.06, calories = 0.06 },
    },
}

ccb.content.define_item {
    id = "egg_chickadee",
    name = ccb.content.text("black-capped chickadee egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "6 days" },
    inheritance = {
        add = { rot_spawn = { monster = "mon_chickadee_chick" } },
        scale = { volume = 0.03, mass = 0.03, calories = 0.03 },
    },
}

ccb.content.define_item {
    id = "egg_waxwing",
    name = ccb.content.text("cedar waxwing egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "8 days" },
    inheritance = {
        add = { rot_spawn = { monster = "mon_waxwing_chick" } },
        scale = { volume = 0.06, mass = 0.06, calories = 0.06 },
    },
}

ccb.content.define_item {
    id = "egg_duck",
    name = ccb.content.text("mallard egg"),
    copy_from = "egg_chicken",
    comestible = {
        shelf_life = "14 days",
        calories = 130,
        vitamins = {
            { id = "iron", amount = "3 mg" },
            { id = "calcium", amount = "45 mg" },
            { id = "egg_allergen", amount = 1 },
        },
    },
    inheritance = { add = { rot_spawn = { monster = "mon_duck_chick" } }, scale = { volume = 1.4, mass = 1.4 } },
}

ccb.content.define_item {
    id = "egg_duck_domestic",
    name = ccb.content.text("domestic duck egg"),
    copy_from = "egg_duck",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_duck_domestic_chick" } } },
}

ccb.content.define_item {
    id = "egg_goose_canadian",
    name = ccb.content.text("Canada goose egg"),
    copy_from = "egg_chicken",
    comestible = {
        shelf_life = "15 days",
        calories = 302,
        vitamins = {
            { id = "iron", amount = "6 mg" },
            { id = "calcium", amount = "98 mg" },
            { id = "egg_allergen", amount = 1 },
        },
    },
    inheritance = {
        add = { rot_spawn = { monster = "mon_goose_canadian_chick" } },
        scale = { volume = 3.26, mass = 3.26 },
    },
}

ccb.content.define_item {
    id = "egg_turkey",
    name = ccb.content.text("wild turkey egg"),
    copy_from = "egg_chicken",
    comestible = {
        shelf_life = "15 days",
        calories = 135,
        vitamins = {
            { id = "iron", amount = "3 mg" },
            { id = "calcium", amount = "78 mg" },
            { id = "egg_allergen", amount = 1 },
        },
    },
    inheritance = {
        add = { rot_spawn = { monster = "mon_turkey_chick" } },
        scale = { volume = 1.58, mass = 1.58 },
    },
}

ccb.content.define_item {
    id = "egg_turkey_domestic",
    name = ccb.content.text("domestic turkey egg"),
    copy_from = "egg_turkey",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_turkey_domestic_chick" } } },
}

ccb.content.define_item {
    id = "egg_pheasant",
    name = ccb.content.text("ring-necked pheasant egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "14 days" },
    inheritance = { add = { rot_spawn = { monster = "mon_pheasant_chick" } } },
}

ccb.content.define_item {
    id = "egg_guinea_fowl",
    name = ccb.content.text("domestic guineafowl egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "14 days" },
    inheritance = {
        add = { rot_spawn = { monster = "mon_guinea_fowl_chick" } },
        scale = { volume = 0.9, mass = 0.9, calories = 0.9 },
    },
}

ccb.content.define_item {
    id = "egg_wormsnake",
    name = ccb.content.text("worm snake egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "23 days" },
    inheritance = {
        add = { rot_spawn = { monster = "mon_wormsnake_baby" } },
        scale = { volume = 0.06, mass = 0.06, calories = 0.06 },
    },
}

ccb.content.define_item {
    id = "egg_turtle_painted",
    name = ccb.content.text("painted turtle egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "40 days" },
    inheritance = {
        add = { rot_spawn = { monster = "mon_turtle_painted_baby" } },
        scale = { volume = 0.25, mass = 0.25, calories = 0.25 },
    },
}

ccb.content.define_item {
    id = "egg_turtle_snapping_common",
    name = ccb.content.text("common snapping turtle egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "51 days" },
    inheritance = {
        add = { rot_spawn = { monster = "mon_turtle_snapping_common_baby" } },
        scale = { volume = 0.25, mass = 0.25, calories = 0.25 },
    },
}

ccb.content.define_item {
    id = "egg_skink_fivelined",
    name = ccb.content.text("five-lined skink egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "28 days" },
    inheritance = {
        add = { rot_spawn = { monster = "mon_skink_fivelined_baby" } },
        scale = { volume = 0.06, mass = 0.06, calories = 0.06 },
    },
}
