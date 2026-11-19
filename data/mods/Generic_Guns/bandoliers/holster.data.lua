local ccb = require("ccb")

ccb.content.define_item {
    id = "western_holster",
    copy_from = "western_holster",
    name = ccb.content.plural_text("western holster", "western holsters"),
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            min_item_volume = "100 ml",
            capacity = "855 ml",
            mass_limit = "2 kg",
            max_item_length = "38 cm",
            moves = 30,
        },
        {
            kind = "CONTAINER",
            holster = false,
            rigid = true,
            ammunition = { ammo_pistol_tiny = 18, ammo_pistol = 18, ammo_pistol_magnum = 18 },
            moves = 20,
        },
    },
    armor = {},
    use_actions = { { kind = "holster" } },
}
