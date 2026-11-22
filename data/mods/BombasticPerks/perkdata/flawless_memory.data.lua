local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_memory",
    copy_from = "fake_item",
    name = ccb.content.plural_text("Flawless memory", "Flawless memory"),
    description = "You can remember with perfect detail everything you've ever lived, even allowing you to read books and play games by remembering them.",
    flags = {
        "INTEGRATED",
        "UNBREAKABLE",
        "PERSONAL",
        "NO_REPAIR",
        "CAMERA_PRO",
        "ALLOWS_NATURAL_ATTACKS",
    },
    materials = { "hflesh" },
    variables = { browsed = "true" },
    pockets = {
        {
            kind = "E_FILE_STORAGE",
            capacity = "1 ml",
            mass_limit = "1 g",
            memory_capacity = "2 TB",
            weight_multiplier = 0,
            rigid = true,
        },
    },
    use_actions = { "CAMERA", "PORTABLE_GAME", "EBOOKSAVE", "E_FILE_DEVICE" },
    tool = { charges_per_use = 0, transfer_rate = "30 MB" },
    armor = {},
    subtype_order = { "tool", "armor" },
}
