local ccb = require("ccb")

ccb.content.define_item {
    id = "laptop",
    copy_from = "abstract_laptop",
    category = "tools",
    name = ccb.content.plural_text("laptop computer", "laptop computers"),
    description = ccb.content.text("A portable computer, the cutting edge of computing technology before the plague and the walkers.  Not much use now, though maybe there's some interesting files on it."),
    symbol = ",",
    color = "dark_gray",
    price = "3500 USD",
    survival_price = "2 USD 50 cent",
    mass = "1319 g",
    volume = "703 ml",
    length = "322 mm",
    pockets = {
        { kind = "MAGAZINE", rigid = true, ammunition = { battery = 200 } },
        {
            kind = "E_FILE_STORAGE",
            rigid = true,
            capacity = "1 ml",
            mass_limit = "1 g",
            weight_multiplier = 0.0,
            memory_capacity = "100 MB",
        },
    },
    tool = {},
    use_actions = {
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        "PORTABLE_GAME",
        {
            kind = "transform",
            target = "laptop_screen_lit",
            message = ccb.content.text("You light up the screen."),
            menu_text = ccb.content.text("Light up the screen"),
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
        { kind = "link_up", cable_length = 5, charge_rate = "140 W" },
    },
}
