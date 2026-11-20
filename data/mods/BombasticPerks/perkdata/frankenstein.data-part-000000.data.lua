local ccb = require("ccb")

ccb.content.define_item {
    id = "meat_hunk",
    name = ccb.content.plural_text("homunculus", "homunculi"),
    description = ccb.content.text("A stitched together monstrosity of meat and bone, with limbs as wide as trash cans.  This one is still sleeping.  It would require a master's touch to bring it to life."),
    volume = "875000 ml",
    mass = "200 kg",
    price = "0 cent",
    survival_price = "0 cent",
    accuracy = -3,
    materials = { "flesh" },
    symbol = ";",
    color = "white_magenta",
    flags = { "SINGLE_USE" },
    melee_damage = { bash = 8 },
    tool = {},
    use_actions = {
        {
            kind = "place_monster",
            monster = "mon_meat_hunk",
            friendly_message = "",
            hostile_message = "",
            difficulty = 0,
            moves = 150,
            skills = { "electronics", "firstaid" },
        },
    },
}
