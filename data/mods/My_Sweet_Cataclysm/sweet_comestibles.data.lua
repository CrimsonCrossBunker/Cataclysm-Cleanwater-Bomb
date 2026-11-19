local ccb = require("ccb")

ccb.content.define_item {
    id = "broken_necco",
    name = ccb.content.text("necco corpse"),
    symbol = "%",
    volume = "100 ml",
    mass = "60 g",
    color = "magenta",
    materials = { "junk" },
    description = ccb.content.text("The corpse of a necco.  Now it really looks like a giant necco wafer.  Surely a bite wouldn't hurt, right?"),
    price = "1 USD",
    flags = { "EDIBLE_FROZEN" },
    comestible = {
        shelf_life = "180 days",
        kind = "FOOD",
        quench = -1,
        healthy = -1,
        calories = 220,
        stimulation = 1,
        fun = 4,
        vitamins = { { id = "junk_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "marshmallow",
    name = ccb.content.plural_text("marshmallows", "marshmallows"),
    symbol = "%",
    default_container = "null",
    description = ccb.content.text("A handful of squishy, fluffy, puffy, delicious marshmallows.  They feel oddly warm…"),
    copy_from = "marshmallow",
    comestible = { shelf_life = "15 days" },
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_MARSHMALLOW", chance = 100 } } },
}

ccb.content.define_item {
    id = "smores",
    name = ccb.content.plural_text("s'mores", "s'mores"),
    symbol = "%",
    default_container = "null",
    copy_from = "smores",
    description = ccb.content.text("A pair of graham crackers with some chocolate and a marshmallow between them.  Warmth radiates from it as if it is… alive?"),
    comestible = { shelf_life = "15 days" },
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_SMORES", chance = 100 } } },
}

ccb.content.define_item {
    id = "candy3",
    name = ccb.content.plural_text("chewy candy", "chewy candy"),
    description = ccb.content.text("A handful of colorful fruit-flavored chewy candy.  They feel warm to the touch and you can almost feel a slow beat coming from them.  How odd…"),
    symbol = "%",
    default_container = "null",
    copy_from = "candy3",
    comestible = { shelf_life = "15 days" },
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_GUMMY", chance = 100 } } },
}

ccb.content.define_item {
    id = "candy3gator",
    name = ccb.content.plural_text("chewy reptilian candy", "chewy reptilian candy"),
    description = ccb.content.text("A handful of colorful fruit-flavored chewy candy shaped in a reptilian fashion.  They're warm to the touch and you can feel a slow beat coming from them.  How odd…"),
    symbol = "%",
    default_container = "null",
    copy_from = "candy3",
    comestible = { shelf_life = "15 days" },
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_GUMMY_GATOR", chance = 100 } } },
}

ccb.content.define_item {
    id = "grahmcrackers",
    name = ccb.content.text("graham cracker"),
    symbol = "%",
    default_container = "null",
    description = ccb.content.text("Dry and sugary, these crackers will leave you thirsty, but go good with some chocolate and marshmallows.  They shiver under your touch.  Weird!"),
    copy_from = "grahmcrackers",
    comestible = { shelf_life = "20 days" },
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_CRACKER", chance = 100 } } },
}

ccb.content.define_item {
    id = "grahmcrackers_roe",
    name = ccb.content.plural_text("graham cracker roe", "graham cracker roe"),
    symbol = "%",
    default_container = "null",
    description = ccb.content.text("Dry and sugary, these cracker pellets will leave you thirsty, but go good with some chocolate and marshmallows.  They shiver under your touch.  Weird!"),
    copy_from = "grahmcrackers",
    comestible = { shelf_life = "20 days" },
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_CRACKER_ROE", chance = 100 } } },
}

ccb.content.define_item {
    id = "cookies",
    name = ccb.content.text("cookie"),
    symbol = "%",
    default_container = "null",
    description = ccb.content.text("Sweet and delicious cookies, just like grandma used to bake.  They shiver under your touch.  Weird!"),
    copy_from = "cookies",
    comestible = { shelf_life = "10 days" },
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_COOKIE", chance = 100 } } },
}

ccb.content.define_item {
    id = "cookies_egg",
    name = ccb.content.text("cookie egg"),
    symbol = "%",
    default_container = "null",
    description = ccb.content.text("Sweet and delicious cookies, shaped like eggs.  They shiver under your touch as if something is inside.  Weird!"),
    copy_from = "cookies",
    comestible = { shelf_life = "10 days" },
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_COOKIE_EGG", chance = 100 } } },
}

ccb.content.define_item {
    id = "gum",
    name = ccb.content.text("chewing gum"),
    description = ccb.content.text("Bright pink chewing gum.  Sugary, sweet, and bad for your teeth.  It's oddly warm to the touch…"),
    symbol = "*",
    copy_from = "gum",
    comestible = { kind = "FOOD", shelf_life = "5 days" },
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_GUM", chance = 100 } } },
}

ccb.content.define_item {
    id = "caff_gum",
    name = ccb.content.text("caffeinated chewing gum"),
    description = ccb.content.text("Chewing gum with added caffeine.  Sugary and bad for your teeth, but it's a nice pick-me-up.  It's oddly warm to the touch…"),
    symbol = "*",
    copy_from = "caff_gum",
    comestible = { kind = "FOOD", shelf_life = "7 days" },
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_CAFFGUM", chance = 100 } } },
}

ccb.content.define_item {
    id = "cow_candy",
    name = ccb.content.plural_text("candy cattle", "candy cattle"),
    description = ccb.content.text("A handful of chocolate candies shaped like cows.  They're really warm, enough to make you wonder how they haven't melted."),
    symbol = "*",
    copy_from = "cow_candy",
    color = "brown",
    comestible = { shelf_life = "10 days" },
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_CHOC_COW", chance = 100 } } },
}

ccb.content.define_item {
    id = "milk_raw_choc",
    name = ccb.content.plural_text("raw chocolate milk", "raw chocolate milk"),
    copy_from = "milk_raw",
    color = "brown",
    description = ccb.content.text("This is raw, unhomogenized and unpasteurized chocolate milk from a chocolate cow.  It couldn't be any fresher unless you drank it straight from the cow, which might upset it.  Depending on your dietary sensibilities, you might want to pasteurize or even boil this before drinking."),
    comestible = {},
}

ccb.content.define_item {
    id = "milk_choc",
    name = ccb.content.plural_text("chocolate milk", "chocolate milk"),
    copy_from = "milk_choc",
    description = ccb.content.text("Baby chocolate cow food, appropriated for adult humans.  Spoils rapidly."),
    comestible = {},
}

ccb.content.define_item {
    id = "liquid_cacao",
    name = ccb.content.plural_text("liquid cacao", "liquid cacao"),
    mass = "258 g",
    color = "white",
    symbol = "~",
    description = ccb.content.text("Liquid unsweetened cacao.  Quite bitter to taste."),
    price = "38 cent",
    survival_price = "5 cent",
    materials = { "junk" },
    volume = "250 ml",
    phase = "liquid",
    flags = { "EATEN_COLD" },
    comestible = {
        shelf_life = "1 d",
        kind = "DRINK",
        quench = -10,
        healthy = -15,
        calories = 132,
        servings = 1,
        fun = -4,
        vitamins = { { id = "junk_allergen", amount = 1 } },
    },
}

-- Not in base game because people don't seem to do this IRL, with chocolate cows they might.
ccb.content.define_item {
    id = "milk_reconstituted_choc",
    name = ccb.content.plural_text("reconstituted chocolate milk", "reconstituted chocolate milk"),
    copy_from = "milk_reconstituted",
    color = "brown",
    description = ccb.content.text("Baby chocolate cow food, appropriated for adult humans.  This milk has been reconstituted from a processed milk.  Spoils rapidly."),
    comestible = {},
}

-- Not in base game because people don't seem to do this IRL, with chocolate cows they might.
ccb.content.define_item {
    id = "milk_powder_choc",
    name = ccb.content.plural_text("powdered chocolate milk", "powdered chocolate milk"),
    copy_from = "milk_powder",
    color = "brown",
    description = ccb.content.text("Dehydrated chocolate milk powder.  Mix with water to make drinkable milk."),
    comestible = { calories = 152, fun = -1 },
}

ccb.content.define_item {
    id = "licorice",
    name = ccb.content.plural_text("licorice", "licorice"),
    symbol = "%",
    copy_from = "licorice",
    default_container = "null",
    color = "red",
    description = ccb.content.text("A swirly confectionary treat in strings of sweet tasting candy.  You think you've seen them wriggle a bit.  How strange…"),
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_LICORICE", chance = 100 } } },
}
