local ccb = require("ccb")

ccb.content.define_item {
    id = "paint_red",
    category = "other",
    price = "1 USD 20 cent",
    survival_price = "0 cent",
    name = ccb.content.plural_text("red paint", "red paint"),
    description = ccb.content.text("Some red paint."),
    symbol = "o",
    color = "red",
    materials = { "paint" },
    volume = "3750 ml",
    mass = "325 g",
    phase = "liquid",
    conditional_names = { { kind = "FLAG", key = "DIRTY", name = ccb.content.text("paint spill") } },
    comestible = { kind = "INVALID", freezing_point = -4, servings = 15 },
}

ccb.content.define_item {
    id = "paint_blue",
    name = ccb.content.plural_text("blue paint", "blue paint"),
    description = ccb.content.text("Some blue paint."),
    copy_from = "paint_red",
    color = "blue",
    comestible = {},
}

ccb.content.define_item {
    id = "paint_white",
    name = ccb.content.plural_text("white paint", "white paint"),
    description = ccb.content.text("Some white paint."),
    copy_from = "paint_red",
    color = "white",
    comestible = {},
}

ccb.content.define_item {
    id = "paint_green",
    name = ccb.content.plural_text("green paint", "green paint"),
    description = ccb.content.text("Some green paint."),
    copy_from = "paint_red",
    color = "green",
    comestible = {},
}

ccb.content.define_item {
    id = "paint_purple",
    name = ccb.content.plural_text("purple paint", "purple paint"),
    description = ccb.content.text("Some purple paint."),
    copy_from = "paint_red",
    color = "magenta",
    comestible = {},
}

ccb.content.define_item {
    id = "paint_yellow",
    name = ccb.content.plural_text("yellow paint", "yellow paint"),
    description = ccb.content.text("Some yellow paint."),
    copy_from = "paint_red",
    color = "yellow",
    comestible = {},
}

ccb.content.define_item {
    id = "paint_black",
    name = ccb.content.plural_text("black paint", "black paint"),
    description = ccb.content.text("Some black paint."),
    copy_from = "paint_red",
    color = "dark_gray",
    comestible = {},
}

ccb.content.define_item {
    id = "paint_orange",
    name = ccb.content.plural_text("orange paint", "orange paint"),
    description = ccb.content.text("Some orange paint."),
    copy_from = "paint_red",
    color = "light_red",
    comestible = {},
}

ccb.content.define_item {
    id = "paint_pink",
    name = ccb.content.plural_text("pink paint", "pink paint"),
    description = ccb.content.text("Some pink paint."),
    copy_from = "paint_red",
    color = "pink",
    comestible = {},
}

ccb.content.define_item {
    id = "paint_gray",
    name = ccb.content.plural_text("gray paint", "gray paint"),
    description = ccb.content.text("Some gray paint."),
    copy_from = "paint_red",
    color = "light_gray",
    comestible = {},
}

ccb.content.define_item {
    id = "paint_brown",
    name = ccb.content.plural_text("brown paint", "brown paint"),
    description = ccb.content.text("Some brown paint."),
    copy_from = "paint_red",
    color = "brown",
    comestible = {},
}

ccb.content.define_item {
    id = "paint_cyan",
    name = ccb.content.plural_text("cyan paint", "cyan paint"),
    description = ccb.content.text("Some cyan paint."),
    copy_from = "paint_red",
    color = "cyan",
    comestible = {},
}
