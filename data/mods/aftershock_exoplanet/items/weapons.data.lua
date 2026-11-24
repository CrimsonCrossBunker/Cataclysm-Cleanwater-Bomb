local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_hardlight_longbow",
    symbol = "(",
    looks_like = "recurbow",
    color = "white",
    name = ccb.content.text("Alien lune"),
    description = ccb.content.text("A delicate strand of light links the antipodes of this crescent-shaped device.  If the strand is interrupted, the device clanks and shudders before violently emitting a bolt of plasma from its apex."),
    price = "10 kUSD",
    survival_price = "200 USD",
    materials = { "superalloy", "qt_steel" },
    flags = { "FIRE_TWOHAND", "STR_DRAW", "SLOW_WIELD", "WATERPROOF_GUN", "NEVER_JAMS" },
    min_strength = 4,
    mass = "500 g",
    volume = "2700 ml",
    length = "90 cm",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "alien_battery" },
        },
    },
    melee_damage = { bash = 8 },
    gun = {
        skill = "archery",
        reload_noise_volume = 0,
        loudness = 0,
        damage = { type = "heat", amount = 50, penetration = 15 },
        ammunition = { "battery" },
        ammo_per_shot = 0,
        energy_drain = "900 kJ",
        effects = { "LOW_RANGE_VAPORIZATION" },
        range = 30,
        dispersion = 80,
        durability = 6,
        reload_time = 50,
    },
}

ccb.content.define_item {
    id = "afs_hydraulic_gauntlet",
    name = ccb.content.text("hydraulic gauntlet"),
    description = ccb.content.text("A huge, heavy metal gauntlet lined with tubing and gauges.  Slow and unwieldy, it uses internal pressure to deliver devastating blows, but takes tremendous strength to use effectively.  Thanks to an internal microreactor, it doesn't require power of its own."),
    mass = "3778 g",
    volume = "2 L",
    price = "100 kUSD",
    survival_price = "200 USD",
    materials = { "qt_steel" },
    symbol = "[",
    looks_like = "gauntlets_chitin",
    color = "light_gray",
    flags = { "NO_REPAIR", "NONCONDUCTIVE", "SLOW_WIELD", "DURABLE_MELEE", "LEAK_DAM" },
    techniques = { "BRUTAL", "AFS_PRESSURE_CRUNCH" },
    melee_damage = { bash = 50 },
    armor = { portions = { { encumbrance = 5, coverage = 100, covers = { "hand_r" } } } },
}

ccb.content.define_item {
    id = "afs_freeze_gauntlet",
    name = ccb.content.plural_text("psychrophile handling gloves", "psychrophile handling gloves"),
    description = ccb.content.text("These gloves are designed for handling organisms that live in extremely cold temperatures.  They can also be used to freeze your foes to death."),
    mass = "3778 g",
    volume = "2 L",
    price = "100 kUSD",
    survival_price = "200 USD",
    materials = { "superalloy" },
    symbol = "[",
    looks_like = "gauntlets_chitin",
    color = "light_cyan",
    accuracy = 0,
    flags = { "NO_REPAIR", "NONCONDUCTIVE", "SLOW_WIELD", "DURABLE_MELEE" },
    techniques = { "WBLOCK_1" },
    melee_damage = { bash = 3 },
    subtype_order = { "armor", "artifact" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 5, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
    artifact = { enchantments = { "ITEM_ENCH_aftershock_exoplanet_afs_freeze_gauntlet_0" } },
}

ccb.content.define_item {
    id = "afs_bionic_rocket",
    name = ccb.content.text("deployed grenade launcher"),
    description = ccb.content.text("A grenade launcher mounted onto your right-hand wrist.  Less powerful than a proper grenade launcher, but infinitely more portable, and quick to reload."),
    volume = "2250 ml",
    price = "0 cent",
    materials = { "steel", "plastic" },
    symbol = "(",
    looks_like = "bio_int_enhancer",
    color = "magenta",
    flags = { "NEVER_JAMS", "BIONIC_WEAPON", "TRADER_AVOID", "ZERO_WEIGHT" },
    pockets = { { kind = "MAGAZINE", ammunition = { ["40x46mm"] = 1 } } },
    melee_damage = { bash = 9 },
    gun = {
        skill = "launcher",
        ammunition = { "40x46mm" },
        dispersion = 290,
        durability = 6,
        clip_size = 1,
        reload_time = 150,
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "TANK",
    looks_like = "m79",
    symbol = "(",
    color = "green",
    name = ccb.content.text_without_extraction("Tankbot Main Gun", "Tankbot Main Gun"),
    description = ccb.content.text_without_extraction("The 120mm cannon from a tankbot.  If you have this, you'd best be debugging!"),
    price = "999 kUSD 999 USD 99 cent",
    materials = { "steel" },
    mass = "2500 g",
    volume = "2500 ml",
    accuracy = -3,
    flags = { "NO_TURRET" },
    pockets = { { kind = "MAGAZINE", ammunition = { ["120mm"] = 1 } } },
    melee_damage = { bash = 6 },
    gun = {
        skill = "launcher",
        ammunition = { "120mm" },
        dispersion = 60,
        durability = 9,
        clip_size = 1,
        loudness = 300,
    },
}

ccb.content.define_item {
    id = "azabow_off",
    copy_from = "compbow",
    name = "Aztlani bow",
    description = "An ornate bow used by Aztlani nobility during hunting rituals.  Designed to fell the plated creatures of Aztlan, its articulated and power assisted limbs allow it to fire projectiles with a strength comparable to modern assault rifles.\n\nWith its drawing aid system currently disabled, firing it will require truly superhuman strength.  It can be activated to toggle it drawing assist functionality.",
    symbol = "(",
    color = "white",
    price = "500 USD",
    survival_price = "400 USD",
    min_strength = 40,
    materials = { "superalloy", "qt_steel", "wood" },
    use_actions = {
        {
            kind = "transform",
            target = "azabow_on",
            ammo_scale = 0,
            message = "You connect the bow to your UPS.",
            menu_text = "Activate",
        },
    },
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 5,
                encumbrance = 20,
                materials = {
                    { id = "superalloy", thickness = 1.0, coverage = 100 },
                    { id = "qt_steel", thickness = 1.0, coverage = 100 },
                    { id = "wood", thickness = 1.0, coverage = 100 },
                },
            },
        },
    },
    gun = {
        range = 25,
        dispersion = 1000,
        clip_size = 1,
        damage = { type = "stab", amount = 17 },
    },
    subtype_order = { "armor", "gun" },
}

ccb.content.define_item {
    id = "azabow_on",
    copy_from = "azabow_off",
    name = ccb.content.plural_text("Aztlani bow (active)", "Aztlani bows (active)"),
    description = "An ornate bow used by Aztlani nobility during hunting rituals.  Designed to fell the plated creatures of Aztlan, its articulated and power assisted limbs allow it to fire projectiles with a strength comparable to modern assault rifles.\n\nWith its drawing aid system enabled, it can be much more easily drawn, at the cost of a modest amount of UPS power consumption per arrow.  It can be activated to toggle it drawing assist functionality.",
    symbol = "(",
    color = "white",
    min_strength = 20,
    use_actions = {
        {
            kind = "transform",
            target = "azabow_off",
            ammo_scale = 0,
            message = "You disconnect the UPS.",
            menu_text = "Deactivate",
        },
    },
    gun = { energy_drain = "12 kJ" },
    inheritance = {
        add = {
            flags = { "USE_UPS" },
        },
    },
}

ccb.content.define_item {
    id = "scrapbow",
    copy_from = "compositebow",
    name = "salvage bow",
    description = "A bow made from readily-available materials, and quickly and cheaply put together.  It is not made to be pretty, but to get a job done.  Its nocks and string are made of shape-memory alloy that help increase string tension in the string.  The memory alloy requires a UPS source to be activated.",
    looks_like = "longbow",
    mass = "540 g",
    volume = "2500 ml",
    length = "152 cm",
    price = "380 USD",
    survival_price = "20 USD",
    materials = { "steel", "plastic" },
    melee_damage = { bash = 12 },
    pockets = {
        {
            kind = "MAGAZINE",
            open_container = true,
            ammunition = { arrow = 1 },
        },
    },
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 5,
                encumbrance = 20,
                materials = {
                    { id = "steel", thickness = 1.0, coverage = 100 },
                    { id = "plastic", thickness = 1.0, coverage = 100 },
                },
            },
        },
    },
    gun = {
        range = 14,
        dispersion = 850,
        durability = 6,
        energy_drain = "4 kJ",
        damage = { type = "stab", amount = 12 },
        mod_locations = {
            { id = "underbarrel", count = 1 },
            { id = "sights", count = 1 },
            { id = "stabilizer", count = 1 },
            { id = "dampening", count = 1 },
        },
    },
    subtype_order = { "armor", "gun" },
    inheritance = {
        add = {
            flags = { "USE_UPS" },
        },
    },
}

ccb.content.define_item {
    id = "scrapcrossbow",
    looks_like = "crossbow",
    symbol = "(",
    color = "green",
    name = ccb.content.text("salvage crossbow"),
    description = ccb.content.text("A crossbow constructed of readily available materials, and quickly and cheaply put together.  While it isn't very pretty, it gets the job done, and its drawing mechanism is motorized allowing quick reloading."),
    price = "2 kUSD",
    materials = { "steel", "plastic" },
    min_strength = 7,
    mass = "3000 g",
    volume = "1750 ml",
    length = "69 cm",
    survival_price = "60 USD",
    accuracy = 1,
    pockets = { { kind = "MAGAZINE", ammunition = { bolt = 1 } } },
    melee_damage = { bash = 11 },
    flags = { "USE_UPS" },
    gun = {
        reload_noise_volume = 4,
        skill = "rifle",
        ammunition = { "bolt" },
        energy_drain = "4 kJ",
        damage = { type = "stab", amount = 16 },
        range = 22,
        loudness = 12,
        dispersion = 325,
        durability = 6,
        clip_size = 1,
        reload_time = 900,
        mod_locations = {
            { id = "grip", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock", count = 1 },
            { id = "underbarrel", count = 1 },
            { id = "dampening", count = 1 },
        },
    },
}
