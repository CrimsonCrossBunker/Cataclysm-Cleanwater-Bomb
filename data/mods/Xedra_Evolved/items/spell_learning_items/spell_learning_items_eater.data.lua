local ccb = require("ccb")

ccb.content.define_item {
    id = "blindfold_artifact",
    copy_from = "blindfold",
    name = "red devil blindfold",
    description = "A red fabric blindfold with a cartoonish devil over the eyes.  You feel some anger when you put it on.  Did that devil just wink at you?",
    use_actions = {
        {
            kind = "learn_spell",
            spells = { "spell_rage" },
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "ring_artifact",
    name = ccb.content.plural_text("ring of Gyges", "rings of Gyges"),
    description = "A small ring.  There is nothing special about it, except the word \"Republic\" embossed on it.",
    symbol = "[",
    color = "brown",
    looks_like = "ring_purity",
    mass = "1 g",
    volume = "1 ml",
    price = "20 USD",
    survival_price = "10 cent",
    flags = { "NO_WEAR_EFFECT", "SKINTIGHT" },
    materials = { "forged_dreamstuff" },
    use_actions = {
        {
            kind = "learn_spell",
            spells = { "spell_invisibility" },
        },
    },
    armor = {
        sided = true,
        portions = {
            {
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                coverage = 0,
                encumbrance = 0,
            },
        },
    },
}
