local ccb = require("ccb")

-- Use of %s not currently supported.
ccb.content.define_item {
    id = "horn_bicycle",
    category = "veh_parts",
    name = ccb.content.plural_text("bicycle horn", "bicycle horns"),
    description = ccb.content.text("A simple bulb horn found on many bicycles.  Activate it to honk.  Honk honk."),
    mass = "170 g",
    volume = "500 ml",
    price = "4 USD",
    survival_price = "10 cent",
    materials = { "plastic", "aluminum" },
    symbol = ";",
    color = "light_gray",
    tool = {},
    use_actions = {
        {
            kind = "manualnoise",
            moves = 100,
            volume = 15,
            sound_message = ccb.content.text("honk."),
            sound_id = "misc",
            sound_variant = "horn_bicycle",
            message = ccb.content.text("You honk the bicycle horn."),
        },
    },
}
