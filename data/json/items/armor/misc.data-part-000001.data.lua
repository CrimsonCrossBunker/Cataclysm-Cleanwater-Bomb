local ccb = require("ccb")

ccb.content.define_item {
    id = "clown_nose",
    name = ccb.content.plural_text("clown nose", "clown noses"),
    description = ccb.content.text("A red latex nose often worn by clowns.  Squeezing the nose makes it honk."),
    mass = "100 g",
    volume = "100 ml",
    price = "8 USD",
    survival_price = "10 cent",
    materials = { "plastic" },
    symbol = ".",
    color = "red",
    armor = {},
    use_actions = {
        {
            kind = "manualnoise",
            message = ccb.content.text("You honk the clown nose."),
            sound_message = ccb.content.text("Honk!"),
            sound_id = "misc",
            sound_variant = "default",
            volume = 10,
            moves = 100,
        },
    },
}
