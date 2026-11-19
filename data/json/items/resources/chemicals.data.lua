local ccb = require("ccb")

ccb.content.define_item {
    id = "mercury",
    category = "chems",
    price = "30 cent",
    survival_price = "10 cent",
    name = ccb.content.plural_text("mercury", "mercury"),
    symbol = "~",
    color = "light_gray",
    description = ccb.content.text("Elemental mercury, unique in that it is a liquid under normal temperatures and pressures.  Known for its use in thermometers."),
    materials = { "mercury" },
    volume = "250 ml",
    mass = "13534 mg",
    phase = "liquid",
    default_container = "flask_glass",
    comestible = { kind = "INVALID", freezing_point = -39, servings = 250 },
}

ccb.content.define_item {
    id = "chem_sodium",
    category = "chems",
    price = "30 cent",
    survival_price = "10 cent",
    name = ccb.content.plural_text("sodium", "sodium"),
    symbol = "~",
    color = "light_gray",
    description = ccb.content.text("A chunk of sodium, a highly reactive soft gray metal, immersed in anhydrous mineral oil to prevent it from oxidizing in the air during storage."),
    materials = { "powder", "oil" },
    volume = "250 ml",
    mass = "968 mg",
    phase = "liquid",
    default_container = "flask_glass",
    comestible = { kind = "INVALID", freezing_point = -50, servings = 250 },
}

ccb.content.define_item {
    id = "chem_potassium",
    category = "chems",
    price = "30 cent",
    survival_price = "10 cent",
    name = ccb.content.plural_text("potassium", "potassium"),
    symbol = "~",
    color = "light_gray",
    description = ccb.content.text("A chunk of potassium, a highly reactive soft gray metal, immersed in anhydrous mineral oil to prevent it from oxidizing in the air during storage."),
    materials = { "powder", "oil" },
    volume = "250 ml",
    mass = "860 mg",
    phase = "liquid",
    default_container = "flask_glass",
    comestible = { kind = "INVALID", freezing_point = -50, servings = 250 },
}

ccb.content.define_item {
    id = "abstract_hair_dye",
    category = "other",
    price = "20 USD",
    survival_price = "50 cent",
    name = ccb.content.plural_text("hair dye", "hair dye"),
    description = ccb.content.text("Some hair dye."),
    symbol = "o",
    color = "red",
    materials = { "paint" },
    volume = "250 ml",
    mass = "250 g",
    phase = "liquid",
    default_container = "bottle_plastic",
    comestible = { kind = "INVALID", freezing_point = -4, servings = 1 },
}

ccb.content.define_item {
    id = "hair_dye_black",
    name = ccb.content.plural_text("black hair dye", "black hair dye"),
    description = ccb.content.text("Some black hair dye."),
    copy_from = "abstract_hair_dye",
    color = "dark_gray",
    comestible = {},
}

ccb.content.define_item {
    id = "hair_dye_blond",
    name = ccb.content.plural_text("blond hair dye", "blond hair dye"),
    description = ccb.content.text("Some blond hair dye."),
    copy_from = "abstract_hair_dye",
    color = "yellow",
    comestible = {},
}

ccb.content.define_item {
    id = "hair_dye_blue",
    name = ccb.content.plural_text("blue hair dye", "blue hair dye"),
    description = ccb.content.text("Some blue hair dye."),
    copy_from = "abstract_hair_dye",
    color = "blue",
    comestible = {},
}

ccb.content.define_item {
    id = "hair_dye_brown",
    name = ccb.content.plural_text("brown hair dye", "brown hair dye"),
    description = ccb.content.text("Some brown hair dye."),
    copy_from = "abstract_hair_dye",
    color = "brown",
    comestible = {},
}

ccb.content.define_item {
    id = "hair_dye_gray",
    name = ccb.content.plural_text("gray hair dye", "gray hair dye"),
    description = ccb.content.text("Some gray hair dye."),
    copy_from = "abstract_hair_dye",
    color = "dark_gray",
    comestible = {},
}

ccb.content.define_item {
    id = "hair_dye_green",
    name = ccb.content.plural_text("green hair dye", "green hair dye"),
    description = ccb.content.text("Some green hair dye."),
    copy_from = "abstract_hair_dye",
    color = "green",
    comestible = {},
}

ccb.content.define_item {
    id = "hair_dye_red",
    name = ccb.content.plural_text("red hair dye", "red hair dye"),
    description = ccb.content.text("Some red hair dye."),
    copy_from = "abstract_hair_dye",
    comestible = {},
}

ccb.content.define_item {
    id = "hair_dye_pink",
    name = ccb.content.plural_text("pink hair dye", "pink hair dye"),
    description = ccb.content.text("Some pink hair dye."),
    copy_from = "abstract_hair_dye",
    color = "pink",
    comestible = {},
}

ccb.content.define_item {
    id = "hair_dye_white",
    name = ccb.content.plural_text("white hair dye", "white hair dye"),
    description = ccb.content.text("Some white hair dye."),
    copy_from = "abstract_hair_dye",
    color = "white",
    comestible = {},
}
