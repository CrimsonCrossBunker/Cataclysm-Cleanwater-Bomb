local ccb = require("ccb")

ccb.content.define_item {
    id = "c4",
    category = "weapons",
    name = ccb.content.plural_text("C-4 explosive", "C-4 explosives"),
    description = ccb.content.text("A block of military-grade RDX composition explosive.  A label reads: \"Highly explosive, use with extreme caution!\" It comes with a small timer."),
    mass = "1570 g",
    volume = "1 L",
    price = "90 USD",
    survival_price = "20 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "rdx" },
    symbol = ";",
    color = "light_gray",
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "ALLOWS_REMOTE_USE" },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            target = "c4armed",
            set_timer = true,
            menu_text = ccb.content.text("Activate"),
        },
    },
}
