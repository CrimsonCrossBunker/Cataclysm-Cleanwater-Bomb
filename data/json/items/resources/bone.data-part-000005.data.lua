local ccb = require("ccb")

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
