local ccb = require("ccb")

ccb.content.define_item {
    id = "teleumbrella",
    category = "tools",
    name = ccb.content.plural_text("telescoping umbrella (collapsed)", "telescoping umbrellas (collapsed)"),
    description = ccb.content.text("A telescoping umbrella which has been collapsed down for easy storage.  May be used to keep dry when extended and wielded."),
    mass = "411 g",
    volume = "1500 ml",
    length = "25 cm",
    price = "120 USD",
    survival_price = "1 USD",
    materials = { "plastic", "aluminum" },
    symbol = ",",
    color = "dark_gray",
    techniques = { "WBLOCK_1" },
    flags = { "ALLOWS_NATURAL_ATTACKS", "BELT_CLIP", "BELTED", "FRAGILE", "OVERSIZE", "PADDED" },
    melee_damage = { bash = 3 },
    armor = {
        sided = true,
        warmth = 0,
        thickness = 1,
        portions = {
            {
                encumbrance = 25,
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
                materials = { { id = "plastic", coverage = 100, thickness = 1 } },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Extend"),
            target = "teleumbrella-extended",
            message = ccb.content.text("You open your umbrella."),
        },
    },
}
