local ccb = require("ccb")

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
