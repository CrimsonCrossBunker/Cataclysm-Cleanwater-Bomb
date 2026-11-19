local ccb = require("ccb")

ccb.content.define_item {
    id = "seed_hops_seedling",
    copy_from = "seed_hops",
    name = ccb.content.plural_text("Hops Seedling", "Hops Seedling"),
    description = ccb.content.text("A young hops seedling with a small root system.  It reaches harvest sooner than ordinary seeds when planted.  Must be planted on a trellis."),
    subtype_order = { "seed", "comestible" },
    seed = {
        required_terrain_flag = "CD_DELIGHT_TRELLIS",
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "18 days" },
            { stage = "GROWTH_SEEDLING", duration = "18 days" },
            { stage = "GROWTH_MATURE", duration = "18 days" },
            { stage = "GROWTH_HARVEST", duration = "18 days" },
            { stage = "GROWTH_OVERGROWN", duration = "36 minutes" },
        },
    },
    comestible = {},
}

ccb.content.define_item {
    id = "seed_grapes_seedling",
    copy_from = "seed_fruit",
    name = ccb.content.plural_text("葡萄苗", "葡萄苗"),
    description = ccb.content.text("一株已经长出少量根系的葡萄幼苗，种植后比普通种子更快进入采收期。必须种在种植架上。"),
    flags = { "PLANTABLE_SEED", "NUTRIENT_OVERRIDE", "INEDIBLE" },
    subtype_order = { "seed", "comestible" },
    seed = {
        plant_name = ccb.content.text("grape"),
        fruit = "grapes",
        drop_seeds = false,
        byproducts = { "grape_leaves", "withered" },
        required_terrain_flag = "CD_DELIGHT_TRELLIS",
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "14 days" },
            { stage = "GROWTH_SEEDLING", duration = "14 days" },
            { stage = "GROWTH_MATURE", duration = "14 days" },
            { stage = "GROWTH_HARVEST", duration = "13 days" },
            { stage = "GROWTH_OVERGROWN", duration = "36 minutes" },
        },
    },
    comestible = {},
}

ccb.content.define_item {
    id = "seed_beans_seedling",
    copy_from = "seed_beans",
    name = ccb.content.plural_text("Bean Seedling", "Bean Seedling"),
    description = ccb.content.text("A young bean seedling with a small root system.  It reaches harvest sooner than ordinary seeds when planted.  Must be planted on a trellis."),
    subtype_order = { "seed", "comestible" },
    seed = {
        required_terrain_flag = "CD_DELIGHT_TRELLIS",
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "14 days" },
            { stage = "GROWTH_SEEDLING", duration = "14 days" },
            { stage = "GROWTH_MATURE", duration = "14 days" },
            { stage = "GROWTH_HARVEST", duration = "13 days" },
            { stage = "GROWTH_OVERGROWN", duration = "36 minutes" },
        },
    },
    comestible = {},
}

ccb.content.define_item {
    id = "seed_pea_seedling",
    copy_from = "seed_pea",
    name = ccb.content.plural_text("Pea Seedling", "Pea Seedling"),
    description = ccb.content.text("A young pea seedling with a small root system.  It reaches harvest sooner than ordinary seeds when planted.  Must be planted on a trellis."),
    subtype_order = { "seed", "comestible" },
    seed = {
        required_terrain_flag = "CD_DELIGHT_TRELLIS",
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "12 days" },
            { stage = "GROWTH_SEEDLING", duration = "12 days" },
            { stage = "GROWTH_MATURE", duration = "12 days" },
            { stage = "GROWTH_HARVEST", duration = "12 days" },
            { stage = "GROWTH_OVERGROWN", duration = "6 hours" },
        },
    },
    comestible = {},
}

ccb.content.define_item {
    id = "seed_cucumber_seedling",
    copy_from = "seed_cucumber",
    name = ccb.content.plural_text("Cucumber Seedling", "Cucumber Seedling"),
    description = ccb.content.text("A young cucumber seedling with a small root system.  It reaches harvest sooner than ordinary seeds when planted.  Must be planted on a trellis."),
    subtype_order = { "seed", "comestible" },
    seed = {
        required_terrain_flag = "CD_DELIGHT_TRELLIS",
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "9 days" },
            { stage = "GROWTH_SEEDLING", duration = "9 days" },
            { stage = "GROWTH_MATURE", duration = "9 days" },
            { stage = "GROWTH_HARVEST", duration = "9 days" },
            { stage = "GROWTH_OVERGROWN", duration = "36 minutes" },
        },
    },
    comestible = {},
}

ccb.content.define_item {
    id = "seed_gherkin_seedling",
    copy_from = "seed_gherkin",
    name = ccb.content.plural_text("Pickling Cucumber Seedling", "Pickling Cucumber Seedling"),
    description = ccb.content.text("A young pickling cucumber seedling with a small root system.  It reaches harvest sooner than ordinary seeds when planted.  Must be planted on a trellis."),
    subtype_order = { "seed", "comestible" },
    seed = {
        required_terrain_flag = "CD_DELIGHT_TRELLIS",
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "9 days" },
            { stage = "GROWTH_SEEDLING", duration = "9 days" },
            { stage = "GROWTH_MATURE", duration = "9 days" },
            { stage = "GROWTH_HARVEST", duration = "9 days" },
            { stage = "GROWTH_OVERGROWN", duration = "36 minutes" },
        },
    },
    comestible = {},
}

ccb.content.define_item {
    id = "seed_bottle_gourd_seedling",
    copy_from = "seed_bottle_gourd",
    name = ccb.content.plural_text("Bottle Gourd Seedling", "Bottle Gourd Seedling"),
    description = ccb.content.text("A young bottle gourd seedling with a small root system.  It reaches harvest sooner than ordinary seeds when planted.  Must be planted on a trellis."),
    subtype_order = { "seed", "comestible" },
    seed = {
        required_terrain_flag = "CD_DELIGHT_TRELLIS",
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "9 days" },
            { stage = "GROWTH_SEEDLING", duration = "9 days" },
            { stage = "GROWTH_MATURE", duration = "9 days" },
            { stage = "GROWTH_HARVEST", duration = "9 days" },
            { stage = "GROWTH_OVERGROWN", duration = "36 minutes" },
        },
    },
    comestible = {},
}

ccb.content.define_item {
    id = "seed_tomato_seedling",
    copy_from = "seed_tomato",
    name = ccb.content.plural_text("Tomato Seedling", "Tomato Seedling"),
    description = ccb.content.text("A young tomato seedling with a small root system.  It reaches harvest sooner than ordinary seeds when planted.  Must be planted on a trellis."),
    subtype_order = { "seed", "comestible" },
    seed = {
        required_terrain_flag = "CD_DELIGHT_TRELLIS",
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "10 days" },
            { stage = "GROWTH_SEEDLING", duration = "10 days" },
            { stage = "GROWTH_MATURE", duration = "10 days" },
            { stage = "GROWTH_HARVEST", duration = "9 days" },
            { stage = "GROWTH_OVERGROWN", duration = "36 minutes" },
        },
    },
    comestible = {},
}

ccb.content.define_item {
    id = "seed_watermelon_seedling",
    copy_from = "seed_watermelon",
    name = ccb.content.plural_text("Watermelon Seedling", "Watermelon Seedling"),
    description = ccb.content.text("A young watermelon seedling with a small root system.  It reaches harvest sooner than ordinary seeds when planted.  Must be planted on a trellis."),
    subtype_order = { "seed", "comestible" },
    seed = {
        required_terrain_flag = "CD_DELIGHT_TRELLIS",
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "14 days" },
            { stage = "GROWTH_SEEDLING", duration = "14 days" },
            { stage = "GROWTH_MATURE", duration = "14 days" },
            { stage = "GROWTH_HARVEST", duration = "13 days" },
            { stage = "GROWTH_OVERGROWN", duration = "36 minutes" },
        },
    },
    comestible = {},
}

ccb.content.define_item {
    id = "seed_melon_seedling",
    copy_from = "seed_melon",
    name = ccb.content.plural_text("Melon Seedling", "Melon Seedling"),
    description = ccb.content.text("A young melon seedling with a small root system.  It reaches harvest sooner than ordinary seeds when planted.  Must be planted on a trellis."),
    subtype_order = { "seed", "comestible" },
    seed = {
        required_terrain_flag = "CD_DELIGHT_TRELLIS",
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "14 days" },
            { stage = "GROWTH_SEEDLING", duration = "14 days" },
            { stage = "GROWTH_MATURE", duration = "14 days" },
            { stage = "GROWTH_HARVEST", duration = "13 days" },
            { stage = "GROWTH_OVERGROWN", duration = "36 minutes" },
        },
    },
    comestible = {},
}

ccb.content.define_item {
    id = "seed_pumpkin_seedling",
    copy_from = "seed",
    name = ccb.content.plural_text("南瓜苗", "南瓜苗"),
    description = ccb.content.text("一株已经长出少量根系的南瓜幼苗，种植后比普通种子更快进入采收期。必须种在种植架上。"),
    mass = "17 g",
    volume = "42 ml",
    color = "green",
    price = "1 USD",
    flags = { "PLANTABLE_SEED" },
    subtype_order = { "seed", "comestible" },
    seed = {
        plant_name = ccb.content.text("pumpkin"),
        fruit = "pumpkin",
        drop_seeds = false,
        byproducts = { "withered" },
        required_terrain_flag = "CD_DELIGHT_TRELLIS",
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "14 days" },
            { stage = "GROWTH_SEEDLING", duration = "14 days" },
            { stage = "GROWTH_MATURE", duration = "14 days" },
            { stage = "GROWTH_HARVEST", duration = "13 days" },
            { stage = "GROWTH_OVERGROWN", duration = "36 minutes" },
        },
    },
    comestible = { calories = 65 },
    use_actions = { "SEED" },
}

ccb.content.define_item {
    id = "seed_cattail_seedling",
    copy_from = "seed_cattail",
    name = ccb.content.plural_text("Cattail Seedling", "Cattail Seedling"),
    description = ccb.content.text("A young cattail seedling with a small root system.  It reaches harvest sooner than ordinary seeds when planted.  Must be planted in a paddy field."),
    subtype_order = { "seed", "comestible" },
    seed = {
        required_terrain_flag = "CD_DELIGHT_PADDY",
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "14 days" },
            { stage = "GROWTH_SEEDLING", duration = "14 days" },
            { stage = "GROWTH_MATURE", duration = "14 days" },
            { stage = "GROWTH_HARVEST", duration = "13 days" },
            { stage = "GROWTH_OVERGROWN", duration = "36 minutes" },
        },
    },
    comestible = {},
}

ccb.content.define_item {
    id = "seed_lotus_seedling",
    copy_from = "seed_lotus",
    name = ccb.content.plural_text("Lotus Seedling", "Lotus Seedling"),
    description = ccb.content.text("A young lotus seedling with a small root system.  It reaches harvest sooner than ordinary seeds when planted.  Must be planted in a paddy field."),
    subtype_order = { "seed", "comestible" },
    seed = {
        required_terrain_flag = "CD_DELIGHT_PADDY",
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "14 days" },
            { stage = "GROWTH_SEEDLING", duration = "14 days" },
            { stage = "GROWTH_MATURE", duration = "14 days" },
            { stage = "GROWTH_HARVEST", duration = "13 days" },
            { stage = "GROWTH_OVERGROWN", duration = "36 minutes" },
        },
    },
    comestible = {},
}

ccb.content.define_item {
    id = "seed_wild_rice_seedling",
    copy_from = "seed_wild_rice",
    name = ccb.content.plural_text("Wild Rice Seedling", "Wild Rice Seedling"),
    description = ccb.content.text("A young wild rice seedling with a small root system.  It reaches harvest sooner than ordinary seeds when planted.  Must be planted in a paddy field."),
    subtype_order = { "seed", "comestible" },
    seed = {
        required_terrain_flag = "CD_DELIGHT_PADDY",
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "14 days" },
            { stage = "GROWTH_SEEDLING", duration = "14 days" },
            { stage = "GROWTH_MATURE", duration = "14 days" },
            { stage = "GROWTH_HARVEST", duration = "13 days" },
            { stage = "GROWTH_OVERGROWN", duration = "36 minutes" },
        },
    },
    comestible = {},
}

ccb.content.define_item {
    id = "seed_cranberries_seedling",
    copy_from = "seed_cranberries",
    name = ccb.content.plural_text("Cranberry Seedling", "Cranberry Seedling"),
    description = ccb.content.text("A young cranberry seedling with a small root system.  It reaches harvest sooner than ordinary seeds when planted.  Must be planted in a paddy field."),
    subtype_order = { "seed", "comestible" },
    seed = {
        required_terrain_flag = "CD_DELIGHT_PADDY",
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "14 days" },
            { stage = "GROWTH_SEEDLING", duration = "14 days" },
            { stage = "GROWTH_MATURE", duration = "14 days" },
            { stage = "GROWTH_HARVEST", duration = "13 days" },
            { stage = "GROWTH_OVERGROWN", duration = "36 minutes" },
        },
    },
    comestible = {},
}
