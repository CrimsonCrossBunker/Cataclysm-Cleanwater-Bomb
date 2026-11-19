local ccb = require("ccb")

-- found in the inner cabins alongside ruana_sci_fi.  complement to cape_sci_fi, which is found as loot from nether spider
ccb.content.define_item {
    id = "helmet_sci_fi",
    category = "armor",
    name = ccb.content.plural_text("lunar veil", "lunar veils"),
    description = ccb.content.text("A wide-brimmed helm anchoring a veil of faintly latticed cloth.  The metallic fibers diffuse light in soft gradients, dimming near the crescent-moon eye-slit."),
    mass = "4100 g",
    volume = "2450 ml",
    survival_price = "150 USD",
    symbol = "n",
    color = "blue",
    flags = { "OVERSIZE", "UNBREAKABLE", "SUN_GLASSES", "PADDED" },
    armor = {
        portions = {
            {
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
                encumbrance = 10,
                coverage = 100,
                materials = { { id = "nanotubes", coverage = 100, thickness = 9 } },
            },
            {
                covers = { "head" },
                subparts = { "head_nape", "head_throat", "head_ear_r", "head_ear_l" },
                encumbrance = 5,
                coverage = 100,
                materials = { { id = "nanotubes", coverage = 100, thickness = 2.5 } },
            },
            {
                covers = { "mouth" },
                encumbrance = 5,
                coverage = 100,
                materials = { { id = "nanotubes", coverage = 100, thickness = 2.5 } },
            },
        },
        warmth = 20,
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Lower the veil"),
            target = "helmet_sci_fi_lowered",
            message = ccb.content.text("You lower the veil and bundle it about your throat."),
        },
    },
}

ccb.content.define_item {
    id = "helmet_sci_fi_lowered",
    category = "armor",
    name = ccb.content.plural_text("lunar veil (lowered)", "lunar veils (lowered)"),
    description = ccb.content.text("A wide-brimmed helm; the veil of faintly latticed cloth gathered into a crinkled scarf.  The metallic fibers diffuse light in soft gradients."),
    mass = "3100 g",
    volume = "2450 ml",
    survival_price = "150 USD",
    symbol = "n",
    color = "blue",
    flags = { "OVERSIZE", "UNBREAKABLE", "SUN_GLASSES", "PADDED" },
    armor = {
        portions = {
            {
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
                encumbrance = 10,
                coverage = 100,
                materials = { { id = "nanotubes", coverage = 100, thickness = 9 } },
            },
            {
                covers = { "head" },
                subparts = { "head_nape", "head_throat" },
                encumbrance = 10,
                coverage = 50,
                materials = { { id = "nanotubes", coverage = 100, thickness = 5 } },
            },
        },
        warmth = 20,
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Raise the veil"),
            target = "helmet_sci_fi",
            message = ccb.content.text("You raise the veil."),
        },
    },
}
