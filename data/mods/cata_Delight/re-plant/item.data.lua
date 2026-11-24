local ccb = require("ccb")

ccb.content.define_item {
    id = "tsow_shrub_base",
    abstract = true,
    name = ccb.content.plural_text("Replantable Shrub", "Replantable Shrubs"),
    description = ccb.content.text("A shrub clump dug out from the ground, ready to be replanted."),
    mass = "500 g",
    volume = "1000 ml",
    materials = { "wood" },
    symbol = "#",
    category = "other",
}

ccb.content.define_item {
    id = "tsow_underbrush",
    copy_from = "tsow_shrub_base",
    name = ccb.content.plural_text("Shrub", "Shrubs"),
    color = "green",
}

ccb.content.define_item {
    id = "tsow_shrub_huckleberry",
    copy_from = "tsow_shrub_base",
    name = ccb.content.plural_text("Huckleberry Shrub", "Huckleberry Shrubs"),
    color = "light_blue_green",
}

ccb.content.define_item {
    id = "tsow_shrub_hobblebush",
    copy_from = "tsow_shrub_base",
    name = ccb.content.plural_text("Hobblebush Shrub", "Hobblebush Shrubs"),
    color = "light_blue_green",
}

ccb.content.define_item {
    id = "tsow_shrub_grape",
    copy_from = "tsow_shrub_base",
    name = ccb.content.plural_text("Grape Shrub", "Grape Shrubs"),
    color = "light_green_green",
}

ccb.content.define_item {
    id = "tsow_shrub_blueberry",
    copy_from = "tsow_shrub_base",
    name = ccb.content.plural_text("Blueberry Shrub", "Blueberry Shrubs"),
    color = "light_blue_green",
}

ccb.content.define_item {
    id = "tsow_shrub_raspberry",
    copy_from = "tsow_shrub_base",
    name = ccb.content.plural_text("Raspberry Shrub", "Raspberry Shrubs"),
    color = "light_red_green",
}

ccb.content.define_item {
    id = "tsow_shrub_strawberry",
    copy_from = "tsow_shrub_base",
    name = ccb.content.plural_text("Strawberry Shrub", "Strawberry Shrubs"),
    color = "light_red_green",
}

ccb.content.define_item {
    id = "tsow_shrub_peanut",
    copy_from = "tsow_shrub_base",
    name = ccb.content.plural_text("Peanut Shrub", "Peanut Shrubs"),
    color = "brown_green",
}

ccb.content.define_item {
    id = "tsow_shrub_autumn_olive",
    copy_from = "tsow_shrub_base",
    name = ccb.content.plural_text("Autumn Olive Shrub", "Autumn Olive Shrubs"),
    color = "light_blue_green",
}

ccb.content.define_item {
    id = "tsow_shrub_blackberry",
    copy_from = "tsow_shrub_base",
    name = ccb.content.plural_text("Blackberry Shrub", "Blackberry Shrubs"),
    color = "black_green",
}

ccb.content.define_item {
    id = "tsow_shrub_spicebush",
    copy_from = "tsow_shrub_base",
    name = ccb.content.plural_text("Spicebush Shrub", "Spicebush Shrubs"),
    color = "light_green_green",
}

ccb.content.define_item {
    id = "tsow_shrub_chokeberry",
    copy_from = "tsow_shrub_base",
    name = ccb.content.plural_text("Chokeberry Shrub", "Chokeberry Shrubs"),
    color = "light_green_green",
}

ccb.content.define_item {
    id = "tsow_shrub_rose",
    copy_from = "tsow_shrub_base",
    name = ccb.content.plural_text("Rose Shrub", "Rose Shrubs"),
    color = "light_red_green",
}

ccb.content.define_item {
    id = "tsow_shrub_hydrangea",
    copy_from = "tsow_shrub_base",
    name = ccb.content.plural_text("Hydrangea Shrub", "Hydrangea Shrubs"),
    color = "light_blue",
}

ccb.content.define_item {
    id = "tsow_shrub_lilac",
    copy_from = "tsow_shrub_base",
    name = ccb.content.plural_text("Lilac Shrub", "Lilac Shrubs"),
    color = "magenta",
}

ccb.content.define_item {
    id = "tsow_grass_stalk_with_seed",
    name = ccb.content.plural_text("Seeded Grass Stalk", "Seeded Grass Stalks"),
    description = ccb.content.text("A grass stalk bearing grain heads, heavier than ordinary hay and suitable for drying and threshing, or as cattle feed and tinder."),
    mass = "100 g",
    volume = "500 ml",
    materials = { "veggy", "dry_plant" },
    symbol = "/",
    color = "yellow",
    flags = { "TRADER_AVOID", "INEDIBLE", "CATTLE", "TINDER", "RABBIT" },
}

ccb.content.define_item {
    id = "tsow_compost_bin_empty",
    category = "container",
    name = ccb.content.plural_text("Empty Compost Bin", "Empty Compost Bins"),
    description = ccb.content.text("A simple wooden box nailed together from boards, about ten liters in volume, used to hold humus for composting."),
    mass = "2000 g",
    volume = "12000 ml",
    length = "30 cm",
    price = "1 USD",
    survival_price = "50 cent",
    materials = { "wood" },
    symbol = ")",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            rigid = true,
            open_container = true,
            capacity = "10 L",
            mass_limit = "50 kg",
        },
    },
    qualities = { { id = "CONTAIN", level = 1 } },
    flags = { "TRADER_AVOID" },
}

ccb.content.define_item {
    id = "tsow_humus",
    category = "spare_parts",
    name = ccb.content.plural_text("Humus", "Humuss"),
    description = ccb.content.text("A rich organic humus made by mixing earthworms, soil, and straw piles, ideal for making fertile soil."),
    mass = "250 g",
    volume = "250 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "soil", "veggy" },
    symbol = "*",
    color = "brown",
    stackable = true,
    flags = { "TRADER_AVOID", "INEDIBLE" },
}

ccb.content.define_item {
    id = "tsow_compost_bin_fermenting",
    category = "other",
    name = ccb.content.plural_text("Compost Bin Fermenting", "Compost Bin Fermentings"),
    description = ccb.content.text("A compost bin filled with humus while its organic matter ferments inside.  In about seven days, the humus will become fertile soil, and the bin can be reused."),
    mass = "7000 g",
    volume = "12000 ml",
    length = "30 cm",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "wood", "soil" },
    symbol = ")",
    color = "yellow_green",
    flags = { "SPAWN_ACTIVE", "TRADER_AVOID" },
    countdown_interval = "7 days",
    transform_into = { target = "tsow_fertile_soil", container = "tsow_compost_bin_empty", target_charges = 20 },
}

ccb.content.define_item {
    id = "tsow_fertile_soil",
    category = "spare_parts",
    name = ccb.content.plural_text("Fertile Soil", "Fertile Soils"),
    description = ccb.content.text("Fully fermented fertile soil rich in humus, perfect for growing crops."),
    mass = "250 g",
    volume = "250 ml",
    price = "0 cent",
    survival_price = "5 cent",
    materials = { "soil", "veggy" },
    symbol = "*",
    color = "brown",
    stackable = true,
    flags = { "TRADER_AVOID", "INEDIBLE" },
}
