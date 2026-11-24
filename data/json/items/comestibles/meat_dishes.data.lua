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

-- NO_I18N
-- NO_I18N
-- This is used for the all_nutrient_starve_test.
ccb.content.define_item {
    id = "debug_nutrition",
    copy_from = "can_spam",
    name = ccb.content.text_without_extraction("holy SPAM of debugging", "holy SPAM of debugging"),
    description = ccb.content.text_without_extraction("A mysterious lump of SPAM that contains just enough calories and vitamins to feed you for a day.  For debug use only."),
    comestible = {
        calories = 2150,
        vitamins = {
            { id = "vitC", amount = 100 },
            { id = "calcium", amount = 100 },
            { id = "iron", amount = 100 },
        },
    },
}

ccb.content.define_item {
    id = "can_sardine",
    name = ccb.content.plural_text("canned sardine", "canned sardine"),
    mass = "200 g",
    color = "light_gray",
    symbol = "%",
    description = ccb.content.text("Salty little fish.  They'll make you thirsty."),
    display_type = "BY_WEIGHT",
    price = "2 USD",
    survival_price = "3 USD",
    materials = { "flesh" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        quench = -8,
        calories = 340,
        fun = 1,
        vitamins = {
            { id = "calcium", amount = 40 },
            { id = "iron", amount = 12 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

-- Semi-arbitrary spoilage of 48 hours set: pretty confident sausage gravy goes bad.
ccb.content.define_item {
    id = "sausagegravy",
    name = ccb.content.plural_text("sausage gravy", "sausage gravy"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("Mannwurst gravy", "Mannwurst gravy"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("killbasa gravy", "killbasa gravy"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("ghastly %s", "ghastly %s"),
        },
    },
    mass = "60 g",
    color = "light_gray",
    symbol = "%",
    description = ccb.content.text("Biscuits, meat, and delicious mushroom soup all crammed together into a wonderfully greasy and tasty mush."),
    price = "10 USD",
    survival_price = "2 USD",
    materials = { "flesh", "wheat", "mushroom" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        quench = 6,
        calories = 363,
        fun = 9,
        vitamins = {
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "pemmican",
    name = ccb.content.plural_text("pemmican", "pemmican"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("prepper %s", "prepper %s"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("Orley %s", "Orley %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("pernicious %s", "pernicious %s"),
        },
    },
    mass = "106 g",
    color = "brown",
    default_container = "bag_plastic_small",
    symbol = "%",
    description = ccb.content.text("A concentrated mixture of fat and protein, first said to have been used as a nutritious high-energy food by the Querecho and Teya people of what is Texas today.  Composed of meat, tallow, and edible berries, it provides excellent nutrition in an easy to carry form."),
    price = "6 USD",
    survival_price = "3 USD 50 cent",
    materials = { "flesh", "fruit" },
    volume = "120 ml",
    stackable = true,
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        quench = -2,
        calories = 440,
        vitamins = {
            { id = "vitC", amount = 3 },
            { id = "calcium", amount = 5 },
            { id = "iron", amount = 21 },
            { id = "meat_allergen", amount = 1 },
            { id = "fruit_allergen", amount = 1 },
        },
        fun = 3,
    },
}

ccb.content.define_item {
    id = "pemmican_veggy",
    name = ccb.content.plural_text("pemmican", "pemmican"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("prepper %s", "prepper %s"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("Orley %s", "Orley %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("pernicious %s", "pernicious %s"),
        },
    },
    mass = "106 g",
    color = "brown",
    default_container = "bag_plastic_small",
    symbol = "%",
    description = ccb.content.text("A concentrated mixture of fat and protein, first said to have been used as a nutritious high-energy food by the Querecho and Teya people of what is Texas today.  Composed of meat, tallow, and edible plants or mushrooms, it provides excellent nutrition in an easy to carry form."),
    price = "5 USD 99 cent",
    survival_price = "3 USD 50 cent",
    materials = { "flesh", "veggy" },
    volume = "120 ml",
    stackable = true,
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        quench = -2,
        calories = 440,
        vitamins = {
            { id = "vitC", amount = 3 },
            { id = "calcium", amount = 5 },
            { id = "iron", amount = 21 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = 3,
    },
}

ccb.content.define_item {
    id = "pemmican_meat",
    name = ccb.content.plural_text("pemmican (meat only)", "pemmican (meat only)"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("prepper %s", "prepper %s"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("Orley %s", "Orley %s"),
        },
        {
            kind = "COMPONENT_ID",
            key = "mutant",
            name = ccb.content.plural_text("pernicious %s", "pernicious %s"),
        },
    },
    mass = "100 g",
    color = "brown",
    default_container = "bag_plastic_small",
    symbol = "%",
    description = ccb.content.text("A concentrated mixture of fat and protein, first said to have been used as a nutritious high-energy food by the Querecho and Teya people of what is Texas today.  Composed of meat and tallow, it provides excellent nutrition in an easy to carry form.  Contains no fruits or veggies."),
    price = "5 USD",
    survival_price = "3 USD",
    materials = { "flesh" },
    volume = "110 ml",
    stackable = true,
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        quench = -3,
        calories = 400,
        vitamins = {
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 20 },
            { id = "meat_allergen", amount = 1 },
        },
        fun = 1,
    },
}

ccb.content.define_item {
    id = "macaroni_helper",
    name = ccb.content.plural_text("hamburger helper", "hamburger helper"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("hobo helper", "hobo helper"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("halfling helper", "halfling helper"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("heinous %s", "heinous %s"),
        },
    },
    mass = "170 g",
    color = "red",
    default_container = "box_small",
    symbol = "%",
    description = ccb.content.text("Some mac and cheese with ground meat added, enhancing the flavor and nutritional value."),
    price = "4 USD 90 cent",
    survival_price = "2 USD",
    materials = { "wheat", "flesh", "milk" },
    volume = "250 ml",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        quench = 13,
        calories = 393,
        fun = 5,
        vitamins = {
            { id = "vitC", amount = 4 },
            { id = "calcium", amount = 32 },
            { id = "iron", amount = 20 },
            { id = "meat_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "ravioli",
    name = ccb.content.plural_text("ravioli", "ravioli"),
    mass = "170 g",
    color = "light_red",
    symbol = "%",
    description = ccb.content.text("Meat encased in little dough satchels.  Tastes fine straight from the can."),
    price = "125 cent",
    survival_price = "1 USD",
    materials = { "flesh", "wheat" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        calories = 393,
        vitamins = {
            { id = "calcium", amount = 5 },
            { id = "iron", amount = 27 },
            { id = "meat_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "chili",
    name = ccb.content.plural_text("chili con carne", "chili con carne"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("chili con Cabron", "chili con Cabron"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("chili con Sindar", "chili con Sindar"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("chili con chupacabra", "chili con chupacabra"),
        },
    },
    mass = "253 g",
    color = "red",
    symbol = "%",
    description = ccb.content.text("A spicy stew containing chili peppers, meat, tomatoes and beans."),
    display_type = "BY_WEIGHT",
    price = "145 cent",
    survival_price = "250 cent",
    phase = "liquid",
    materials = { "flesh", "veggy", "bean", "tomato" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        calories = 299,
        servings = 1,
        fun = 5,
        vitamins = {
            { id = "vitC", amount = 7 },
            { id = "calcium", amount = 7 },
            { id = "iron", amount = 27 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "pork_beans",
    name = ccb.content.plural_text("pork and beans", "pork and beans"),
    mass = "267 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Greasy Prospector brand improved pork and beans with hickory smoked pig fat chunks."),
    display_type = "BY_WEIGHT",
    price = "1 USD",
    survival_price = "150 cent",
    phase = "liquid",
    materials = { "flesh", "bean" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    comestible = {
        shelf_life = "1 day 12 hours",
        kind = "FOOD",
        quench = -8,
        calories = 283,
        servings = 1,
        fun = 5,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 14 },
            { id = "iron", amount = 32 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "can_tuna",
    name = ccb.content.plural_text("canned tuna fish", "canned tuna fish"),
    mass = "154 g",
    color = "light_gray",
    symbol = "%",
    description = ccb.content.text("Now with 95 percent fewer dolphins!"),
    display_type = "BY_WEIGHT",
    price = "2 USD",
    survival_price = "3 USD",
    materials = { "flesh" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        calories = 305,
        fun = 2,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 12 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "can_salmon",
    name = ccb.content.plural_text("canned salmon", "canned salmon"),
    mass = "200 g",
    color = "pink",
    symbol = "%",
    description = ccb.content.text("Bright pink fish-paste from a can."),
    display_type = "BY_WEIGHT",
    price = "5 USD",
    survival_price = "3 USD 50 cent",
    materials = { "flesh" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        calories = 276,
        fun = 1,
        vitamins = {
            { id = "calcium", amount = 57 },
            { id = "iron", amount = 9 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "can_chicken",
    name = ccb.content.plural_text("canned chicken", "canned chicken"),
    mass = "217 g",
    color = "pink",
    symbol = "%",
    description = ccb.content.text("Off-white chicken-paste from a can."),
    display_type = "BY_WEIGHT",
    price = "2 USD",
    survival_price = "3 USD",
    materials = { "flesh" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        calories = 400,
        fun = 1,
        vitamins = {
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 18 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "can_herring",
    name = ccb.content.plural_text("pickled herring", "pickled herring"),
    mass = "232 g",
    color = "white",
    default_container = "jar_glass_sealed",
    symbol = "%",
    description = ccb.content.text("Fish fillets pickled in some sort of tangy white sauce."),
    display_type = "BY_WEIGHT",
    price = "155 cent",
    survival_price = "350 cent",
    materials = { "flesh" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        shelf_life = "4 days",
        kind = "FOOD",
        calories = 465,
        fun = 3,
        vitamins = {
            { id = "calcium", amount = 34 },
            { id = "iron", amount = 34 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "can_clams",
    name = ccb.content.plural_text("canned clam", "canned clam"),
    mass = "169 g",
    color = "light_gray",
    symbol = "%",
    description = ccb.content.text("Chopped quahog clams in water."),
    display_type = "BY_WEIGHT",
    price = "5 USD",
    survival_price = "5 USD",
    materials = { "flesh" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        quench = 1,
        calories = 240,
        fun = 2,
        vitamins = {
            { id = "calcium", amount = 11 },
            { id = "iron", amount = 25 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "can_chowder",
    name = ccb.content.plural_text("clam chowder", "clam chowder"),
    conditional_names = {
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "meat",
            name = ccb.content.plural_text("meat chowder", "meat chowder"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("monster chowder", "monster chowder"),
        },
    },
    mass = "253 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("Delicious, lumpy, white soup made of meat (traditionally clams) and potatoes in a milk base.  A taste of the lost glory of New England."),
    display_type = "BY_VOLUME",
    price = "2 USD",
    survival_price = "2 USD",
    phase = "liquid",
    materials = { "flesh", "milk" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        quench = 2,
        calories = 142,
        servings = 1,
        fun = 6,
        vitamins = {
            { id = "vitC", amount = 14 },
            { id = "calcium", amount = 7 },
            { id = "iron", amount = 16 },
            { id = "meat_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

-- One beans + one protein = 2 servings
ccb.content.define_item {
    id = "deluxe_beans",
    name = ccb.content.plural_text("baked beans", "baked beans"),
    conditional_names = {
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("ork and beans", "ork and beans"),
        },
    },
    mass = "293 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Slow-cooked beans with meat.  Tasty and very filling."),
    display_type = "BY_WEIGHT",
    price = "350 cent",
    survival_price = "2 USD",
    materials = { "bean", "flesh" },
    volume = "500 ml",
    phase = "liquid",
    flags = { "EATEN_HOT" },
    comestible = {
        shelf_life = "15 days",
        kind = "FOOD",
        calories = 373,
        servings = 1,
        fun = 4,
        vitamins = {
            { id = "vitC", amount = 10 },
            { id = "calcium", amount = 6 },
            { id = "iron", amount = 51 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

-- One rice + one protein/veg = 2 servings
ccb.content.define_item {
    id = "deluxe_rice",
    name = ccb.content.plural_text("meat fried rice", "meat fried rice"),
    conditional_names = {
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("mutant fried rice", "mutant fried rice"),
        },
    },
    mass = "187 g",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("Delicious fried rice with meat.  Tasty and very filling."),
    display_type = "BY_WEIGHT",
    price = "350 cent",
    survival_price = "2 USD",
    materials = { "veggy", "flesh" },
    volume = "500 ml",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "15 days",
        kind = "FOOD",
        calories = 313,
        fun = 5,
        vitamins = {
            { id = "vitC", amount = 8 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 40 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "deluxe_beansnrice",
    name = ccb.content.plural_text("deluxe beans and rice", "deluxe beans and rice"),
    conditional_names = {
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("\"deluxe\" beans and rice", "\"deluxe\" beans and rice"),
        },
    },
    mass = "312 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Slow-cooked beans and rice with meat and seasonings.  Tasty and very filling."),
    display_type = "BY_WEIGHT",
    price = "375 cent",
    survival_price = "2 USD",
    materials = { "veggy", "bean", "flesh" },
    volume = "187 ml",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "15 days",
        kind = "FOOD",
        calories = 414,
        fun = 4,
        vitamins = {
            { id = "vitC", amount = 5 },
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 10 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "pie_meat",
    name = ccb.content.plural_text("slice of meat pie", "slices of meat pie"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("slice of prick pie", "slices of prick pie"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("slice of talking animal pie", "slices of talking animal pie"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("malignant %s", "malignant %s"),
        },
    },
    mass = "189 g",
    color = "brown",
    default_container = "box_small",
    symbol = "%",
    description = ccb.content.text("A delicious slice of baked pie with a hearty meat filling."),
    price = "168 cent",
    survival_price = "250 cent",
    materials = { "wheat", "flesh" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "3 days 8 hours",
        kind = "FOOD",
        quench = 5,
        calories = 400,
        fun = 3,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 14 },
            { id = "meat_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "pizza_meat",
    name = ccb.content.plural_text("slice of meat pizza", "slices of meat pizza"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("slice of poser pizza", "slices of poser pizza"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("slice of protesting pizza", "slices of protesting pizza"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("miserable %s", "miserable %s"),
        },
    },
    mass = "230 g",
    color = "light_red",
    default_container = "box_small",
    symbol = "%",
    description = ccb.content.text("A slice of meat pizza, for all the carnivores out there.  Chock-full of minced meat and heavily seasoned."),
    price = "272 cent",
    survival_price = "250 cent",
    materials = { "wheat", "flesh" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        calories = 566,
        fun = 10,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 44 },
            { id = "iron", amount = 36 },
            { id = "meat_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "pizza_supreme",
    name = ccb.content.plural_text("slice of supreme pizza", "slices of supreme pizza"),
    copy_from = "pizza_meat",
    color = "light_red",
    mass = "300 g",
    description = ccb.content.text("A slice of supreme pizza with ALL the toppings."),
    price = "15 USD",
    survival_price = "15 USD",
    materials = { "wheat", "flesh", "veggy", "milk" },
    comestible = {
        calories = 641,
        fun = 11,
        vitamins = {
            { id = "vitC", amount = 20 },
            { id = "calcium", amount = 32 },
            { id = "iron", amount = 28 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "deluxe_eggs",
    name = ccb.content.plural_text("deluxe scrambled eggs", "deluxe scrambled eggs"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("deluxe scrambled eggheads", "deluxe scrambled eggheads"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("birdman's scrambled eggs", "birdman's scrambled eggs"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("\"deluxe\" scrambled eggs", "\"deluxe\" scrambled eggs"),
        },
    },
    mass = "198 g",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("Fluffy and delicious scrambled eggs made even better with the addition of tasty meat or fish."),
    price = "233 cent",
    survival_price = "150 cent",
    materials = { "egg", "flesh" },
    volume = "83 ml",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        calories = 279,
        fun = 4,
        vitamins = {
            { id = "vitC", amount = 2 },
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 39 },
            { id = "meat_allergen", amount = 1 },
            { id = "egg_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "meat_canned",
    name = ccb.content.plural_text("canned meat", "canned meat"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("soylent slice", "soylent slice"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("sapient slice", "sapient slice"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("%s, mutant", "%s, mutant"),
        },
    },
    copy_from = "meat_cooked",
    color = "red",
    default_container = "can_food",
    description = ccb.content.text("Low-sodium boiled and canned meat.  Contains most of the nutrition, but little of the savor of cooked meat."),
    price = "2 USD 50 cent",
    survival_price = "2 USD 50 cent",
    flags = { "EATEN_HOT" },
    sealed_container = true,
    comestible = { shelf_life = "1 day 16 hours", fun = 2 },
}

ccb.content.define_item {
    id = "meat_salted",
    name = ccb.content.plural_text("vacuum-packed meat", "vacuum-packed meat"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("vacuum-packed human meat", "vacuum-packed human meat"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("vacuum-packed demihuman meat", "vacuum-packed demihuman meat"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("%s, mutant", "%s, mutant"),
        },
    },
    copy_from = "meat_cooked",
    color = "red",
    default_container = "plastic_bag_vac",
    description = ccb.content.text("Cooked meat sealed in a vacuum bag to slow spoilage.  Its listed shelf life applies once exposed to air; an intact vacuum seal slows decay by half again."),
    display_type = "BY_WEIGHT",
    price = "5 USD",
    survival_price = "3 USD",
    materials = { { id = "flesh" } },
    comestible = { shelf_life = "42 days", fun = 2, vitamins = { { id = "meat_allergen", amount = 1 } } },
    inheritance = { remove = { flags = { "NUTRIENT_OVERRIDE" } } },
}

ccb.content.define_item {
    id = "spaghetti_bolognese",
    name = ccb.content.plural_text("spaghetti bolognese", "spaghetti bolognese"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("scoundrel spaghetti", "scoundrel spaghetti"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("speaking spaghetti", "speaking spaghetti"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("gnarly %s", "gnarly %s"),
        },
    },
    mass = "150 g",
    color = "red",
    symbol = "%",
    description = ccb.content.text("Spaghetti covered with a thick meat sauce.  Yum!"),
    price = "125 cent",
    survival_price = "150 cent",
    materials = { "wheat", "flesh" },
    volume = "218 ml",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        calories = 226,
        fun = 4,
        vitamins = {
            { id = "vitC", amount = 5 },
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 9 },
            { id = "meat_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "lasagne",
    name = ccb.content.plural_text("lasagne", "lasagne"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("Luigi %s", "Luigi %s"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("Lab %s", "Lab %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("monster %s", "monster %s"),
        },
    },
    mass = "255 g",
    color = "red",
    symbol = "%",
    description = ccb.content.text("A very old type of pasta made with several layers of lasagne sheets alternated with cheese, sauce and meat."),
    price = "125 cent",
    survival_price = "37 cent",
    materials = {
        { id = "processed_food", portions = 10 },
        { id = "flesh", portions = 1 },
        { id = "wheat", portions = 1 },
        { id = "milk", portions = 1 },
    },
    volume = "250 ml",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "2 days 16 hours",
        kind = "FOOD",
        quench = 5,
        calories = 226,
        fun = 15,
        vitamins = {
            { id = "vitC", amount = 6 },
            { id = "calcium", amount = 22 },
            { id = "iron", amount = 17 },
            { id = "meat_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "fried_spam",
    name = ccb.content.plural_text("fried SPAM", "fried SPAM"),
    copy_from = "can_spam",
    color = "red",
    description = ccb.content.text("Now that it's been fried, this SPAM is actually pretty tasty."),
    price = "5 USD",
    materials = { "flesh" },
    flags = { "EATEN_HOT" },
    comestible = { quench = -6, fun = 8, vitamins = { { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "cheeseburger",
    name = ccb.content.text("cheeseburger"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("chump %s", "chump %s"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("elf %s", "elf %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("chilling %s", "chilling %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "egg",
            name = ccb.content.text("breakfast cheeseburger"),
        },
    },
    mass = "333 g",
    color = "brown",
    default_container = "wrapper",
    symbol = "%",
    description = ccb.content.text("A sandwich of minced meat and cheese with condiments.  A simple favorite of the people before the Cataclysm."),
    price = "10 USD",
    survival_price = "2 USD 50 cent",
    materials = {
        { id = "processed_food", portions = 10 },
        { id = "flesh", portions = 1 },
        { id = "wheat", portions = 1 },
        { id = "milk", portions = 1 },
    },
    volume = "300 ml",
    flags = { "EATEN_HOT", "ALLERGEN_MILK" },
    stackable = true,
    comestible = {
        shelf_life = "1 day 12 hours",
        kind = "FOOD",
        calories = 380,
        fun = 5,
        vitamins = {
            { id = "vitC", amount = 1 },
            { id = "calcium", amount = 57 },
            { id = "iron", amount = 65 },
            { id = "meat_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "deluxe_cheeseburger",
    copy_from = "cheeseburger",
    name = ccb.content.text("deluxe cheeseburger"),
    mass = "380 g",
    description = ccb.content.text("A cheeseburger with more vegetables and condiments.  This is the apex of pre-Cataclysm culinary achievement."),
    survival_price = "3 USD",
    materials = {
        { id = "processed_food", portions = 10 },
        { id = "flesh", portions = 1 },
        { id = "wheat", portions = 1 },
        { id = "milk", portions = 1 },
        { id = "veggy", portions = 1 },
        { id = "tomato", portions = 1 },
    },
    volume = "350 ml",
    comestible = {
        calories = 500,
        fun = 7,
        vitamins = {
            { id = "vitC", amount = 30 },
            { id = "calcium", amount = 60 },
            { id = "iron", amount = 65 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "hamburger",
    name = ccb.content.text("hamburger"),
    conditional_names = {
        { kind = "VITAMIN", key = "human_flesh_vitamin", name = ccb.content.text("bobburger") },
        { kind = "FLAG", key = "STRICT_HUMANITARIANISM", name = ccb.content.text("Moreauburger") },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("horrible %s", "horrible %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "egg",
            name = ccb.content.text("breakfast burger"),
        },
    },
    mass = "300 g",
    color = "brown",
    default_container = "wrapper",
    symbol = "%",
    description = ccb.content.text("A sandwich of minced meat with condiments."),
    price = "9 USD",
    survival_price = "2 USD",
    materials = { "flesh", "wheat" },
    volume = "300 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "1 day 12 hours",
        kind = "FOOD",
        calories = 258,
        fun = 4,
        vitamins = {
            { id = "vitC", amount = 1 },
            { id = "calcium", amount = 57 },
            { id = "iron", amount = 65 },
            { id = "meat_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "sloppyjoe",
    name = ccb.content.text("sloppy joe"),
    conditional_names = {
        { kind = "VITAMIN", key = "human_flesh_vitamin", name = ccb.content.text("sloppy Joseph") },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("manfriendwich", "manfriendwiches"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("suspicious %s", "suspicious %s"),
        },
    },
    mass = "313 g",
    color = "brown",
    default_container = "wrapper",
    symbol = "%",
    description = ccb.content.text("A sandwich consisting of ground meat and tomato sauce served on bread."),
    price = "9 USD",
    survival_price = "2 USD 50 cent",
    materials = { "flesh", "tomato", "wheat" },
    volume = "300 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "1 day 12 hours",
        kind = "FOOD",
        calories = 391,
        fun = 4,
        vitamins = {
            { id = "vitC", amount = 5 },
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 5 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "taco",
    name = ccb.content.text("taco"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("tio %s", "tio %s"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("talking %s", "talking %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("terrifying %s", "terrifying %s"),
        },
    },
    mass = "102 g",
    color = "yellow",
    default_container = "wrapper",
    symbol = "%",
    description = ccb.content.text("A traditional Mexican dish composed of a corn tortilla folded or rolled around a meat filling."),
    price = "2 USD 10 cent",
    survival_price = "1 USD 50 cent",
    materials = { "flesh" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        quench = -5,
        calories = 210,
        fun = 8,
        vitamins = {
            { id = "vitC", amount = 1 },
            { id = "calcium", amount = 8 },
            { id = "iron", amount = 15 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "ndn_taco",
    name = ccb.content.text("Indian taco"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("tio %s", "tio %s"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("talking %s", "talking %s"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("terrifying %s", "terrifying %s"),
        },
    },
    mass = "265 g",
    color = "yellow",
    default_container = "wrapper",
    symbol = "%",
    description = ccb.content.text("Frybread topped with beans, meat, and lettuce.  Originally conceived by the Navajo in the 19th century, only having available basic foodstuffs provided by the US-government after forced expulsion from their homelands, this dish became popular with many Native Americans and is often served at Powwows or other festivities."),
    price = "2 USD 10 cent",
    survival_price = "1 USD 50 cent",
    materials = { "flesh" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        quench = -5,
        calories = 365,
        fun = 8,
        vitamins = {
            { id = "vitC", amount = 1 },
            { id = "calcium", amount = 8 },
            { id = "iron", amount = 15 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "meat_pickled",
    name = ccb.content.plural_text("pickled meat", "pickled meat"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("pickled punk", "pickled punk"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("pickled anthro", "pickled anthro"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("%s, mutant", "%s, mutant"),
        },
    },
    copy_from = "meat_cooked",
    color = "pink",
    default_container = "jar_glass_sealed",
    description = ccb.content.text("A serving of crisply brined and canned meat.  Tasty and nutritious."),
    price = "2 USD 50 cent",
    survival_price = "3 USD",
    comestible = { shelf_life = "4 days", fun = 6 },
    inheritance = { remove = { flags = { "NUTRIENT_OVERRIDE" } } },
}

ccb.content.define_item {
    id = "dehydrated_cured_meat",
    name = ccb.content.plural_text("dehydrated cured meat", "dehydrated cured meat"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("dehydrated cured human meat", "dehydrated cured human meat"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("dehydrated cured demihuman meat", "dehydrated cured demihuman meat"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("%s, mutant", "%s, mutant"),
        },
    },
    copy_from = "raw_cured_meat",
    mass = "85 g",
    volume = "125 ml",
    color = "brown",
    description = ccb.content.text("Raw cured meat dried until nearly all moisture is gone.  It will keep indefinitely, but is extremely salty and must be washed before normal cooking."),
    display_type = "BY_WEIGHT",
    price = "9 USD",
    survival_price = "4 USD",
    materials = { { id = "cured_meat", portions = 10 }, { id = "flesh", portions = 1 } },
    flags = { "RAW", "EDIBLE_FROZEN" },
    comestible = {
        shelf_life = 0,
        quench = -15,
        fun = -6,
        smoking_result = "null",
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "washed_cured_meat",
    name = ccb.content.plural_text("washed cured meat", "washed cured meat"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("washed cured human meat", "washed cured human meat"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("washed cured demihuman meat", "washed cured demihuman meat"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("%s, mutant", "%s, mutant"),
        },
    },
    copy_from = "raw_cured_meat",
    mass = "275 g",
    volume = "250 ml",
    color = "light_red",
    description = ccb.content.text("Raw cured meat soaked and rinsed to remove its excess salt.  It spoils quickly again, but can now be used anywhere ordinary raw red meat is called for."),
    display_type = "BY_WEIGHT",
    price = "7 USD",
    survival_price = "2 USD",
    materials = { { id = "flesh" } },
    flags = { "RAW" },
    comestible = {
        shelf_life = "3 days",
        quench = 0,
        fun = -6,
        cooked_item = "cooked_cured_meat",
        cooking_energy = "300 kJ",
        smoking_result = "null",
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "cooked_cured_meat",
    name = ccb.content.plural_text("cooked cured meat", "cooked cured meat"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("cooked cured human meat", "cooked cured human meat"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("cooked cured demihuman meat", "cooked cured demihuman meat"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("%s, mutant", "%s, mutant"),
        },
    },
    copy_from = "meat_cooked",
    description = ccb.content.text("Cured meat that has been rinsed of excess salt and cooked.  It is savory and ready to eat, but no longer keeps like its heavily salted form."),
    display_type = "BY_WEIGHT",
    price = "9 USD",
    survival_price = "3 USD",
    materials = { { id = "cured_meat", portions = 1 }, { id = "flesh", portions = 3 } },
    comestible = { shelf_life = "3 days", fun = 6, vitamins = { { id = "meat_allergen", amount = 1 } } },
    inheritance = { remove = { flags = { "NUTRIENT_OVERRIDE" } } },
}

ccb.content.define_item {
    id = "dry_meat",
    name = ccb.content.plural_text("dehydrated meat", "dehydrated meat"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("%s, human", "%s, human"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("%s, demihuman", "%s, demihuman"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("%s, mutant", "%s, mutant"),
        },
    },
    copy_from = "meat_cooked",
    mass = "85 g",
    color = "red",
    description = ccb.content.text("Dehydrated meat flakes.  With proper storage, this dried food will remain edible for an incredibly long time."),
    display_type = "BY_WEIGHT",
    price = "9 USD",
    survival_price = "3 USD",
    materials = { { id = "cured_meat", portions = 10 }, { id = "flesh", portions = 1 } },
    volume = "125 ml",
    flags = { "EDIBLE_FROZEN" },
    comestible = {
        shelf_life = "360 days",
        quench = -3,
        fun = -2,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}

-- Froglegs are 87 percent water
ccb.content.define_item {
    id = "dry_froglegs",
    name = ccb.content.plural_text("dehydrated frog legs (pair)", "dehydrated frog legs (pair)"),
    copy_from = "froglegs_cooked",
    mass = "13 g",
    color = "red",
    description = ccb.content.text("A pair of dehydrated frog legs.  With proper storage, this dried food will remain edible for an incredibly long time."),
    price = "6 USD",
    survival_price = "3 USD",
    materials = { { id = "cured_meat", portions = 10 }, { id = "flesh", portions = 1 } },
    volume = "25 ml",
    flags = { "EDIBLE_FROZEN" },
    comestible = { shelf_life = "360 days", quench = -1, vitamins = { { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "dry_poultry",
    name = ccb.content.plural_text("dehydrated chicken", "dehydrated chicken"),
    copy_from = "dry_meat",
    color = "white",
    description = ccb.content.text("Dehydrated flakes of bird meat.  With proper storage, this dried food will remain edible for an incredibly long time."),
    display_type = "BY_WEIGHT",
    comestible = { calories = 220, fun = 0 },
}

ccb.content.define_item {
    id = "rehydrated_froglegs",
    name = ccb.content.text("rehydrated frog leg"),
    copy_from = "froglegs_cooked",
    color = "light_red",
    description = ccb.content.text("Reconstituted frog legs, which are much more enjoyable to eat now that they have been rehydrated."),
    price = "6 USD",
    survival_price = "3 USD",
    comestible = { fun = 2 },
}

ccb.content.define_item {
    id = "rehydrated_poultry",
    name = ccb.content.plural_text("rehydrated chicken", "rehydrated chicken"),
    copy_from = "poultry_cooked",
    color = "light_red",
    description = ccb.content.text("Reconstituted bird meat, which are much more enjoyable to eat now that they have been rehydrated."),
    display_type = "BY_WEIGHT",
    price = "6 USD",
    survival_price = "3 USD",
    comestible = { fun = 2 },
}

ccb.content.define_item {
    id = "rehydrated_meat",
    name = ccb.content.plural_text("rehydrated meat", "rehydrated meat"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("%s, human", "%s, human"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("%s, demihuman", "%s, demihuman"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("%s, mutant", "%s, mutant"),
        },
    },
    copy_from = "meat_cooked",
    color = "light_red",
    description = ccb.content.text("Reconstituted meat flakes, which are much more enjoyable to eat now that they have been rehydrated."),
    display_type = "BY_WEIGHT",
    price = "9 USD",
    survival_price = "1 USD",
    comestible = { fun = 2 },
    inheritance = { remove = { flags = { "NUTRIENT_OVERRIDE" } } },
}

-- That's whisky without an 'e' because we're talking about Scotch whisky.
ccb.content.define_item {
    id = "haggis",
    name = ccb.content.plural_text("haggis", "haggises"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("human %s", "human %s"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("%s, demihuman", "%s, demihuman"),
        },
    },
    mass = "156 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("This traditional Scottish savory pudding is made of meat and offal mixed with oatmeal, sewn into an animal's stomach and boiled.  Surprisingly tasty and quite filling, it is best served with boiled root vegetables and strong whisky."),
    price = "7 USD 50 cent",
    survival_price = "2 USD 50 cent",
    materials = { "wheat", "flesh" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "15 days",
        kind = "FOOD",
        quench = 2,
        calories = 979,
        fun = 2,
        vitamins = {
            { id = "vitC", amount = 21 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 29 },
            { id = "meat_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "sushi_fishroll",
    name = ccb.content.plural_text("fish makizushi", "fish makizushi"),
    mass = "159 g",
    color = "green",
    symbol = "%",
    description = ccb.content.text("Delicious slivers of thinly-sliced raw fish, wrapped in tasty sushi rice and rolled up in a healthy green vegetable."),
    price = "116 cent",
    survival_price = "1 USD",
    materials = { "veggy", "flesh" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        shelf_life = "12 hours",
        kind = "FOOD",
        calories = 378,
        fun = 14,
        vitamins = {
            { id = "vitC", amount = 23 },
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 3 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "sushi_meatroll",
    name = ccb.content.plural_text("meat temaki", "meat temaki"),
    conditional_names = {
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("troubling %s", "troubling %s"),
        },
    },
    mass = "273 g",
    color = "green",
    symbol = "%",
    description = ccb.content.text("Delicious slivers of raw meat, wrapped in tasty sushi rice and rolled up in a healthy green vegetable."),
    price = "185 cent",
    survival_price = "150 cent",
    materials = { "veggy", "flesh" },
    volume = "500 ml",
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        calories = 417,
        fun = 13,
        vitamins = {
            { id = "vitC", amount = 36 },
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 37 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "sashimi",
    name = ccb.content.plural_text("sashimi", "sashimi"),
    copy_from = "fish_cooked",
    color = "white",
    description = ccb.content.text("Delicious slivers of thinly sliced raw fish, served with tasty vegetables."),
    price = "6 USD",
    survival_price = "3 USD",
    materials = { "veggy", "flesh" },
    comestible = {
        shelf_life = "12 hours",
        calories = 160,
        fun = 7,
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "dry_meat_tainted",
    name = ccb.content.plural_text("dehydrated tainted meat", "dehydrated tainted meat"),
    copy_from = "meat_tainted",
    mass = "85 g",
    color = "red",
    description = ccb.content.text("Pieces of poisonous meat that have been dried to prevent them from rotting away.  They're still unsafe to eat."),
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "flesh" },
    volume = "125 ml",
    flags = { "EDIBLE_FROZEN" },
    comestible = {
        shelf_life = "360 days",
        quench = -3,
        fun = -7,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "pelmeni",
    name = ccb.content.plural_text("pelmeni", "pelmeni"),
    conditional_names = {
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("perilous %s", "perilous %s"),
        },
    },
    mass = "151 g",
    color = "light_red",
    default_container = "can_medium",
    symbol = "%",
    description = ccb.content.text("Delicious cooked dumplings consisting of a meat filling wrapped in thin dough."),
    price = "175 cent",
    survival_price = "2 USD",
    materials = { "flesh", "wheat" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        calories = 300,
        fun = 6,
        vitamins = {
            { id = "vitC", amount = 3 },
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 15 },
            { id = "meat_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "homemade_burrito",
    name = ccb.content.text("homemade burrito"),
    conditional_names = {
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.text("bone-chilling burrito"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "egg",
            name = ccb.content.text("breakfast burrito"),
        },
    },
    mass = "142 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("A traditional Mexican dish of meat, beans or rice, and vegetables spread on a corn tortilla and rolled into a tube shape.  The fresh ingredients make this one taste way better than those gas station knockoffs."),
    price = "233 cent",
    survival_price = "166 cent",
    materials = { "flesh", "veggy" },
    volume = "83 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "1 days 4 hours",
        kind = "FOOD",
        quench = -8,
        calories = 292,
        fun = 7,
        vitamins = {
            { id = "vitC", amount = 3 },
            { id = "calcium", amount = 19 },
            { id = "iron", amount = 12 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "meatball_raw",
    name = ccb.content.text("raw meatball"),
    conditional_names = {
        { kind = "VITAMIN", key = "human_flesh_vitamin", name = ccb.content.text("raw manball") },
        { kind = "FLAG", key = "STRICT_HUMANITARIANISM", name = ccb.content.text("raw murderball") },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("sinister %s", "sinister %s"),
        },
    },
    mass = "85g",
    color = "pink",
    symbol = "%",
    description = ccb.content.text("A round, seasoned lump of meat, ready to fry."),
    price = "8 USD",
    survival_price = "2 USD",
    materials = { "flesh" },
    volume = "85 ml",
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        calories = 230,
        parasites = 32,
        vitamins = {
            { id = "vitC", amount = 2 },
            { id = "calcium", amount = 8 },
            { id = "iron", amount = 4 },
            { id = "meat_allergen", amount = 1 },
        },
        fun = -10,
    },
}

ccb.content.define_item {
    id = "meatball",
    name = ccb.content.text("meatball"),
    conditional_names = {
        { kind = "VITAMIN", key = "human_flesh_vitamin", name = ccb.content.text("manball") },
        { kind = "FLAG", key = "STRICT_HUMANITARIANISM", name = ccb.content.text("murderball") },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("sinister %s", "sinister %s"),
        },
    },
    copy_from = "meatball_raw",
    survival_price = "3 USD",
    description = ccb.content.text("A seasoned and fried round lump of meat.  Just like mom used to make!"),
    flags = { "EATEN_HOT" },
    comestible = { parasites = 0, shelf_life = "4 days", fun = 6 },
}

ccb.content.define_item {
    id = "paella_valenciana",
    name = ccb.content.plural_text("Valencian paella", "Valencian paella"),
    conditional_names = {
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("vulgar paella", "vulgar paella"),
        },
    },
    mass = "110 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("A traditional dish originating from Spain, more specifically from the region of Valencia.  A very tasty and filling dish made traditionally of rabbit, beans, rice, chicken, spices and sometimes snails."),
    price = "375 cent",
    survival_price = "2 USD",
    materials = { "veggy", "bean", "flesh" },
    volume = "110 ml",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "15 days",
        kind = "FOOD",
        calories = 442,
        fun = 4,
        vitamins = {
            { id = "vitC", amount = 8 },
            { id = "calcium", amount = 5 },
            { id = "iron", amount = 11 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

-- Nutrition information roughly based on a serving of 6 snails + butter and veggies. if you know more pls expand
ccb.content.define_item {
    id = "escargot",
    name = ccb.content.plural_text("escargot", "escargot"),
    mass = "20 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("A traditional dish originating from France, more specifically from the region of Bourgogne.  It consists of prepared snails that have then been cooked in butter and parsley inside their own shells, very low on fat but high on protein."),
    price = "125 cent",
    survival_price = "66 cent",
    materials = { "veggy", "flesh", "milk" },
    volume = "20 ml",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        calories = 40,
        fun = 4,
        vitamins = {
            { id = "vitC", amount = 3 },
            { id = "calcium", amount = 18 },
            { id = "iron", amount = 6 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "kiymali_pide",
    name = ccb.content.plural_text("kiymali pide", "kiymali pide"),
    mass = "160 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Turkish flatbread topped with ground lamb or beef mixed with peppers, onions, and tomatoes."),
    price = "125 cent",
    survival_price = "66 cent",
    materials = { "bread", "flesh" },
    volume = "300 ml",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "3 days",
        kind = "FOOD",
        calories = 250,
        fun = 4,
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "bread_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "lahmacun",
    name = ccb.content.text("lahmacun"),
    mass = "50 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Turkish flatbread topped with minced meat, minced vegetables, and herbs including onions, garlic, tomatoes, red peppers, and parsley, flavored with spices such as chili pepper and paprika, then baked."),
    price = "187 cent",
    survival_price = "1 USD",
    materials = { "bread", "flesh" },
    volume = "120 ml",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "3 days",
        kind = "FOOD",
        calories = 300,
        fun = 4,
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "bread_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "iskender",
    name = ccb.content.plural_text("iskender kebab", "iskender kebab"),
    mass = "250 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("A Turkish dish that consists of sliced döner kebab meat topped with hot tomato sauce over pieces of pita bread and generously slathered with melted special sheep's milk butter and yogurt."),
    price = "187 cent",
    survival_price = "1 USD",
    materials = { "bread", "flesh" },
    volume = "450 ml",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "3 days",
        kind = "FOOD",
        calories = 250,
        fun = 4,
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "bread_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "manti",
    name = ccb.content.plural_text("manti", "manti"),
    mass = "160 g",
    color = "red",
    symbol = "%",
    description = ccb.content.text("Dumplings that typically consist of a spiced meat mixture, usually lamb or ground beef, wrapped in a thin dough sheet which is then boiled or steamed."),
    price = "125 cent",
    survival_price = "66 cent",
    materials = { "bread", "flesh" },
    volume = "300 ml",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "3 days",
        kind = "FOOD",
        calories = 250,
        fun = 4,
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "bread_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "sarma",
    name = ccb.content.plural_text("sarma", "sarma"),
    mass = "250 g",
    color = "green",
    symbol = "%",
    description = ccb.content.text("A traditional Turkish dish prepared by rolling rice and minced meat in grape leaves."),
    price = "187 cent",
    survival_price = "1 USD",
    materials = { "veggy", "flesh" },
    volume = "240 ml",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "3 days",
        kind = "FOOD",
        calories = 373,
        fun = 4,
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "chicken_fried",
    name = ccb.content.plural_text("fried chicken", "fried chicken"),
    mass = "181 g",
    volume = "250 ml",
    price = "3 USD",
    default_container = "box_small",
    symbol = "%",
    description = ccb.content.text("A delicious golden-brown serving of crispy fried chicken."),
    stackable = true,
    comestible = {
        shelf_life = "4 days",
        kind = "FOOD",
        calories = 440,
        fun = 14,
        vitamins = { { id = "calcium", amount = "24 mg" }, { id = "iron", amount = "2 mg" } },
    },
}

ccb.content.define_item {
    id = "chicken_fried_buttermilk",
    name = ccb.content.plural_text("buttermilk fried chicken", "buttermilk fried chicken"),
    mass = "181 g",
    volume = "250 ml",
    price = "4 USD",
    default_container = "box_small",
    symbol = "%",
    description = ccb.content.text("Brined in buttermilk, seasoned and breaded to perfection, and fried until crispy and golden.  This fried chicken is so good you can almost forget about the end of the world.  Vinegar leg is on the right!"),
    stackable = true,
    comestible = {
        shelf_life = "4 days",
        kind = "FOOD",
        calories = 500,
        fun = 25,
        vitamins = { { id = "calcium", amount = "24 mg" }, { id = "iron", amount = "2 mg" } },
    },
}

ccb.content.define_item {
    id = "chicken_tandoori",
    name = ccb.content.text("tandoori chicken"),
    mass = "200 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Originating from Punjabi cuisine, this deep-red and spicy baked chicken is marinated with a yogurt-based sauce and is traditionally baked directly on the walls of a wood-fired clay oven."),
    price = "10 USD",
    survival_price = "3 USD 40 cent",
    materials = { { id = "flesh", portions = 10 }, { id = "milk", portions = 1 } },
    volume = "250 ml",
    flags = { "EATEN_HOT", "ALLERGEN_MILK" },
    stackable = true,
    comestible = {
        shelf_life = "4 days",
        kind = "FOOD",
        calories = 400,
        fun = 18,
        vitamins = {
            { id = "calcium", amount = "105 mg" },
            { id = "iron", amount = "1 mg" },
            { id = "meat_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "chicken_rice_hianese",
    name = ccb.content.plural_text("Hinanese chicken rice", "Hinanese chicken rice"),
    mass = "195 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("This delicious serving of poached chicken with rice is one of the national dishes of Singapore."),
    display_type = "BY_WEIGHT",
    price = "10 USD",
    survival_price = "2 USD 50 cent",
    materials = { "flesh", "veggy" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        calories = 403,
        fun = 18,
        vitamins = {
            { id = "calcium", amount = "108 mg" },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "chicken_parm",
    name = ccb.content.plural_text("chicken parmesan", "chicken parmesan"),
    mass = "250 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("A classic Italian-American dish of breaded and fried chicken atop a bed of pasta, enrobed with tomato sauce and cheese."),
    price = "10 USD",
    survival_price = "2 USD 50 cent",
    materials = { "flesh", "wheat", "veggy" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        calories = 620,
        fun = 18,
        vitamins = {
            { id = "calcium", amount = "423 mg" },
            { id = "iron", amount = "8 mg" },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "scrapple",
    name = ccb.content.plural_text("scrapple", "scrapple"),
    symbol = "%",
    looks_like = "offal_cooked",
    description = ccb.content.text("A dry mush of meat scraps and grain, sliced and pan-fried; better than it sounds and looks.  A staple food of the Mid-Atlantic United States."),
    survival_price = "40 cent",
    materials = { { id = "flesh", portions = 10 }, { id = "wheat", portions = 1 } },
    color = "brown",
    mass = "58 g",
    volume = "56 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        shelf_life = "5 days",
        calories = 127,
        fun = 1,
        quench = -8,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 8 },
            { id = "meat_allergen", amount = 1 },
            { id = "wheat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "meat_dolmas",
    name = ccb.content.plural_text("dolmas", "dolmas"),
    symbol = "%",
    looks_like = "homemade_burrito",
    description = ccb.content.text("Grape leaves stuffed with rice, meat, vegetables, and spices.  A popular dish in Mediterranean and Middle Eastern cuisines."),
    survival_price = "40 cent",
    materials = { { id = "flesh", portions = 10 }, { id = "veggy", portions = 1 } },
    color = "green",
    mass = "110 g",
    volume = "104 ml",
    flags = { "FREEZERBURN" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        shelf_life = "3 days",
        calories = 220,
        fun = 5,
        quench = -2,
        vitamins = {
            { id = "vitC", amount = 8 },
            { id = "iron", amount = 12 },
            { id = "veggy_allergen", amount = 1 },
            { id = "calcium", amount = 4 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}
