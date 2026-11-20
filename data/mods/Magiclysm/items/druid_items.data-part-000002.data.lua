local ccb = require("ccb")

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
