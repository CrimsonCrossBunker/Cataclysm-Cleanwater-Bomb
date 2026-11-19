local ccb = require("ccb")

ccb.content.define_item {
    id = "bead_bracelet",
    name = ccb.content.plural_text("beaded bracelet", "beaded bracelets"),
    description = ccb.content.text("A simple bracelet of string and wooden beads.  Also doubles as a set of prayer beads, if you're so inclined."),
    looks_like = "copper_bracelet",
    mass = "6 g",
    volume = "10 ml",
    price = "1 USD",
    survival_price = "10 cent",
    materials = { "wood" },
    symbol = "[",
    color = "brown",
    flags = { "NO_WEAR_EFFECT", "BELTED", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 0,
                coverage = 20,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
    use_actions = { "MEDITATE" },
}
