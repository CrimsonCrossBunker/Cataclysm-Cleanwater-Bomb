local ccb = require("ccb")

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
