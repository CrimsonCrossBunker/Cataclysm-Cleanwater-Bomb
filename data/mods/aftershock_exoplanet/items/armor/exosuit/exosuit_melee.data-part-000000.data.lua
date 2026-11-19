local ccb = require("ccb")

ccb.content.define_item {
    id = "heavy_drill",
    symbol = "=",
    color = "yellow",
    name = ccb.content.plural_text("heavy mining drill", "heavy mining drills"),
    description = ccb.content.text("This is a portable roadheader, designed to chew through the toughest rock with three carbide-tipped mining heads.  Heavy cables run from the module to a handheld trigger mechanism.  Currently inactive, it still makes a powerful blunt weapon."),
    mass = "45 kg",
    volume = "6 L",
    length = "90 cm",
    techniques = { "WBLOCK_2", "BRUTAL", "WIDE", "SWEEP" },
    qualities = { { id = "HAMMER", level = 2 }, { id = "DIG", level = 1 } },
    accuracy = { grip = "weapon", length = "long", surface = "any", balance = "clumsy" },
    materials = { "qt_steel", "carbide" },
    weapon_categories = { "MACES", "GREAT_HAMMERS" },
    flags = { "NONCONDUCTIVE", "DURABLE_MELEE", "REACH_ATTACK", "USE_UPS", "EXO_LARGE_GADGET" },
    category = "weapons",
    melee_damage = { bash = 50, cut = 5 },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        sided = true,
        portions = {
            {
                materials = {
                    { id = "qt_steel", coverage = 100, thickness = 10 },
                    { id = "carbide", coverage = 15, thickness = 5 },
                },
                covers = { "hand_l", "hand_r" },
                coverage = 100,
                encumbrance = 20,
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate the drill's motor."),
            target = "heavy_drill_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("There is not enough charge to activate the drill."),
        },
    },
}

ccb.content.define_item {
    id = "heavy_drill_on",
    copy_from = "heavy_drill",
    name = ccb.content.plural_text("heavy mining drill (on)", "heavy mining drills (on)"),
    description = ccb.content.text("This is a portable roadheader, designed to chew through the toughest rock.  Currently active, the drill heads are a blur."),
    qualities = { { id = "HAMMER", level = 1 }, { id = "DIG", level = 3 } },
    accuracy = { grip = "weapon", length = "long", surface = "every", balance = "clumsy" },
    revert_to = "heavy_drill",
    melee_damage = { bash = 50, cut = 25 },
    inheritance = { add = { flags = { "POWERED", "EXO_LARGE_GADGET", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "1500 mW" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "heavy_drill",
            message = ccb.content.text("You deactivate the drill."),
        },
    },
}
