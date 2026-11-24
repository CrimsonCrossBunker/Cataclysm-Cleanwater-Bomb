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

ccb.content.define_item {
    id = "exosuit_claw",
    name = ccb.content.plural_text("exosuit claws", "exosuit claws"),
    description = ccb.content.text("A pair of oversized and articulated hydraulic gauntlets with fingertips ending in cruel talons."),
    mass = "3 kg",
    volume = "300 ml",
    length = "50 cm",
    price = "11 USD",
    survival_price = "2 USD 50 cent",
    accuracy = { grip = "weapon", length = "hand", surface = "any", balance = "neutral" },
    materials = { "qt_steel" },
    symbol = "[",
    color = "light_gray",
    flags = { "WATER_FRIENDLY", "DURABLE_MELEE", "OVERSIZE", "OUTER", "EXO_MEDIUM_GADGET", "SPAWN_ACTIVE" },
    melee_damage = { bash = 50, cut = 10 },
    armor = {
        power_armor = true,
        portions = {
            {
                materials = {
                    { id = "qt_steel", coverage = 100, thickness = 2 },
                    { id = "superalloy", coverage = 25, thickness = 1.5 },
                },
                covers = { "hand_l", "hand_r" },
                coverage = 100,
                encumbrance = 5,
            },
        },
    },
}

ccb.content.define_item {
    id = "exosuit_plasma_torch",
    name = ccb.content.plural_text("392-UASTA plasma torch", "392-UASTA plasma torches"),
    description = ccb.content.text("One of the many versions of UASTA certified plasma torches, essentially a civilian plasma railgun used to deliver focused waves of plasma for precision welding or metal cutting.  This is a larger, more powerful model meant to be used by an exosuit for heavy engineering tasks.  Heavy cables run from the module to a handheld trigger mechanism."),
    mass = "8 kg",
    volume = "6500 ml",
    length = "80 cm",
    accuracy = { grip = "weapon", length = "short", surface = "point", balance = "good" },
    materials = { "qt_steel", "ceramic" },
    symbol = ";",
    color = "red",
    qualities = { { id = "WELD", level = 3 } },
    flags = { "ALLOWS_REMOTE_USE", "CANT_WEAR", "EXO_LARGE_GADGET", "FRAGILE_MELEE" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            magazine_well = "120 ml",
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "afs_40g_plasma_civ", "afs_4g_plasma" },
        },
    },
    melee_damage = { bash = 50, cut = 10 },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = { "afs_shydrogen" } },
    armor = {
        portions = {
            {
                materials = {
                    { id = "qt_steel", coverage = 100, thickness = 2 },
                    { id = "superalloy", coverage = 25, thickness = 1.5 },
                },
                covers = { "hand_l", "hand_r" },
                coverage = 100,
                encumbrance = 15,
            },
        },
    },
    use_actions = { { kind = "cast_spell", spell = "exo_plasmacut", no_fail = true, level = 20 }, "OXYTORCH" },
}

ccb.content.define_item {
    id = "exosuit_power_cutter",
    name = ccb.content.plural_text("exosuit power cutter (off)", "exosuit power cutters (off)"),
    description = ccb.content.text("A huge, multi-fuel powered saw with a diamond blade, mounted on an exosuit.  If it has fuel, it can be turned on to turn it into a powerful metal cutting tool.  Heavy cables run from the module to a handheld trigger mechanism."),
    mass = "10 kg",
    volume = "4 L",
    accuracy = { grip = "weapon", length = "short", surface = "point", balance = "good" },
    materials = { "qt_steel", "diamond" },
    symbol = "/",
    looks_like = "circsaw_off",
    color = "light_red",
    pockets = {
        {
            kind = "MAGAZINE",
            description = ccb.content.text("This is a tank for fuel.  Holds up to 1 liter."),
            rigid = true,
            watertight = true,
            airtight = true,
            ammunition = {
                gasoline = 1000,
                diesel = 1000,
                jp8 = 1000,
                avgas = 1000,
                lamp_oil = 1000,
                motor_oil = 1000,
                propane = 1000,
                conc_alcohol = 1000,
                ammonia_liquid = 1000,
            },
        },
    },
    flags = { "ALWAYS_TWOHAND", "NONCONDUCTIVE", "EXO_LARGE_GADGET" },
    melee_damage = { bash = 10, cut = 5 },
    subtype_order = { "tool", "armor" },
    tool = {
        charges_per_use = 1,
        ammo_types = {
            "gasoline",
            "diesel",
            "jp8",
            "avgas",
            "lamp_oil",
            "motor_oil",
            "propane",
            "conc_alcohol",
            "ammonia_liquid",
        },
    },
    armor = {
        portions = {
            {
                materials = {
                    { id = "qt_steel", coverage = 100, thickness = 2 },
                    { id = "diamond", coverage = 5, thickness = 1 },
                },
                covers = { "hand_l", "hand_r" },
                coverage = 100,
                encumbrance = 30,
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "exosuit_power_cutter_on",
            message = ccb.content.text("You rev up the power cutter!"),
        },
    },
}
