local ccb = require("ccb")

-- 100m backblast.
ccb.content.define_item {
    id = "m3_carlgustav",
    looks_like = "m79",
    symbol = "(",
    color = "green",
    name = ccb.content.text("M3 recoilless rifle"),
    description = ccb.content.text("Manufactured in Sweden, the Carl Gustaf M3 is a breech-loading 84 millimeter man-portable, reusable, multi-role recoilless rifle commonly used by the US military.  Under normal circumstances, users should refrain from shooting more than 6 rounds per day to avoid undue risk of brain injury…"),
    price = "13 kUSD",
    survival_price = "60 USD",
    materials = { "steel" },
    flags = { "RELOAD_ONE", "BACKBLAST", "NEVER_JAMS" },
    mass = "10 kg",
    length = "1065 mm",
    volume = "6730 ml",
    accuracy = -3,
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["84x246mm"] = 1 } } },
    melee_damage = { bash = 8 },
    gun = {
        reload_noise_volume = 10,
        skill = "launcher",
        ammunition = { "84x246mm" },
        dispersion = 300,
        durability = 8,
        clip_size = 1,
        reload_time = 300,
        loudness = 200,
        mod_locations = {
            { id = "sling", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights", count = 1 },
        },
    },
}

-- This is called the Carl Gustaf M4 everywhere but in the U.S. It is the lighter and more portable version of the Carl Gustaf, with Picatinny rails, programmable ammunition, etc.
ccb.content.define_item {
    id = "m4_carlgustav",
    copy_from = "m3_carlgustav",
    name = ccb.content.text("M3E1 recoilless rifle"),
    description = ccb.content.text("The Carl Gustaf M3E1 is a breech-loading 84 millimeter man-portable, reusable, multi-role recoilless rifle.  This is a shorter, lighter, and more advanced development of the M3.  Under normal circumstances, users should refrain from shooting more than 6 rounds per day to prevent undue risk of brain injury…"),
    price = "20 kUSD",
    survival_price = "80 USD",
    materials = { "steel", "plastic" },
    mass = "6900 g",
    volume = "5730 ml",
    length = "1000 mm",
    gun = {
        mod_locations = {
            { id = "sling", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights", count = 1 },
            { id = "rail", count = 1 },
            { id = "underbarrel", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "AT4",
    copy_from = "m3_carlgustav",
    name = ccb.content.text("AT4"),
    description = ccb.content.text("A milspec recoilless rifle - an 84mm unguided, portable, single-shot recoilless smoothbore weapon used primarily by the US military."),
    materials = { "fiberglass" },
    mass = "6803 g",
    volume = "8670 ml",
    length = "1020 mm",
    price = "20 kUSD",
    survival_price = "60 USD",
    melee_damage = { bash = 4 },
    inheritance = {
        add = { flags = { "FIRE_TWOHAND", "NO_REPAIR", "NO_RELOAD", "NO_UNLOAD" } },
        remove = { flags = { "RELOAD_ONE" } },
    },
    gun = {
        ammunition = { "84x246mm" },
        dispersion = 200,
        durability = 7,
        mod_locations = { { id = "sling", count = 1 }, { id = "sights mount", count = 1 } },
    },
}
