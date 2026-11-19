local ccb = require("ccb")

-- red variety as theres no data on Monarda fistulosa, but this is similar enough - <https://pmc.ncbi.nlm.nih.gov/articles/PMC7356345/table/plants-09-00691-t002/>
ccb.content.define_item {
    id = "bee_balm",
    name = ccb.content.plural_text("bee balm", "bee balm"),
    description = ccb.content.text("A snow-white flower also known as wild bergamot.  Smells faintly of mint."),
    mass = "10 g",
    color = "white",
    symbol = ",",
    materials = { "veggy" },
    volume = "20 ml",
    price = "0 cent",
    survival_price = "0 cent",
    flags = { "RABBIT", "CATTLE" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        calories = 1,
        fun = -5,
        vitamins = { { id = "veggy_allergen", amount = 1 }, { id = "vitC", amount = "136 μg" } },
    },
}

ccb.content.define_item {
    id = "groundnut",
    name = ccb.content.plural_text("handful of ground nuts", "handfuls of ground nuts"),
    mass = "40 g",
    volume = "40 ml",
    price = "0 cent",
    survival_price = "50 cent",
    color = "brown",
    materials = { "veggy" },
    description = ccb.content.text("An almost forgotten staple of the native tribes, called the Indian potato by some.  Very nutritious, but mildly toxic unless cooked."),
    symbol = ",",
    looks_like = "potato",
    flags = { "RAW", "RAT", "MOUSE" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        calories = 29,
        shelf_life = "20 days",
        healthy = -1,
        vitamins = {
            { id = "calcium", amount = 14 },
            { id = "iron", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = -3,
    },
}

ccb.content.define_item {
    id = "wild_sarsaparilla_root",
    name = ccb.content.text("wild sarsaparilla root"),
    mass = "40 g",
    volume = "80 ml",
    price = "0 cent",
    survival_price = "5 cent",
    color = "brown",
    materials = { "veggy" },
    description = ccb.content.text("This aromatic rhizome can be eaten as is in an emergency, but it is much better used for making beverages.  Its taste is pleasant but it is also tough and stringy."),
    symbol = ",",
    flags = { "RAW", "RAT" },
    stackable = true,
    comestible = {
        calories = 40,
        stimulation = 1,
        shelf_life = "20 days",
        kind = "FOOD",
        vitamins = {
            { id = "calcium", amount = 10 },
            { id = "iron", amount = 8 },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = -3,
    },
}

ccb.content.define_item {
    id = "jerusalem_artichoke",
    name = ccb.content.text("Jerusalem artichoke"),
    mass = "40 g",
    length = "10 cm",
    price = "1 USD",
    survival_price = "50 cent",
    volume = "80 ml",
    color = "yellow",
    description = ccb.content.text("A slightly sweet tuber.  Contains much inulin which may cause some minor issues with your digestive tract, so it should be cooked."),
    symbol = ",",
    flags = { "RAW", "RAT" },
    materials = { "veggy" },
    stackable = true,
    comestible = {
        calories = 33,
        shelf_life = "20 days",
        kind = "FOOD",
        healthy = -1,
        vitamins = {
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 8 },
            { id = "vitC", amount = 2 },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = -2,
    },
}

-- no flags like CATTLE because most wildlife actually hate the onion smell
ccb.content.define_item {
    id = "wild_garlic",
    name = ccb.content.plural_text("wild garlic", "wild garlic"),
    mass = "30 g",
    price = "1 USD",
    survival_price = "50 cent",
    volume = "70 ml",
    color = "light_green",
    description = ccb.content.text("Also called ramps, this delicate leafy vegetable is healthy and a tasty ingredient for many dishes."),
    symbol = ",",
    flags = { "RAW" },
    materials = { "veggy" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        calories = 12,
        shelf_life = "3 days",
        vitamins = {
            { id = "vitC", amount = 10 },
            { id = "iron", amount = 2 },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = -2,
    },
}

ccb.content.define_item {
    id = "broccoli",
    name = ccb.content.plural_text("broccoli", "broccoli"),
    mass = "151 g",
    color = "green",
    symbol = "%",
    description = ccb.content.text("A big stalk of broccoli.  It's a bit tough, but rich in Vitamin C and quite delicious when properly cooked."),
    price = "47 cent",
    survival_price = "50 cent",
    materials = { "veggy" },
    volume = "180 ml",
    flags = { "EATEN_HOT", "RAW", "CATTLE", "RABBIT", "MOUSE", "RAT" },
    comestible = {
        shelf_life = "6 days 16 hours",
        kind = "FOOD",
        calories = 51,
        smoking_result = "dry_veggy",
        vitamins = {
            { id = "vitC", amount = "134700 μg" },
            { id = "iron", amount = "1100 μg" },
            { id = "calcium", amount = "71 mg" },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

-- Actually, not recommended for rats and mice to eat in big quantities because gas but no way to implement that yet, very minor detail though
ccb.content.define_item {
    id = "cabbage_head",
    name = ccb.content.plural_text("cabbage head", "cabbage head"),
    mass = "910 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("A head of crisp white cabbage.  You should probably prepare it before eating."),
    price = "104 cent",
    survival_price = "104 cent",
    materials = { "veggy" },
    volume = "1632 ml",
    flags = { "RAW", "CATTLE", "RABBIT", "RAT", "MOUSE" },
    comestible = {
        shelf_life = "10 days",
        kind = "FOOD",
        quench = 2,
        calories = 234,
        fun = -2,
        vitamins = {
            { id = "vitC", amount = "332800 μg" },
            { id = "iron", amount = "12900 μg" },
            { id = "calcium", amount = "364 mg" },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "cabbage",
    name = ccb.content.plural_text("handful of shredded cabbage", "handfuls of shredded cabbage"),
    mass = "70 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("A handful of shredded cabbage."),
    price = "8 cent",
    survival_price = "8 cent",
    materials = { "veggy" },
    volume = "250 ml",
    flags = { "RAW", "CATTLE", "RABBIT", "RAT", "MOUSE" },
    stackable = true,
    comestible = {
        shelf_life = "10 days",
        kind = "FOOD",
        quench = 2,
        calories = 18,
        fun = -2,
        smoking_result = "dry_veggy",
        vitamins = {
            { id = "vitC", amount = "25600 μg" },
            { id = "iron", amount = "300 μg" },
            { id = "calcium", amount = "28 mg" },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "grape_leaves",
    looks_like = "lettuce",
    name = ccb.content.plural_text("grape leaves", "grape leaves"),
    mass = "14 g",
    color = "light_green",
    symbol = "%",
    description = ccb.content.text("Edible leaves of the grape vine.  Typically used in salads or as a food wrapping."),
    price = "80 cent",
    materials = { "veggy" },
    volume = "250 ml",
    flags = { "FREEZERBURN", "RAW", "CATTLE", "RABBIT", "RAT", "MOUSE" },
    stackable = true,
    comestible = {
        shelf_life = "6 days 16 hours",
        kind = "FOOD",
        calories = 22,
        smoking_result = "dry_veggy",
        vitamins = {
            { id = "vitC", amount = 2 },
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 2 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "radish_taproot",
    name = ccb.content.plural_text("handful of radish taproots", "handfuls of radish taproots"),
    mass = "100 g",
    color = "red",
    symbol = "%",
    looks_like = "carrot",
    description = ccb.content.text("A handful of crunchy red radish taproots."),
    price = "104 cent",
    survival_price = "104 cent",
    materials = { "veggy" },
    volume = "325 ml",
    flags = { "RAW" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        quench = 2,
        calories = 15,
        smoking_result = "dry_veggy",
        vitamins = {
            { id = "veggy_allergen", amount = 1 },
            { id = "vitC", amount = "15 mg" },
            { id = "iron", amount = "3 mg" },
            { id = "calcium", amount = "25 mg" },
        },
    },
}

ccb.content.define_item {
    id = "spinach",
    name = ccb.content.plural_text("handful of spinach", "handfuls of spinach"),
    mass = "30 g",
    color = "green",
    symbol = "%",
    description = ccb.content.text("A bunch of spinach leaves.  Their ability to provide one with superhuman strength has been greatly exaggerated by popular media."),
    price = "18 cent",
    survival_price = "5 cent",
    materials = { "veggy" },
    volume = "250 ml",
    flags = { "RAW", "CATTLE", "RABBIT", "RAT", "MOUSE" },
    stackable = true,
    comestible = {
        shelf_life = "8 days",
        kind = "FOOD",
        quench = 2,
        calories = 7,
        fun = -2,
        smoking_result = "dry_veggy",
        vitamins = {
            { id = "vitC", amount = "8400 μg" },
            { id = "iron", amount = "800 μg" },
            { id = "calcium", amount = "29700 μg" },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

-- Carrots are somewhat high in sugar and should only be eaten sparingly by rabbits but there is no way to implement that yet
ccb.content.define_item {
    id = "carrot",
    name = ccb.content.text("carrot"),
    mass = "72 g",
    color = "light_red",
    symbol = "%",
    description = ccb.content.text("A healthy root vegetable.  Rich in vitamin A!"),
    price = "23 cent",
    survival_price = "8 cent",
    materials = { "veggy" },
    volume = "146 ml",
    length = "19 cm",
    flags = { "RAW", "CATTLE", "RABBIT", "RAT", "MOUSE" },
    comestible = {
        shelf_life = "5 days",
        kind = "FOOD",
        calories = 30,
        fun = 1,
        smoking_result = "dry_veggy",
        vitamins = {
            { id = "vitC", amount = "4200 μg" },
            { id = "iron", amount = "200 μg" },
            { id = "calcium", amount = "23800 μg" },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "cattail_rhizome",
    name = ccb.content.text("cattail rhizome"),
    mass = "209 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("A stout, branching rhizome from a cattail plant.  Its crisp white flesh is very starchy and fibrous, but you really ought to cook it before you attempt to eat it."),
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "veggy" },
    volume = "250 ml",
    flags = { "RAW", "RABBIT" },
    comestible = {
        shelf_life = "3 days 8 hours",
        kind = "FOOD",
        calories = 334,
        fun = -12,
        vitamins = { { id = "iron", amount = 8 }, { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "lotus_rhizome",
    name = ccb.content.text("lotus root"),
    mass = "200 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("The rhizome of the lotus, which has many tubular cavities inside, can be eaten both raw and cooked."),
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "veggy" },
    volume = "500 ml",
    flags = { "FREEZERBURN", "RABBIT" },
    comestible = {
        shelf_life = "3 days 8 hours",
        kind = "FOOD",
        calories = 150,
        smoking_result = "dry_veggy",
        vitamins = {
            { id = "vitC", amount = 94 },
            { id = "calcium", amount = 9 },
            { id = "iron", amount = 12 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

-- need to be able to fit stalks in a swag_bag for MISSION_LEARN_ABOUT_CATTAIL_JELLY
ccb.content.define_item {
    id = "cattail_stalk",
    name = ccb.content.text("cattail stalk"),
    mass = "100 g",
    length = "60 cm",
    color = "green",
    symbol = "%",
    description = ccb.content.text("A stiff, green stalk from a cattail plant.  It is starchy and fibrous, but it would be much better if you cooked it."),
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "veggy" },
    volume = "250 ml",
    flags = { "RAW", "RABBIT", "CATTLE" },
    comestible = {
        shelf_life = "3 days 8 hours",
        kind = "FOOD",
        calories = 25,
        fun = -8,
        smoking_result = "dry_veggy",
        vitamins = {
            { id = "calcium", amount = 5 },
            { id = "iron", amount = 5 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "plant_stalk",
    name = ccb.content.text("plant stalk"),
    description = ccb.content.text("A stiff, green stalk from a plant.  It is starchy and fibrous, but it would be much better if you cooked it."),
    copy_from = "cattail_stalk",
    comestible = {},
}

-- It appears that celery is energy-negative for rodents
ccb.content.define_item {
    id = "celery",
    name = ccb.content.plural_text("celery", "celery"),
    mass = "40 g",
    color = "light_green",
    symbol = "%",
    description = ccb.content.text("A single stalk of celery.  Neither tasty nor very nutritious, but it goes well with salad."),
    price = "10 cent",
    survival_price = "10 cent",
    materials = { "veggy" },
    volume = "146 ml",
    length = "19 cm",
    flags = { "FREEZERBURN", "RAW", "CATTLE", "RABBIT" },
    stackable = true,
    comestible = {
        shelf_life = "6 days 6 hours",
        kind = "FOOD",
        quench = 3,
        calories = 6,
        smoking_result = "dry_veggy",
        vitamins = {
            { id = "vitC", amount = "8400 μg" },
            { id = "iron", amount = "800 μg" },
            { id = "calcium", amount = "29700 μg" },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "cotton_boll",
    name = ccb.content.text("cotton boll"),
    category = "other",
    mass = "26 g",
    color = "light_green",
    symbol = "%",
    description = ccb.content.text("A tough protective capsule bulging with densely-packed fibers and seeds, this cotton boll can be processed into usable material with the right tools."),
    price = "25 cent",
    survival_price = "2 cent",
    materials = { "veggy", "cotton" },
    volume = "62 ml",
    stackable = true,
    comestible = {
        kind = "FOOD",
        quench = -6,
        calories = 9,
        fun = -10,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}

-- Birds can eat spicy stuff easily due to their inability to taste spiciness
ccb.content.define_item {
    id = "chili_pepper",
    name = ccb.content.text("chili pepper"),
    mass = "45 g",
    color = "red",
    symbol = "%",
    description = ccb.content.text("A spicy chili pepper.  Not the best on its own, but adds great flavor when used in cooking."),
    price = "8 cent",
    survival_price = "16 cent",
    materials = { "veggy" },
    volume = "70 ml",
    flags = { "FREEZERBURN", "RAW", "BIRD" },
    comestible = {
        shelf_life = "30 days",
        kind = "FOOD",
        calories = 18,
        smoking_result = "dry_chili",
        vitamins = {
            { id = "vitC", amount = "64700 μg" },
            { id = "iron", amount = "500 μg" },
            { id = "calcium", amount = "6300 μg" },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = -2,
    },
}

ccb.content.define_item {
    id = "chili_pepper_cut",
    copy_from = "chili_pepper",
    name = ccb.content.text("cut chili pepper"),
    description = ccb.content.text("A chili pepper that's been cut into pieces.  The seeds have been removed."),
    price = "3 cent",
    survival_price = "3 cent",
    comestible = { cooks_like = "chili_pepper", shelf_life = "3 days" },
}

-- No data on cows finding cucumbers super tasty
ccb.content.define_item {
    id = "cucumber",
    name = ccb.content.text("salad cucumber"),
    mass = "301 g",
    color = "green",
    symbol = "%",
    description = ccb.content.text("The larger cousin of a pickle.  A vegetable from the gourd family.  Not especially flavorful, but very refreshing."),
    price = "84 cent",
    survival_price = "50 cent",
    materials = { "veggy" },
    volume = "275 ml",
    length = "22 cm",
    flags = { "FREEZERBURN", "RAW", "RAT", "MOUSE" },
    stackable = true,
    comestible = {
        shelf_life = "6 days 6 hours",
        kind = "FOOD",
        quench = 7,
        calories = 45,
        smoking_result = "dry_veggy",
        vitamins = {
            { id = "vitC", amount = "8400 μg" },
            { id = "iron", amount = "800 μg" },
            { id = "calcium", amount = "48200 μg" },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "cucumber_cut",
    name = ccb.content.text("cut salad cucumber"),
    volume = "274 ml",
    mass = "300 g",
    copy_from = "cucumber",
    description = ccb.content.text("A chopped-up salad cucumber."),
    price = "30 cent",
    survival_price = "10 cent",
    stackable = true,
    comestible = { cooks_like = "cucumber", shelf_life = "2 days" },
}

ccb.content.define_item {
    id = "gherkin",
    name = ccb.content.text("gherkin cucumber"),
    mass = "65 g",
    color = "green",
    symbol = "%",
    description = ccb.content.text("A pickle before it becomes a pickle.  Gherkins are smaller cucumbers that - you guessed it - are used to make pickles."),
    price = "13 cent",
    survival_price = "11 cent",
    materials = { "veggy" },
    volume = "60 ml",
    length = "10 cm",
    flags = { "FREEZERBURN", "RAW", "RAT", "MOUSE" },
    stackable = true,
    comestible = {
        shelf_life = "6 days 6 hours",
        kind = "FOOD",
        quench = 2,
        calories = 7,
        smoking_result = "dry_veggy",
        vitamins = {
            { id = "vitC", amount = "700 μg" },
            { id = "iron", amount = "300 μg" },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "gherkin_cut",
    name = ccb.content.text("cut gherkin cucumber"),
    copy_from = "gherkin",
    description = ccb.content.text("A chopped-up gherkin cucumber."),
    price = "13 cent",
    survival_price = "5 cent",
    comestible = { cooks_like = "gherkin", shelf_life = "2 days" },
}

-- Dahlia roots contain an incredible amount of vitamin B6. This isn't a vitamin tracked in Cataclysm, but be careful of vitamin overdose when eating dahlia in real life.
ccb.content.define_item {
    id = "dahlia_root",
    name = ccb.content.text("dahlia root"),
    mass = "190 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("The large, tuberous root of a dahlia flower.  It smells spicy, but is too starchy to eat without cooking."),
    price = "1 USD",
    survival_price = "25 cent",
    materials = { "veggy" },
    volume = "250 ml",
    flags = { "RAW", "RAT", "MOUSE" },
    stackable = true,
    comestible = {
        shelf_life = "30 days",
        kind = "FOOD",
        calories = 60,
        fun = -4,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}

-- Serving Size is 1 cup of sliced roots. Salsify grows in bountiful clumps, it's a weed.
ccb.content.define_item {
    id = "salsify_raw",
    name = ccb.content.text("salsify root"),
    mass = "133 g",
    color = "green",
    symbol = "%",
    description = ccb.content.text("A highly nutritious root, it is tough and bland until cooked, at which point it tastes strangely similar to oysters."),
    price = "39 cent",
    survival_price = "50 cent",
    materials = { "veggy" },
    volume = "250 ml",
    flags = { "RAW", "RAT", "MOUSE" },
    stackable = true,
    comestible = {
        shelf_life = "30 days",
        kind = "FOOD",
        calories = 109,
        fun = -2,
        smoking_result = "dry_veggy",
        vitamins = {
            { id = "vitC", amount = "10600 μg" },
            { id = "iron", amount = "900 μg" },
            { id = "calcium", amount = "79800 μg" },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "chicory_raw",
    name = ccb.content.text("chicory root"),
    mass = "60 g",
    color = "cyan",
    symbol = "%",
    description = ccb.content.text("A very bitter root, not meant to be eaten raw."),
    price = "4 cent",
    survival_price = "25 cent",
    materials = { "veggy" },
    volume = "135 ml",
    flags = { "RAW" },
    stackable = true,
    comestible = {
        shelf_life = "30 days",
        kind = "FOOD",
        calories = 43,
        fun = -8,
        vitamins = {
            { id = "vitC", amount = "3 mg" },
            { id = "iron", amount = "500 μg" },
            { id = "calcium", amount = "24600 μg" },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

-- Also known as Queen Anne's Lace. It's that boring white flower that grows wild everywhere. Water hemlock looks almost exactly like wild carrot. The easiest way to tell them apart is by their scent. Please don't eat either of them at home, hemlock will kill you deader than Socrates.
ccb.content.define_item {
    id = "carrot_wild",
    name = ccb.content.text("wild root"),
    copy_from = "carrot",
    color = "white",
    description = ccb.content.text("These are often wild carrots, but beware of poisonous lookalikes.  In any case, the root is tough and is not as tasty as a real raw carrot."),
    price = "30 cent",
    survival_price = "16 cent",
    volume = "256 ml",
    comestible = { fun = -2 },
    inheritance = { add = { flags = { "FORAGE_POISON" } } },
}
