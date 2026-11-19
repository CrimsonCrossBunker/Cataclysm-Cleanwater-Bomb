local ccb = require("ccb")

ccb.content.define_item {
    id = "corset",
    name = ccb.content.plural_text("leather corset", "leather corsets"),
    description = ccb.content.text("A snug, black leather corset.  Has no pockets, but its thick material provides good protection from harm.  Use it to loosen it if you want to wear it over normal clothing."),
    mass = "640 g",
    volume = "1250 ml",
    price = "110 USD",
    survival_price = "1 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "vest_leather",
    color = "dark_gray",
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 25,
        thickness = 3,
        environmental_protection = 1,
        portions = {
            { encumbrance = 15, covers = { "torso" }, subparts = { "torso_upper" }, coverage = 70 },
            { covers = { "torso" }, subparts = { "torso_lower" }, coverage = 100 },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You loosen your corset."),
            target = "corset_loose",
            menu_text = ccb.content.text("Loosen"),
        },
    },
}

ccb.content.define_item {
    id = "corset_loose",
    copy_from = "corset",
    name = ccb.content.plural_text("leather corset (loose)", "leather corsets (loose)"),
    description = ccb.content.text("A somewhat loose black leather corset.  Has no pockets, but its thick material provides good protection from harm.  Use it to wear it tighter and close to the skin."),
    inheritance = { remove = { flags = { "SKINTIGHT" } } },
    armor = {
        thickness = 3,
        environmental_protection = 1,
        portions = {
            { encumbrance = 12, covers = { "torso" }, subparts = { "torso_upper" }, coverage = 70 },
            { covers = { "torso" }, subparts = { "torso_lower" }, coverage = 100 },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You wrap your corset tighter."),
            target = "corset",
            menu_text = ccb.content.text("Wrap tighter"),
        },
    },
}

ccb.content.define_item {
    id = "corset_waist",
    name = ccb.content.plural_text("waist corset", "waist corsets"),
    description = ccb.content.text("A snug, black leather waist corset.  Works as a stylish solution for back pain.  Use it to loosen it if you want to wear it over normal clothing."),
    mass = "320 g",
    volume = "650 ml",
    copy_from = "corset",
    armor = {
        thickness = 3,
        environmental_protection = 1,
        portions = { { encumbrance = 8, coverage = 100, covers = { "torso" }, subparts = { "torso_lower" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You loosen your corset."),
            target = "corset_waist_loose",
            menu_text = ccb.content.text("Loosen"),
        },
    },
}

ccb.content.define_item {
    id = "corset_waist_loose",
    copy_from = "corset_waist",
    name = ccb.content.plural_text("waist corset (loose)", "waist corsets (loose)"),
    description = ccb.content.text("A somewhat loose black leather waist corset.  Works as a stylish solution for back pain.  Use it to wear it tighter and close to the skin."),
    inheritance = { remove = { flags = { "SKINTIGHT" } } },
    armor = {
        thickness = 3,
        environmental_protection = 1,
        portions = { { encumbrance = 6, coverage = 100, covers = { "torso" }, subparts = { "torso_lower" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You wrap your corset tighter."),
            target = "corset_waist",
            menu_text = ccb.content.text("Wrap tighter"),
        },
    },
}
