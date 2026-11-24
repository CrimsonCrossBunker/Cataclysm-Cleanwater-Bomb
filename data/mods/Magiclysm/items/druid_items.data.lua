local ccb = require("ccb")

ccb.content.define_item {
    id = "mag_wildwood",
    abstract = true,
    name = ccb.content.plural_text("abstract wildwood doodad", "abstract wildwood doodads"),
    description = ccb.content.text("A generic wildwood doodad used"),
    materials = { "wood", "veggy" },
    symbol = "x",
    color = "light_green",
    max_worn = 1,
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { warmth = 0 },
}

ccb.content.define_item {
    id = "mag_awakened_water",
    name = ccb.content.plural_text("glowing awakened water", "glowing awakened water"),
    description = ccb.content.text("A nutrient-rich elixir for wildwood entities.  No longer fit for consumption."),
    category = "fuel",
    mass = "750 mg",
    volume = "200ml",
    price = "2 USD",
    survival_price = "20 cent",
    phase = "liquid",
    default_container = "bottle_gourd",
    materials = { "mag_awakened_water" },
    symbol = "=",
    color = "light_blue",
    stack_size = 20,
    ammunition = { count = 225, type = "mag_awakened_water" },
}

ccb.content.define_item {
    id = "mag_sealed_glowing_gourd",
    category = "clothing",
    name = ccb.content.plural_text("sealed glowing gourd", "sealed glowing gourd"),
    description = ccb.content.text("A gourd sealed with a druid's rune.  You may harvest the liquid inside when it is done brewing."),
    mass = "2125 g",
    volume = "2500 ml",
    materials = { "wood" },
    symbol = "6",
    color = "brown",
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "TRADER_AVOID" },
    armor = {
        portions = {
            {
                materials = { { id = "wood", coverage = 100, thickness = 2.0 } },
                encumbrance = 3,
                coverage = 8,
                covers = { "torso" },
                subparts = { "torso_hanging_front" },
            },
        },
    },
    use_actions = {
        {
            kind = "delayed_transform",
            target = "mag_awakened_water",
            message = ccb.content.text("The rune cracks as you open the gourd and collect the liquid."),
            container = "bottle_gourd",
            target_charges = 225,
            moves = 50,
            age = 28800,
            not_ready_message = ccb.content.text("The liquid isn't done brewing yet."),
        },
    },
}

ccb.content.define_item {
    id = "mag_immature_weaver",
    copy_from = "mag_wildwood",
    name = ccb.content.plural_text("immature wildwood weaver", "immature wildwood weavers"),
    description = ccb.content.text("This weaver is immature, it needs to be fed with awakened water to grow.  It attentively observes its surroundings."),
    mass = "50 g",
    volume = "125 ml",
    flags = {
        "AURA", "STURDY", "ONE_PER_LAYER", "WATER_FRIENDLY", "ALLOWS_NATURAL_ATTACKS", "OVERSIZE",
        "ALLOWS_REMOTE_USE", "PADDED",
    },
    qualities = {
        { id = "SEW", level = 4 },
        { id = "SEW_CURVED", level = 1 },
        { id = "KNIT", level = 1 },
        { id = "LEATHER_AWL", level = 2 },
    },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            watertight = true,
            ammunition = { mag_awakened_water = 350 },
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { crafting_subtype = "sewing_kit", ammo_types = { "mag_awakened_water" } },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
    use_actions = {
        {
            kind = "delayed_transform",
            target = "mag_adult_weaver",
            message = ccb.content.text("The %s matures.  Another pair of legs sharpen into blades for cutting fabric.  It still has some room to grow."),
            moves = 50,
            need_charges = 350,
            need_charges_message = ccb.content.text("The weaver does not have enough liquid."),
            age = 432000,
            not_ready_message = ccb.content.text("The weaver isn't done growing yet."),
        },
        {
            kind = "repair_item",
            id = "repair_fabric",
            materials = {
                "cotton", "leather", "lycra", "nylon", "wool", "fur", "faux_fur", "nomex", "kevlar",
                "kevlar_layered", "neoprene", "parabolan_wool", "gutskin", "canvas", "black_dragon_hide",
            },
            skill = "tailor",
            tool_quality = 1,
            cost_scaling = 0.1,
            move_cost = 700,
        },
    },
}

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
