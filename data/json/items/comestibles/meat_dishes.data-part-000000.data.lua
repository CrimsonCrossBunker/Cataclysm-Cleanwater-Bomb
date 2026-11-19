local ccb = require("ccb")

-- 撤销 PR #86581 — 恢复僵尸尸体的实用性
ccb.content.define_item {
    id = "sausage_raw",
    name = ccb.content.text("raw sausage"),
    conditional_names = {
        { kind = "VITAMIN", key = "human_flesh_vitamin", name = ccb.content.text("raw Mannwurst") },
        { kind = "FLAG", key = "STRICT_HUMANITARIANISM", name = ccb.content.text("raw killbasa") },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("sinister %s", "sinister %s"),
        },
    },
    mass = "148 g",
    color = "red",
    symbol = "%",
    description = ccb.content.text("A hefty raw sausage, prepared for smoking or cooking."),
    price = "16 USD",
    survival_price = "2 USD",
    materials = { "flesh" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        quench = -1,
        calories = 474,
        parasites = 32,
        smoking_result = "sausage",
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 6 },
            { id = "meat_allergen", amount = 1 },
        },
        fun = -10,
    },
}

ccb.content.define_item {
    id = "sausage",
    name = ccb.content.text("smoked sausage"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.text("smoked Mannwurst"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.text("smoked killbasa"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("sinister %s", "sinister %s"),
        },
    },
    copy_from = "sausage_raw",
    survival_price = "3 USD",
    description = ccb.content.text("A hefty sausage that has been cured and smoked for long term storage."),
    flags = { "EATEN_HOT", "SMOKED" },
    comestible = { parasites = 0, shelf_life = "14 days", fun = 5 },
}

ccb.content.define_item {
    id = "sausage_cooked",
    name = ccb.content.text("cooked sausage"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.text("cooked Mannwurst"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.text("cooked killbasa"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("sinister %s", "sinister %s"),
        },
    },
    copy_from = "sausage_raw",
    survival_price = "2 USD",
    description = ccb.content.text("A hefty cooked sausage.  Better eat it hot and fresh."),
    flags = { "EATEN_HOT" },
    comestible = { parasites = 0, fun = 5, shelf_life = "2 days" },
}

ccb.content.define_item {
    id = "confit_meat",
    looks_like = "meat_cooked",
    name = ccb.content.plural_text("meat confit", "meat confit"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("con confit", "con confit"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("birdman confit", "birdman confit"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("twisted confit", "twisted confit"),
        },
    },
    mass = "351 g",
    color = "brown",
    default_container = "can_medium",
    symbol = "%",
    description = ccb.content.text("Salted meat slowly cooked in butter or melted fat, a form of food preservation from the days before canning.  Rich and fatty, it will last for a long time."),
    price = "6 USD",
    survival_price = "3 USD 50 cent",
    materials = { "flesh" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "90 days",
        kind = "FOOD",
        quench = -2,
        calories = 716,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 20 },
            { id = "meat_allergen", amount = 1 },
        },
        fun = 1,
    },
}

ccb.content.define_item {
    id = "sweet_sausage",
    name = ccb.content.text("sweet sausage"),
    conditional_names = {
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("sinister %s", "sinister %s"),
        },
    },
    mass = "148 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("A sweet and delicious maple-flavored sausage.  Better eat it hot and fresh."),
    price = "24 USD",
    materials = { "flesh" },
    volume = "250 ml",
    survival_price = "2 USD 50 cent",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        calories = 539,
        vitamins = {
            { id = "vitC", amount = 4 },
            { id = "iron", amount = 22 },
            { id = "meat_allergen", amount = 1 },
        },
        fun = 8,
    },
}

-- volume and weight for a roughly 25cm length, 2.5cm diameter link, estimated
ccb.content.define_item {
    id = "blutwurst_sausage",
    name = ccb.content.text("blutwurst"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.text("Menschenblutwurst"),
        },
        { kind = "FLAG", key = "STRICT_HUMANITARIANISM", name = ccb.content.text("Mein teil") },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("baleful %s", "baleful %s"),
        },
    },
    mass = "100 g",
    color = "brown",
    symbol = "%",
    looks_like = "sausage",
    description = ccb.content.text("A type of German sausage made of pre-cooked meat and blood.  Better eat it hot and fresh."),
    price = "180 cent",
    volume = "150 ml",
    materials = { "flesh" },
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        quench = -1,
        calories = 385,
        fun = 2,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}

-- volume and weight for a roughly 25cm length, 2.5cm diameter link, estimated
ccb.content.define_item {
    id = "bratwurst_sausage",
    name = ccb.content.text("bratwurst"),
    conditional_names = {
        { kind = "VITAMIN", key = "human_flesh_vitamin", name = ccb.content.text("Mannbrat") },
        { kind = "FLAG", key = "STRICT_HUMANITARIANISM", name = ccb.content.text("frankenfurter") },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("baleful %s", "baleful %s"),
        },
    },
    mass = "100 g",
    color = "brown",
    symbol = "%",
    looks_like = "sausage",
    description = ccb.content.text("A type of German sausage made of finely-chopped meat, meant to be pan-fried or roasted.  Better eat it hot and fresh."),
    price = "180 cent",
    volume = "150 ml",
    materials = { "flesh" },
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        quench = -1,
        calories = 297,
        fun = 5,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "royal_beef",
    name = ccb.content.plural_text("royal beef", "royal beef"),
    mass = "446 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("A chunk of meat coated with royal jelly.  It's a lot like a honey-baked ham."),
    price = "210 USD",
    survival_price = "45 USD",
    materials = { "flesh" },
    volume = "500 ml",
    stackable = true,
    comestible = {
        shelf_life = "3 days 8 hours",
        kind = "FOOD",
        calories = 637,
        fun = 7,
        vitamins = {
            { id = "vitC", amount = 4 },
            { id = "calcium", amount = 6 },
            { id = "iron", amount = 69 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "bacon",
    name = ccb.content.plural_text("bacon", "pieces of bacon"),
    mass = "85 g",
    color = "pink",
    default_container = "bag_plastic_small",
    symbol = "%",
    description = ccb.content.text("A thick slab of salty cured bacon.  Shelf stable, precooked and ready-to-eat, it tastes better when reheated."),
    price = "950 cent",
    volume = "125 ml",
    survival_price = "250 cent",
    materials = { "flesh" },
    flags = { "EATEN_HOT", "SMOKED" },
    stackable = true,
    comestible = {
        shelf_life = "42 days",
        kind = "FOOD",
        quench = -2,
        calories = 398,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 6 },
            { id = "meat_allergen", amount = 1 },
        },
        fun = 5,
    },
}

ccb.content.define_item {
    id = "sausage_wasteland",
    copy_from = "sausage",
    name = ccb.content.text("wasteland sausage"),
    description = ccb.content.text("Lean sausage made from heavily salt-cured offal, with natural gut casing.  Waste not, want not."),
    flags = { "SMOKED" },
    comestible = { quench = -7, fun = -3 },
}

ccb.content.define_item {
    id = "sausage_wasteland_raw",
    copy_from = "sausage_raw",
    name = ccb.content.text("raw wasteland sausage"),
    description = ccb.content.text("Lean raw sausage made from heavily salt-cured offal, ready to be smoked."),
    comestible = { quench = -7, smoking_result = "sausage_wasteland" },
}

ccb.content.define_item {
    id = "cracklins",
    name = ccb.content.plural_text("cracklins", "cracklins"),
    mass = "42 g",
    volume = "100 ml",
    color = "brown",
    default_container = "bag_plastic_small",
    symbol = "%",
    description = ccb.content.text("Also known as pork rinds or chicharrones, these are bits of edible fat and skin that have been fried until they are crispy and delicious."),
    price = "42 cent",
    survival_price = "125 cent",
    materials = { "flesh" },
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "7 days",
        kind = "FOOD",
        quench = -2,
        calories = 270,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 3 },
            { id = "meat_allergen", amount = 1 },
        },
        fun = 4,
    },
}

ccb.content.define_item {
    id = "human_cracklins",
    name = ccb.content.plural_text("cracklins", "cracklins"),
    copy_from = "cracklins",
    materials = { "hflesh" },
    comestible = { vitamins = { { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "mutant_cracklins",
    name = ccb.content.plural_text("cracklins", "cracklins"),
    copy_from = "cracklins",
    materials = { "flesh" },
    comestible = { vitamins = { { id = "mutant_toxin", amount = 52 }, { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "mutant_human_cracklins",
    name = ccb.content.plural_text("cracklins", "cracklins"),
    copy_from = "cracklins",
    materials = { "hflesh" },
    comestible = { vitamins = { { id = "mutant_toxin", amount = 52 }, { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "demihuman_cracklins",
    name = ccb.content.plural_text("cracklins", "cracklins"),
    copy_from = "cracklins",
    materials = { "flesh" },
    flags = { "STRICT_HUMANITARIANISM" },
    comestible = { vitamins = { { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "glazed_tenderloin",
    name = ccb.content.plural_text("glazed tenderloins", "glazed tenderloins"),
    conditional_names = {
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("grisly %s", "grisly %s"),
        },
    },
    mass = "205 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("A tender piece of meat, perfectly seasoned with a thin sweet glaze and a vegetable accompaniment.  A gourmet dish that is both healthy and delicious."),
    price = "1333 cent",
    survival_price = "333 cent",
    materials = { { id = "flesh", portions = 10 }, { id = "veggy", portions = 1 } },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "2 days 8 hours",
        kind = "FOOD",
        quench = 3,
        calories = 560,
        fun = 18,
        vitamins = {
            { id = "vitC", amount = 17 },
            { id = "calcium", amount = 8 },
            { id = "iron", amount = 32 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "lobster_platter",
    name = ccb.content.plural_text("lobster platter", "lobster platter"),
    mass = "205 g",
    color = "red",
    symbol = "%",
    description = ccb.content.text("Fresh lobster meat, perfectly seasoned with lemon juice and a vegetable accompaniment.  A gourmet dish that is both healthy and delicious."),
    price = "1333 cent",
    survival_price = "5 USD",
    materials = { { id = "flesh", portions = 10 }, { id = "veggy", portions = 1 } },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "2 days 8 hours",
        kind = "FOOD",
        quench = 3,
        calories = 550,
        fun = 18,
        vitamins = {
            { id = "vitC", amount = 17 },
            { id = "calcium", amount = 8 },
            { id = "iron", amount = 32 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "currywurst",
    name = ccb.content.text("currywurst"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("cheapskate %s", "cheapskate %s"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("confusing %s", "confusing %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("bloodcurdling %s", "bloodcurdling %s"),
        },
    },
    mass = "85 g",
    color = "red",
    default_container = "wrapper",
    symbol = "%",
    description = ccb.content.text("Sausage covered in a curry ketchup sauce.  Spicy and delicious!"),
    price = "450 cent",
    survival_price = "175 cent",
    materials = { "flesh" },
    volume = "125 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        quench = -3,
        calories = 260,
        fun = 10,
        vitamins = {
            { id = "calcium", amount = 20 },
            { id = "iron", amount = 10 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

-- Same as the meat it's been made from.  It's additional ingredient compared to smoking, jerking, and dehydrating, so there's no incentive otherwise.
ccb.content.define_item {
    id = "meat_aspic",
    name = ccb.content.plural_text("aspic", "aspic"),
    conditional_names = {
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("abomination %s", "abomination %s"),
        },
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("amoral %s", "amoral %s"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("Orwell's %s", "Orwell's %s"),
        },
    },
    mass = "154 g",
    color = "red",
    symbol = "%",
    description = ccb.content.text("A dish in which meat or fish is set into a gelatin made from a meat or vegetable stock."),
    price = "25 USD",
    survival_price = "1 USD 50 cent",
    materials = { "flesh" },
    volume = "250 ml",
    flags = { "EATEN_COLD", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "3 days 8 hours",
        kind = "FOOD",
        calories = 213,
        vitamins = {
            { id = "vitC", amount = 15 },
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 8 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "dry_fish",
    name = ccb.content.plural_text("dehydrated fish", "dehydrated fish"),
    copy_from = "fish_cooked",
    materials = { { id = "cured_meat" } },
    mass = "85 g",
    color = "light_gray",
    description = ccb.content.text("Dehydrated fish flakes.  With proper storage, this dried food will remain edible for an incredibly long time."),
    display_type = "BY_WEIGHT",
    price = "5 USD",
    survival_price = "2 USD 50 cent",
    volume = "125 ml",
    flags = { "EDIBLE_FROZEN" },
    comestible = { shelf_life = "360 days", quench = -3 },
}

ccb.content.define_item {
    id = "rehydrated_fish",
    name = ccb.content.plural_text("rehydrated fish", "rehydrated fish"),
    copy_from = "fish_cooked",
    color = "white",
    description = ccb.content.text("Reconstituted fish flakes, which are much more enjoyable to eat now that they have been rehydrated."),
    display_type = "BY_WEIGHT",
    price = "5 USD",
    comestible = { fun = 2 },
}

ccb.content.define_item {
    id = "dry_lobster",
    name = ccb.content.plural_text("dehydrated lobster", "dehydrated lobster"),
    copy_from = "lobster_cooked",
    materials = { { id = "cured_meat" } },
    mass = "85 g",
    color = "light_gray",
    description = ccb.content.text("Dehydrated lobster meat.  With proper storage, this dried food will remain edible for an incredibly long time."),
    display_type = "BY_WEIGHT",
    price = "5 USD",
    survival_price = "3 USD",
    volume = "125 ml",
    flags = { "EDIBLE_FROZEN" },
    comestible = { shelf_life = "360 days", quench = -3 },
}

ccb.content.define_item {
    id = "rehydrated_lobster",
    name = ccb.content.plural_text("rehydrated lobster", "rehydrated lobster"),
    copy_from = "lobster_cooked",
    color = "white",
    description = ccb.content.text("Reconstituted lobster meat, which is much more enjoyable to eat now that it has been rehydrated."),
    display_type = "BY_WEIGHT",
    price = "5 USD",
    comestible = { fun = 4 },
}

ccb.content.define_item {
    id = "dry_mollusk",
    name = ccb.content.plural_text("dehydrated mollusk", "dehydrated mollusk"),
    copy_from = "mollusk_cooked",
    materials = { { id = "cured_meat" } },
    mass = "85 g",
    color = "light_red",
    description = ccb.content.text("Dehydrated mollusk meat.  With proper storage, this dried food will remain edible for an incredibly long time."),
    display_type = "BY_WEIGHT",
    price = "5 USD",
    survival_price = "3 USD",
    volume = "125 ml",
    flags = { "EDIBLE_FROZEN" },
    comestible = { shelf_life = "360 days", quench = -3 },
}

ccb.content.define_item {
    id = "rehydrated_mollusk",
    name = ccb.content.plural_text("rehydrated mollusk", "rehydrated mollusk"),
    copy_from = "mollusk_cooked",
    color = "pink",
    description = ccb.content.text("Reconstituted mollusk meat, which is much more enjoyable to eat now that it has been rehydrated."),
    display_type = "BY_WEIGHT",
    price = "5 USD",
    comestible = { fun = 4 },
}

ccb.content.define_item {
    id = "fish_pickled",
    name = ccb.content.plural_text("pickled fish", "pickled fish"),
    copy_from = "fish_cooked",
    color = "white",
    default_container = "jar_glass_sealed",
    description = ccb.content.text("A serving of crisply brined and canned fish.  Tasty and nutritious."),
    materials = { "flesh" },
    comestible = {
        shelf_life = "4 days",
        quench = -1,
        fun = 7,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "fish_canned",
    name = ccb.content.plural_text("canned fish", "canned fish"),
    copy_from = "fish_cooked",
    color = "light_gray",
    description = ccb.content.text("Low-sodium boiled and canned fish.  Contains most of the nutrition, but little of the savor of cooked fish."),
    display_type = "BY_WEIGHT",
    price = "2 USD 50 cent",
    survival_price = "2 USD 50 cent",
    sealed_container = true,
    comestible = { shelf_life = "1 day 16 hours", fun = 2 },
}

ccb.content.define_item {
    id = "lobster_canned",
    name = ccb.content.plural_text("canned lobster", "canned lobster"),
    copy_from = "lobster_cooked",
    color = "light_gray",
    description = ccb.content.text("Low-sodium boiled and canned lobster.  Contains most of the nutrition, but little of the savor of cooked lobster."),
    display_type = "BY_WEIGHT",
    price = "2 USD 50 cent",
    survival_price = "2 USD 50 cent",
    sealed_container = true,
    comestible = { shelf_life = "1 day 16 hours", fun = 4 },
}

ccb.content.define_item {
    id = "fried_froglegs",
    name = ccb.content.plural_text("fried frog legs (pair)", "fried frog legs (pair)"),
    mass = "120 g",
    color = "yellow",
    default_container = "box_small",
    symbol = "f",
    description = ccb.content.text("A delicious pair of golden-brown crispy fried frog legs."),
    price = "7 USD",
    survival_price = "3 USD",
    materials = { "flesh" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        calories = 381,
        fun = 8,
        vitamins = {
            { id = "calcium", amount = 16 },
            { id = "iron", amount = 10 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "fish_fried",
    name = ccb.content.plural_text("batter fried fish", "batter fried fish"),
    mass = "201 g",
    color = "yellow",
    default_container = "box_small",
    symbol = "%",
    description = ccb.content.text("A delicious golden-brown serving of crispy fried fish."),
    price = "5 USD",
    survival_price = "4 USD",
    materials = { "flesh" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        calories = 748,
        fun = 10,
        vitamins = {
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 5 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

-- Currently only found in worldgen and is uncraftable. If crab gets added please make a recipe for crab cakes.
ccb.content.define_item {
    id = "crab_cakes",
    name = ccb.content.text("crab cake"),
    copy_from = "fish_fried",
    mass = "150 g",
    description = ccb.content.text("A delicious deep-fried biscuit loaded with crab meat."),
    volume = "175 ml",
    looks_like = "fish_fried",
    comestible = { calories = 572, fun = 13 },
}

ccb.content.define_item {
    id = "lobster_cakes",
    name = ccb.content.text("lobster cake"),
    copy_from = "fish_fried",
    mass = "150 g",
    description = ccb.content.text("A delicious deep-fried biscuit loaded with lobster meat."),
    volume = "175 ml",
    looks_like = "fish_fried",
    comestible = { calories = 765, fun = 13 },
}

ccb.content.define_item {
    id = "stuffed_clams",
    name = ccb.content.plural_text("stuffed clams", "stuffed clams"),
    copy_from = "fish_fried",
    mass = "150 g",
    description = ccb.content.text("Quahog clams stuffed with bread crumbs and fried."),
    volume = "35 ml",
    looks_like = "fish_fried",
    comestible = {
        calories = 115,
        fun = 13,
        vitamins = { { id = "calcium", amount = 2 }, { id = "iron", amount = 5 } },
    },
}

-- *Looking for ~$6 per pound here.
ccb.content.define_item {
    id = "lunchmeat",
    name = ccb.content.plural_text("lunch meat", "lunch meat"),
    conditional_names = {
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("loathsome %s", "loathsome %s"),
        },
    },
    mass = "56 g",
    color = "red",
    default_container = "bag_plastic_small",
    symbol = "%",
    description = ccb.content.text("Meat that has been cooked, preserved, and cut into thin slices for convenient sandwich construction.  It tastes fine cold."),
    price = "14 cent",
    survival_price = "75 cent",
    materials = { "flesh" },
    volume = "75 ml",
    stackable = true,
    comestible = {
        shelf_life = "2 days 12 hours",
        kind = "FOOD",
        calories = 180,
        vitamins = { { id = "iron", amount = 2 }, { id = "meat_allergen", amount = 1 } },
    },
}

-- Rebalanced: the recipe looks to easily make two pounds.
ccb.content.define_item {
    id = "bologna",
    name = ccb.content.plural_text("bologna", "bologna"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("brat %s", "brat %s"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("Tumnis %s", "Tumnis %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("bleak %s", "bleak %s"),
        },
    },
    mass = "56 g",
    color = "red",
    default_container = "bag_plastic_small",
    symbol = "%",
    description = ccb.content.text("Formally known as Bologna sausage, this is a finely-ground preserved meat that comes in circular slices.  Its first name isn't Oscar.  You can eat it cold."),
    price = "1 USD",
    survival_price = "25 cent",
    materials = { "flesh" },
    volume = "75 ml",
    stackable = true,
    comestible = {
        shelf_life = "23 days 8 hours",
        kind = "FOOD",
        calories = 26,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 6 },
            { id = "iron", amount = 5 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "lutefisk",
    name = ccb.content.plural_text("lutefisk", "lutefisk"),
    mass = "175 g",
    color = "light_gray",
    default_container = "bag_plastic_small",
    symbol = "%",
    description = ccb.content.text("Preserved fish that has been dried in a lye solution.  Vile and soap-like yet highly nutritious, it is reminiscent of the afterbirth of a dog or the world's largest chunk of phlegm."),
    price = "2 USD",
    survival_price = "2 USD 50 cent",
    materials = { { id = "cured_meat" } },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        quench = -2,
        calories = 260,
        fun = -15,
        vitamins = { { id = "iron", amount = 3 }, { id = "meat_allergen", amount = 1 } },
    },
}

-- SPAM comes in cans of six 2 oz slices.  Each charge is one slice.
ccb.content.define_item {
    id = "can_spam",
    name = ccb.content.plural_text("SPAM", "SPAM"),
    mass = "56 g",
    color = "pink",
    symbol = "%",
    description = ccb.content.text("A canned pork product that is unnaturally pink, oddly rubbery, and not very tasty.  Quite filling, but completely unappetizing cold."),
    display_type = "BY_WEIGHT",
    price = "66 cent",
    survival_price = "50 cent",
    materials = { "flesh" },
    volume = "83 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        quench = -3,
        calories = 180,
        fun = -8,
        vitamins = { { id = "iron", amount = 3 }, { id = "meat_allergen", amount = 1 } },
    },
}
