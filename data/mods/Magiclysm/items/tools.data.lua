local ccb = require("ccb")

ccb.content.define_item {
    id = "sewing_kit",
    name = ccb.content.plural_text("sewing kit", "sewing kits"),
    copy_from = "sewing_kit",
    tool = {},
    use_actions = {
        {
            kind = "repair_item",
            id = "repair_fabric",
            materials = {
                "cotton", "leather", "lycra", "nylon", "wool", "fur", "faux_fur", "nomex", "kevlar",
                "kevlar_layered", "gutskin", "denim", "canvas", "black_dragon_hide",
            },
            skill = "tailor",
            tool_quality = 0,
            cost_scaling = 0.1,
            move_cost = 1000,
        },
    },
}

ccb.content.define_item {
    id = "tailors_kit",
    name = ccb.content.plural_text("tailor's kit", "tailor's kits"),
    copy_from = "tailors_kit",
    tool = {},
    use_actions = {
        {
            kind = "repair_item",
            id = "repair_fabric",
            materials = {
                "cotton", "leather", "lycra", "nylon", "wool", "fur", "faux_fur", "nomex", "kevlar",
                "kevlar_layered", "neoprene", "gutskin", "denim", "canvas", "black_dragon_hide",
            },
            skill = "tailor",
            tool_quality = 1,
            cost_scaling = 0.1,
            move_cost = 800,
        },
    },
}

ccb.content.define_item {
    id = "soldering_iron",
    name = ccb.content.plural_text("soldering iron", "soldering irons"),
    description = ccb.content.text("A device with a metal tip that can get very hot.  It is necessary for advanced electronics crafting.  Has a short cable that you can plug to your grid."),
    mass = "90 g",
    volume = "120 ml",
    length = "22 cm",
    price = "10 USD",
    survival_price = "1 USD",
    materials = { { id = "plastic", portions = 75 }, { id = "copper", portions = 25 } },
    symbol = ",",
    color = "light_gray",
    flags = { "BELT_CLIP", "ALLOWS_REMOTE_USE", "WATER_BREAK" },
    accuracy = { grip = "solid", length = "hand", surface = "point", balance = "neutral" },
    melee_damage = { stab = 2 },
    tool = { charges_per_use = 1, ammo_types = { "battery" } },
    use_actions = {
        {
            kind = "repair_item",
            id = "repair_metal",
            materials = { "plastic", "lead", "tin", "zinc", "demon_chitin" },
            skill = "fabrication",
            cost_scaling = 0.1,
            move_cost = 1500,
        },
        { kind = "link_up", cable_length = 3, charge_rate = "70 W" },
    },
}

ccb.content.define_item {
    id = "soldering_iron_portable",
    copy_from = "soldering_iron",
    name = ccb.content.plural_text("portable soldering iron", "portable soldering irons"),
    description = ccb.content.text("A device with a metal tip that can get very hot.  It is necessary for advanced electronics crafting.  This one is a portable version, and contains a slot for a battery."),
    symbol = ",",
    color = "light_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
    },
    accuracy = { grip = "solid", length = "hand", surface = "point", balance = "neutral" },
    melee_damage = { stab = 2 },
    tool = {},
    use_actions = {
        {
            kind = "repair_item",
            id = "repair_metal",
            materials = { "plastic", "lead", "tin", "zinc", "demon_chitin" },
            skill = "fabrication",
            cost_scaling = 0.1,
            move_cost = 1500,
        },
    },
}
