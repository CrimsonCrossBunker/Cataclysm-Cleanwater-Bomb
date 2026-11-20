local ccb = require("ccb")

ccb.content.define_item {
    id = "bot_skitterbot_rat",
    copy_from = "bot_skitterbot_base",
    name = ccb.content.plural_text("inactive rat snatcher", "inactive rat snatchers"),
    description = ccb.content.text("A small hexapod drone designed to hold small pests, folded into a small cube for easy storage.  It's capable of hunting all sorts of small mammals with remarkable efficiency, but shouldn't be expected to handle anything much bigger than a rat."),
    color = "dark_gray",
    mass = "750 g",
    volume = "1 L",
    price = "200 USD",
    accuracy = -3,
    melee_damage = { bash = 2 },
    tool = {},
    use_actions = {
        {
            kind = "place_monster",
            monster = "mon_skitterbot_rat",
            difficulty = 1,
            moves = 100,
            skills = { "electronics", "computer" },
        },
    },
}
