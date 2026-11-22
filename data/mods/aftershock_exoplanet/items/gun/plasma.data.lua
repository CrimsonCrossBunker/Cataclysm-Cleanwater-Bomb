local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_makeshift_fusion_gun",
    name = ccb.content.plural_text("direct fusion gun", "direct fusion gun"),
    copy_from = "afs_plasma_base",
    looks_like = "plasma_gun",
    description = ccb.content.text("Exhaust from a salvaged starship engine is channeled through a series of magnetic coils and focused into a searing fan of plasma, creating a crude but effective short range weapon that can easily melt through most forms of armor.  Its makeshift nature and lack of proper cooling systems make it prone to overheating and catastrophic failure."),
    mass = "8500 g",
    volume = "6 L",
    length = "45 cm",
    price = "2 kUSD",
    survival_price = "2 kUSD",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            magazine_well = "120 ml",
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "afs_40g_plasma_civ" },
        },
    },
    faults = { { fault = "fault_overheat_explosion" }, { fault = "fault_overheat_venting" } },
    inheritance = {
        add = { flags = { "OVERHEATS" }, firing_effects = { "FUSION_FAN" } },
        remove = { firing_effects = { "PLASMA", "FLAME", "EMP", "EXPLOSIVE_SMALL" } },
    },
    gun = {
        range = 10,
        damage = { { type = "afs_plasma", amount = 10 } },
        modes = {
            { id = "DEFAULT", label = ccb.content.text("standard"), quantity = 3 },
            { id = "AUTO", label = ccb.content.text("unsafe auto-rpm"), rpm = 1500 },
        },
        ammunition = { "afs_shydrogen" },
        dispersion = 200,
        ammo_per_shot = 1,
        overheat_threshold = 30,
        cooling = 5,
        heat_per_shot = 9,
        recoil = 30,
        handling = 20,
        durability = 4,
        loudness = 0,
        reload_time = 1800,
    },
}

ccb.content.define_item {
    id = "afs_plasma_torch_gun",
    copy_from = "afs_plasma_base",
    name = ccb.content.plural_text("377-UASTA (weaponized)", "377-UASTA (weaponized)"),
    description = "A common modification for directed plasma torches that involves the installation of oversize capacitor banks and judiciously bypassed safety mechanisms, allowing them to function as a deadly if decidedly short-ranged weapons.  In most cases, the resulting \"gun\" can still perform its original metalworking functions, albeit at a much lower efficiency.\n\nUnlike purposefully made plasma weapons, the propelled plasma bottle won't cause a considerable explosion upon contact, allowing for relatively safe operation within enclosed spaces.",
    mass = "4200 g",
    volume = "4500 ml",
    length = "60 cm",
    price = "350 USD",
    survival_price = "350 USD",
    flags = {
        "ALLOWS_REMOTE_USE",
        "NEVER_JAMS",
        "NON_FOULING",
        "NEEDS_NO_LUBE",
        "OVERHEATS",
        "BELT_CLIP",
        "OVERHEATS",
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            capacity = "20 L",
            mass_limit = "20 kg",
            magazine_well = "120 ml",
            holster = true,
            allowed_items = { "afs_40g_plasma_civ" },
        },
    },
    faults = {
        { fault = "fault_overheat_melting" },
    },
    qualities = {
        { id = "WELD", level = 2 },
    },
    use_actions = { "OXYTORCH" },
    tool = {
        charges_per_use = 2,
        ammo_types = { "afs_shydrogen" },
    },
    gun = {
        skill = "launcher",
        range = 3,
        dispersion = 1500,
        recoil = 30,
        durability = 6,
        loudness = 5,
        reload_time = 2200,
        ammo_per_shot = 2,
        heat_per_shot = 27,
        cooling = 3,
        overheat_threshold = 100,
        damage = {
            { type = "afs_plasma", amount = 45 },
        },
        mod_locations = {
            { id = "sling", count = 1 },
        },
    },
    subtype_order = { "tool", "gun" },
    inheritance = {
        add = {
            firing_effects = { "DAZZLE_BEAM" },
        },
        remove = {
            firing_effects = { "FLAME", "EXPLOSIVE_SMALL" },
        },
    },
}
