local ccb = require("ccb")

ccb.content.define_item {
    id = "inventor_light_minus_cell",
    copy_from = "light_minus_disposable_cell",
    category = "tool_magazine",
    name = ccb.content.plural_text("ultra-light modified battery", "ultra-light modified batteries"),
    description = ccb.content.text("A light battery cell that was modified and replaced with much more effective cells inside."),
    flags = {
        "NO_SALVAGE",
        "NO_UNLOAD",
        "NO_RELOAD",
        "RECHARGE",
        "BATTERY_ULTRA_LIGHT",
        "INVENTOR_CRAFTED",
    },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 125 } } },
    magazine = { count = 125, capacity = 125 },
}

ccb.content.define_item {
    id = "inventor_light_cell",
    copy_from = "light_battery_cell",
    category = "tool_magazine",
    name = ccb.content.plural_text("light modified battery", "light modified batteries"),
    description = ccb.content.text("A light battery cell that was modified and replaced with much more effective cells inside."),
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "RECHARGE", "BATTERY_LIGHT", "INVENTOR_CRAFTED" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 375 } } },
    magazine = { count = 375, capacity = 375 },
}

ccb.content.define_item {
    id = "inventor_medium_cell",
    copy_from = "medium_battery_cell",
    category = "tool_magazine",
    name = ccb.content.plural_text("medium modified battery", "medium modified batteries"),
    description = ccb.content.text("A medium battery cell that was modified and replaced with much more effective cells inside."),
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "RECHARGE", "BATTERY_MEDIUM", "INVENTOR_CRAFTED" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 1500 } } },
    magazine = { count = 1500, capacity = 1500 },
}

ccb.content.define_item {
    id = "inventor_heavy_cell",
    copy_from = "heavy_plus_battery_cell",
    category = "tool_magazine",
    name = ccb.content.plural_text("modified tool battery", "modified tool batteries"),
    description = ccb.content.text("A tool battery cell that was modified and replaced with much more effective cells inside."),
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "RECHARGE", "BATTERY_HEAVY", "INVENTOR_CRAFTED" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 3125 } } },
    magazine = { count = 3125, capacity = 3125 },
}

ccb.content.define_item {
    id = "inventor_welder",
    copy_from = "welder",
    name = ccb.content.plural_text("inventor's welder", "inventor's welders"),
    description = ccb.content.text("A lightweight, battery-powered tool to weld metal pieces together using a plasma-inducted electric arc.  A decent tool, but you think you can do more with some modifications."),
    mass = "2000 g",
    volume = "2500 ml",
    materials = { "lc_steel", "plastic" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM", "BATTERY_HEAVY" },
            default_magazine = "medium_battery_cell",
        },
    },
    inheritance = { add = { flags = { "INVENTOR_CRAFTED" } } },
    tool = {},
    use_actions = {
        {
            kind = "repair_item",
            id = "repair_metal",
            materials = {
                "iron", "steel", "aluminum", "copper", "bronze", "fancy_bronze", "silver", "gold",
                "budget_steel", "lc_steel", "mc_steel", "hc_steel", "ch_steel", "lc_steel_chain",
                "mc_steel_chain", "hc_steel_chain", "ch_steel_chain", "platinum", "superalloy",
            },
            skill = "fabrication",
            tool_quality = 10,
            cost_scaling = 0.1,
            move_cost = 500,
        },
        {
            kind = "link_up",
            menu_text = ccb.content.text("Plug in / Unplug"),
            ammo_scale = 0,
            cable_length = 10,
            charge_rate = "100 W",
        },
    },
}

ccb.content.define_item {
    id = "inventor_portal_closer",
    name = "Netherium-Reality Smoothing Device",
    description = "An enormous industrial press shaped device, covered in sensors, circuits, and other doodads.  Two inverted teleporters are located on each side of the hammers, poised to perfectly align at the end of a strike.  Doing so will smoothen the overall local barrier between Earth and other realities, filling in any holes at the expense of weakening it in a much wider area.  This is an overall positive effect, allowing you to heal tears that would never naturally close, but expect large temporary side-effects.",
    symbol = "#",
    looks_like = "box_large_metal",
    mass = "226 kg",
    volume = "601475 ml",
    length = "1495 mm",
    price = "100000 USD",
    survival_price = "1000 USD",
    flags = { "ELECTRONIC", "INVENTOR_CRAFTED" },
    materials = { "mc_steel" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            capacity = "10 L",
            mass_limit = "20 kg",
            default_magazine = "inventor_heavy_cell",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY", "BATTERY_MEDIUM" },
        },
    },
    faults = {
        { group = "electronic_general" },
    },
    use_actions = {
        { kind = "cast_spell", spell = "inventor_portal_closer_spell", level = 0, no_fail = true },
    },
    tool = { charges_per_use = 3125, ammo_types = "battery" },
}

ccb.content.define_item {
    id = "inventor_gaming_rig",
    name = ccb.content.plural_text("Oneiromantic gaming rig", "Oneiromantic gaming rigs"),
    description = ccb.content.text("One of the harsh realities of being an inventor is needing to devote a third of your time to sleep and then devote some time to do non-inventor fun things.  This little wonder alleviates this issue by turning your sleep time in entertainment time through application of your deductive power!  Have it on your person while you sleep and your dreams will become anything you want!  No nightmare will disturb you, for you decide if they happen at all!"),
    materials = { "steel" },
    symbol = "n",
    volume = "750 ml",
    mass = "1 kg",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM", "BATTERY_HEAVY" },
            default_magazine = "inventor_heavy_cell",
        },
    },
    flags = { "ELECTRONIC", "INVENTOR_CRAFTED" },
    faults = { { group = "electronic_general" } },
    subtype_order = { "tool", "artifact" },
    tool = { ammo_types = "battery" },
    artifact = { enchantments = { "ench_inventor_gaming_rig" } },
    use_actions = {
        {
            kind = "transform",
            target = "inventor_gaming_rig_on",
            need_charges = 1,
            message = ccb.content.text("The gaming rig is activated."),
        },
    },
}
