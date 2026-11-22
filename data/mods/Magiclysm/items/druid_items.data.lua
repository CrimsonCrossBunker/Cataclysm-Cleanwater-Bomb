local ccb = require("ccb")

ccb.content.define_item {
    id = "rune_wildwood",
    name = ccb.content.plural_text("wildwood rune", "wildwood runes"),
    description = ccb.content.text("A small druid rune wrapped in a leaf.  It appears to be made of some kind of resin, and is very sticky."),
    price = "0 USD",
    mass = "40 g",
    volume = "50 ml",
    symbol = ",",
    color = "green",
    subtype_order = { "tool", "comestible" },
    tool = {},
    comestible = { quench = 1, calories = 350, kind = "INVALID", pet_food = { "rune_wildwood" } },
    use_actions = { "PETFOOD" },
}

ccb.content.define_item {
    id = "mag_pseudo_weaver",
    copy_from = "fake_item",
    name = "Wildwood Weaver",
    qualities = {
        { id = "SEW", level = 4 },
        { id = "SEW_CURVED", level = 1 },
        { id = "KNIT", level = 1 },
        { id = "LEATHER_AWL", level = 2 },
        { id = "CUT", level = 2 },
        { id = "FABRIC_CUT", level = 2 },
    },
    use_actions = {
        {
            kind = "repair_item",
            id = "repair_fabric",
            skill = "tailor",
            tool_quality = 1,
            move_cost = 300,
            cost_scaling = 0.1,
            materials = {
                "cotton",
                "leather",
                "lycra",
                "nylon",
                "wool",
                "fur",
                "faux_fur",
                "nomex",
                "kevlar",
                "kevlar_layered",
                "neoprene",
                "parabolan_wool",
                "gutskin",
                "canvas",
            },
        },
        "PLAY_GAME",
    },
    tool = {
        charges_per_use = 1,
        crafting_subtype = "sewing_kit",
        ammo_types = { "mag_awakened_water" },
    },
}
