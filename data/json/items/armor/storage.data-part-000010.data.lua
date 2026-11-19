local ccb = require("ccb")

-- The main section of the golf bag actually assumes things will stick out of it, but specifically contains them, so some extra wiggle room was added.
ccb.content.define_item {
    id = "golf_bag",
    name = ccb.content.plural_text("golf bag", "golf bags"),
    description = ccb.content.text("A tall canvas and plastic bag with fold-out legs used for golfing.  It even has straps to be worn on the back and a slot for an umbrella."),
    mass = "1900 g",
    volume = "45 L",
    price = "8 USD",
    survival_price = "7 USD 50 cent",
    materials = { "nylon", "plastic" },
    symbol = "[",
    looks_like = "quiver_large",
    color = "green",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "40 L",
            mass_limit = "200 kg",
            moves = 300,
            rigid = true,
            max_item_length = "150 cm",
        },
        { capacity = "90 ml", mass_limit = "750 g", max_item_length = "10 cm", moves = 200 },
        { capacity = "90 ml", mass_limit = "750 g", max_item_length = "10 cm", moves = 200 },
        { capacity = "1350 ml", mass_limit = "4 kg", max_item_length = "25 cm", moves = 300 },
        { capacity = "675 ml", mass_limit = "2 kg", max_item_length = "20 cm", moves = 300 },
        { capacity = "675 ml", mass_limit = "2 kg", max_item_length = "20 cm", moves = 300 },
        { capacity = "500 ml", mass_limit = "300 g", max_item_length = "15 cm", moves = 100 },
    },
    flags = { "BELTED", "OVERSIZE" },
    armor = {
        warmth = 5,
        thickness = 3,
        portions = {
            {
                encumbrance = { 30, 35 },
                coverage = 70,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Sheath golf club"),
            message = ccb.content.text("You awkwardly sheath your %s"),
        },
    },
}
