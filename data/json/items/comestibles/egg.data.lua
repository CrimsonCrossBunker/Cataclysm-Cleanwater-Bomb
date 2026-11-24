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

-- NO_I18N
-- 5x the weight and 3x the nutrition of real chicken eggs, toxins equal to 296g mutant meat
ccb.content.define_item {
    id = "egg_insect",
    abstract = true,
    name = ccb.content.text_without_extraction("insect egg"),
    color = "white",
    symbol = "o",
    materials = { "egg" },
    volume = "250 ml",
    mass = "275 g",
    price = "0 cent",
    survival_price = "1 USD",
    flags = { "FREEZERBURN", "RAW", "NO_AUTO_CONSUME" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        calories = 240,
        quench = 10,
        fun = -20,
        shelf_life = "5 days",
        vitamins = {
            { id = "calcium", amount = 7 },
            { id = "iron", amount = 18 },
            { id = "mutant_toxin", amount = 25 },
            { id = "egg_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "ant_egg",
    name = ccb.content.text("ant egg"),
    copy_from = "egg_insect",
    description = ccb.content.text("A large, heavy ant egg, the size of a softball.  Extremely nutritious, but incredibly gross."),
    price = "1 USD 75 cent",
    survival_price = "5 USD",
    comestible = {
        vitamins = {
            { id = "calcium", amount = 28 },
            { id = "iron", amount = 72 },
            { id = "mutant_toxin", amount = 100 },
            { id = "egg_allergen", amount = 1 },
        },
    },
    inheritance = {
        add = { rot_spawn = { monster = "mon_ant_larva", chance = 100 } },
        scale = { mass = 4, calories = 4, volume = 4 },
    },
}

ccb.content.define_item {
    id = "ant_egg_acid",
    name = ccb.content.text("acid ant egg"),
    copy_from = "ant_egg",
    description = ccb.content.text("A large, heavy acid ant egg, the size of a softball.  Extremely nutritious, but incredibly gross."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_ant_acid_larva" } } },
}

ccb.content.define_item {
    id = "egg_roach",
    name = ccb.content.text("roach egg"),
    description = ccb.content.text("A fist-sized egg from a giant roach.  Incredibly gross."),
    copy_from = "egg_insect",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_giant_cockroach_nymph", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_roach_plague",
    name = ccb.content.text("plague vector egg"),
    description = ccb.content.text("A fist-sized egg from a plague vector.  Incredibly gross."),
    copy_from = "egg_roach",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_plague_nymph" } } },
}

ccb.content.define_item {
    id = "egg_locust",
    name = ccb.content.text("locust egg"),
    description = ccb.content.text("A fist-sized egg from a locust."),
    copy_from = "egg_insect",
    color = "green",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_locust_nymph", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_dragonfly",
    name = ccb.content.text("dragonfly egg"),
    description = ccb.content.text("The still-wet egg of a mutated dragonfly.  Serves as a disgusting substitute for the real thing, just don't let it hatch in the water."),
    copy_from = "egg_insect",
    color = "light_green",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_dragonfly_naiad", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_firefly",
    name = ccb.content.text("firefly egg"),
    description = ccb.content.text("The fist-sized egg of a mutant firefly.  Glows faintly in the dark."),
    copy_from = "egg_insect",
    color = "yellow",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_firefly_larva", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_centipede",
    name = ccb.content.text("centipede egg"),
    description = ccb.content.text("A large, soft egg of a mutant centipede.  Inside, you can already see a bundle of spindly legs, twitching in anticipation."),
    copy_from = "egg_insect",
    color = "light_green",
    comestible = {
        vitamins = {
            { id = "calcium", amount = 14 },
            { id = "iron", amount = 36 },
            { id = "mutant_toxin", amount = 50 },
            { id = "egg_allergen", amount = 1 },
        },
    },
    inheritance = {
        add = { rot_spawn = { monster = "mon_centipede_larva", chance = 50 } },
        scale = { mass = 2, calories = 2, volume = 2 },
    },
}

ccb.content.define_item {
    id = "egg_wasp",
    name = ccb.content.text("wasp egg"),
    description = ccb.content.text("A white, flexible wasp egg.  It looks like a pristine grain of rice the size of your palm."),
    copy_from = "egg_insect",
    color = "white",
    comestible = { shelf_life = "2 days" },
    inheritance = { add = { rot_spawn = { monster = "mon_wasp_larva", chance = 100 } } },
}

ccb.content.define_item {
    id = "egg_stag_beetle",
    name = ccb.content.text("stag beetle egg"),
    description = ccb.content.text("A huge, translucent beetle egg.  You can see a larva slowly squirming inside, contorting uncomfortably outside of the soil."),
    copy_from = "egg_insect",
    color = "brown",
    comestible = {
        shelf_life = "20 days",
        vitamins = {
            { id = "calcium", amount = 35 },
            { id = "iron", amount = 90 },
            { id = "mutant_toxin", amount = 125 },
            { id = "egg_allergen", amount = 1 },
        },
    },
    inheritance = {
        add = { rot_spawn = { monster = "mon_stag_beetle_larva", chance = 50 } },
        scale = { mass = 5, calories = 5, volume = 5 },
    },
}

ccb.content.define_item {
    id = "egg_antlion",
    name = ccb.content.text("antlion egg"),
    description = ccb.content.text("A large, white antlion egg.  There is something hard inside."),
    copy_from = "egg_insect",
    color = "yellow",
    comestible = {
        vitamins = {
            { id = "calcium", amount = 14 },
            { id = "iron", amount = 36 },
            { id = "mutant_toxin", amount = 50 },
            { id = "egg_allergen", amount = 1 },
        },
    },
    inheritance = {
        add = { rot_spawn = { monster = "mon_antlion_larva", chance = 50 } },
        scale = { mass = 2, calories = 2, volume = 2 },
    },
}

ccb.content.define_item {
    id = "egg_strider",
    name = ccb.content.text("water strider egg"),
    description = ccb.content.text("A large, sticky, and wet water strider egg.  You should probably put it back in the water."),
    copy_from = "egg_insect",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_strider_nymph", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_grasshopper",
    name = ccb.content.text("grasshopper egg"),
    description = ccb.content.text("A long, white, pill-shaped grasshopper egg.  Inside you can see two twitching legs."),
    copy_from = "egg_insect",
    color = "light_green",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_grasshopper_nymph", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_lady_bug",
    name = ccb.content.text("ladybug egg"),
    description = ccb.content.text("A ladybug egg.  It looks like a huge yellow rice grain.  You can see a translucent, hungry larva inside."),
    copy_from = "egg_insect",
    color = "light_red",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_lady_bug_larva", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_mole_cricket",
    name = ccb.content.text("mole cricket egg"),
    description = ccb.content.text("A mole cricket egg covered in bits of sand and dirt.  It's brown with a few black dots on it."),
    copy_from = "egg_insect",
    color = "brown",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_mole_cricket_nymph", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_mantis",
    name = ccb.content.text("praying mantis egg case"),
    description = ccb.content.text("Praying mantis eggs glued to each other inside a strange-looking case.  It resembles a trilobite or a woodlouse."),
    copy_from = "egg_insect",
    color = "green",
    comestible = {
        shelf_life = "10 days",
        vitamins = {
            { id = "calcium", amount = 35 },
            { id = "iron", amount = 90 },
            { id = "mutant_toxin", amount = 125 },
            { id = "egg_allergen", amount = 1 },
        },
    },
    inheritance = {
        add = { rot_spawn = { monster = "mon_mantis_nymph", chance = 50, amount = { 1, 3 } } },
        scale = { mass = 5, calories = 5, volume = 5 },
    },
}

ccb.content.define_item {
    id = "egg_fly",
    name = ccb.content.text("fly egg"),
    description = ccb.content.text("The egg of a fly."),
    copy_from = "egg_insect",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fly_larva", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_moth_fly",
    name = ccb.content.text("moth fly egg"),
    description = ccb.content.text("The egg of a moth fly."),
    copy_from = "egg_insect",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_moth_fly_larva", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_silverfish",
    name = ccb.content.text("silverfish egg"),
    description = ccb.content.text("The egg of a silverfish."),
    copy_from = "egg_insect",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_silverfish_nymph", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_centipede_house",
    name = ccb.content.text("house centipede egg"),
    description = ccb.content.text("The egg of a house centipede."),
    copy_from = "egg_insect",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_centipede_house_larva", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_mosquito",
    name = ccb.content.text("mosquito egg"),
    description = ccb.content.text("The egg of a mosquito."),
    copy_from = "egg_insect",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_mosquito_larva", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_spider_cellar",
    name = ccb.content.text("cellar spider egg"),
    description = ccb.content.text("The egg of a cellar spider."),
    copy_from = "egg_insect",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_spider_cellar_giant_s", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_spider_jumping",
    name = ccb.content.text("jumping spider egg"),
    description = ccb.content.text("The egg of a jumping spider."),
    copy_from = "egg_insect",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_spider_jumping_giant_s", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_spider_trapdoor",
    name = ccb.content.text("trapdoor spider egg"),
    description = ccb.content.text("The egg of a trapdoor spider."),
    copy_from = "egg_insect",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_spider_trapdoor_s", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_spider_web",
    name = ccb.content.text("web spider egg"),
    description = ccb.content.text("The egg of a web spider."),
    copy_from = "egg_insect",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_spider_web_s", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_spider_widow",
    name = ccb.content.text("black widow egg"),
    description = ccb.content.text("The egg of a black widow."),
    copy_from = "egg_insect",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_spider_widow_giant_s", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_spider_wolf",
    name = ccb.content.text("wolf spider egg"),
    description = ccb.content.text("The egg of a wolf spider."),
    copy_from = "egg_insect",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_spider_wolf_giant_s", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_worm",
    name = ccb.content.text("earthworm egg"),
    description = ccb.content.text("The egg of an earthworm."),
    copy_from = "egg_insect",
    comestible = {
        shelf_life = "10 days",
        vitamins = {
            { id = "calcium", amount = 35 },
            { id = "iron", amount = 90 },
            { id = "mutant_toxin", amount = 125 },
            { id = "egg_allergen", amount = 1 },
        },
    },
    inheritance = {
        add = { rot_spawn = { monster = "mon_worm_larva", chance = 50, amount = { 1, 3 } } },
        scale = { mass = 5, calories = 5, volume = 5 },
    },
}

ccb.content.define_item {
    id = "egg_slug",
    name = ccb.content.text("slug egg"),
    description = ccb.content.text("The egg of a slug."),
    copy_from = "egg_insect",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_slug_larva", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_snail",
    name = ccb.content.text("snail egg"),
    description = ccb.content.text("The egg of a snail."),
    copy_from = "egg_insect",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_snail_larva", chance = 50 } } },
}

ccb.content.define_item {
    id = "razorclaw_roe",
    name = ccb.content.plural_text("razorclaw roe", "razorclaw roe"),
    mass = "236 g",
    color = "red",
    symbol = "o",
    description = ccb.content.text("A clump of razorclaw eggs.  A post-Cataclysm delicacy."),
    price = "30 USD",
    survival_price = "7 USD 50 cent",
    materials = { "egg" },
    volume = "250 ml",
    flags = { "RAW" },
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        quench = 10,
        calories = 338,
        vitamins = {
            { id = "vitC", amount = 42 },
            { id = "calcium", amount = 5 },
            { id = "iron", amount = 8 },
            { id = "mutant_toxin", amount = 25 },
            { id = "egg_allergen", amount = 1 },
        },
        fun = 5,
    },
}

ccb.content.define_item {
    id = "egg_fish",
    name = ccb.content.plural_text("roe", "roe"),
    mass = "24 g",
    color = "red",
    symbol = "o",
    description = ccb.content.text("Common roe from an unknown fish."),
    price = "12 cent",
    survival_price = "25 cent",
    materials = { "egg" },
    volume = "25 ml",
    flags = { "RAW" },
    stackable = true,
    comestible = {
        shelf_life = "7 days",
        kind = "FOOD",
        quench = 4,
        calories = 34,
        fun = 1,
        vitamins = { { id = "vitC", amount = 1 }, { id = "egg_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "egg_brown_trout",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_brown_trout", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_brook_trout",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_brook_trout", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_lake_trout",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_lake_trout", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_rainbow_trout",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_rainbow_trout", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_salmon",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_salmon", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_cod",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_cod", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_haddock",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_haddock", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_bluefin_tuna",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_bluefin_tuna", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_halibut",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_halibut", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_pollock",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_pollock", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_flounder",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_flounder", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_mackerel",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_mackerel", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_bluefish",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_bluefish", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_blackfish",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_blackfish", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_porgy",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_porgy", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_kokanee_salmon",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_kokanee_salmon", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_whitefish",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_whitefish", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_whitefish_round",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_whitefish_round", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_lbass",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_lbass", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_sbass",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_sbass", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_pbass",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_pbass", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_perch",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_perch", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_walleye",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_walleye", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_sunfish",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_sunfish", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_pumpkinseed",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_pumpkinseed", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_bluegill",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_bluegill", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_redbreast",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_redbreast", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_green_sunfish",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_green_sunfish", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_rock_bass",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_rock_bass", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_calico_bass",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_calico_bass", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_warmouth",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_warmouth", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_bullhead",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_bullhead", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_bullhead_yellow",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_bullhead_yellow", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_channel_catfish",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_channel_catfish", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_white_catfish",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_white_catfish", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_pike",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_pike", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_pickerel",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_pickerel", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_pickerel_american",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_pickerel_american", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_muskellunge",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_muskellunge", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_white_sucker",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_white_sucker", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_carp",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_carp", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_grass_carp",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_grass_carp", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_goldfish",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_goldfish", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_bowfin",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_bowfin", chance = 20 } } },
}

-- Gar eggs are poisonous - this is not an oversight. This is also why these are omitted from the cooking requirement group.
ccb.content.define_item {
    id = "egg_gar_longnose",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    inheritance = { add = { rot_spawn = { monster = "mon_fry_gar_longnose", chance = 20 } } },
    comestible = {},
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "egg_burbot",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_burbot", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_sturgeon_lake",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_sturgeon_lake", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_sturgeon_shortnose",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_sturgeon_shortnose", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_fallfish",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_fallfish", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_fish_mutant",
    abstract = true,
    name = ccb.content.plural_text("mutant fish roe", "mutant fish roe"),
    description = ccb.content.text("A large half-translucent glob with a mutant fish fry inside."),
    volume = "330 ml",
    mass = "300 g",
    color = "red",
    symbol = "o",
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "egg" },
    flags = { "RAW" },
    stackable = true,
    comestible = {
        shelf_life = "7 days",
        kind = "FOOD",
        calories = 425,
        quench = 50,
        fun = -8,
        vitamins = {
            { id = "vitC", amount = 12 },
            { id = "mutant_toxin", amount = 27 },
            { id = "egg_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "egg_mutant_salmon",
    name = ccb.content.plural_text("mutant fish roe", "mutant fish roe"),
    copy_from = "egg_fish_mutant",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_mutant_salmon", chance = 45 } } },
}

ccb.content.define_item {
    id = "powder_eggs",
    name = ccb.content.plural_text("powdered egg", "powdered egg"),
    mass = "7 g",
    color = "yellow",
    default_container = "bottle_plastic_small",
    symbol = "%",
    description = ccb.content.text("Whole fresh eggs, dehydrated into an easy to store powder."),
    display_type = "BY_WEIGHT",
    price = "70 cent",
    survival_price = "46 cent",
    materials = { { id = "powder", portions = 10 }, { id = "egg", portions = 1 } },
    volume = "15 ml",
    flags = { "EDIBLE_FROZEN", "NO_AUTO_CONSUME" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        quench = -2,
        calories = 80,
        fun = -4,
        freezing_point = -274,
        vitamins = { { id = "egg_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "rehydrated_eggs",
    copy_from = "egg_chicken",
    name = ccb.content.plural_text("rehydrated egg", "rehydrated egg"),
    color = "yellow",
    symbol = "%",
    looks_like = "powder_egg",
    description = ccb.content.text("Rehydrated eggs.  You can use them instead of eggs when cooking, provided you don't care that they have lost their complete shape."),
    price = "22 cent",
    survival_price = "25 cent",
    flags = {},
    comestible = { quench = 2, fun = -2 },
    inheritance = { add = { rot_spawn = { chance = 0 } } },
}

ccb.content.define_item {
    id = "scrambled_eggs",
    name = ccb.content.plural_text("scrambled eggs", "scrambled eggs"),
    copy_from = "egg_chicken",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("Fluffy and delicious scrambled eggs."),
    price = "4 USD",
    survival_price = "1 USD",
    materials = { "egg" },
    volume = "125 ml",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = { shelf_life = "2 days", fun = 3, vitamins = { { id = "egg_allergen", amount = 1 } } },
    inheritance = { add = { rot_spawn = { chance = 0 } } },
}

ccb.content.define_item {
    id = "seasoned_scrambled_eggs",
    name = ccb.content.plural_text("seasoned scrambled eggs", "seasoned scrambled eggs"),
    copy_from = "scrambled_eggs",
    description = ccb.content.text("Tasty scrambled eggs, with seasoning to taste!"),
    comestible = { fun = 5 },
}

ccb.content.define_item {
    id = "boiled_egg",
    name = ccb.content.text("boiled egg"),
    copy_from = "egg_chicken",
    color = "white",
    symbol = "o",
    description = ccb.content.text("A hard-boiled egg, still in its shell.  Portable and nutritious!"),
    price = "95 cent",
    survival_price = "50 cent",
    materials = { "egg" },
    flags = { "FREEZERBURN" },
    comestible = { quench = -1, fun = 2, vitamins = { { id = "egg_allergen", amount = 1 } } },
    inheritance = { add = { rot_spawn = { chance = 0 } } },
}

ccb.content.define_item {
    id = "egg_salad",
    name = ccb.content.plural_text("egg salad", "egg salad"),
    copy_from = "boiled_egg",
    color = "white",
    symbol = "o",
    description = ccb.content.text("Hard-boiled eggs, mixed into a salad.  Can be made into a sandwich!"),
    price = "95 cent",
    survival_price = "50 cent",
    materials = { "egg" },
    flags = { "FREEZERBURN" },
    comestible = {
        quench = 2,
        shelf_life = "2 hours",
        fun = 4,
        vitamins = { { id = "egg_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "fried_eggs",
    name = ccb.content.plural_text("fried eggs", "fried eggs"),
    copy_from = "scrambled_eggs",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("Sunny-side up eggs fried with a runny yolk and just a bit of crisp on the edges."),
    price = "5 USD",
    survival_price = "1 USD 20 cent",
    materials = { "egg" },
    flags = { "EATEN_HOT", "FREEZERBURN" },
    comestible = { quench = -1, calories = 222, vitamins = { { id = "egg_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "seasoned_fried_eggs",
    name = ccb.content.plural_text("seasoned fried eggs", "seasoned fried eggs"),
    copy_from = "fried_eggs",
    description = ccb.content.text("A tasty fried egg, with seasoning added to taste!"),
    comestible = { fun = 5 },
}

ccb.content.define_item {
    id = "deluxe_fried_eggs",
    name = ccb.content.plural_text("deluxe fried eggs", "deluxe fried eggs"),
    copy_from = "scrambled_eggs",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("Deluxe sunny-side up eggs fried with a runny yolk and just a bit of crisp on the edges with cheese or a vegetable, garnish and condiment."),
    price = "5 USD",
    survival_price = "1 USD 20 cent",
    materials = { "egg", "veggy" },
    flags = { "EATEN_HOT", "FREEZERBURN" },
    comestible = {
        quench = -1,
        calories = 322,
        fun = 10,
        vitamins = { { id = "veggy_allergen", amount = 1 }, { id = "egg_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "fried_egg_sandwich",
    name = ccb.content.plural_text("fried egg sandwich", "fried egg sandwiches"),
    copy_from = "scrambled_eggs",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("Sunny-side up eggs fried with a runny yolk and just a bit of crisp on the edges.  Made into a sandwich, just like Sunday morning."),
    price = "5 USD",
    survival_price = "1 USD 20 cent",
    materials = { "egg", "wheat" },
    flags = { "EATEN_HOT", "FREEZERBURN" },
    comestible = {
        quench = -1,
        calories = 422,
        fun = 4,
        vitamins = { { id = "wheat_allergen", amount = 1 }, { id = "egg_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "deluxe_fried_egg_sandwich",
    name = ccb.content.plural_text("deluxe fried egg sandwich", "deluxe fried egg sandwiches"),
    copy_from = "scrambled_eggs",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("Deluxe sunny-side up eggs fried with a runny yolk and just a bit of crisp on the edges.  Made into a sandwich, just like Sunday morning."),
    price = "5 USD",
    survival_price = "1 USD 20 cent",
    materials = { "egg", "wheat" },
    flags = { "EATEN_HOT", "FREEZERBURN" },
    comestible = {
        quench = -1,
        calories = 422,
        fun = 12,
        vitamins = { { id = "wheat_allergen", amount = 1 }, { id = "egg_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "omelet",
    name = ccb.content.text("omelet"),
    copy_from = "scrambled_eggs",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("A fluffy beaten egg pancaked over with cheese inside."),
    price = "5 USD",
    survival_price = "70 cent",
    materials = { "egg", "milk" },
    flags = { "EATEN_HOT", "FREEZERBURN" },
    comestible = {
        calories = 190,
        vitamins = { { id = "egg_allergen", amount = 1 }, { id = "milk_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "vegetable_omelet",
    name = ccb.content.text("vegetable omelet"),
    copy_from = "scrambled_eggs",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("A fluffy beaten egg pancaked over with cheese and vegetables inside."),
    price = "5 USD",
    survival_price = "70 cent",
    materials = { "egg", "milk", "veggy" },
    flags = { "EATEN_HOT", "FREEZERBURN" },
    comestible = {
        calories = 240,
        vitamins = {
            { id = "veggy_allergen", amount = 1 },
            { id = "egg_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "supreme_omelet",
    name = ccb.content.text("supreme omelet"),
    copy_from = "scrambled_eggs",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("A fluffy beaten egg pancaked over with cheese, vegetables, and meat all stuffed inside.  The mother of all omelets."),
    price = "5 USD",
    survival_price = "70 cent",
    materials = { "egg", "milk", "veggy", "flesh" },
    flags = { "EATEN_HOT", "FREEZERBURN" },
    comestible = {
        calories = 350,
        vitamins = {
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
            { id = "egg_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "caviar_egg_sandwich",
    name = ccb.content.plural_text("caviar and egg sandwich", "caviar and egg sandwiches"),
    mass = "165 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("A simple sandwich with sliced, hard boiled eggs and mayo to balance out the saltiness of the caviar.  Scandinavian breakfast staple."),
    price = "5 USD",
    survival_price = "3 USD",
    materials = { { id = "bread", portions = 10 }, { id = "egg", portions = 1 } },
    volume = "649 ml",
    comestible = {
        kind = "FOOD",
        calories = 252,
        shelf_life = "4 hours",
        fun = 10,
        vitamins = { { id = "egg_allergen", amount = 1 }, { id = "bread_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "pickled_egg",
    name = ccb.content.text("pickled egg"),
    copy_from = "egg_chicken",
    color = "white",
    symbol = "%",
    description = ccb.content.text("A pickled egg.  Rather salty, but tastes good and lasts for a long time."),
    price = "95 cent",
    survival_price = "75 cent",
    materials = { "egg" },
    flags = { "FREEZERBURN" },
    comestible = {
        shelf_life = "30 days",
        quench = -1,
        fun = 2,
        vitamins = { { id = "egg_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "curing_roe_active",
    copy_from = "egg_fish",
    name = ccb.content.plural_text("curing roe", "curing roe"),
    description = ccb.content.text("Roe in the process of becoming fully cured with salt, capable of becoming homemade caviar.  The flavor is slowly developing at this stage, and is currently significantly unpleasant due to the residual salt.  Activate it once completed to make use of the final product."),
    mass = "96 g",
    volume = "500ml",
    stack_size = 4,
    price = "5 USD",
    survival_price = "2 USD 50 cent",
    phase = "liquid",
    revert_to = "cured_roe",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    comestible = { servings = 1, calories = 68, fun = -15 },
    countdown_interval = "30 minutes",
}

ccb.content.define_item {
    id = "cured_roe",
    copy_from = "egg_fish",
    name = ccb.content.plural_text("post apocalyptic 'caviar'", "post apocalyptic 'caviar'"),
    description = ccb.content.text("Fish eggs that have been cured in a salty brine.  Can be vacuum sealed to preserve freshness.  Technically caviar only came from a specific type of Sturgeon roe but the FDA allows all cured fish to be referred to as caviar."),
    mass = "48 g",
    volume = "62 ml",
    price = "125 cent",
    survival_price = "62 cent",
    flags = {},
    comestible = { calories = 68, fun = 5 },
}

ccb.content.define_item {
    id = "egg_goose",
    name = ccb.content.text("domestic goose egg"),
    copy_from = "egg_chicken",
    comestible = {
        calories = 266,
        vitamins = {
            { id = "iron", amount = "5 mg" },
            { id = "calcium", amount = "86 mg" },
            { id = "egg_allergen", amount = 1 },
        },
    },
    inheritance = {
        add = { rot_spawn = { monster = "mon_goose_chick" } },
        scale = { volume = 2.88, mass = 2.88 },
    },
}

-- Volume and calories defined manually because proportional rounded them down to 0
ccb.content.define_item {
    id = "egg_hummingbird",
    name = ccb.content.text("ruby-throated hummingbird egg"),
    copy_from = "egg_chicken",
    volume = "1 ml",
    comestible = { shelf_life = "7 days", calories = 1 },
    inheritance = { add = { rot_spawn = { monster = "mon_hummingbird_chick" } }, scale = { mass = 0.01 } },
}

ccb.content.define_item {
    id = "egg_woodpecker",
    name = ccb.content.text("downy woodpecker egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "6 days" },
    inheritance = {
        add = { rot_spawn = { monster = "mon_woodpecker_chick" } },
        scale = { volume = 0.06, mass = 0.06, calories = 0.06 },
    },
}

ccb.content.define_item {
    id = "egg_coot",
    name = ccb.content.text("American coot egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "13 days" },
    inheritance = {
        add = { rot_spawn = { monster = "mon_coot_chick" } },
        scale = { volume = 0.73, mass = 0.73, calories = 0.73 },
    },
}

ccb.content.define_item {
    id = "egg_cormorant",
    name = ccb.content.text("double-crested cormorant egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "14 days" },
    inheritance = { add = { rot_spawn = { monster = "mon_cormorant_chick" } } },
}

ccb.content.define_item {
    id = "egg_moorhen",
    name = ccb.content.text("common gallinule egg"),
    copy_from = "egg_chicken",
    comestible = {},
    inheritance = {
        add = { rot_spawn = { monster = "mon_moorhen_chick" } },
        scale = { volume = 0.73, mass = 0.73, calories = 0.73 },
    },
}

ccb.content.define_item {
    id = "egg_grebe",
    name = ccb.content.text("horned grebe egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "12 days" },
    inheritance = { add = { rot_spawn = { monster = "mon_grebe_chick" } } },
}

ccb.content.define_item {
    id = "egg_water_beetle",
    name = ccb.content.text("water beetle egg"),
    description = ccb.content.text("The egg of a water beetle, usually found near aquatic grass."),
    copy_from = "egg_insect",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_diving_larva", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_water_bug",
    name = ccb.content.text("water scorpion egg"),
    copy_from = "egg_insect",
    description = ccb.content.text("The egg of a water scorpion, usually found near aquatic grass."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_water_scorpion_larva", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_butterfly",
    name = ccb.content.text("butterfly egg"),
    description = ccb.content.text("The egg of a butterfly.  They are usually found clustered on leaves."),
    copy_from = "egg_insect",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_caterpillar_butterfly", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_moth",
    name = ccb.content.text("moth egg"),
    description = ccb.content.text("The egg of a moth.  They are usually found clustered on leaves."),
    copy_from = "egg_insect",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_caterpillar_moth", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_cicada",
    name = ccb.content.text("cicada egg"),
    description = ccb.content.text("The egg of a cicada.  They are usually found near trees."),
    copy_from = "egg_insect",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_cicada_nymph", chance = 50 } } },
}

ccb.content.define_item {
    id = "menemen",
    name = ccb.content.plural_text("menemen", "menemen"),
    copy_from = "scrambled_eggs",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("A popular traditional Turkish dish which includes eggs, tomato, green peppers, and spices such as ground black and red pepper cooked in olive oil."),
    price = "5 USD",
    survival_price = "2 USD 50 cent",
    materials = { "egg", "veggy" },
    flags = { "EATEN_HOT", "FREEZERBURN" },
    comestible = {
        quench = -1,
        calories = 450,
        fun = 5,
        vitamins = { { id = "veggy_allergen", amount = 1 }, { id = "egg_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "egg_proxy_frog",
    abstract = true,
    copy_from = "egg_fish",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    color = "brown",
    description = ccb.content.text("A large clump of frog eggs.  They're gelatinous and transparent."),
    price = "25 cent",
    survival_price = "50 cent",
    comestible = { fun = -16, vitamins = { { id = "iron", amount = 4 }, { id = "egg_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "egg_leo_frog",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    description = ccb.content.text("This is a dense cluster of dark frog's eggs, not dissimilar in appearance to caviar."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_leo_tadpole", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_bullfrog_frog",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    description = ccb.content.text("A thin film of frog eggs floats together atop the water in a roughly circular mass."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_bullfrog_tadpole", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_fowler_toad",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    description = ccb.content.text("These eggs float in long strands, drifting in the still water."),
    inheritance = { add = { rot_spawn = { monster = "mon_fowler_tadpole", chance = 20 } } },
    comestible = {},
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "egg_freedom_toad",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    description = ccb.content.text("A spiral strand of frog eggs adorns a patch of underwater vegetation."),
    inheritance = { add = { rot_spawn = { monster = "mon_freedom_tadpole", chance = 20 } } },
    comestible = {},
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "egg_peeper_frog",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    description = ccb.content.text("A loose grouping of surprisingly few frog's eggs, anchored to submerged vegetation."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_peeper_tadpole", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_gray_frog",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    description = ccb.content.text("A small patch of frog's eggs rests on the water's surface."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_gray_tadpole", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_mink_frog",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    description = ccb.content.text("A tight, spherical cluster of eggs, often found near submerged vegetation.  This cluster is polar, with dark pigment collected near the tops of the eggs and white left on the underside."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_mink_tadpole", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_pickerel_frog",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    description = ccb.content.text("A globular mass of frog's eggs.  The individual eggs are colored a dark brown on top and a yellow-cream on the bottom."),
    inheritance = { add = { rot_spawn = { monster = "mon_pickerel_tadpole", chance = 20 } } },
    comestible = {},
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "egg_green_frog",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    description = ccb.content.text("A thin sheet of clear, gelatinous eggs with dark embryos peppered throughout."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_green_tadpole", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_wood_frog",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    description = ccb.content.text("This softball-sized mass of gooey eggs clings together like a bunch of soft, transparent grapes.  The \"seeds\" inside these appear to be growing legs."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_wood_tadpole", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_spade_frog",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    description = ccb.content.text("Several short strands of tightly clustered black eggs connected together by their viscous coverings."),
    inheritance = { add = { rot_spawn = { monster = "mon_spade_tadpole", chance = 20 } } },
    comestible = {},
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "egg_proxy_bigfrog",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of giant frog's eggs", "clusters of giant frog's eggs"),
    mass = "160 g",
    volume = "1 L",
    symbol = "O",
    description = ccb.content.text("A large clump of very large frog eggs.  They're gelatinous, transparent and larger than even chicken's eggs."),
    price = "50 cent",
    survival_price = "1 USD",
    comestible = {
        quench = 8,
        calories = 200,
        fun = -30,
        vitamins = {
            { id = "iron", amount = 29 },
            { id = "mutant_toxin", amount = 20 },
            { id = "egg_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "egg_pattern_bigfrog",
    copy_from = "egg_proxy_bigfrog",
    name = ccb.content.plural_text("cluster of giant frog's eggs", "clusters of giant frog's eggs"),
    description = ccb.content.text("From a distance you could mistake it for a cluster of gigantic caviar.  It is only on close inspection that you can make out the faint translucence of these softball-sized frog eggs."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_pattern_bigtad", chance = 45 } } },
}

ccb.content.define_item {
    id = "egg_strange_bigfrog",
    copy_from = "egg_proxy_bigfrog",
    name = ccb.content.plural_text("cluster of giant frog's eggs", "clusters of giant frog's eggs"),
    description = ccb.content.text("A thick flotilla of enormous frog eggs floats together atop the water in a roughly circular mass."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_strange_bigtad", chance = 45 } } },
}

ccb.content.define_item {
    id = "egg_foul_bigfrog",
    copy_from = "egg_proxy_bigfrog",
    name = ccb.content.plural_text("cluster of giant frog's eggs", "clusters of giant frog's eggs"),
    description = ccb.content.text("Looking like a submerged buoy-line, this long strand of softball-sized, gelatinous eggs floats gently in the still water."),
    inheritance = { add = { rot_spawn = { monster = "mon_foul_bigtad", chance = 45 } } },
    comestible = {},
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "egg_odd_bigfrog",
    copy_from = "egg_proxy_bigfrog",
    name = ccb.content.plural_text("cluster of giant frog's eggs", "clusters of giant frog's eggs"),
    description = ccb.content.text("This is a spiral strand of giant frog eggs.  Its increased weight and size nearly smothers the submerged vegetation it clings to."),
    inheritance = { add = { rot_spawn = { monster = "mon_odd_bigtad", chance = 45 } } },
    comestible = {},
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "egg_vocal_bigfrog",
    copy_from = "egg_proxy_bigfrog",
    name = ccb.content.plural_text("cluster of giant frog's eggs", "clusters of giant frog's eggs"),
    description = ccb.content.text("A patch of giant frog's eggs resembling a very thick, clear sack of oranges."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_vocal_bigtad", chance = 45 } } },
}

ccb.content.define_item {
    id = "egg_shift_bigfrog",
    copy_from = "egg_proxy_bigfrog",
    name = ccb.content.plural_text("cluster of giant frog's eggs", "clusters of giant frog's eggs"),
    description = ccb.content.text("These golfball-sized frog eggs cling together by their sticky membranes."),
    inheritance = { add = { rot_spawn = { monster = "mon_shift_bigtad", chance = 45 } } },
    comestible = {},
    use_actions = { "POISON" },
}
