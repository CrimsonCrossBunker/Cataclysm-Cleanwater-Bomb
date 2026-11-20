local ccb = require("ccb")

ccb.content.define_item {
    id = "art_harp",
    name = ccb.content.plural_text("ancient harp", "ancient harps"),
    category = "tools",
    mass = "3200 g",
    color = "brown",
    accuracy = { grip = "solid", length = "long", surface = "any", balance = "clumsy" },
    symbol = "7",
    description = ccb.content.text("A harp made of black wood.  Faint hypnotic notes ring in the air each time you touch it.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    price = "10 USD",
    survival_price = "2 USD 50 cent",
    materials = { { id = "wood", portions = 19 }, { id = "steel" } },
    volume = "6750 ml",
    length = "97 cm",
    flags = { "FRAGILE_MELEE", "BELTED", "SLEEP_IGNORE" },
    melee_damage = { bash = 18 },
    tool = {},
    use_actions = {
        {
            kind = "musical_instrument",
            speed_penalty = 15,
            volume = 0,
            fun = 5,
            fun_bonus = 5,
            description_interval = 20,
            player_messages = {
                "You strum a string and the note hangs in the air far longer than you would expect.",
                "You improvise a tune on the harp.  The sound is beautiful, even if you can't remember what you just played.",
                "You pluck a chord on the harp.  It doesn't sound anything at all like the sounds of the individual strings.",
            },
            npc_messages = { "plucks a few notes on the harp, though no sound seems to come." },
        },
    },
}
