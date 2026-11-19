local ccb = require("ccb")

-- Sturmpistole meets express gun, basically.
ccb.content.define_item {
    id = "brogyeki",
    looks_like = "m79",
    name = ccb.content.text("Exodii hand mortar"),
    description = ccb.content.text("Originating from big game express smoothbores and heavy fowling pieces adapted for wallguns, the Brogyeki '23 is an over/under break action 'pistol' that is (unfortunately?) capable of launching its original 27.3x110 Diyua express slug and shot loads as well as the wide array of payloads in 27.3x44 Diyua.  A simple wire stock collapses neatly along its octagonal barrels, which feature a combination of sighting devices necessary for launching its numerous loads, in addition to the usual Exodii retrofits.  Unless you are a quadrupedal cyborg with this gun in a shock absorbing mount, recoil with the 27.3x110 Diyua shells will be *stout*."),
    mass = "2900 g",
    volume = "1775 ml",
    length = "428 mm",
    price = "8 kUSD 500 USD",
    survival_price = "28 USD",
    variant_kind = "gun",
    variants = {
        {
            id = "Brogyeki",
            name = ccb.content.text("Brogyeki '23 hand mortar"),
            description = ccb.content.text("Originating from big game express smoothbores and heavy fowling pieces adapted for wallguns, the Brogyeki '23 is an over/under break action 'pistol' that is (unfortunately?) capable of launching its original 27.3x110 Diyua express slug and shot loads as well as the wide array of payloads in 27.3x44 Diyua.  A simple wire stock collapses neatly along its octagonal barrels, which feature a combination of sighting devices necessary for launching its numerous loads, in addition to the usual Exodii retrofits.  Unless you are a quadrupedal cyborg with this gun in a shock absorbing mount, recoil with the 27.3x110 Diyua shells will be *stout*."),
            weight = 1,
        },
    },
    accuracy = -3,
    materials = { "qt_steel", "aluminum" },
    symbol = "(",
    color = "light_gray",
    faults = {
        { fault = "fault_gun_blackpowder" },
        { fault = "fault_gun_dirt" },
        { fault = "fault_gun_chamber_spent" },
    },
    pockets = {
        {
            kind = "MAGAZINE",
            magazine_well = "61 ml",
            ammunition = { ["273x110"] = 2, ["273x44"] = 2, ["273x44RG"] = 1 },
        },
    },
    flags = { "NEVER_JAMS", "RELOAD_EJECT", "RELOAD_ONE", "EASY_CLEAN", "SINGLE_ACTION" },
    melee_damage = { bash = 6 },
    gun = {
        barrel_length = "212 mm",
        skill = "shotgun",
        ammunition = { "273x44", "273x110", "273x44RG" },
        dispersion = 350,
        durability = 9,
        blackpowder_tolerance = 120,
        clip_size = 1,
        handling = 20,
        reload_time = 140,
        mod_locations = { { id = "stock", count = 1 }, { id = "sling", count = 1 } },
        default_mods = { "wire_stock" },
    },
}

-- Expressgun meets puntgun/wall gun.  Based on an H&H 4 bore shotgun.
ccb.content.define_item {
    id = "brogyaga",
    copy_from = "gun_base_rifle_manual",
    looks_like = "trexgun",
    name = ccb.content.text("Exodii express gun"),
    description = ccb.content.text("An over/under fowling piece with a long barrel, Brogyaga were favored for their versatility in taking large game and fowl with their 27.3x110 Diyua shells.  They would be pressed into combat during two global conflicts, initially as 'light' wall guns, and later as the downsized and down-loaded Brogyeki '23, before being brought along by the Exodii to dimensions unknown.  Though unwieldy in combat as either a primary or secondary, Brogyaga serve as useful parts donors for Brogyeki counterparts, fantastic pieces for the occasional hunting party, and popular trade goods for the locals."),
    mass = "7700 g",
    volume = "2980 ml",
    length = "110 cm",
    price = "6 kUSD 600 USD",
    survival_price = "30 USD",
    variant_kind = "gun",
    variants = {
        {
            id = "Brogyaga",
            name = ccb.content.text("Brogyaga express gun"),
            description = ccb.content.text("An over/under fowling piece with a long barrel, Brogyaga were favored for their versatility in taking large game and fowl with their 27.3x110 Diyua shells.  They would be pressed into combat during two global conflicts, initially as 'light' wall guns, and later as the downsized and down-loaded Brogyeki '23, before being brought along by the Exodii to dimensions unknown.  Though unwieldy in combat as either a primary or secondary, Brogyaga serve as useful parts donors for Brogyeki counterparts, fantastic pieces for the occasional hunting party, and popular trade goods for the locals."),
            weight = 1,
        },
    },
    materials = { "qt_steel", "wood" },
    color = "dark_gray",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["273x110"] = 2, ["273x44"] = 2 } } },
    flags = { "NEVER_JAMS", "RELOAD_EJECT", "RELOAD_ONE", "EASY_CLEAN" },
    gun = {
        ammunition = { "273x44", "273x110", "273x44RG" },
        dispersion = 250,
        durability = 9,
        blackpowder_tolerance = 120,
        clip_size = 1,
        reload_time = 280,
        barrel_length = "1051 mm",
        barrel_volume = "934 ml",
        mod_locations = {
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 2 },
        },
    },
}

-- note for translators, its pronounced "Ka-hu-na-o-fa-aye" and doesn't actually mean anything, you can translate the syllables directly.
ccb.content.define_item {
    id = "khuunaofaai",
    copy_from = "m4_carlgustav",
    looks_like = "m202_flash",
    name = ccb.content.text("Exodii ordnance cannon"),
    description = ccb.content.text("An oddball in the Exodii's oddball selection of armaments - This robust, shoulder mounted weapons platform started life not as a weapon, but as a ceremonial firework cannon, mounted in droves atop of parade tanks the size of buildings by some globe spanning military culture.  Little of its original design remains under the retrofits and wear, with even its engravings worn down to nothing by time.  It finds its niche in disposing incoming hordes from large distances, helped by the variety of chemical payloads its been modified to fire."),
    mass = "8180 g",
    volume = "10360 ml",
    materials = { "qt_steel", "gold" },
    length = "1080 mm",
    survival_price = "125 USD",
    variant_kind = "gun",
    variants = {
        {
            id = "Khuunaofaai",
            name = ccb.content.text("Khuunäöfaai ordnance cannon"),
            description = ccb.content.text("An oddball in the Exodii's oddball selection of armaments - This robust, shoulder mounted weapons platform started life not as a weapon, but as a ceremonial firework cannon, mounted in droves atop of parade tanks the size of buildings by some globe spanning military culture.  Little of its original design remains under the retrofits and wear, with even its engravings worn down to nothing by time.  The Khuunäöfaai finds its niche in disposing incoming hordes from large distances, helped by the variety of chemical payloads its been modified to fire."),
            weight = 1,
        },
    },
    color = "red",
    flags = { "NEVER_JAMS", "NON_FOULING" },
    melee_damage = { bash = 12 },
    pockets = {
        {
            magazine_well = "1250 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "exodii_khuunaofaai_mag_firework", "exodii_khuunaofaai_mag_incendiary",
                "exodii_khuunaofaai_mag_corrosive", "exodii_khuunaofaai_mag_adhesive",
            },
        },
    },
    gun = {
        mod_locations = { { id = "sights_mount", count = 1 }, { id = "sling", count = 1 } },
        reload_noise_volume = 20,
        ammunition = {
            "khuunaofaai_payload",
            "khuunaofaai_payload_fire",
            "khuunaofaai_payload_acid",
            "khuunaofaai_payload_glue",
        },
    },
}
