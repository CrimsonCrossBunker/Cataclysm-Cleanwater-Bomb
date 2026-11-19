local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_hi_vis_jacket",
    repair_like = "jacket_windbreaker",
    copy_from = "jacket_windbreaker",
    looks_like = "jacket_windbreaker",
    name = ccb.content.text("hi-vis jacket"),
    description = ccb.content.text("Glowing orange and very visible indeed."),
    color = "red",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "xl_jeans",
    mass = "900 g",
    volume = "3 L",
    copy_from = "jeans",
    pockets = { { kind = "CONTAINER", rigid = true, capacity = "750 ml", mass_limit = "1 kg" } },
    flags = { "VARSIZE", "POCKETS", "OVERSIZE", "PREFIX_XL" },
    armor = { thickness = 4 },
}
