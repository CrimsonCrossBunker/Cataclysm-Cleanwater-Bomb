local ccb = require("ccb")

-- It's not very advanced because it was made very quickly to provide working flamethrowers to a certain agency
ccb.content.define_item {
    id = "rm451_flamethrower",
    copy_from = "flamethrower",
    looks_like = "m79",
    name = ccb.content.text("DARPA flamethrower"),
    description = ccb.content.text("A modernized flamethrower, using alloy components and composite pressure tanks.  Despite having been replaced by the M202 FLASH, due to the questionable effectiveness of the flamethrower in modern combat, it appears that someone, somewhere, needed a flamethrower for the modern age, as the date code on many of the components is within the past five years.  While this resembles the Vietnam War era M9-7, the wand ignition system has been improved with a piezoelectric one, in addition to the material improvements of the system overall."),
    price = "9 kUSD 700 USD",
    survival_price = "100 USD",
    materials = { "aluminum", "carbonfiber" },
    inheritance = { scale = { mass = 0.66 } },
    gun = {
        range = 10,
        mod_locations = {
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "flamethrower",
    name = "M9-7 flamethrower",
    description = "A large flamethrower with substantial gas reserves.  The steel frame, with canvas accoutrements and aluminum cylinders, are all colored olive drab, like so many other pieces of equipment from the Vietnam War era.",
    symbol = "(",
    color = "light_gray",
    looks_like = "m79",
    mass = "11340 g",
    volume = "69450 ml",
    length = "584 mm",
    price = "800 USD",
    survival_price = "60 USD",
    max_worn = 1,
    flags = { "NEVER_JAMS", "FIRESTARTER", "BELTED", "PRIMITIVE_RANGED_WEAPON", "IS_ARMOR" },
    melee_damage = { bash = 10 },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            magazine_well = "1196 ml",
            rigid = false,
            allowed_items = { "pressurized_tank", "pressurized_tank_modern" },
        },
    },
    faults = {},
    use_actions = {
        { kind = "firestarter" },
    },
    armor = {
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
                coverage = 80,
                volume_encumbrance = 0.2307,
                encumbrance = { 0, 60 },
                materials = {
                    { id = "steel", thickness = 2, coverage = 40 },
                    { id = "aluminum", thickness = 2, coverage = 100 },
                },
            },
        },
    },
    gun = {
        skill = "launcher",
        ammunition = { "flammable" },
        range = 6,
        dispersion = 300,
        durability = 8,
        reload_time = 4,
        effects = { "FLARE" },
        ammo_per_shot = 100,
        modes = {
            { id = "DEFAULT", label = "Jet", quantity = 1 },
            { id = "AUTO", label = "Gout", quantity = 4 },
        },
        mod_locations = {
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
    subtype_order = { "armor", "gun" },
}
