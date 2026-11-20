local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_old_imaginifer",
    copy_from = "mon_wraitheon_imaginifer",
    name = ccb.content.plural_text("Parallax-3A Secutor", "Parallax-3A Secutors"),
    description = ccb.content.text("Pitted steel and silicon will remain steadfast even after its charge was long claimed by the unyielding cold.  Its single azure eye casts a cruel and calculating gaze upon the ruins of a universe made unfamiliar."),
    speed = 80,
    default_faction = "rampant_machine",
    attacks = {
        { id = "android_crush", cooldown = 1 },
        { id = "android_crush_monster", cooldown = 1 },
        { id = "android_drop", cooldown = 3 },
        {
            id = "smash",
            throw_strength = 48,
            cooldown = 5,
            when = "allow_wraitheon_imaginifer_smash",
        },
    },
    inheritance = { remove = { flags = { "DROPS_AMMO" } } },
    death = { drops = { groups = { { id = "dead_old_imaginifer", weight = 1 } } } },
}

ccb.content.define_monster {
    id = "mon_old_imaginifer_laser",
    copy_from = "mon_wraitheon_imaginifer",
    name = ccb.content.plural_text("Parallax-3E Veles", "Parallax-3E Velites"),
    description = ccb.content.text("It walks heavily, with each step resonating beneath the weight of its rust-bitten frame.  A single azure eye scans its surroundings with predatory hunger, and any movement is met by the destructive gaze of a grafted light-cannon."),
    speed = 60,
    default_faction = "rampant_machine",
    attacks = {
        { id = "android_crush", cooldown = 1 },
        {
            cooldown = 8,
            move_cost = 100,
            kind = "gun",
            gun = {
                weapon = "afs_light_cannon_mon",
                skills = { { id = "gun", level = 5 }, { id = "pistol", level = 3 } },
                dexterity = 8,
                ranges = { { minimum = 5, maximum = 16, mode = "DEFAULT" } },
                lock_player = true,
                lock_npc = true,
                lock_monster = true,
                target_moving_vehicles = true,
                targeting_cost = 300,
                targeting_timeout = 10,
                targeting_extension = 0,
                targeting_sound = ccb.content.text("\"Hostile detected.\""),
                targeting_volume = 10,
            },
        },
        { id = "android_crush_monster", cooldown = 1 },
        { id = "android_drop", cooldown = 5 },
        {
            id = "smash",
            throw_strength = 48,
            cooldown = 3,
            when = "allow_wraitheon_imaginifer_smash",
        },
    },
    inheritance = { remove = { flags = { "DROPS_AMMO" } } },
    death = { drops = { groups = { { id = "dead_old_imaginifer_laser", weight = 1 } } } },
}
