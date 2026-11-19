local ccb = require("ccb")

ccb.content.define_item {
    id = "tourniquet_upper",
    name = ccb.content.plural_text("tourniquet (arm)", "tourniquets (arm)"),
    description = ccb.content.text("A first aid device used to apply pressure to a limb or extremity in order to limit blood flow.  Should be employed only to manage heavy bleeding, because prolonged use will harm the limb.  It can be adjusted in size to fit different limbs."),
    mass = "200 g",
    volume = "300 ml",
    price = "200 USD",
    survival_price = "50 cent",
    materials = { "wood", "cotton" },
    symbol = "{",
    looks_like = "armguard_hard",
    color = "red",
    flags = { "WATER_FRIENDLY", "OUTER", "TOURNIQUET" },
    armor = {
        sided = true,
        warmth = 0,
        thickness = 1,
        portions = { { encumbrance = 70, coverage = 10, covers = { "arm_l", "arm_r" } } },
    },
    use_actions = {
        {
            kind = "transform",
            target = "tourniquet_upper_XL",
            message = ccb.content.text("You adjust the tourniquet."),
            menu_text = ccb.content.text("Adjust"),
        },
    },
}

ccb.content.define_item {
    id = "tourniquet_upper_XL",
    name = ccb.content.plural_text("tourniquet (arm)", "tourniquets (arm)"),
    description = ccb.content.text("A first aid device used to apply pressure to a limb or extremity in order to limit blood flow.  Should be employed only to manage heavy bleeding, because prolonged use will harm the limb.  It can be adjusted in size to fit different limbs."),
    copy_from = "tourniquet_upper",
    looks_like = "tourniquet_upper",
    flags = { "WATER_FRIENDLY", "OUTER", "TOURNIQUET", "OVERSIZE", "PREFIX_XL" },
    armor = { sided = true },
    use_actions = {
        {
            kind = "transform",
            target = "tourniquet_upper_XS",
            message = ccb.content.text("You adjust the tourniquet."),
            menu_text = ccb.content.text("Adjust"),
        },
    },
}

ccb.content.define_item {
    id = "tourniquet_upper_XS",
    name = ccb.content.plural_text("tourniquet (arm)", "tourniquets (arm)"),
    description = ccb.content.text("A first aid device used to apply pressure to a limb or extremity in order to limit blood flow.  Should be employed only to manage heavy bleeding, because prolonged use will harm the limb.  It can be adjusted in size to fit different limbs."),
    copy_from = "tourniquet_upper",
    looks_like = "tourniquet_upper",
    flags = { "WATER_FRIENDLY", "OUTER", "TOURNIQUET", "UNDERSIZE", "PREFIX_XS" },
    armor = { covers = { "arm_l", "arm_r" }, sided = true },
    use_actions = {
        {
            kind = "transform",
            target = "tourniquet_lower",
            message = ccb.content.text("You adjust the tourniquet."),
            menu_text = ccb.content.text("Adjust"),
        },
    },
}

ccb.content.define_item {
    id = "tourniquet_lower",
    name = ccb.content.plural_text("tourniquet (leg)", "tourniquets (leg)"),
    description = ccb.content.text("A first aid device used to apply pressure to a limb or extremity in order to limit blood flow.  Should be employed only to manage heavy bleeding, because prolonged use will harm the limb.  It can be adjusted in size to fit different limbs."),
    copy_from = "tourniquet_upper",
    looks_like = "tourniquet_upper",
    materials = { "wood", "cotton" },
    flags = { "WATER_FRIENDLY", "OUTER", "TOURNIQUET", "ALLOWS_TAIL" },
    armor = {
        sided = true,
        portions = { { encumbrance = 70, coverage = 10, covers = { "leg_l", "leg_r" } } },
    },
    use_actions = {
        {
            kind = "transform",
            target = "tourniquet_lower_XL",
            message = ccb.content.text("You adjust the tourniquet."),
            menu_text = ccb.content.text("Adjust"),
        },
    },
}

ccb.content.define_item {
    id = "tourniquet_lower_XL",
    name = ccb.content.plural_text("tourniquet (leg)", "tourniquets (leg)"),
    description = ccb.content.text("A first aid device used to apply pressure to a limb or extremity in order to limit blood flow.  Should be employed only to manage heavy bleeding, because prolonged use will harm the limb.  It can be adjusted in size to fit different limbs."),
    copy_from = "tourniquet_lower",
    looks_like = "tourniquet_lower",
    flags = { "WATER_FRIENDLY", "OUTER", "TOURNIQUET", "OVERSIZE", "PREFIX_XL", "ALLOWS_TAIL" },
    armor = { sided = true },
    use_actions = {
        {
            kind = "transform",
            target = "tourniquet_lower_XS",
            message = ccb.content.text("You adjust the tourniquet."),
            menu_text = ccb.content.text("Adjust"),
        },
    },
}

ccb.content.define_item {
    id = "tourniquet_lower_XS",
    name = ccb.content.plural_text("tourniquet (leg)", "tourniquets (leg)"),
    description = ccb.content.text("A first aid device used to apply pressure to a limb or extremity in order to limit blood flow.  Should be employed only to manage heavy bleeding, because prolonged use will harm the limb.  It can be adjusted in size to fit different limbs."),
    copy_from = "tourniquet_lower",
    looks_like = "tourniquet_lower",
    flags = { "WATER_FRIENDLY", "OUTER", "TOURNIQUET", "UNDERSIZE", "PREFIX_XS", "ALLOWS_TAIL" },
    armor = { sided = true },
    use_actions = {
        {
            kind = "transform",
            target = "tourniquet_upper",
            message = ccb.content.text("You adjust the tourniquet."),
            menu_text = ccb.content.text("Adjust"),
        },
    },
}

ccb.content.define_item {
    id = "makeshift_blindfold",
    name = ccb.content.plural_text("makeshift blindfold", "makeshift blindfolds"),
    description = ccb.content.text("A crude eye covering woven from blades of grass with string attached to fasten it.  Useful for sleeping in bright areas.  Use to raise it."),
    mass = "32 g",
    volume = "200 ml",
    price = "5 cent",
    survival_price = "1 cent",
    materials = { "dry_plant" },
    symbol = "[",
    looks_like = "blindfold",
    color = "yellow",
    flags = { "BLIND" },
    armor = {
        warmth = 0,
        thickness = 0.1,
        environmental_protection = 0,
        portions = { { encumbrance = 10, coverage = 95, covers = { "eyes" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You uncover your eyes."),
            target = "makeshift_blindfold_up",
            menu_text = ccb.content.text("Raise"),
        },
    },
}

ccb.content.define_item {
    id = "makeshift_blindfold_up",
    name = ccb.content.plural_text("makeshift blindfold (raised)", "makeshift blindfolds (raised)"),
    description = ccb.content.text("A crude eye covering woven from blades of grass with string attached to fasten it.  It's currently raised, letting you see.  Use to lower it."),
    mass = "32 g",
    volume = "200 ml",
    price = "5 cent",
    survival_price = "1 cent",
    materials = { "dry_plant" },
    symbol = "[",
    looks_like = "blindfold",
    color = "yellow",
    armor = {
        warmth = 0,
        thickness = 0.1,
        environmental_protection = 0,
        portions = { { encumbrance = 10, coverage = 95, covers = { "head" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You cover your eyes."),
            target = "makeshift_blindfold",
            menu_text = ccb.content.text("Lower"),
        },
    },
}

-- A folded bandana still takes up some space on the head.
ccb.content.define_item {
    id = "blindfold",
    name = ccb.content.plural_text("blindfold", "blindfolds"),
    description = ccb.content.text("A simple fabric covering tied over the eyes to block sight.  Useful for sleeping in bright areas.  Use to raise it."),
    mass = "50 g",
    volume = "100 ml",
    price = "6 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "scarf",
    color = "dark_gray",
    flags = { "BLIND" },
    armor = {
        warmth = 5,
        thickness = 0.1,
        environmental_protection = 1,
        portions = { { encumbrance = 10, coverage = 95, covers = { "eyes" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You uncover your eyes."),
            target = "blindfold_up",
            menu_text = ccb.content.text("Raise"),
        },
    },
}

ccb.content.define_item {
    id = "blindfold_up",
    name = ccb.content.plural_text("blindfold (raised)", "blindfolds (raised)"),
    description = ccb.content.text("A simple fabric covering tied over the eyes to block sight.  It's currently raised, letting you see.  Use to lower it."),
    mass = "50 g",
    volume = "100 ml",
    price = "6 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "scarf",
    color = "dark_gray",
    armor = {
        warmth = 5,
        thickness = 0.1,
        environmental_protection = 1,
        portions = { { encumbrance = 10, coverage = 95, covers = { "head" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You cover your eyes."),
            target = "blindfold",
            menu_text = ccb.content.text("Lower"),
        },
    },
}

-- A folded bandana still takes up some space on the head.
ccb.content.define_item {
    id = "blindfold_duct",
    name = ccb.content.plural_text("duct tape blindfold", "duct tape blindfolds"),
    description = ccb.content.text("A simple covering tied over the eyes to block sight, made out of duct tape.  Useful for sleeping in bright areas.  Use to raise it."),
    mass = "20 g",
    volume = "60 ml",
    price = "10 cent",
    survival_price = "5 cent",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "blindfold",
    color = "dark_gray",
    flags = { "BLIND", "SKINTIGHT" },
    armor = {
        warmth = 0,
        thickness = 1,
        environmental_protection = 1,
        portions = { { encumbrance = 10, coverage = 95, covers = { "eyes" }, rigid_only = true } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You uncover your eyes."),
            target = "blindfold_duct_up",
            menu_text = ccb.content.text("Raise"),
        },
    },
}

ccb.content.define_item {
    id = "blindfold_duct_up",
    name = ccb.content.plural_text("duct tape blindfold (raised)", "duct tape blindfolds (raised)"),
    description = ccb.content.text("A simple covering tied over the eyes to block sight, made out of duct tape.  It's currently raised, letting you see.  Use to lower it."),
    mass = "20 g",
    volume = "60 ml",
    price = "10 cent",
    survival_price = "5 cent",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "blindfold",
    color = "dark_gray",
    flags = { "SKINTIGHT" },
    armor = {
        warmth = 0,
        thickness = 1,
        environmental_protection = 1,
        portions = { { encumbrance = 10, coverage = 95, covers = { "head" }, rigid_only = true } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You cover your eyes."),
            target = "blindfold_duct",
            menu_text = ccb.content.text("Lower"),
        },
    },
}
