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

-- weight and dimensions based on the approx. size of a Griff 350, which is a commercial cargo-hauling quadcopter.  Then I added a large balloon on top.
ccb.content.define_monster {
    id = "exodii_sniper_drone",
    abstract = true,
    name = ccb.content.plural_text("balloon sniper-drone", "balloon sniper-drones"),
    description = ccb.content.text("This unusual contraption looks like a combination of a weather balloon and a quadcopter.  Beneath the crude box containing its components hangs a small articulated rig wielding an integrated rifle.  Its propellers flicker to life briefly, then shut down again, keeping it mostly stationary despite the air currents.  It looks capable of hanging in the air for quite a long time before running out of power."),
    default_faction = "exodii",
    species = { "ROBOT" },
    volume = "5000 L",
    mass = "150 kg",
    hp = 20,
    speed = 70,
    materials = { "aluminum", "qt_steel" },
    symbol = "e",
    color = "light_green",
    aggression = -20,
    morale = 70,
    aggressive_to_characters = false,
    vision_day = 50,
    vision_night = 20,
    starting_ammo = { ["123ln_ap"] = 10 },
    anger_triggers = { "FRIEND_ATTACKED", "FRIEND_DIED", "HURT" },
    attacks = {
        {
            cooldown = 1,
            move_cost = 350,
            kind = "gun",
            gun = {
                weapon = "pamd71z",
                ammo = "123ln",
                skills = { { id = "gun", level = 6 }, { id = "rifle", level = 9 } },
                dexterity = 12,
                ranges = { { minimum = 0, maximum = 50, mode = "DEFAULT" } },
                lock_npc = true,
                lock_monster = true,
                target_moving_vehicles = true,
                laser_lock = true,
                targeting_cost = 700,
                targeting_extension = -10,
                empty_sound = ccb.content.text("tick!"),
            },
        },
    },
    pathing = { max_distance = 30, avoid_traps = true, avoid_sharp = true },
    flags = {
        "SEES", "HEARS", "FLIES", "NOHEAD", "ELECTRONIC", "BIOLOGICALPROOF", "NO_BREATHE",
        "INTERIOR_AMMO", "PATH_AVOID_DANGER", "PRIORITIZE_TARGETS", "HIT_AND_RUN", "STUN_IMMUNE",
    },
    armor = { bash = 4, cut = 3 },
    death = {
        drops = { kind = "collection", groups = { { id = "robots", weight = 80 } } },
        outcome = { corpse = "BROKEN" },
    },
}

ccb.content.define_monster {
    id = "mon_tazer_hack",
    copy_from = "base_drone",
    name = ccb.content.plural_text("taser hack", "taser hacks"),
    description = ccb.content.text("An automated drone, this small quadcopter robot appears to have a taser strapped to the front.  While extremely fast, it is very fragile."),
    difficulty_adjustment = 10,
    speed = 350,
    color = "cyan",
    revert_item = "bot_tazer_hack",
    attacks = { { reference = "TAZER", cooldown = 5 } },
    armor = { cut = 2, bullet = 1 },
    death = { outcome = { corpse = "BROKEN" } },
}
