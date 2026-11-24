local ccb = require("ccb")

-- 撤销 PR #86581 — 恢复僵尸尸体的实用性
-- Values based roughly on a male human femur.
ccb.content.define_item {
    id = "bone",
    name = ccb.content.plural_text("bone", "bones"),
    description = ccb.content.text("A bone from some creature or other.  Could be used in cooking and crafting."),
    mass = "290 g",
    volume = "320 ml",
    length = "44 cm",
    symbol = "%",
    color = "white",
    materials = { "bone" },
    category = "spare_parts",
    price = "0 cent",
    survival_price = "10 cent",
    melee_damage = { bash = 3 },
    accuracy = { grip = "none", length = "short", surface = "any", balance = "uneven" },
    flags = { "RAW", "INEDIBLE", "LUPINE", "NO_TEMP", "PUNCTURE_VEHICLE_WHEELS" },
    stackable = true,
    subtype_order = { "milling", "comestible" },
    milling = { result = "meal_bone", recipe = "meal_bone_mill_1_4" },
    comestible = {
        kind = "FOOD",
        calories = 171,
        vitamins = { { id = "calcium", amount = "25588 mg" }, { id = "meat_allergen", amount = 1 } },
    },
}

-- Values based roughly on an adult female African elephant femur. 61 times the size of the normal bone.
-- While it would make sense to be able to mill it, the bone won't fit into a mill…
ccb.content.define_item {
    id = "large_bone",
    name = ccb.content.text("large bone"),
    description = ccb.content.text("A huge bone of a large creature."),
    mass = "17700 g",
    volume = "19550 ml",
    length = "110 cm",
    symbol = "I",
    color = "white",
    materials = { "bone" },
    price = "0 cent",
    survival_price = "20 cent",
    accuracy = { grip = "bad", length = "long", surface = "any", balance = "clumsy" },
    melee_damage = { bash = 15 },
    flags = { "RAW", "INEDIBLE", "NO_TEMP", "PUNCTURE_VEHICLE_WHEELS" },
    comestible = {
        kind = "FOOD",
        calories = 10436,
        vitamins = { { id = "calcium", amount = "1561750 mg" }, { id = "meat_allergen", amount = 1 } },
    },
}

-- Not for use in edible recipes, and should require ~200% as much as normal for applicable inedible recipes.
ccb.content.define_item {
    id = "bone_tainted",
    name = ccb.content.plural_text("tainted bone", "tainted bones"),
    description = ccb.content.text("A rotten, brittle bone from some unnatural creature or other.  Could be used to make some stuff, like charcoal or glue.  You could eat it, but it will poison you."),
    copy_from = "bone",
    color = "light_gray",
    survival_price = "5 cent",
    subtype_order = { "milling", "comestible" },
    milling = { result = "meal_bone_tainted", recipe = "meal_bone_tainted_mill_1_4" },
    comestible = { fun = -10 },
    use_actions = { "POISON" },
}

-- No extend support for vitamins, we need to overwrite
ccb.content.define_item {
    id = "bone_human",
    copy_from = "bone",
    name = ccb.content.plural_text("human bone", "human bones"),
    description = ccb.content.text("A bone from a human being.  Could be used to make some stuff, if you're feeling sufficiently ghoulish."),
    subtype_order = { "milling", "comestible" },
    milling = { result = "meal_bone", recipe = "meal_bone_mill_1_4" },
    comestible = {
        vitamins = {
            { id = "calcium", amount = "25588 mg" },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "bone_demihuman",
    copy_from = "bone",
    name = ccb.content.plural_text("demihuman bone", "demihuman bones"),
    description = ccb.content.text("A bone from a demihuman being.  Could be used to make some stuff, if you're feeling sufficiently ghoulish."),
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = {},
}

ccb.content.define_item {
    id = "meal_bone",
    name = ccb.content.plural_text("bone meal", "bone meal"),
    mass = "60 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("This bone meal can be used to craft fertilizer and some other things."),
    price = "6 cent",
    survival_price = "2 cent",
    materials = { "powder" },
    volume = "125 ml",
    flags = { "NO_TEMP" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        calories = 35,
        vitamins = { { id = "calcium", amount = "5294 mg" }, { id = "meat_allergen", amount = 1 } },
        fun = -10,
    },
}

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

ccb.content.define_item {
    id = "skull_canis_small",
    name = ccb.content.plural_text("tiny canine skull", "tiny canine skulls"),
    description = ccb.content.text("The skull of a tiny canine, likely a Chihuahua or another similarly sized dog breed."),
    copy_from = "skull_tiny_abstract",
    mass = "35 g",
    volume = "270 ml",
    length = "7 cm",
    inheritance = { scale = { calories = 0.7 } },
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = { vitamins = { { id = "calcium", amount = "210 mg" }, { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "skull_canis_medium",
    name = ccb.content.plural_text("small canine skull", "small canine skulls"),
    description = ccb.content.text("The skull of a small canine, likely a small dog breed."),
    copy_from = "skull_small_abstract",
    mass = "65 g",
    volume = "500 ml",
    length = "12 cm",
    inheritance = { scale = { calories = 0.65 } },
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = { vitamins = { { id = "calcium", amount = "390 mg" }, { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "skull_canis",
    name = ccb.content.plural_text("large canine skull", "large canine skulls"),
    description = ccb.content.text("The skull of a wolf or a dog.  Essential material for building an articulated wolf skeleton."),
    copy_from = "skull_medium_abstract",
    mass = "500 g",
    volume = "4 L",
    length = "29 cm",
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = {},
}

ccb.content.define_item {
    id = "skull_canis_triclopean",
    name = ccb.content.plural_text("triclopean canine skull", "triclopean canine skulls"),
    description = ccb.content.text("The skull of a what looks like a dog, although it has an extra eye socket."),
    copy_from = "skull_canis",
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = {},
}

ccb.content.define_item {
    id = "skull_feline_small",
    name = ccb.content.plural_text("small feline skull", "small feline skulls"),
    description = ccb.content.text("The skull of a small feline, likely a house cat."),
    copy_from = "skull_tiny_abstract",
    mass = "40 g",
    volume = "300 ml",
    length = "10 cm",
    inheritance = { scale = { calories = 0.8 } },
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = { vitamins = { { id = "calcium", amount = "240 mg" }, { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "skull_feline_medium",
    name = ccb.content.plural_text("medium feline skull", "medium feline skulls"),
    description = ccb.content.text("The skull of a medium-sized feline, likely a bobcat."),
    copy_from = "skull_small_abstract",
    mass = "65 g",
    volume = "500 ml",
    length = "13 cm",
    inheritance = { scale = { calories = 0.65 } },
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = { vitamins = { { id = "calcium", amount = "390 mg" }, { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "skull_cougar",
    name = ccb.content.plural_text("cougar skull", "cougar skulls"),
    description = ccb.content.text("The skull of a cougar."),
    copy_from = "skull_medium_abstract",
    mass = "450 g",
    volume = "3 L",
    length = "21 cm",
    inheritance = { scale = { calories = 0.9 } },
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = { vitamins = { { id = "calcium", amount = "2700 mg" }, { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "skull_raccoon",
    name = ccb.content.plural_text("raccoon skull", "raccoon skulls"),
    description = ccb.content.text("The skull of a raccoon."),
    copy_from = "skull_small_abstract",
    mass = "75 g",
    volume = "575 ml",
    length = "12 cm",
    inheritance = { scale = { calories = 0.75 } },
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = { vitamins = { { id = "calcium", amount = "450 mg" }, { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "skull_bear",
    name = ccb.content.plural_text("bear skull", "bear skulls"),
    description = ccb.content.text("The skull of a bear."),
    copy_from = "skull_abstract",
    mass = "1500 g",
    volume = "10500 ml",
    length = "30 cm",
    inheritance = { scale = { calories = 1.5 } },
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = { vitamins = { { id = "calcium", amount = "9000 mg" }, { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "skull_opossum",
    name = ccb.content.plural_text("opossum skull", "opossum skulls"),
    description = ccb.content.text("The skull of an opossum."),
    copy_from = "skull_tiny_abstract",
    mass = "45 g",
    volume = "275 ml",
    length = "11 cm",
    inheritance = { scale = { calories = 0.9 } },
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = { vitamins = { { id = "calcium", amount = "270 mg" }, { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "skull_skunk",
    name = ccb.content.plural_text("skunk skull", "skunk skulls"),
    description = ccb.content.text("The skull of a skunk."),
    copy_from = "skull_small_abstract",
    mass = "56 g",
    volume = "300 ml",
    length = "8 cm",
    inheritance = { scale = { calories = 0.56 } },
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = { vitamins = { { id = "calcium", amount = "336 mg" }, { id = "meat_allergen", amount = 1 } } },
}

-- Rodents are super tiny, so this is a special case that gets its own milling recipe.
ccb.content.define_item {
    id = "skull_rodent",
    name = ccb.content.plural_text("rodent skull", "rodent skulls"),
    description = ccb.content.text("The skull of a small rodent, most likely a rat."),
    copy_from = "skull_tiny_abstract",
    mass = "3 g",
    volume = "20 ml",
    length = "5 cm",
    inheritance = { scale = { calories = 0.06 } },
    subtype_order = { "milling", "comestible" },
    milling = { result = "meal_bone", recipe = "meal_bone_mill_20_1" },
    comestible = { vitamins = { { id = "calcium", amount = "18 mg" }, { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "skull_rabbit",
    name = ccb.content.plural_text("rabbit skull", "rabbit skulls"),
    description = ccb.content.text("The skull of a rabbit or a hare."),
    copy_from = "skull_small_abstract",
    mass = "90 g",
    volume = "450 ml",
    length = "10 cm",
    inheritance = { scale = { calories = 0.9 } },
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = { vitamins = { { id = "calcium", amount = "540 mg" }, { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "skull_beaver",
    name = ccb.content.plural_text("beaver skull", "beaver skulls"),
    description = ccb.content.text("The skull of a beaver."),
    copy_from = "skull_medium_abstract",
    mass = "280 g",
    volume = "2 L",
    length = "16 cm",
    inheritance = { scale = { calories = 0.56 } },
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = { vitamins = { { id = "calcium", amount = "1680 mg" }, { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "skull_human_tainted",
    copy_from = "skull_human",
    name = "tainted human skull",
    description = "The stained skull of what was once a human being.  It is rotted and noticeably warped from its lively form.  Carrying this around probably isn't going to win you any friends.",
    color = "light_gray",
    survival_price = "0 cent",
    snippet_category = "skull_human_tainted_desc",
    materials = { "bone" },
    use_actions = { "POISON" },
    milling = { result = "meal_bone_tainted", recipe = "meal_bone_tainted_mill_1_4" },
    comestible = { fun = -10 },
    subtype_order = { "milling", "comestible" },
    inheritance = {
        remove = {
            vitamins = {
                { id = "human_flesh_vitamin", amount = 1 },
            },
        },
    },
}

ccb.content.define_item {
    id = "skull_pig",
    name = ccb.content.plural_text("pig skull", "pig skulls"),
    description = ccb.content.text("The skull of a pig, either a domestic or a wild one."),
    copy_from = "skull_abstract",
    mass = "650 g",
    volume = "6 L",
    length = "30 cm",
    inheritance = { scale = { calories = 0.65 } },
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = { vitamins = { { id = "calcium", amount = "3900 mg" }, { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "skull_sheep",
    name = ccb.content.plural_text("sheep skull", "sheep skulls"),
    description = ccb.content.text("The skull of a domestic sheep."),
    copy_from = "skull_medium_abstract",
    mass = "500 g",
    volume = "4 L",
    length = "25 cm",
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = {},
}

ccb.content.define_item {
    id = "skull_goat",
    name = ccb.content.plural_text("goat skull", "goat skulls"),
    description = ccb.content.text("The skull of a goat with the horns still attached."),
    copy_from = "skull_abstract",
    mass = "800 g",
    volume = "4500 ml",
    length = "25 cm",
    inheritance = { scale = { calories = 0.8 } },
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = { vitamins = { { id = "calcium", amount = "4800 mg" }, { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "skull_beaver_huge",
    copy_from = "skull_beaver",
    name = "dambreaker skull",
    description = "A skull of an abnormally large mutant beaver.",
    milling = { result = "meal_bone", recipe = "meal_bone_mill_1_4" },
    comestible = {
        vitamins = {
            { id = "calcium", amount = "4200 mg" },
            { id = "meat_allergen", amount = 1 },
        },
    },
    subtype_order = { "milling", "comestible" },
    inheritance = {
        scale = { mass = 2.5, volume = 2.5, length = 1.75, calories = 2.5 },
    },
}

ccb.content.define_item {
    id = "skull_bovine",
    name = ccb.content.text("cow skull"),
    description = ccb.content.text("The skull of a bovine, likely a domestic cow, with the horns still attached."),
    copy_from = "skull_large_abstract",
    mass = "10 kg",
    volume = "58500 ml",
    length = "35 cm",
    comestible = {},
}

ccb.content.define_item {
    id = "skull_equine",
    name = ccb.content.text("horse skull"),
    description = ccb.content.text("The skull of a horse.  Given the circumstances you can be pretty sure it was a domestic horse."),
    copy_from = "skull_large_abstract",
    mass = "10 kg",
    volume = "45 L",
    length = "55 cm",
    comestible = {},
}

ccb.content.define_item {
    id = "skull_cervine",
    name = ccb.content.plural_text("deer skull", "deer skulls"),
    description = ccb.content.text("The skull of a cervine, either a deer or a reindeer, with the antlers still attached."),
    copy_from = "skull_abstract",
    mass = "2500 g",
    volume = "2 L",
    length = "50 cm",
    inheritance = { scale = { calories = 2.5 } },
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = { vitamins = { { id = "calcium", amount = "15000 mg" }, { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "skull_cervine_spideer",
    name = ccb.content.plural_text("spideer skull", "spideer skulls"),
    description = ccb.content.text("The skull of a cervine, with the antlers still attached…  But why does it have eight eye sockets?"),
    copy_from = "skull_abstract",
    mass = "2250 g",
    volume = "2 L",
    length = "40 cm",
    inheritance = { scale = { calories = 2.25 } },
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = { vitamins = { { id = "calcium", amount = "13500 mg" }, { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "skull_moose",
    name = ccb.content.text("moose skull"),
    description = ccb.content.text("The skull of a moose, unmistakable thanks to the antler shape."),
    copy_from = "skull_large_abstract",
    mass = "12 kg",
    volume = "85 L",
    length = "65 cm",
    comestible = { vitamins = { { id = "calcium", amount = "72000 mg" }, { id = "meat_allergen", amount = 1 } } },
    inheritance = { scale = { calories = 1.2 } },
}

ccb.content.define_item {
    id = "skull_moose_tusked",
    name = ccb.content.text("tusked moose skull"),
    description = ccb.content.text("The skull of a moose, unmistakable thanks to the antler shape and… tusks?  Okay, maybe this did not belong to a normal moose after all."),
    copy_from = "skull_large_abstract",
    mass = "20 kg",
    volume = "125 L",
    length = "120 cm",
    comestible = {
        vitamins = { { id = "calcium", amount = "120000 mg" }, { id = "meat_allergen", amount = 1 } },
    },
    inheritance = { scale = { calories = 2 } },
}

ccb.content.define_item {
    id = "skull_llama",
    name = ccb.content.plural_text("llama skull", "llama skulls"),
    description = ccb.content.text("The skull of a llama."),
    copy_from = "skull_abstract",
    mass = "800 g",
    volume = "8850 ml",
    length = "30 cm",
    inheritance = { scale = { calories = 0.8 } },
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = { vitamins = { { id = "calcium", amount = "4800 mg" }, { id = "meat_allergen", amount = 1 } } },
}
