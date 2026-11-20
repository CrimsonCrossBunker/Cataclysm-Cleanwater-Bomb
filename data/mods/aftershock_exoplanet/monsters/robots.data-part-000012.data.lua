local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_advbot_emp",
    copy_from = "mon_advbot_base",
    name = ccb.content.plural_text("Wraitheon Frequency", "Wraitheon Frequencies"),
    description = ccb.content.text("An autonomous weapons platform, made to disrupt or disable electronics - especially other robots - with an electromagnetic pulse."),
    default_faction = "WraitheonRobotics",
    difficulty_adjustment = 10,
    melee_dice = 4,
    melee_sides = 5,
    melee_armor_penetration = 4,
    attacks = {
        {
            cooldown = 2,
            kind = "gun",
            gun = {
                weapon = "emp_gun",
                skills = { { id = "gun", level = 5 }, { id = "rifle", level = 5 } },
                dexterity = 10,
                ranges = {
                    { minimum = 0, maximum = 4, mode = "BURST" },
                    { minimum = 4, maximum = 8, mode = "AUTO" },
                    { minimum = 9, maximum = 16, mode = "DEFAULT" },
                },
                lock_player = true,
                lock_npc = true,
                lock_monster = true,
                target_moving_vehicles = true,
                targeting_cost = 10,
                targeting_timeout = 1,
                targeting_extension = -1,
                targeting_sound = ccb.content.text("\"Hostile detected.\""),
                targeting_volume = 10,
            },
        },
    },
    armor = { bash = 30, cut = 50, bullet = 60, afs_laser = 30, afs_plasma = 20, electric = 10 },
}

-- A monster so that the player and other monsters can shoot at it without the need of custom AI.
-- Deliberately electric and not electronic, so it can be immune to electric damage and EMP.
ccb.content.define_monster {
    id = "mon_shock_mine",
    name = ccb.content.plural_text("shock-mine", "shock-mines"),
    description = ccb.content.text("A bulky device that will constantly discharge electricity in a small radius around it."),
    default_faction = "rampant_machine",
    species = { "ROBOT" },
    difficulty_adjustment = 12,
    volume = "1 L",
    mass = "1200 g",
    hp = 5,
    speed = 100,
    materials = { "steel" },
    symbol = "i",
    color = "light_gray",
    aggression = 100,
    morale = 100,
    bleed_rate = 0,
    vision_night = 4,
    luminance = 10,
    emissions = { { id = "emit_spark", delay = "1 s" } },
    attacks = {
        {
            cooldown = 1,
            kind = "gun",
            gun = {
                weapon = "afs_mine_shocker",
                skills = { { id = "gun", level = 2 }, { id = "rifle", level = 3 } },
                ranges = { { minimum = 0, maximum = 5, mode = "DEFAULT" } },
            },
        },
        {
            spell = { id = "shock_mine_control", min_level = 1, hit_self = true },
            allow_no_target = true,
            casting_message = "",
            cooldown = 3,
            kind = "spell",
        },
    },
    flags = { "SEES", "NOHEAD", "ELECTRIC", "BIOLOGICALPROOF", "COLDPROOF", "IMMOBILE", "NO_BREATHE" },
    armor = { bash = 5, cut = 2, bullet = 3, stab = 0, electric = 100 },
    death = { outcome = { corpse = "BROKEN" } },
}
