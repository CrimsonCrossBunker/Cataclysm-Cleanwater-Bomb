local ccb = require("ccb")

-- 84mm HE 441D RS. Ref:TC 3-22.84.  35494gr projectile traveling at 787.4fps.
ccb.content.define_item {
    id = "84x246mm_he",
    name = ccb.content.text("84x245mm HE"),
    price = "700 USD",
    survival_price = "120 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    symbol = "=",
    color = "dark_gray",
    description = ccb.content.text("An 84x245mm High Explosive anti-personnel cartridge for the Carl Gustaf M3 and other 84mm recoilless rifles.  Designed to be highly effective against personnel."),
    ascii_picture = "84x246mm_he",
    materials = { "steel", "powder" },
    volume = "2084 ml",
    length = "376 mm",
    mass = "3200 g",
    stack_size = 1,
    ammunition = {
        type = "84x246mm",
        damage = { type = "bullet", amount = 60, penetration = 10 },
        range = 120,
        dispersion = 60,
        recoil = 45,
        count = 4,
        effects = { "SPECIAL_COOKOFF", "EXPLOSIVE_84x246HE" },
    },
}

-- 84mm HEDP 502 RS.
ccb.content.define_item {
    id = "84x246mm_hedp",
    copy_from = "84x246mm_he",
    price = "700 USD",
    survival_price = "120 USD",
    name = ccb.content.text("84x245mm HEDP"),
    description = ccb.content.text("An 84x245mm High Explosive Dual Purpose anti-materiel cartridge for the Carl Gustaf M3 and other 84mm recoilless rifles.  Designed to be highly effective against vehicles and structures."),
    ascii_picture = "84x246mm_hedp",
    volume = "2422 ml",
    length = "437 mm",
    mass = "3300 g",
    ammunition = {
        damage = { type = "bullet", amount = 1200, penetration = 200 },
        range = 100,
        dispersion = 75,
        recoil = 60,
        effects = { "SPECIAL_COOKOFF", "EXPLOSIVE_84x246HEDP" },
    },
}

-- 84mm SMOKE 469C.  35340gr projectile traveling at 787.4 fps.
ccb.content.define_item {
    id = "84x246mm_smoke",
    copy_from = "84x246mm_he",
    name = ccb.content.text("84x245mm SMOKE"),
    price = "450 USD",
    survival_price = "120 USD",
    description = ccb.content.text("An 84x245mm smoke marker cartridge for the Carl Gustaf M3 and other 84mm recoilless rifles.  Commonly used for signaling, target designation, and for screening troop movements."),
    ascii_picture = "84x246mm_smoke",
    volume = "2422 ml",
    mass = "3100 g",
    length = "437 mm",
    inheritance = {
        add = { projectile_effects = { "SMOKE_BIG" } },
        remove = { projectile_effects = { "EXPLOSIVE_84x246HE" } },
    },
    ammunition = { range = 140, dispersion = 30 },
}
