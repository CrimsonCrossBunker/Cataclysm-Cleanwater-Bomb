local ccb = require("ccb")

ccb.content.define_item {
    id = "mre_chilibeans",
    copy_from = "mre_entree",
    name = ccb.content.text("chili & beans entree"),
    description = ccb.content.text("The chili & beans entree from an MRE."),
    materials = { "veggy", "bean" },
    comestible = { calories = 289, fun = -2, vitamins = { { id = "veggy_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "mre_bbqbeef",
    copy_from = "mre_entree",
    name = ccb.content.text("BBQ beef entree"),
    description = ccb.content.text("The BBQ beef entree from an MRE."),
    materials = { "flesh" },
    comestible = { calories = 293, fun = 2, vitamins = { { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "mre_chickennoodle",
    copy_from = "mre_entree",
    name = ccb.content.text("chicken noodle entree"),
    description = ccb.content.text("The chicken noodle entree from an MRE."),
    materials = { "flesh", "veggy", "wheat" },
    comestible = {
        calories = 231,
        fun = 1,
        vitamins = {
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "mre_spaghetti",
    copy_from = "mre_entree",
    name = ccb.content.text("spaghetti entree"),
    description = ccb.content.text("The spaghetti entree from an MRE."),
    materials = { "flesh", "wheat" },
    comestible = {
        calories = 280,
        fun = 0,
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "wheat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "mre_chicken",
    copy_from = "mre_entree",
    name = ccb.content.text("chicken chunks entree"),
    description = ccb.content.text("The chicken chunks entree from an MRE, with an included beef stick."),
    materials = { "flesh" },
    comestible = { calories = 238, vitamins = { { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "mre_beeftaco",
    copy_from = "mre_entree",
    name = ccb.content.text("beef taco entree"),
    description = ccb.content.text("The beef taco entree from an MRE."),
    materials = { "flesh", "veggy" },
    comestible = {
        calories = 273,
        fun = 0,
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "mre_beef",
    copy_from = "mre_entree",
    name = ccb.content.text("beef brisket entree"),
    description = ccb.content.text("The beef brisket entree from an MRE."),
    materials = { "flesh" },
    comestible = { calories = 289, fun = 1, vitamins = { { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "mre_meatball",
    copy_from = "mre_entree",
    name = ccb.content.text("meatballs & marinara entree"),
    description = ccb.content.text("The meatballs & marinara entree from an MRE."),
    materials = { "flesh", "tomato" },
    comestible = {
        calories = 311,
        fun = 0,
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "mre_beefstew",
    copy_from = "mre_entree",
    name = ccb.content.text("beef stew entree"),
    description = ccb.content.text("The beef stew entree from an MRE."),
    materials = { "flesh", "veggy" },
    comestible = {
        calories = 211,
        fun = 0,
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "mre_chilimac",
    copy_from = "mre_entree",
    name = ccb.content.text("chili & macaroni entree"),
    description = ccb.content.text("The chili & macaroni entree from an MRE."),
    materials = { "wheat", "veggy" },
    comestible = {
        calories = 280,
        fun = 1,
        vitamins = { { id = "veggy_allergen", amount = 1 }, { id = "wheat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "mre_veggy",
    copy_from = "mre_entree",
    name = ccb.content.text("vegetarian taco entree"),
    description = ccb.content.text("The vegetarian taco entree from an MRE."),
    materials = { "veggy", "tomato" },
    comestible = { calories = 231, fun = -2, vitamins = { { id = "veggy_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "mre_macaronimarinara",
    copy_from = "mre_entree",
    name = ccb.content.text("macaroni & marinara entree"),
    description = ccb.content.text("The macaroni & marinara entree from an MRE."),
    materials = { "tomato", "veggy" },
    comestible = { calories = 223, fun = 0, vitamins = { { id = "veggy_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "mre_sfettuccine",
    copy_from = "mre_entree",
    name = ccb.content.text("spinach fettuccine entree"),
    description = ccb.content.text("The creamy spinach fettuccine entree from an MRE."),
    materials = { "veggy", "milk" },
    comestible = {
        calories = 219,
        fun = -2,
        vitamins = { { id = "veggy_allergen", amount = 1 }, { id = "milk_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "mre_ratatouille",
    copy_from = "mre_entree",
    name = ccb.content.text("ratatouille entree"),
    description = ccb.content.text("The ratatouille entree from an MRE."),
    materials = { "veggy", "tomato", "wheat" },
    comestible = {
        calories = 248,
        fun = 0,
        vitamins = { { id = "veggy_allergen", amount = 1 }, { id = "wheat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "mre_cheesetort",
    copy_from = "mre_entree",
    name = ccb.content.text("cheese tortellini entree"),
    description = ccb.content.text("The cheese tortellini entree from an MRE."),
    materials = { "tomato", "veggy", "milk" },
    comestible = {
        calories = 251,
        vitamins = { { id = "veggy_allergen", amount = 1 }, { id = "milk_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "mre_mushroomfettuccine",
    copy_from = "mre_entree",
    name = ccb.content.text("mushroom fettuccine entree"),
    description = ccb.content.text("The mushroom fettuccine entree from an MRE."),
    materials = { "mushroom", "veggy", "wheat" },
    comestible = {
        calories = 239,
        vitamins = { { id = "veggy_allergen", amount = 1 }, { id = "wheat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "mre_mexicanchickenstew",
    copy_from = "mre_entree",
    name = ccb.content.text("Mexican chicken stew entree"),
    description = ccb.content.text("The Mexican chicken stew entree from an MRE."),
    materials = { "tomato", "veggy", "flesh", "bean" },
    comestible = {
        calories = 214,
        fun = 1,
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "mre_chickenburritobowl",
    copy_from = "mre_entree",
    name = ccb.content.text("chicken burrito bowl entree"),
    description = ccb.content.text("The chicken burrito bowl entree from an MRE."),
    materials = { "flesh", "veggy", "bean" },
    comestible = {
        calories = 264,
        fun = 0,
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "mre_maplesausage",
    copy_from = "mre_entree",
    name = ccb.content.text("maple sausage entree"),
    description = ccb.content.text("The maple sausage entree from an MRE."),
    materials = { "flesh", "junk" },
    comestible = {
        calories = 218,
        fun = 1,
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "junk_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "mre_ravioli",
    copy_from = "mre_entree",
    name = ccb.content.text("ravioli entree"),
    description = ccb.content.text("The ravioli entree from an MRE."),
    materials = { "flesh", "wheat" },
    comestible = {
        calories = 293,
        fun = 0,
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "wheat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "mre_pepperjackbeef",
    copy_from = "mre_entree",
    name = ccb.content.text("pepper jack beef entree"),
    description = ccb.content.text("The pepper jack beef entree from an MRE."),
    materials = { "flesh", "milk" },
    comestible = {
        calories = 148,
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "milk_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "mre_hashbrownbacon",
    copy_from = "mre_entree",
    name = ccb.content.text("hash browns & bacon entree"),
    description = ccb.content.text("The hash browns & bacon entree from an MRE."),
    materials = { "flesh", "veggy" },
    comestible = {
        calories = 249,
        fun = 2,
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "mre_lemontuna",
    copy_from = "mre_entree",
    name = ccb.content.text("lemon pepper tuna entree"),
    description = ccb.content.text("The lemon pepper tuna entree from an MRE."),
    materials = { "flesh" },
    comestible = { calories = 136, fun = 2, vitamins = { { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "mre_lobstermedley",
    copy_from = "mre_entree",
    name = ccb.content.text("lobster seafood medley entree"),
    description = ccb.content.text("The lobster seafood medley entree from an MRE."),
    materials = { "flesh" },
    comestible = { calories = 130, fun = 3, vitamins = { { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "mre_asianbeef",
    copy_from = "mre_entree",
    name = ccb.content.text("Asian beef & vegetables entree"),
    description = ccb.content.text("The Asian beef & vegetables entree from an MRE."),
    materials = { "flesh", "veggy" },
    comestible = {
        calories = 247,
        fun = 1,
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "mre_chickenpesto",
    copy_from = "mre_entree",
    name = ccb.content.text("chicken pesto & pasta entree"),
    description = ccb.content.text("The chicken pesto & pasta entree from an MRE."),
    materials = { "flesh", "wheat", "veggy" },
    comestible = {
        calories = 264,
        fun = 0,
        vitamins = {
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "mre_southwestbeef",
    copy_from = "mre_entree",
    name = ccb.content.text("southwest beef & beans entree"),
    description = ccb.content.text("The southwest beef & beans entree from an MRE."),
    materials = { "flesh", "bean" },
    comestible = {
        calories = 262,
        fun = 2,
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "mre_hotdog",
    copy_from = "mre_entree",
    name = ccb.content.text("frankfurters & beans entree"),
    description = ccb.content.text("The dreaded four fingers of death.  It seems to be several decades old."),
    price = "8 USD 50 cent",
    materials = { "flesh", "junk", "bean" },
    comestible = {
        calories = 254,
        fun = -6,
        vitamins = {
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
            { id = "junk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "mre_cheesepizza",
    copy_from = "mre_entree",
    name = ccb.content.text("cheese pizza entree"),
    description = ccb.content.text("The pizza entree from an MRE, now in vegetarian form."),
    price = "8 USD 50 cent",
    materials = { "wheat", "milk" },
    comestible = {
        calories = 261,
        fun = 1,
        vitamins = { { id = "wheat_allergen", amount = 1 }, { id = "milk_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "mre_pizza",
    copy_from = "mre_entree",
    name = ccb.content.text("pepperoni pizza entree"),
    description = ccb.content.text("The pizza entree from an MRE, featuring pepperoni slices and cheese."),
    materials = { "flesh", "wheat", "milk" },
    comestible = {
        calories = 291,
        fun = 3,
        vitamins = {
            { id = "meat_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}
