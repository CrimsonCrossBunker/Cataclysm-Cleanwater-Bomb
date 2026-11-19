local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "barb_launcher",
    symbol = "%",
    color = "red",
    name = ccb.content.text_without_extraction("barb launching organ"),
    description = ccb.content.text_without_extraction("A mutated organ capable of launching bony barbs at great speed."),
    materials = { "hflesh" },
    flags = {
        "PRIMITIVE_RANGED_WEAPON", "PSEUDO", "NEVER_JAMS", "NONCONDUCTIVE", "NO_REPAIR",
        "WATERPROOF_GUN", "NO_SALVAGE", "NO_UNLOAD", "RELOAD_AND_SHOOT",
    },
    mass = "540 g",
    volume = "750 ml",
    length = "25 cm",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { barb = 1 } } },
    melee_damage = { bash = 2 },
    gun = {
        skill = "pistol",
        ammunition = { "barb" },
        clip_size = 1,
        reload_noise_volume = 2,
        loudness = 2,
        range = 12,
        dispersion = 100,
        durability = 8,
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "emp_frond",
    symbol = "%",
    color = "red",
    name = ccb.content.text_without_extraction("electric alien frond"),
    description = ccb.content.text_without_extraction("Electricity unnaturally arcs from the tips of this alien frond."),
    materials = { "hflesh" },
    flags = {
        "PRIMITIVE_RANGED_WEAPON", "PSEUDO", "NEVER_JAMS", "NONCONDUCTIVE", "NO_REPAIR",
        "WATERPROOF_GUN", "NO_SALVAGE", "NO_UNLOAD", "NO_TURRET",
    },
    mass = "540 g",
    volume = "750 ml",
    length = "25 cm",
    accuracy = { grip = "solid", length = "hand", surface = "every", balance = "neutral" },
    melee_damage = { bash = 2 },
    gun = {
        skill = "pistol",
        effects = { "EMP", "LIGHTNING" },
        damage = { type = "electric", amount = 1 },
        reload_noise_volume = 2,
        loudness = 2,
        range = 12,
        dispersion = 150,
        durability = 8,
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "firework_cannon",
    symbol = "%",
    color = "red",
    name = ccb.content.text_without_extraction("fireworks cannon"),
    description = ccb.content.text_without_extraction("An autoloading fireworks launcher."),
    materials = { "steel" },
    flags = {
        "PRIMITIVE_RANGED_WEAPON", "PSEUDO", "NEVER_JAMS", "NONCONDUCTIVE", "NO_REPAIR",
        "WATERPROOF_GUN", "NO_SALVAGE", "NO_UNLOAD", "NO_TURRET",
    },
    mass = "540 g",
    volume = "750 ml",
    length = "25 cm",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "neutral" },
    melee_damage = { bash = 2 },
    gun = {
        skill = "launcher",
        effects = { "SMOKE", "FLASHBANG" },
        damage = { type = "bash", amount = 1 },
        reload_noise_volume = 2,
        loudness = 50,
        range = 12,
        dispersion = 400,
        durability = 8,
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "gene_sting_gun",
    symbol = "%",
    color = "red",
    name = ccb.content.text_without_extraction("viscous barb launcher"),
    description = ccb.content.text_without_extraction("A mutated organ capable of launching bony barbs at great speed."),
    materials = { "hflesh" },
    flags = {
        "PRIMITIVE_RANGED_WEAPON", "PSEUDO", "NEVER_JAMS", "NONCONDUCTIVE", "NO_REPAIR",
        "WATERPROOF_GUN", "NO_SALVAGE", "NO_UNLOAD", "RELOAD_AND_SHOOT",
    },
    mass = "540 g",
    volume = "750 ml",
    length = "25 cm",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { gene_sting = 100 } } },
    melee_damage = { bash = 2 },
    gun = {
        skill = "pistol",
        ammunition = { "gene_sting" },
        clip_size = 1,
        reload_noise_volume = 2,
        loudness = 2,
        range = 12,
        dispersion = 100,
        durability = 8,
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "feral_human_thrown_rock",
    symbol = "%",
    color = "red",
    name = ccb.content.text_without_extraction("hurled rubble"),
    description = ccb.content.text_without_extraction("Stone at the ready to crush that which isn't part of the blob."),
    materials = { "stone" },
    flags = {
        "PRIMITIVE_RANGED_WEAPON", "PSEUDO", "NEVER_JAMS", "NONCONDUCTIVE", "NO_REPAIR",
        "WATERPROOF_GUN", "NO_SALVAGE", "NO_UNLOAD", "NO_TURRET",
    },
    mass = "540 g",
    volume = "210 ml",
    length = "75 mm",
    accuracy = { grip = "solid", length = "hand", surface = "any", balance = "neutral" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            capacity = "200 L",
            mass_limit = "400 kg",
            max_item_length = "2000 m",
            ammunition = { rock = 5 },
        },
    },
    melee_damage = { bash = 2 },
    gun = {
        skill = "throw",
        ammunition = { "rock" },
        effects = { "NO_PENETRATE_OBSTACLES" },
        damage = { type = "bash", amount = -1 },
        clip_size = 1,
        loudness = 2,
        range = 6,
        dispersion = 975,
        durability = 8,
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "bone_dart_launcher",
    symbol = "%",
    color = "red",
    name = ccb.content.text_without_extraction("bone dart launching organ"),
    description = ccb.content.text_without_extraction("Bone dart launched from a netherum creature."),
    materials = { "cyber_bone" },
    flags = {
        "PRIMITIVE_RANGED_WEAPON", "PSEUDO", "NEVER_JAMS", "NONCONDUCTIVE", "NO_REPAIR",
        "WATERPROOF_GUN", "NO_SALVAGE", "NO_UNLOAD", "RELOAD_AND_SHOOT",
    },
    mass = "540 g",
    volume = "750 ml",
    length = "25 cm",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            capacity = "200 L",
            mass_limit = "400 kg",
            max_item_length = "2000 m",
            ammunition = { bone_dart = 20 },
        },
    },
    melee_damage = { bash = 2 },
    gun = {
        skill = "throw",
        ammunition = { "bone_dart" },
        clip_size = 1,
        reload_noise_volume = 2,
        loudness = 2,
        range = 8,
        dispersion = 130,
        durability = 8,
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "nether_huntsman_arm",
    symbol = "%",
    color = "red",
    name = ccb.content.text_without_extraction("huntsman appendage"),
    description = ccb.content.text_without_extraction("huntsman throwing appendage as a pseudo item."),
    materials = { "bone" },
    flags = {
        "PRIMITIVE_RANGED_WEAPON", "PSEUDO", "NEVER_JAMS", "NONCONDUCTIVE", "NO_REPAIR",
        "WATERPROOF_GUN", "NO_SALVAGE", "NO_TURRET", "RELOAD_AND_SHOOT",
    },
    mass = "12 kg",
    volume = "20000 ml",
    length = "1000 mm",
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            capacity = "1400 ml",
            mass_limit = "1200 g",
            max_item_length = "76 cm",
            ammunition = { nether_huntsman_javelin_ammo = 1 },
        },
    },
    gun = {
        skill = "throw",
        ammunition = { "nether_huntsman_javelin_ammo" },
        clip_size = 1,
        loudness = 0,
        range = 14,
        dispersion = 150,
        durability = 8,
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "v29_turret",
    copy_from = "v29",
    name = ccb.content.text_without_extraction("mounted laser"),
    flags = { "PSEUDO", "NEVER_JAMS", "NO_UNLOAD", "NON_FOULING", "NEEDS_NO_LUBE", "NO_TURRET" },
    gun = { energy_drain = "0 kJ" },
}

-- NO_I18N
ccb.content.define_item {
    id = "yrax_deterrent_laser",
    copy_from = "v29",
    name = ccb.content.text_without_extraction("deterrent laser weapon"),
    flags = { "PSEUDO", "NEVER_JAMS", "NO_UNLOAD", "NON_FOULING", "NEEDS_NO_LUBE", "NO_TURRET" },
    gun = {
        energy_drain = "0 kJ",
        effects = { "LASER" },
        damage = { type = "electric", amount = 10, penetration = 4 },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "civilian_cop_glock22",
    copy_from = "glock_22",
    looks_like = "glock_22",
    flags = { "PSEUDO" },
    name = ccb.content.text_without_extraction("Cops' Glock 22"),
    description = ccb.content.text_without_extraction("A gun carried by overconfident officer monsters, more inaccurate for balancing reasons."),
    gun = { dispersion = 960, durability = 5 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "civilian_glock19",
    copy_from = "glock_19",
    looks_like = "glock_19",
    flags = { "PSEUDO" },
    name = ccb.content.text_without_extraction("Fighters' Glock 19"),
    description = ccb.content.text_without_extraction("A gun carried by civilian monsters, more inaccurate for balancing reasons.  If you see this, it's a bug."),
    gun = { dispersion = 960, durability = 5 },
}

-- NO_I18N
-- A rifle carried by cop monsters, more inaccurate for balancing reasons.
ccb.content.define_item {
    id = "civilian_AR-15",
    copy_from = "modular_ar15",
    looks_like = "modular_ar15",
    flags = { "PSEUDO" },
    name = ccb.content.text_without_extraction("Cops' AR15"),
    pockets = { { magazine_well = "500 ml", kind = "MAGAZINE_WELL", allowed_items = { "stanag30" } } },
    gun = { ammunition = { "223" }, dispersion = 960, durability = 5 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "acid_spit",
    copy_from = "fake_item",
    name = ccb.content.text_without_extraction("acid spit gun"),
    description = ccb.content.text_without_extraction("Fake gun that fires acid globs."),
    flags = { "PSEUDO", "NEVER_JAMS", "NO_TURRET" },
    materials = { "flesh" },
    gun = {
        effects = { "BLINDS_EYES", "NO_DAMAGE_SCALING", "NO_PENETRATE_OBSTACLES" },
        skill = "rifle",
        durability = 10,
        range = 100,
        dispersion = 1000,
        damage = { type = "acid", amount = 4 },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "acid_spray",
    copy_from = "fake_item",
    name = ccb.content.text_without_extraction("acid dart volley"),
    description = ccb.content.text_without_extraction("Fake gun that fires acid globs."),
    flags = { "NEVER_JAMS", "NO_TURRET", "PSEUDO" },
    materials = { "flesh" },
    gun = {
        modes = { { id = "DEFAULT", label = ccb.content.text("auto"), quantity = 3 } },
        effects = { "BLINDS_EYES", "NO_PENETRATE_OBSTACLES", "NO_DAMAGE_SCALING" },
        skill = "rifle",
        durability = 10,
        range = 100,
        dispersion = 5000,
        damage = { { type = "acid", amount = 3 }, { type = "stab", amount = 8, armor_multiplier = 0.8 } },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "acid_sniper",
    copy_from = "fake_item",
    name = ccb.content.text_without_extraction("acid dart gun"),
    description = ccb.content.text_without_extraction("Fake gun that fires acid globs."),
    flags = { "NEVER_JAMS", "NO_TURRET", "PSEUDO" },
    materials = { "flesh" },
    gun = {
        effects = { "BLINDS_EYES", "NO_PENETRATE_OBSTACLES", "NO_DAMAGE_SCALING" },
        skill = "rifle",
        durability = 10,
        range = 100,
        dispersion = 500,
        damage = { { type = "acid", amount = 3 }, { type = "stab", amount = 6 } },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "migo_bio_gun",
    copy_from = "fake_item",
    name = ccb.content.text_without_extraction("mi-go bio-gun"),
    description = ccb.content.text_without_extraction("Fake gun that fires some sort of solidified organic matter at very high speed by unknown means of propulsion."),
    flags = { "NEVER_JAMS", "NO_TURRET", "PSEUDO" },
    materials = { "flesh" },
    gun = {
        effects = { "NO_PENETRATE_OBSTACLES" },
        skill = "rifle",
        durability = 10,
        range = 100,
        dispersion = 1000,
        damage = { type = "stab", amount = 30 },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "boomer_head",
    copy_from = "fake_item",
    name = ccb.content.text_without_extraction("boomer head"),
    description = ccb.content.text_without_extraction("The head of a boomer, if you see this item it's a bug."),
    materials = { "flesh" },
    flags = { "NEVER_JAMS", "NON_FOULING", "NO_TURRET" },
    pockets = { { kind = "MAGAZINE", ammunition = { bile = 1000 }, watertight = true } },
    melee_damage = { bash = 9 },
    gun = {
        reload_noise = ccb.content.text("slosh."),
        effects = { "NO_PENETRATE_OBSTACLES", "LIQUID" },
        ammunition = { "bile" },
        skill = "rifle",
        dispersion = 300,
        durability = 10,
        range = 10,
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "nl_destruction_ray",
    copy_from = "v29",
    name = ccb.content.text_without_extraction("destruction ray"),
    flags = { "PSEUDO", "NEVER_JAMS", "NO_UNLOAD", "NON_FOULING", "NEEDS_NO_LUBE", "NO_TURRET" },
    gun = {
        energy_drain = "0 kJ",
        effects = { "NL_DESTRUCTION_RAY" },
        damage = { type = "bash", amount = 15, penetration = 10 },
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "nl_turret_chem_thrower",
    copy_from = "v29",
    name = ccb.content.text_without_extraction("chem thrower"),
    flags = { "PSEUDO", "NEVER_JAMS", "NO_UNLOAD", "NON_FOULING", "NEEDS_NO_LUBE", "NO_TURRET" },
    gun = {
        energy_drain = "0 kJ",
        effects = { "LASER" },
        dispersion = 2000,
        damage = { type = "acid", amount = 6, penetration = 0 },
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "nl_turret_phase_goo_thrower",
    copy_from = "v29",
    name = ccb.content.text_without_extraction("phase alternator"),
    flags = { "PSEUDO", "NEVER_JAMS", "NO_UNLOAD", "NON_FOULING", "NEEDS_NO_LUBE", "NO_TURRET" },
    gun = {
        energy_drain = "0 kJ",
        effects = { "NL_PHASE_GOO" },
        damage = { type = "pure", amount = 1, penetration = 0 },
    },
}
