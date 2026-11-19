local ccb = require("ccb")

-- Binding
ccb.content.define_item {
    id = "leather_journal",
    category = "tools",
    name = ccb.content.plural_text("leather journal", "leather journals"),
    looks_like = "book_nonf_soft_psych_cggamers",
    description = ccb.content.text("A leather-back journal for preserving notes and maps, has a strap to keep loose pages contained."),
    volume = "300 ml",
    mass = "80 g",
    flags = { "TRADER_AVOID" },
    materials = { "leather" },
    symbol = "*",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            rigid = false,
            mass_limit = "2 kg",
            capacity = "2500 ml",
            max_item_length = "300 mm",
            moves = 150,
            allowed_flags = { "PAPER_SHAPED" },
        },
    },
    tool = {},
}
