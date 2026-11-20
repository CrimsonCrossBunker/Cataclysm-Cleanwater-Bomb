local ccb = require("ccb")

-- Use of %s not currently supported.
ccb.content.define_item {
    id = "whistle",
    name = ccb.content.plural_text("whistle", "whistles"),
    volume = "10 ml",
    description = ccb.content.text("A simple metal whistle, with a cord to wear it around your neck."),
    mass = "25 g",
    color = "light_gray",
    price = "2 USD",
    survival_price = "50 cent",
    materials = { "steel", "cotton" },
    flags = { "WATER_FRIENDLY", "BELTED" },
    symbol = "[",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { portions = { { coverage = 1, covers = { "torso" }, subparts = { "torso_neck" } } } },
    use_actions = {
        {
            kind = "manualnoise",
            message = ccb.content.text("You blow the whistle."),
            sound_message = ccb.content.text("FWEEEET!"),
            sound_id = "misc",
            sound_variant = "whistle",
            volume = 100,
            moves = 100,
        },
    },
}
