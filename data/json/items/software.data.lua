local ccb = require("ccb")

ccb.content.define_item {
    id = "abstract_efile",
    abstract = true,
    name = "abstract electronic file",
    description = "abstract electronic file, copy-from for any item that should solely be on an electronic storage medium",
    symbol = "o",
    category = "e_files",
    ememory_size = "1 KB",
    flags = { "E_STORABLE", "ZERO_WEIGHT", "NO_DROP", "IRREMOVABLE" },
    variables = { browsed = "false" },
}

ccb.content.define_item {
    id = "abstract_efile_exclusive_copiable",
    abstract = true,
    copy_from = "abstract_efile",
    name = "abstract copiable electronic file",
    description = "abstract copiable electronic file",
    symbol = "o",
    ememory_size = "1 KB",
    inheritance = {
        add = {
            flags = { "E_COPIABLE", "E_STORABLE_EXCLUSIVE" },
        },
        remove = {
            flags = { "E_STORABLE" },
        },
    },
}

ccb.content.define_item {
    id = "abstract_efile_read",
    abstract = true,
    copy_from = "abstract_efile",
    name = "abstract read electronic file",
    description = "abstract electronic file, copy-from for any item that should solely be on an electronic storage medium, pre-read so the device doesn't have to be browsed.",
    symbol = "o",
    variables = { browsed = "true" },
}

ccb.content.define_item {
    id = "abstract_efile_recipes",
    abstract = true,
    copy_from = "abstract_efile_exclusive_copiable",
    name = "abstract recipe catalog",
    description = "for any collection of recipes",
    symbol = "o",
    ememory_size = "4 MB",
    variables = { browsed = "false" },
    inheritance = {
        add = {
            flags = { "E_FILE_COLLECTION", "E_STORABLE_EXCLUSIVE" },
        },
    },
}

ccb.content.define_item {
    id = "efile_recipes",
    copy_from = "abstract_efile_recipes",
    name = "recipe catalog",
    description = "This is a filtered collection of PDFs, images, and texts that contains instructions for making useful items.  Any electronic recipe catalogs will be added to this one.",
    symbol = "o",
    ememory_size = "4 MB",
    memory_card = {
        data_chance = 1,
        recipes_chance = 1,
        recipes_amount = 5,
        recipes_categories = { "CC_AMMO", "CC_ARMOR", "CC_CHEM", "CC_ELECTRONIC", "CC_FOOD", "CC_WEAPON" },
        recipes_level_max = 5,
    },
    use_actions = { "VIEW_RECIPES" },
}

ccb.content.define_item {
    id = "efile_recipes_science",
    copy_from = "abstract_efile_recipes",
    name = "scientific recipe catalog",
    symbol = "o",
    ememory_size = "4 MB",
    memory_card = {
        data_chance = 1,
        recipes_chance = 1,
        recipes_amount = 3,
        recipes_categories = { "CC_CHEM", "CC_ELECTRONIC" },
        recipes_level_min = 5,
    },
    use_actions = { "VIEW_RECIPES" },
}

ccb.content.define_item {
    id = "efile_recipes_medical",
    copy_from = "abstract_efile_recipes",
    name = "medical recipe catalog",
    symbol = "o",
    ememory_size = "4 MB",
    memory_card = {
        data_chance = 1,
        recipes_chance = 1,
        recipes_amount = 3,
        recipes_categories = { "CSC_CHEM_DRUGS", "CSC_OTHER_MEDICAL" },
        recipes_level_min = 3,
    },
    use_actions = { "VIEW_RECIPES" },
}
