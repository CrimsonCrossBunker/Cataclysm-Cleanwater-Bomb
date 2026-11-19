local ccb = require("ccb")

-- We're just going to pretend that .357 and .44 magnum deagles will run .38's and .44 special just fine
ccb.content.define_item {
    id = "pistol_magnum_automag",
    looks_like = "glock_17",
    name = ccb.content.text("hand cannon"),
    description = ccb.content.text("This large pistol is almost as heavy as a small carbine, and just about as powerful too.  Chambered in hard hitting magnum calibers, it is suitable for hunting medium game, humans, or offsetting any of one's perceived deficiencies.  Though traditionally such magnums are revolvers, this one is a magazine fed semi-automatic."),
    mass = "1700 g",
    volume = "617 ml",
    length = "29 cm",
    price = "875 USD",
    survival_price = "27 USD 50 cent",
    materials = { "steel", "plastic" },
    symbol = "(",
    color = "light_gray",
    flags = { "ALLOWS_BODY_BLOCK" },
    weapon_categories = { "AUTOMATIC_PISTOLS" },
    faults = {
        { fault = "fault_gun_blackpowder" },
        { fault = "fault_gun_dirt" },
        { fault = "fault_gun_chamber_spent" },
        { fault = "fault_fail_to_feed" },
        { fault = "fault_stovepipe" },
        { fault = "fault_double_feed" },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "pistol_mag", "pistol_magnum_mag" },
            rigid = true,
        },
    },
    melee_damage = { bash = 12 },
    gun = {
        reload_noise_volume = 10,
        barrel_length = "152 mm",
        ammunition = { "ammo_pistol", "ammo_pistol_magnum" },
        skill = "pistol",
        dispersion = 480,
        durability = 7,
        min_cycle_recoil = 1413,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "grip", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "stock", count = 1 },
            { id = "underbarrel", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "pistol_magnum_levergun",
    copy_from = "henry_big_boy",
    name = ccb.content.text("magnum levergun"),
    description = ccb.content.text("A modern re-imagining of the classic western lever-action, this larger rifle accepts powerful magnum pistol ammunition as well as weaker pistol ammo.  Carrying this along side a magnum pistol would allow one to reduce the number of calibers carried, and allow you to squeeze more power from ammunition."),
    pockets = {
        {
            kind = "MAGAZINE",
            ammunition = { ammo_pistol_magnum = 10, ammo_pistol = 10 },
            rigid = true,
        },
    },
    gun = { ammunition = { "ammo_pistol_magnum", "ammo_pistol" }, clip_size = 10 },
}

ccb.content.define_item {
    id = "pistol_magnum_pipe_levergun",
    copy_from = "henry_big_boy",
    name = ccb.content.text("handmade magnum carbine"),
    description = ccb.content.text("A crudely constructed carbine, chambered for magnum pistol ammo and standard pistol ammo.  It feeds from commercial magnum pistol magazines, and locks with a rudimentary lever-action system.  Its powerful cartridge and relative precision should serve well against zombies and medium game."),
    mass = "2114 g",
    volume = "2 L",
    price = "100 USD",
    color = "brown",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "pistol_mag", "pistol_magnum_mag" },
            rigid = true,
        },
    },
    melee_damage = { bash = 10 },
    gun = {
        ammunition = { "ammo_pistol_magnum", "ammo_pistol" },
        damage = { type = "bullet", amount = 0 },
        dispersion = 550,
        durability = 6,
        blackpowder_tolerance = 60,
        loudness = 25,
        barrel_volume = "250 ml",
        mod_locations = {
            { id = "muzzle", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock", count = 1 },
            { id = "grip mount", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "pistol_magnum_pipe",
    copy_from = "ashot",
    name = ccb.content.text("pipe magnum"),
    description = ccb.content.text("A firearm made from a stout pipe, reinforced at the chamber.  It holds a single a round of standard or magnum pistol ammunition, and has a crude assembly to fire it.  There's no extractor, so it might be slow to reload, and its construction makes for poor reliability and longevity."),
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { ammo_pistol = 1, ammo_pistol_magnum = 1 },
        },
    },
    gun = {
        ammunition = { "ammo_pistol_magnum", "ammo_pistol" },
        damage = { type = "bullet", amount = -2 },
        dispersion = 440,
        reload_time = 110,
    },
}

ccb.content.define_item {
    id = "pistol_magnum_revolver",
    copy_from = "sw629",
    name = ccb.content.text("hunting magnum"),
    description = ccb.content.text("Early handgun hunters helped develop this revolver's magnum ammunition from standard calibers, which needed heavier revolvers to safely fire it.  These revolvers' cylinders can thus chamber both magnum and standard pistol ammunition.  You could take medium to large game with this hefty piece."),
    pockets = {
        {
            kind = "MAGAZINE",
            holster = true,
            ammunition = { ammo_pistol_magnum = 6, ammo_pistol = 6 },
            rigid = true,
        },
    },
    gun = { ammunition = { "ammo_pistol_magnum", "ammo_pistol" }, clip_size = 6 },
}
