local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "renfield_glock",
    copy_from = "gun_base_9mm_semi_pistol",
    looks_like = "glock_19",
    name = ccb.content.text_without_extraction("Glock 19", "Glock 19"),
    description = ccb.content.text_without_extraction("A poorly maintained and inaccurate version of the Glock 19 for renfields."),
    ascii_picture = "glock_19",
    mass = "600 g",
    volume = "386 ml",
    length = "211 mm",
    price = "650 USD",
    survival_price = "25 USD",
    materials = { "steel", "aluminum" },
    pockets = {
        {
            magazine_well = "250 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "glockmag",
                "glockbigmag",
                "glock17_17",
                "glock17_22",
                "glock_drum_50rd",
                "glock_drum_100rd",
            },
        },
    },
    gun = { damage = { type = "bullet", amount = -4 }, range = 1, dispersion = 4800, durability = 7 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "renfield_remington",
    symbol = "R",
    color = "dark_gray",
    name = ccb.content.text_without_extraction("renfield Remington", "renfield Remington"),
    description = ccb.content.text_without_extraction("A fake shotgun for renfields (because monster aiming is too lethal)."),
    materials = { "steel", "aluminum", "plastic" },
    flags = { "NONCONDUCTIVE", "NO_REPAIR", "NO_SALVAGE", "NO_UNLOAD", "RELOAD_AND_SHOOT" },
    mass = "3400 g",
    volume = "2487 ml",
    length = "1234 mm",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { shot = 5 } } },
    melee_damage = { bash = 3 },
    gun = {
        skill = "shotgun",
        ammunition = { "shot" },
        clip_size = 5,
        dispersion = 3250,
        range = 65,
        durability = 9,
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "feral_57",
    copy_from = "gun_base_57_semi_pistol",
    looks_like = "fn57",
    name = ccb.content.text_without_extraction("FN Five-seveN", "FN Five-seveN"),
    description = ccb.content.text_without_extraction("A poorly maintained and inaccurate version of the Five-seveN for feral agents."),
    ascii_picture = "FN_five_seven",
    mass = "600 g",
    volume = "551 ml",
    length = "164 mm",
    price = "650 USD",
    survival_price = "25 USD",
    materials = { "steel", "aluminum" },
    pockets = { { magazine_well = "250 ml", kind = "MAGAZINE_WELL", allowed_items = { "fn57mag" } } },
    gun = { damage = { type = "bullet", amount = -5 }, range = 1, dispersion = 4800, durability = 7 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "feral_p90",
    looks_like = "hk_mp5",
    name = ccb.content.text_without_extraction("P90 automatic PDW"),
    description = ccb.content.text_without_extraction("A late 90s manufactured personal defense weapon (PDW), this automatic firearm fires the high-velocity, proprietary 5.7x28mm cartridge.  Making use of top-mounted 50-round custom magazines which lock into the receiver of the weapon behind the grip, this little submachine gun packs quite the nasty payload.  Its small, high-speed caliber makes it excellent at both defeating armored opponents and firing short bursts manageably."),
    mass = "2640 g",
    volume = "3817 ml",
    length = "511 mm",
    price = "3 kUSD 500 USD",
    survival_price = "35 USD",
    materials = { "steel", "plastic" },
    symbol = "(",
    color = "light_gray",
    faults = {
        { fault = "fault_gun_blackpowder" },
        { fault = "fault_gun_dirt" },
        { fault = "fault_gun_chamber_spent" },
        { fault = "fault_fail_to_feed" },
        { fault = "fault_stovepipe" },
        { fault = "fault_double_feed" },
    },
    pockets = { { magazine_well = "500 ml", kind = "MAGAZINE_WELL", allowed_items = { "fnp90mag" } } },
    melee_damage = { bash = 10 },
    gun = {
        reload_noise_volume = 10,
        barrel_length = "264 mm",
        damage = { type = "bullet", amount = -5 },
        range = 4,
        ammunition = { "57" },
        skill = "smg",
        dispersion = 4800,
        durability = 8,
        min_cycle_recoil = 81,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 900 },
        },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 2 },
        },
    },
}
