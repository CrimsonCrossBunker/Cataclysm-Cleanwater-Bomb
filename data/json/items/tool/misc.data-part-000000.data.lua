local ccb = require("ccb")

-- Use of %s not currently supported.
ccb.content.define_item {
    id = "airhorn",
    name = ccb.content.plural_text("compressed air horn", "compressed air horns"),
    description = ccb.content.text("A small can of compressed air attached to a plastic horn.  Pressing the button on top causes it to emit a loud honking sound."),
    mass = "467 g",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "50 cent",
    materials = { "plastic", "aluminum" },
    symbol = ";",
    color = "red",
    tool = { initial_charges = 50, max_charges = 50, charges_per_use = 1 },
    use_actions = {
        {
            kind = "manualnoise",
            moves = 100,
            volume = 110,
            sound_message = ccb.content.text("HOOOOONK!"),
            sound_id = "misc",
            sound_variant = "airhorn",
            message = ccb.content.text("You honk your airhorn."),
        },
    },
}
