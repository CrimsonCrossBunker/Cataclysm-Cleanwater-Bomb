local ccb = require("ccb")

ccb.content.define_item {
    id = "cardboard_crown",
    name = ccb.content.plural_text("cardboard crown", "cardboard crowns"),
    description = ccb.content.text("A piece of cardboard crudely bent into shape and cut to look like a crown."),
    mass = "200 g",
    volume = "100 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "cardboard" },
    looks_like = "crown_golden",
    symbol = "[",
    color = "brown_yellow",
    flags = { "WATER_DISSOLVE", "FRAGILE_MELEE", "NO_WEAR_EFFECT", "FRAGILE", "SOFT" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 1, coverage = 20, covers = { "head" }, subparts = { "head_crown" } } },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Loosen"),
            target = "cardboard_crown_loose",
            message = ccb.content.text("You loosen your cardboard crown."),
        },
    },
}

ccb.content.define_item {
    id = "cardboard_crown_loose",
    name = ccb.content.plural_text("cardboard crown (loosened)", "cardboard crowns (loosened)"),
    description = ccb.content.text("A piece of cardboard crudely bent into shape and cut to look like a crown.  This one's been loosened up somewhat, allowing it to be worn over some headgear comfortably."),
    copy_from = "cardboard_crown",
    flags = {
        "WATER_DISSOLVE",
        "FRAGILE_MELEE",
        "NO_WEAR_EFFECT",
        "FRAGILE",
        "OUTER",
        "POWERARMOR_COMPATIBLE",
        "SOFT",
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Adjust"),
            target = "cardboard_crown",
            message = ccb.content.text("You adjust your cardboard crown."),
        },
    },
}
