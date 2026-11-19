local ccb = require("ccb")

ccb.content.define_monster {
    id = "base_drone",
    abstract = true,
    name = ccb.content.plural_text("autonomous drone", "autonomous drones"),
    default_faction = "defense_bot",
    species = { "ROBOT_FLYING" },
    volume = "750 ml",
    mass = "1 kg",
    hp = 10,
    materials = { "steel" },
    symbol = "e",
    aggression = 100,
    morale = 100,
    luminance = 5,
    flags = {
        "SEES", "FLIES", "NOHEAD", "ELECTRONIC", "NO_BREATHE", "BIOLOGICALPROOF", "INTERIOR_AMMO",
        "STUN_IMMUNE", "PACIFIST",
    },
    death = {
        outcome = {
            message = ccb.content.text("The %s's interior compartment sizzles with destructive energy."),
            corpse = "BROKEN",
        },
    },
}

ccb.content.define_monster {
    id = "mon_EMP_hack",
    copy_from = "base_drone",
    name = ccb.content.plural_text("EMP hack", "EMP hacks"),
    description = ccb.content.text("An automated kamikaze drone, this small quadcopter robot appears to have an EMP grenade inside."),
    difficulty_adjustment = 5,
    speed = 250,
    color = "cyan",
    revert_item = "bot_EMP_hack",
    starting_ammo = { grenade_emp = 1 },
    attacks = { { reference = "KAMIKAZE", cooldown = 0 } },
    armor = { cut = 4, bullet = 3 },
}

ccb.content.define_monster {
    id = "mon_c4_hack",
    copy_from = "base_drone",
    name = ccb.content.plural_text("C-4 hack", "C-4 hacks"),
    description = ccb.content.text("An automated kamikaze drone, this small quadcopter robot appears to have some C-4 inside."),
    difficulty_adjustment = 20,
    speed = 250,
    color = "light_gray",
    revert_item = "bot_c4_hack",
    starting_ammo = { c4_payload = 1 },
    attacks = { { reference = "KAMIKAZE", cooldown = 0 } },
    armor = { cut = 4, bullet = 3 },
}

ccb.content.define_monster {
    id = "mon_flashbang_hack",
    copy_from = "base_drone",
    name = ccb.content.plural_text("flashbang hack", "flashbang hacks"),
    description = ccb.content.text("An automated kamikaze drone, this small quadcopter robot appears to have a flashbang inside."),
    difficulty_adjustment = 5,
    speed = 250,
    color = "dark_gray",
    revert_item = "bot_flashbang_hack",
    starting_ammo = { flashbang = 1 },
    attacks = { { reference = "KAMIKAZE", cooldown = 0 } },
    armor = { cut = 4, bullet = 3 },
}

ccb.content.define_monster {
    id = "mon_gasbomb_hack",
    copy_from = "base_drone",
    name = ccb.content.plural_text("tear gas hack", "tear gas hacks"),
    description = ccb.content.text("An automated kamikaze drone, this small quadcopter robot appears to have a tear gas canister inside."),
    difficulty_adjustment = 10,
    speed = 250,
    color = "dark_gray",
    revert_item = "bot_gasbomb_hack",
    starting_ammo = { tear_gas_payload = 1 },
    attacks = { { reference = "KAMIKAZE", cooldown = 0 } },
    armor = { cut = 4, bullet = 3 },
}

ccb.content.define_monster {
    id = "mon_grenade_hack",
    copy_from = "base_drone",
    name = ccb.content.plural_text("grenade hack", "grenade hacks"),
    description = ccb.content.text("An automated kamikaze drone, this small quadcopter robot appears to have a grenade inside."),
    difficulty_adjustment = 10,
    speed = 250,
    color = "green",
    revert_item = "bot_grenade_hack",
    starting_ammo = { grenade = 1 },
    attacks = { { reference = "KAMIKAZE", cooldown = 0 } },
    armor = { cut = 4, bullet = 3 },
}

ccb.content.define_monster {
    id = "mon_manhack",
    copy_from = "base_drone",
    name = ccb.content.plural_text("manhack", "manhacks"),
    description = ccb.content.text("An automated anti-personnel drone, a small quadcopter robot surrounded by whirring blades."),
    difficulty_adjustment = 2,
    speed = 190,
    color = "light_green",
    melee_skill = 5,
    melee_dice = 2,
    melee_sides = 4,
    melee_damage = { { type = "cut", amount = 12 } },
    revert_item = "bot_manhack",
    armor = { bash = 2, cut = 8, bullet = 6 },
    inheritance = { add = { flags = { "HIT_AND_RUN" } }, remove = { flags = { "PACIFIST" } } },
    death = { outcome = { corpse = "BROKEN" } },
}
