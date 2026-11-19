local ccb = require("ccb")

ccb.content.define_item {
    id = "meal_bone_tainted",
    name = ccb.content.plural_text("tainted bone meal", "tainted bone meal"),
    copy_from = "meal_bone",
    description = ccb.content.text("This is a grayish bone meal made from rotten bones."),
    price = "0 cent",
    survival_price = "1 cent",
    comestible = {},
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "skewer_bone",
    symbol = ",",
    color = "white",
    name = ccb.content.plural_text("bone skewer", "bone skewers"),
    description = ccb.content.text("A thin skewer carved from bone.  Sadly, it won't make squirrel on a stick taste better."),
    category = "other",
    materials = { "bone" },
    flags = { "TRADER_AVOID", "PUNCTURE_VEHICLE_WHEELS" },
    mass = "10 g",
    volume = "25 ml",
    qualities = { { id = "COOK", level = 1 } },
    stackable = true,
    milling = { result = "meal_bone_tainted", recipe = "meal_bone_tainted_mill_6_1" },
    use_actions = { "HEAT_SOLID_ITEMS" },
}

-- NO_I18N
-- NO_I18N
-- Skulls roughly the size of an adult human's, though not necessarily human or human-like.
-- 59 calories per 100g. 600mg of bioavailable calcium per 100g, on average.
ccb.content.define_item {
    id = "skull_abstract",
    abstract = true,
    name = ccb.content.text_without_extraction("abstract skull"),
    description = ccb.content.text_without_extraction("This is a dummy item.  If you see it something went wrong."),
    flags = { "TRADER_AVOID", "PUNCTURE_VEHICLE_WHEELS", "RAW", "INEDIBLE", "NO_TEMP", "LUPINE" },
    category = "other",
    mass = "1 kg",
    volume = "1400 ml",
    symbol = "@",
    color = "white",
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "bone" },
    subtype_order = { "milling", "comestible" },
    milling = { result = "meal_bone", recipe = "meal_bone_mill_1_4" },
    comestible = {
        kind = "FOOD",
        vitamins = { { id = "calcium", amount = "6000 mg" }, { id = "meat_allergen", amount = 1 } },
        calories = 590,
    },
}

-- NO_I18N
-- NO_I18N
-- Animal skulls larger than a rodent but smaller than a standard dog. Tiny skulls are very unlikely to puncture vehicle tires and usually use the mill_2_1 ratio.
-- 59 calories per 100g. 600mg of bioavailable calcium per 100g, on average.
ccb.content.define_item {
    id = "skull_tiny_abstract",
    abstract = true,
    name = ccb.content.text_without_extraction("abstract tiny skull"),
    description = ccb.content.text_without_extraction("This is a dummy item.  If you see it something went wrong."),
    copy_from = "skull_abstract",
    mass = "50 g",
    volume = "385 ml",
    length = "10 cm",
    survival_price = "0 cent",
    inheritance = { remove = { flags = { "PUNCTURE_VEHICLE_WHEELS" } } },
    subtype_order = { "milling", "comestible" },
    milling = { result = "meal_bone", recipe = "meal_bone_mill_2_1" },
    comestible = {
        vitamins = { { id = "calcium", amount = "300 mg" }, { id = "meat_allergen", amount = 1 } },
        calories = 29,
    },
}

-- NO_I18N
-- NO_I18N
-- Animal skulls approximately the size of a cat or small breed dog. Tiny skulls are unlikely to puncture vehicle tires and usually use the mill_1_1 ratio.
-- 59 calories per 100g. 600mg of bioavailable calcium per 100g, on average.
ccb.content.define_item {
    id = "skull_small_abstract",
    abstract = true,
    name = ccb.content.text_without_extraction("abstract small skull"),
    description = ccb.content.text_without_extraction("This is a dummy item.  If you see it something went wrong."),
    copy_from = "skull_abstract",
    mass = "100 g",
    volume = "475 ml",
    length = "15 cm",
    survival_price = "1 cent",
    inheritance = { remove = { flags = { "PUNCTURE_VEHICLE_WHEELS" } } },
    subtype_order = { "milling", "comestible" },
    milling = { result = "meal_bone", recipe = "meal_bone_mill_1_1" },
    comestible = {
        vitamins = { { id = "calcium", amount = "600 mg" }, { id = "meat_allergen", amount = 1 } },
        calories = 59,
    },
}

-- NO_I18N
-- NO_I18N
-- Animal skulls approximately the size of a dog. Medium skulls are capable of puncturing vehicle tires and usually use the mill_1_4 ratio.
-- 59 calories per 100g. 600mg of bioavailable calcium per 100g, on average.
ccb.content.define_item {
    id = "skull_medium_abstract",
    abstract = true,
    name = ccb.content.text_without_extraction("abstract medium skull"),
    description = ccb.content.text_without_extraction("This is a dummy item.  If you see it something went wrong."),
    copy_from = "skull_abstract",
    mass = "500 g",
    volume = "4000 ml",
    length = "29 cm",
    survival_price = "5 cent",
    subtype_order = { "milling", "comestible" },
    milling = { result = "meal_bone", recipe = "meal_bone_mill_1_4" },
    comestible = {
        vitamins = { { id = "calcium", amount = "3000 mg" }, { id = "meat_allergen", amount = 1 } },
        calories = 295,
    },
}

-- NO_I18N
-- NO_I18N
-- Animal skulls approximately the size of livestock. Large skulls can easily damage vehicles and can not be milled or eaten without being broken down first.
-- 59 calories per 100g. 600mg of bioavailable calcium per 100g, on average.
ccb.content.define_item {
    id = "skull_large_abstract",
    abstract = true,
    name = ccb.content.text_without_extraction("abstract large skull"),
    description = ccb.content.text_without_extraction("This is a dummy item.  If you see it something went wrong."),
    copy_from = "skull_abstract",
    mass = "10 kg",
    volume = "58500 ml",
    length = "35 cm",
    survival_price = "1 USD",
    inheritance = { remove = { flags = { "LUPINE" } } },
    subtype_order = { "milling", "comestible" },
    milling = { result = "null", recipe = "" },
    comestible = {
        vitamins = { { id = "calcium", amount = "60 g" }, { id = "meat_allergen", amount = 1 } },
        calories = 5900,
    },
}

-- Values set to match human bone, adjusted for weight.
ccb.content.define_item {
    id = "skull_human",
    name = ccb.content.plural_text("human skull", "human skulls"),
    description = ccb.content.text("The skull of a human being.  Carrying this around probably isn't going to win you any friends."),
    copy_from = "skull_abstract",
    subtype_order = { "milling", "comestible" },
    milling = { result = "meal_bone", recipe = "meal_bone_mill_1_4" },
    comestible = {
        kind = "FOOD",
        vitamins = {
            { id = "calcium", amount = "88234 mg" },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}
