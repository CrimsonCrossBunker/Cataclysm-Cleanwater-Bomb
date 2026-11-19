local ccb = require("ccb")

-- remove mac_10 variants
ccb.content.define_item {
    id = "mac_11",
    copy_from = "mac_10",
    looks_like = "hk_mp5",
    name = ccb.content.text("MAC-11 machine pistol"),
    description = ccb.content.text("A lesser known variant of the MAC-10, this machine pistol is chambered in .380 ACP for a smaller overall size while remaining inherently subsonic.  Smaller in almost every dimension, this inexpensive automatic weapon was declared 'fit only for combat in a phone booth' due to its low weight and absurd fire rate ranging from 1200 to 1400 rounds per minute."),
    variants = {},
    mass = "1590 g",
    volume = "754 ml",
    length = "253 mm",
    price = "1 kUSD 600 USD",
    survival_price = "25 USD",
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "mac11mag" } } },
    melee_damage = { bash = 5 },
    gun = {
        barrel_length = "129 mm",
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
        },
        ammunition = { "380" },
        min_cycle_recoil = 270,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 1200 },
        },
    },
}

ccb.content.define_item {
    id = "rugerlcp",
    copy_from = "gun_base_380_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("Ruger LCP pistol"),
    description = ccb.content.text("One of the best-selling modern day 'pocket pistols', the LCP is an affordable, polymer framed pistol chambered in .380 ACP.  Despite the round's relatively low power, the pistol's low weight and short sight radius make for moderately poor handling."),
    ascii_picture = "ruger_LCP",
    mass = "267 g",
    volume = "160 ml",
    length = "145 mm",
    price = "210 USD",
    materials = { "steel", "plastic" },
    pockets = { { magazine_well = "60 ml", kind = "MAGAZINE_WELL", allowed_items = { "rugerlcpmag" } } },
    gun = {
        barrel_length = "70 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "hptcf380",
    copy_from = "gun_base_380_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("Hi-Point CF-380 pistol"),
    description = ccb.content.text("The Hi-Point CF-380 is a blowback operated semi-automatic pistol designed by Hi-Point Firearms, which is known for making inexpensive firearms, and for making said firearms bulky and uncomfortable.  Hi-Points have slides made with a zinc pot-metal which is relatively fragile compared to steel slides."),
    mass = "820 g",
    volume = "478 ml",
    length = "200 mm",
    price = "75 USD",
    materials = { "plastic", "steel", "zinc" },
    pockets = {
        {
            magazine_well = "236 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "hptcf380mag_8rd", "hptcf380mag_10rd" },
        },
    },
    gun = {
        barrel_length = "89 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
        durability = 7,
    },
}

ccb.content.define_item {
    id = "hpt3895",
    looks_like = "modular_ar15",
    name = ccb.content.text(".380 ACP pistol-caliber carbine"),
    description = ccb.content.text("A pistol-caliber carbine chambered in .380 ACP.  It is more powerful and accurate than an equivalent pistol but the .380 ACP round is nonetheless fairly weak.  Accepts 10-round magazines, which are not shared with any .380 ACP pistol unlike many other similar pistol-caliber carbines."),
    variant_kind = "gun",
    variants = {
        {
            id = "hpt3895",
            name = ccb.content.text("Hi-Point 3895 carbine"),
            description = ccb.content.text("A pistol-caliber carbine chambered in .380 ACP, designed by Hi-Point Firearms.  Its 16.5\" barrel provides extra stopping power over an equivalent pistol, but .380 is still a relatively weak caliber.  Accepts 10-round magazines, which are notably not interchangeable with those of CF380 pistols."),
        },
    },
    mass = "2835 g",
    volume = "1881 ml",
    length = "787 mm",
    price = "315 USD",
    survival_price = "25 USD",
    accuracy = -1,
    symbol = "(",
    materials = { "plastic", "steel", "zinc" },
    color = "dark_gray",
    faults = {
        { fault = "fault_gun_blackpowder" },
        { fault = "fault_gun_dirt" },
        { fault = "fault_gun_chamber_spent" },
        { fault = "fault_fail_to_feed" },
        { fault = "fault_stovepipe" },
        { fault = "fault_double_feed" },
    },
    pockets = { { magazine_well = "236 ml", kind = "MAGAZINE_WELL", allowed_items = { "hpt3895mag_10rd" } } },
    melee_damage = { bash = 10 },
    gun = {
        barrel_length = "419 mm",
        range = 6,
        ammunition = { "380" },
        skill = "rifle",
        dispersion = 180,
        durability = 8,
        blackpowder_tolerance = 30,
        min_cycle_recoil = 270,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "swbodyguard",
    copy_from = "gun_base_380_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text(".380 conceal carry handgun"),
    description = ccb.content.text("A very small and lightweight handgun, firing the .380 ACP cartridge."),
    variant_kind = "gun",
    variants = {
        {
            id = "swbodyguard",
            name = ccb.content.text("S&W M&P Bodyguard"),
            description = ccb.content.text("A now-discontinued conceal carry gun, the S&W Bodyguard is a small and lightweight conceal carry gun, firing the .380 ACP cartridge.  Despite the short barrel and weak cartridge, it is still enough for self defense.  Even though it's discontinued, it still remains as a very popular firearm."),
        },
    },
    mass = "337 g",
    volume = "156 ml",
    length = "160 mm",
    price = "399 USD",
    materials = { "plastic", "steel" },
    pockets = { { magazine_well = "40 ml", kind = "MAGAZINE_WELL", allowed_items = { "swbodyguard_mag" } } },
    gun = {
        barrel_length = "70 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "glock_42",
    copy_from = "gun_base_380_semi_pistol",
    looks_like = "glock_19",
    name = ccb.content.text("Glock 42 pistol"),
    description = ccb.content.text("The smallest gun Glock produces, chambered in .380 ACP.  Even though it is small a small gun that shoots a weak cartridge, it is still effective against small game, paper targets, and zombified children."),
    mass = "345 g",
    volume = "234 ml",
    length = "151 mm",
    price = "420 USD",
    materials = { "plastic", "steel" },
    pockets = { { magazine_well = "60 ml", kind = "MAGAZINE_WELL", allowed_items = { "glock42_mag" } } },
    gun = {
        barrel_length = "83 mm",
        dispersion = 420,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}
