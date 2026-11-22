local ccb = require("ccb")

ccb.content.define_item {
    id = "syringe",
    name = ccb.content.plural_text("jet injector", "jet injectors"),
    description = ccb.content.text("A compact jet injector from a first aid kit.  A light based assistive injection system allows use without any medical training."),
    mass = "4240 mg",
    volume = "10ml",
    length = "10 cm",
    accuracy = { grip = "none", length = "hand", surface = "point", balance = "neutral" },
    price = "2 USD",
    survival_price = "2 USD",
    materials = { "plastic" },
    symbol = ",",
    color = "white",
    flags = { "FRAGILE_MELEE" },
    melee_damage = { stab = 1 },
    tool = {},
}

ccb.content.define_item {
    id = "afs_internal_battery_compartment",
    name = ccb.content.plural_text("high-voltage battery compartment", "high-voltage battery compartments"),
    description = ccb.content.text("A battery slot installed in your upper torso, designed to power bionic implants.  Compatible with the power cartridges used by laser weaponry."),
    volume = "750 ml",
    mass = "1 g",
    price = "0 cent",
    materials = { "plastic" },
    symbol = "(",
    color = "magenta",
    flags = {
        "INTEGRATED", "UNBREAKABLE", "PERSONAL", "NO_REPAIR", "ALLOWS_NATURAL_ATTACKS",
        "BIONIC_FUEL_SOURCE", "SOFT", "TRADER_AVOID",
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "afs_cartridge", "afs_bootleg_cartridge", "afs_archeotech_cartridge" },
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = { "battery" } },
    armor = {},
}

ccb.content.define_item {
    id = "nano_forge",
    name = "folded nanotech forge",
    description = "Matrioshka Fabritechnics created this portable nanotech forge for when expeditions are setting up a basecamp far from population centers.  Once deployed it can be used to craft ultratech marvels that otherwise are too minute for human crafting.",
    symbol = "u",
    color = "light_green",
    category = "tools",
    looks_like = "forge",
    mass = "8464 g",
    volume = "11356 ml",
    price = "50 USD",
    survival_price = "450 USD",
    flags = { "DURABLE_MELEE", "HEAVY_TOOL" },
    materials = { "superalloy" },
    melee_damage = { bash = 5 },
    pockets = {
        {
            kind = "MAGAZINE",
            ammunition = { battery = 5000 },
        },
    },
    use_actions = {
        { kind = "deploy_furn", furn_type = "f_nano_forge" },
    },
    artifact = {
        charge = { recharge_type = "periodic", interval = "1 h", regenerate_ammo = true },
    },
}

ccb.content.define_item {
    id = "afs_cRTG",
    copy_from = "folding_solar_panel",
    name = "U-344 RTG",
    description = "A compact power source that employs the decay of transuranic elements to generate a small but constant amount of electricity and is commonly used in remote locations to power up equipment.  Must be integrated into a power grid before use.",
    symbol = "]",
    color = "light_green",
    mass = "17500 g",
    volume = "2 L",
    length = "30 cm",
    price = "5600 USD",
    survival_price = "5600 USD",
    materials = { "lead", "steel" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { battery = 1000 },
        },
    },
    use_actions = {
        { kind = "deploy_appliance", base = "afs_cRTG" },
    },
    artifact = {
        charge = { recharge_type = "periodic", interval = "5 m", regenerate_ammo = true },
    },
    inheritance = {
        add = {
            flags = { "RECHARGE", "NO_UNLOAD", "NO_RELOAD", "WATERPROOF", "LEAK_DAM", "RADIOACTIVE" },
        },
    },
}
