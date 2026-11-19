local ccb = require("ccb")

ccb.content.define_item {
    id = "egg_rhea",
    name = ccb.content.text("greater rhea egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "25 days" },
    inheritance = {
        add = { rot_spawn = { monster = "mon_rhea_chick" } },
        scale = { volume = 12, mass = 12, calories = 12 },
    },
}

ccb.content.define_item {
    id = "egg_toucan",
    name = ccb.content.text("toco toucan egg"),
    copy_from = "egg_crow",
    comestible = { shelf_life = "9 days" },
    inheritance = { add = { rot_spawn = { monster = "mon_toucan_chick" } } },
}

ccb.content.define_item {
    id = "egg_parrot",
    name = ccb.content.text("white-eyed parakeet egg"),
    copy_from = "egg_bluejay",
    comestible = { shelf_life = "13 days" },
    inheritance = { add = { rot_spawn = { monster = "mon_parrot_chick" } } },
}

ccb.content.define_item {
    id = "egg_macaw",
    name = ccb.content.text("blue-and-yellow macaw egg"),
    copy_from = "egg_crow",
    comestible = { shelf_life = "13 days" },
    inheritance = { add = { rot_spawn = { monster = "mon_macaw_chick" } } },
}

ccb.content.define_item {
    id = "egg_finch_saffron",
    name = ccb.content.text("saffron finch egg"),
    copy_from = "egg_waxwing",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_finch_saffron_chick" } } },
}

ccb.content.define_item {
    id = "egg_great_kiskadee",
    name = ccb.content.text("great kiskadee egg"),
    copy_from = "egg_bluejay",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_great_kiskadee_chick" } } },
}

ccb.content.define_item {
    id = "egg_rufous_hornero",
    name = ccb.content.text("rufous hornero egg"),
    copy_from = "egg_waxwing",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_rufous_hornero_chick" } } },
}

ccb.content.define_item {
    id = "egg_tinamou",
    name = ccb.content.text("small-billed tinamou egg"),
    copy_from = "egg_bluejay",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_tinamou_chick" } } },
}

ccb.content.define_item {
    id = "egg_seriema",
    name = ccb.content.text("red-legged seriema egg"),
    copy_from = "egg_guinea_fowl",
    comestible = { shelf_life = "15 days" },
    inheritance = { add = { rot_spawn = { monster = "mon_seriema_chick" } } },
}

ccb.content.define_item {
    id = "egg_chachalaca",
    name = ccb.content.text("Chaco chachalaca egg"),
    copy_from = "egg_crow",
    comestible = { shelf_life = "12 days" },
    inheritance = { add = { rot_spawn = { monster = "mon_chachalaca_chick" } } },
}

ccb.content.define_item {
    id = "egg_guan",
    name = ccb.content.text("dusky-legged guan egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "14 days" },
    inheritance = { add = { rot_spawn = { monster = "mon_guan_chick" } } },
}

ccb.content.define_item {
    id = "egg_curassow",
    name = ccb.content.text("bare-faced curassow egg"),
    copy_from = "egg_crow",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_curassow_chick" } } },
}

ccb.content.define_item {
    id = "egg_constrictor",
    name = ccb.content.text("snake egg"),
    copy_from = "egg_chicken",
    description = ccb.content.text("The egg of a tropical snake."),
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_CONSTRICTOR" } } },
}

ccb.content.define_item {
    id = "egg_lizard",
    name = ccb.content.text("lizard egg"),
    copy_from = "egg_bird_unfert",
    description = ccb.content.text("The egg of a tropical lizard."),
    comestible = {},
}

ccb.content.define_item {
    id = "egg_iguana",
    name = ccb.content.text("iguana egg"),
    copy_from = "egg_chicken",
    description = ccb.content.text("The egg of an iguana."),
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_IGUANA" } } },
}

ccb.content.define_item {
    id = "egg_turtle",
    name = ccb.content.text("turtle egg"),
    copy_from = "egg_chicken",
    description = ccb.content.text("The round egg of a turtle.  It is covered in leaves."),
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_TURTLE" } } },
}

ccb.content.define_item {
    id = "egg_tortoise",
    name = ccb.content.text("tortoise egg"),
    copy_from = "egg_chicken",
    description = ccb.content.text("The round egg of a tortoise.  It is covered in dirt."),
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_TORTOISE" } } },
}

ccb.content.define_item {
    id = "egg_termite",
    name = ccb.content.text("termite egg"),
    copy_from = "ant_egg",
    description = ccb.content.text("The small translucent egg of a termite.  It will grow quickly into a nymph if allowed."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_termite_nymph" } } },
}

-- Copied from Fungal Fluid Sac which is also based on Wild Vegetables.
ccb.content.define_item {
    id = "triffid_pod",
    name = ccb.content.text("triffid pod"),
    mass = "278 g",
    color = "light_green",
    symbol = "o",
    description = ccb.content.text("A strange green pod produced by a triffid.  Based on observation it may be the closest thing to triffid seeds (or eggs?)."),
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "veggy" },
    volume = "250 ml",
    flags = { "RAW" },
    comestible = {
        shelf_life = "3 days 8 hours",
        kind = "FOOD",
        quench = 18,
        healthy = -1,
        calories = 35,
        smoking_result = "dry_veggy",
        rot_spawn = { group = "GROUP_EGG_TRIFFID" },
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}

-- Copied from Fungal Fluid Sac which is also based on Wild Vegetables.
ccb.content.define_item {
    id = "fungal_pod",
    name = ccb.content.text("fungal pod"),
    mass = "278 g",
    color = "light_gray",
    symbol = "o",
    description = ccb.content.text("A strange gray pod that was dropped by one of the giant fungus.  It may be the closest thing to a fungal egg."),
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "veggy" },
    volume = "250 ml",
    flags = { "RAW" },
    comestible = {
        shelf_life = "3 days 8 hours",
        kind = "FOOD",
        quench = 18,
        healthy = -1,
        calories = 35,
        smoking_result = "dry_veggy",
        rot_spawn = { group = "GROUP_EGG_FUNGUS" },
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "egg_fish_alien",
    name = ccb.content.plural_text("alien roe", "alien roe"),
    copy_from = "egg_fish",
    description = ccb.content.text("Common roe from an unknown alien creature."),
    comestible = {},
}

ccb.content.define_item {
    id = "egg_tadfish",
    name = ccb.content.plural_text("cluster of tadfish eggs", "clusters of tadfish eggs"),
    copy_from = "egg_proxy_frog",
    description = ccb.content.text("A large clump of tadfish eggs.  Very similar to other amphibian eggs."),
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_TADFISH" } } },
}

ccb.content.define_item {
    id = "egg_lungfish",
    name = ccb.content.plural_text("lungfish roe", "lungfish roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_LUNGFISH" } } },
}

ccb.content.define_item {
    id = "egg_eel_electric",
    name = ccb.content.plural_text("electric eel roe", "electric eel roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_EEL_ELECTRIC" } } },
}

ccb.content.define_item {
    id = "egg_pacu",
    name = ccb.content.plural_text("pacu roe", "pacu roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_PACU" } } },
}

ccb.content.define_item {
    id = "egg_tambaqui",
    name = ccb.content.plural_text("tambaqui roe", "tambaqui roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_TAMBAQUI" } } },
}

ccb.content.define_item {
    id = "egg_piranha",
    name = ccb.content.plural_text("piranha roe", "piranha roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_PIRANHA" } } },
}

ccb.content.define_item {
    id = "egg_arowana",
    name = ccb.content.plural_text("arowana roe", "arowana roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_AROWANA" } } },
}

ccb.content.define_item {
    id = "egg_arapaima",
    name = ccb.content.plural_text("arapaima roe", "arapaima roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_ARAPAIMA" } } },
}

ccb.content.define_item {
    id = "egg_piraiba",
    name = ccb.content.plural_text("piraiba roe", "piraiba roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_PIRAIBA" } } },
}

ccb.content.define_item {
    id = "egg_pleco",
    name = ccb.content.plural_text("pleco roe", "pleco roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_PLECO" } } },
}

-- gar eggs seem to be poisonous to consume according to Wikipedia, but poison tag didn't seem to work on this item
ccb.content.define_item {
    id = "egg_gar",
    name = ccb.content.plural_text("gar roe", "gar roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_GAR" } } },
}

ccb.content.define_item {
    id = "egg_tucunare",
    name = ccb.content.plural_text("tucunaré roe", "tucunaré roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_TUCUNARE" } } },
}

ccb.content.define_item {
    id = "egg_discus",
    name = ccb.content.plural_text("discus roe", "discus roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_DISCUS" } } },
}

ccb.content.define_item {
    id = "egg_angelfish",
    name = ccb.content.plural_text("angelfish roe", "angelfish roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_ANGELFISH" } } },
}

ccb.content.define_item {
    id = "egg_koi",
    name = ccb.content.plural_text("koi roe", "koi roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_KOI" } } },
}

ccb.content.define_item {
    id = "egg_tilapia",
    name = ccb.content.plural_text("tilapia roe", "tilapia roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_TILAPIA" } } },
}

ccb.content.define_item {
    id = "egg_sabalo",
    name = ccb.content.plural_text("sabalo roe", "sabalo roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_SABALO" } } },
}

ccb.content.define_item {
    id = "egg_oscar",
    name = ccb.content.plural_text("oscar roe", "oscar roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_OSCAR" } } },
}

ccb.content.define_item {
    id = "egg_guapote",
    name = ccb.content.plural_text("guapote roe", "guapote roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_GUAPOTE" } } },
}

ccb.content.define_item {
    id = "egg_mayaheros",
    name = ccb.content.plural_text("mayaheros roe", "mayaheros roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_MAYAHEROS" } } },
}
