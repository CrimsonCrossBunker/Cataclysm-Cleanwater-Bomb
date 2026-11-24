local ccb = require("ccb")

ccb.content.define_item {
    id = "arrow_odin",
    price = "35 USD",
    name = ccb.content.text("orichalcum arrow"),
    symbol = "=",
    color = "white",
    looks_like = "arrow_fire_hardened_fletched",
    description = ccb.content.text("An arrow composed of a sliver of orichalcum.  The arrow has a mysterious glow.  Has a very high chance of staying intact when fired, however can only be fired from Ichaival."),
    materials = { "wood", "orichalcum_metal" },
    volume = "145 ml",
    mass = "30 g",
    stack_size = 15,
    melee_damage = { bash = 12 },
    ammunition = {
        type = "arrow_orichalcum",
        damage = { type = "stab", constant_damage_multiplier = 1.95, penetration = 20 },
        dispersion = 35,
        loudness = 0,
        range = 7,
        count = 15,
        critical_multiplier = 10,
        recovery_chance = 98,
    },
}

ccb.content.define_item {
    id = "arrow_druid_crafted",
    price = "250 USD",
    name = ccb.content.text("tangler arrow"),
    symbol = "=",
    color = "green",
    looks_like = "arrow_heavy_fire_hardened_fletched",
    description = ccb.content.text("An arrow with a fragment of a druid rune in the arrowhead.  It unleashes a storm of entangling vegetation when it strikes."),
    materials = { { id = "wood", portions = 81 }, { id = "steel", portions = 19 } },
    volume = "90 ml",
    survival_price = "1 USD",
    mass = "32 g",
    length = "76 cm",
    melee_damage = { bash = 3, cut = 1 },
    ammunition = {
        type = "arrow",
        damage = { type = "stab", constant_damage_multiplier = 1.45, penetration = 1 },
        dispersion = 110,
        loudness = 0,
        show_stats = true,
        critical_multiplier = 10,
        recovery_chance = 86,
        effects = { "TANGLE" },
    },
}

ccb.content.define_item {
    id = "arrow_stormshaper_crafted",
    copy_from = "arrow_druid_crafted",
    name = ccb.content.text("thunderclap arrow"),
    color = "magenta",
    description = ccb.content.text("An arrow with a fragment of a stormshaper rune in the arrowhead.  It trails lightning and explodes with a crash of thunder."),
    ammunition = { recovery_chance = 86, effects = { "LIGHTNING", "FLASHBANG" } },
}

ccb.content.define_item {
    id = "arrow_earthshaper_crafted",
    copy_from = "arrow_druid_crafted",
    name = ccb.content.text("avalanche arrow"),
    color = "light_gray",
    description = ccb.content.text("An arrow with a fragment of a earthshaper rune in the arrowhead.  It hits the target with the force of an avalanche."),
    ammunition = { effects = { "LARGE_BEANBAG", "RECOVER_7" } },
}

ccb.content.define_item {
    id = "arrow_kelvinist_crafted",
    copy_from = "arrow_druid_crafted",
    name = ccb.content.text("fireball arrow"),
    color = "red",
    description = ccb.content.text("An arrow with a fragment of a kelvinist rune in the arrowhead.  It explodes into a firestorm."),
    ammunition = { recovery_chance = 86, effects = { "NAPALM" } },
}

ccb.content.define_item {
    id = "arrow_biomancer_crafted",
    copy_from = "arrow_druid_crafted",
    name = ccb.content.text("visceral arrow"),
    color = "green",
    materials = { "bone" },
    description = ccb.content.text("A disturbing bone arrow with a fragment of a biomancer rune in the arrowhead.  It showers its target in acid."),
    ammunition = { recovery_chance = 86, effects = { "ACIDBOMB" } },
}

ccb.content.define_item {
    id = "arrow_technomancer_crafted",
    copy_from = "arrow_druid_crafted",
    name = ccb.content.text("sparking arrow"),
    color = "white",
    description = ccb.content.text("A metallic arrow with a fragment of a technomancer rune in the arrowhead.  It destroys electronic targets."),
    ammunition = { recovery_chance = 86, effects = { "EMP", "DRAW_LASER_BEAM" } },
}

-- I'd like this to cause massive knockback but I'm limited by the available ammo flags.
ccb.content.define_item {
    id = "arrow_magus_crafted",
    copy_from = "arrow_druid_crafted",
    name = ccb.content.text("gravity arrow"),
    color = "dark_gray",
    description = ccb.content.text("An arrow with a fragment of a magus rune in the arrowhead.  It reverses flight briefly after striking its target and then hits another one."),
    ammunition = { recovery_chance = 86, effects = { "BOUNCE" } },
}

-- I'd like this to drain life but see above.
ccb.content.define_item {
    id = "arrow_animist_crafted",
    copy_from = "arrow_druid_crafted",
    name = ccb.content.text("enervating arrow"),
    color = "cyan",
    description = ccb.content.text("An arrow with a fragment of an animist rune in the arrowhead.  It unleashes a cloud of enervating gas."),
    ammunition = { recovery_chance = 86, effects = { "PARALYZEPOISON", "TOXICGAS" } },
}

ccb.content.define_item {
    id = "quiver_of_holding_plus_one",
    name = ccb.content.plural_text("quiver of holding +1", "quivers of holding +1"),
    description = ccb.content.text("A quiver enchanted to hold 40 arrows or bolts while not taking up any more space than a normal quiver.  Rarely made after the invention of firearms."),
    copy_from = "quiver",
    price = "500 USD",
    survival_price = "20 USD",
    looks_like = "quiver",
    pockets = {
        {
            ammunition = { arrow = 40, bolt = 40, arrow_orichalcum = 40 },
            weight_multiplier = 0.5,
            volume_multiplier = 0.5,
            moves = 20,
        },
    },
    armor = {
        portions = {
            {
                encumbrance = { 3, 11 },
                coverage = 25,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
    inheritance = { add = { flags = { "TARDIS" } } },
}

ccb.content.define_item {
    id = "quiver_of_holding_plus_two",
    name = ccb.content.plural_text("quiver of holding +2", "quivers of holding +2"),
    description = ccb.content.text("A quiver enchanted to hold 80 arrows or bolts while not taking up any more space than a normal quiver.  Rarely made after the invention of firearms."),
    copy_from = "quiver_of_holding_plus_one",
    pockets = {
        {
            ammunition = { arrow = 80, bolt = 80, arrow_orichalcum = 80 },
            weight_multiplier = 0.25,
            volume_multiplier = 0.25,
            moves = 20,
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "ichaival",
    name = "Ichaival",
    description = "Ichaival, the bow of Odin.  Rumored to fire 10 arrows with every pull of the string.  It has gold and silver ornaments on it, as well as an ornate Raven.",
    symbol = "(",
    color = "white",
    looks_like = "reflexrecurvebow",
    mass = "740 g",
    volume = "2 L",
    length = "150 cm",
    price = "1 kUSD 600 USD",
    min_strength = 10,
    flags = {
        "FIRE_TWOHAND",
        "STR_DRAW",
        "RELOAD_AND_SHOOT",
        "PRIMITIVE_RANGED_WEAPON",
        "BELTED",
        "WATER_FRIENDLY",
        "WATERPROOF_GUN",
        "NEVER_JAMS",
        "SHEATH_BOW",
    },
    materials = { "orichalcum_metal", "gold", "wood" },
    melee_damage = { bash = 14 },
    pockets = {
        {
            kind = "MAGAZINE",
            open_container = true,
            ammunition = { arrow_orichalcum = 1, arrow = 1 },
        },
    },
    armor = {
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
                coverage = 5,
                encumbrance = 14,
                materials = {
                    { id = "orichalcum_metal", thickness = 1.0, coverage = 100 },
                    { id = "gold", thickness = 1.0, coverage = 100 },
                    { id = "wood", thickness = 1.0, coverage = 100 },
                },
            },
        },
    },
    gun = {
        skill = "archery",
        ammunition = { "arrow_orichalcum", "arrow" },
        range = 20,
        dispersion = 95,
        durability = 6,
        loudness = 5,
        clip_size = 1,
        reload_time = 40,
        reload_noise_volume = 2,
        damage = { type = "stab", amount = 15 },
        mod_locations = {
            { id = "underbarrel", count = 1 },
            { id = "sights", count = 1 },
            { id = "stabilizer", count = 1 },
            { id = "dampening", count = 1 },
        },
    },
    subtype_order = { "armor", "gun" },
}
