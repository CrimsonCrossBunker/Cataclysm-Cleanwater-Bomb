local ccb = require("ccb")

ccb.content.define_item {
    id = "azabow_off",
    copy_from = "compbow",
    name = "Aztlani bow",
    description = "An ornate bow used by Aztlani nobility during hunting rituals.  Designed to fell the plated creatures of Aztlan, its articulated and power assisted limbs allow it to fire projectiles with a strength comparable to modern assault rifles.\n\nWith its drawing aid system currently disabled, firing it will require truly superhuman strength.  It can be activated to toggle it drawing assist functionality.",
    symbol = "(",
    color = "white",
    price = "500 USD",
    survival_price = "400 USD",
    min_strength = 40,
    materials = { "superalloy", "qt_steel", "wood" },
    use_actions = {
        {
            kind = "transform",
            target = "azabow_on",
            ammo_scale = 0,
            message = "You connect the bow to your UPS.",
            menu_text = "Activate",
        },
    },
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 5,
                encumbrance = 20,
                materials = {
                    { id = "superalloy", thickness = 1.0, coverage = 100 },
                    { id = "qt_steel", thickness = 1.0, coverage = 100 },
                    { id = "wood", thickness = 1.0, coverage = 100 },
                },
            },
        },
    },
    gun = {
        range = 25,
        dispersion = 1000,
        clip_size = 1,
        damage = { type = "stab", amount = 17 },
    },
    subtype_order = { "armor", "gun" },
}

ccb.content.define_item {
    id = "azabow_on",
    copy_from = "azabow_off",
    name = ccb.content.plural_text("Aztlani bow (active)", "Aztlani bows (active)"),
    description = "An ornate bow used by Aztlani nobility during hunting rituals.  Designed to fell the plated creatures of Aztlan, its articulated and power assisted limbs allow it to fire projectiles with a strength comparable to modern assault rifles.\n\nWith its drawing aid system enabled, it can be much more easily drawn, at the cost of a modest amount of UPS power consumption per arrow.  It can be activated to toggle it drawing assist functionality.",
    symbol = "(",
    color = "white",
    min_strength = 20,
    use_actions = {
        {
            kind = "transform",
            target = "azabow_off",
            ammo_scale = 0,
            message = "You disconnect the UPS.",
            menu_text = "Deactivate",
        },
    },
    gun = { energy_drain = "12 kJ" },
    inheritance = {
        add = {
            flags = { "USE_UPS" },
        },
    },
}

ccb.content.define_item {
    id = "scrapbow",
    copy_from = "compositebow",
    name = "salvage bow",
    description = "A bow made from readily-available materials, and quickly and cheaply put together.  It is not made to be pretty, but to get a job done.  Its nocks and string are made of shape-memory alloy that help increase string tension in the string.  The memory alloy requires a UPS source to be activated.",
    looks_like = "longbow",
    mass = "540 g",
    volume = "2500 ml",
    length = "152 cm",
    price = "380 USD",
    survival_price = "20 USD",
    materials = { "steel", "plastic" },
    melee_damage = { bash = 12 },
    pockets = {
        {
            kind = "MAGAZINE",
            open_container = true,
            ammunition = { arrow = 1 },
        },
    },
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 5,
                encumbrance = 20,
                materials = {
                    { id = "steel", thickness = 1.0, coverage = 100 },
                    { id = "plastic", thickness = 1.0, coverage = 100 },
                },
            },
        },
    },
    gun = {
        range = 14,
        dispersion = 850,
        durability = 6,
        energy_drain = "4 kJ",
        damage = { type = "stab", amount = 12 },
        mod_locations = {
            { id = "underbarrel", count = 1 },
            { id = "sights", count = 1 },
            { id = "stabilizer", count = 1 },
            { id = "dampening", count = 1 },
        },
    },
    subtype_order = { "armor", "gun" },
    inheritance = {
        add = {
            flags = { "USE_UPS" },
        },
    },
}
