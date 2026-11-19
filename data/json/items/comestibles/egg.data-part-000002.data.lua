local ccb = require("ccb")

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
