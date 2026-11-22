local ccb = require("ccb")

ccb.content.define_item {
    id = "mag_brokeweaver",
    symbol = ";",
    color = "green",
    name = ccb.content.plural_text("small damaged weaver", "small damaged weavers"),
    description = ccb.content.text("A tiny broken weaver.  Its legs bent and broken, it can no longer be used to repair clothing or create a shelter."),
    materials = { "wood", "veggy" },
    mass = "50 g",
    volume = "125 ml",
    flags = { "TRADER_AVOID" },
    artifact = {},
}

ccb.content.define_item {
    id = "mag_adult_weaver",
    copy_from = "mag_immature_weaver",
    name = "adult wildwood weaver",
    description = "This weaver is fully grown.  There's no light behind its eyes, yet.",
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            watertight = true,
            ammunition = { mag_awakened_water = 300 },
        },
    },
    use_actions = {
        {
            kind = "delayed_transform",
            target = "mag_awoken_weaver",
            moves = 50,
            need_charges = 300,
            age = 432000,
            message = "The %s awakens.  It gazes at you with its many eyes, ready to serve you.",
            need_charges_message = "The weaver does not have enough liquid.",
            not_ready_message = "The weaver isn't done growing yet.",
        },
        {
            kind = "repair_item",
            id = "repair_fabric",
            skill = "tailor",
            tool_quality = 1,
            move_cost = 500,
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
                "black_dragon_hide",
            },
        },
    },
    tool = { crafting_subtype = "sewing_kit" },
    armor = {},
    subtype_order = { "tool", "armor" },
    inheritance = {
        add = {
            flags = { "SPAWN_ACTIVE" },
            qualities = {
                { id = "CUT", level = 2 },
                { id = "FABRIC_CUT", level = 2 },
            },
        },
    },
}

ccb.content.define_item {
    id = "mag_awoken_weaver",
    copy_from = "mag_adult_weaver",
    name = "awoken wildwood weaver",
    description = "You never thought you'd see the day when a wildwood entity would be so playful and docile.  This weaver is ready to serve you, and can be used to repair clothing or create a shelter.",
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            watertight = true,
            ammunition = { mag_awakened_water = 250 },
        },
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
                "black_dragon_hide",
                "demon_chitin",
            },
        },
        "PLAY_GAME",
    },
    tool = { charges_per_use = 1, crafting_subtype = "sewing_kit" },
    armor = {},
    artifact = {
        enchantments = { "ITEM_ENCH_Magiclysm_mag_awoken_weaver_0" },
    },
    subtype_order = { "tool", "armor", "artifact" },
}
