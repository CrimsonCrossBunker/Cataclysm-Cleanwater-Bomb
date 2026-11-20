local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_turret",
    copy_from = "mon_turret",
    name = ccb.content.plural_text("improvised SMG turret", "improvised SMG turrets"),
    default_faction = "defense_bot",
    starting_ammo = { pistol_ball = 30 },
    attacks = {
        {
            cooldown = 1,
            move_cost = 150,
            kind = "gun",
            gun = {
                weapon = "pistol_smg",
                ammo = "pistol_ball",
                skills = { { id = "gun", level = 5 }, { id = "smg", level = 5 } },
                dexterity = 12,
                ranges = { { minimum = 0, maximum = 14, mode = "DEFAULT" } },
                lock_npc = true,
                lock_monster = true,
                laser_lock = false,
                targeting_cost = 400,
                targeting_extension = -10,
                targeting_sound = ccb.content.text("\"Hostile detected.\""),
                targeting_volume = 20,
                empty_sound = ccb.content.text("a chk!"),
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_turret_bmg",
    copy_from = "mon_turret_bmg",
    name = ccb.content.plural_text("CROWS II, heavy machinegun", "CROWS II, heavy machinegun"),
    description = ccb.content.text("A remote weapon system derived from the M153 CROWS II and enhanced with autonomous operation software.  Thousands of these were deployed by the US military before the Cataclysm and they were valued for their use in engaging anything up to light vehicles at long range without exposing the operator.  This one is fitted with a heavy machinegun."),
    default_faction = "military",
    starting_ammo = { rifle_huge_ball = 400 },
    attacks = {
        {
            cooldown = 1,
            move_cost = 150,
            kind = "gun",
            gun = {
                weapon = "rifle_huge_hmg",
                ammo = "rifle_huge_ball",
                skills = { { id = "gun", level = 8 }, { id = "rifle", level = 8 } },
                dexterity = 12,
                ranges = {
                    { minimum = 0, maximum = 40, mode = "AUTO" },
                    { minimum = 41, maximum = 110, mode = "DEFAULT" },
                },
                lock_npc = true,
                lock_monster = true,
                laser_lock = false,
                targeting_cost = 200,
                targeting_extension = -10,
                targeting_sound = ccb.content.text("\"Hostile detected.\""),
                targeting_volume = 50,
                empty_sound = ccb.content.text("a chk!"),
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_turret_rifle",
    copy_from = "mon_turret_rifle",
    name = ccb.content.plural_text("CROWS II, light machinegun", "CROWS II, light machinegun"),
    description = ccb.content.text("A remote weapon system derived from the M153 CROWS II and enhanced with autonomous operation software.  Thousands of these were deployed by the US military before the Cataclysm and they were valued for their use in engaging infantry without exposing the operator.  This one is fitted with a light machine gun."),
    default_faction = "military",
    starting_ammo = { rifle_ball = 1000 },
    attacks = {
        {
            cooldown = 1,
            move_cost = 150,
            kind = "gun",
            gun = {
                weapon = "rifle_lmg",
                ammo = "rifle_ball",
                skills = { { id = "gun", level = 8 }, { id = "rifle", level = 8 } },
                dexterity = 12,
                ranges = { { minimum = 0, maximum = 60, mode = "DEFAULT" } },
                lock_npc = true,
                lock_monster = true,
                laser_lock = false,
                targeting_cost = 200,
                targeting_extension = -10,
                targeting_sound = ccb.content.text("\"Hostile detected.\""),
                targeting_volume = 50,
                empty_sound = ccb.content.text("a chk!"),
            },
        },
    },
}
