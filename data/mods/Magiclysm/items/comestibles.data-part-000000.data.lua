local ccb = require("ccb")

-- Alchemically speaking, I see this egg as having the elements of Growth, Stone, and Egg.  Growth would make things grow faster, the simplest example being a magical liquid fertilizer.  Stone would be a defensive element, used in creating something like a potion of stoneskin.  Egg would be interesting though.  What if instead of being imbibed there were potions that instead functioned similarly to the sourdough items, or the blob vehicle parts, in that they take a gestation period and then you could activate them and have a new item pop out.  Creatures sure but especially biomancers could have temporarily-lived tools, weapons, and armor.
ccb.content.define_item {
    id = "egg_owlbear_rock",
    name = ccb.content.text("owlbear egg"),
    mass = "2395 g",
    color = "light_gray",
    symbol = "0",
    description = ccb.content.text("This egg laid by an owlbear seems almost indistinguishable from a large rock until you touch it and can feel the warm glow of potential life energy from within.  It's hard to believe that an owlbear could grow so quickly from something so small.  Perhaps you could carefully crack it open to get at the liquid golden goodness inside."),
    price = "3 kUSD",
    materials = { "egg", "stone" },
    volume = "2500 ml",
    flags = { "FREEZERBURN" },
    comestible = {
        shelf_life = "14 days",
        kind = "FOOD",
        quench = 128,
        healthy = 3,
        calories = 3200,
        fun = -18,
        vitamins = {
            { id = "calcium", amount = 120 },
            { id = "iron", amount = 160 },
            { id = "egg_allergen", amount = 1 },
        },
        rot_spawn = { group = "GROUP_EGG_OWLBEAR", chance = 80 },
    },
}

ccb.content.define_item {
    id = "egg_giant_heron_ridable",
    name = ccb.content.text("aenorhi egg"),
    copy_from = "egg_chicken",
    description = ccb.content.text("A large egg laid by an aenor.  You could feed a lot of people with this."),
    volume = "1800 ml",
    comestible = { quench = 14, calories = 2100 },
    inheritance = { add = { rot_spawn = { monster = "mon_giant_heron_ridable_chick", chance = 75 } } },
}

-- Normal whiskey has been greatly devalued in the apocalypse by the disproportionate quantity of endless whiskey flasks in comparison to the number of survivors.
ccb.content.define_item {
    id = "whiskey",
    name = ccb.content.plural_text("whiskey", "whiskey"),
    copy_from = "whiskey",
    price = "2 USD 50 cent",
    survival_price = "1 cent",
    comestible = {},
}

ccb.content.define_item {
    id = "egg_owlbear",
    name = ccb.content.text("owlbear egg yolk"),
    copy_from = "egg_chicken",
    phase = "liquid",
    color = "yellow",
    description = ccb.content.text("The liquid innards of an owlbear egg.  Good eating."),
    comestible = { servings = 1, healthy = 3 },
}

ccb.content.define_item {
    id = "hairball",
    materials = { { id = "fur", portions = 10 }, { id = "water", portions = 1 } },
    volume = "350 ml",
    mass = "15 g",
    color = "brown",
    symbol = "0",
    name = ccb.content.text("hairball"),
    description = ccb.content.text("A big, ugly ball of animal spit and licked-off hairs.  Don't swallow it."),
    price = "0 cent",
    flags = { "TRADER_AVOID", "EDIBLE_FROZEN" },
    comestible = { kind = "MED", healthy = -1, fun = -20 },
}

ccb.content.define_item {
    id = "meat_dragon",
    copy_from = "meat",
    name = ccb.content.plural_text("dragon meat", "dragon meat"),
    description = ccb.content.text("The meat from a slain dragon.  It does not seem to respond to cooking the same way as other meat, making it obvious that it still retains some magical properties."),
    comestible = { parasites = 0 },
}

ccb.content.define_item {
    id = "scream_mush",
    copy_from = "mushroom",
    name = ccb.content.text("scream mushroom"),
    description = ccb.content.text("The mushrooms harvested from a dead shrieker.  Could be used in potions."),
    price = "14 USD",
    comestible = {},
}

-- Same reason as whiskey
ccb.content.define_item {
    id = "tea_green",
    copy_from = "tea_green",
    name = ccb.content.plural_text("green tea", "green tea"),
    survival_price = "1 cent",
    comestible = {},
}

ccb.content.define_item {
    id = "purified_meat",
    copy_from = "meat",
    name = ccb.content.plural_text("purified meat", "purified meat"),
    description = ccb.content.text("Indistinguishable from pre-Cataclysm lab grown beef.  It should be excellent but somehow it's just edible."),
    price = "4 USD",
    comestible = { calories = 402 },
    inheritance = { add = { flags = { "NUTRIENT_OVERRIDE" } } },
}
