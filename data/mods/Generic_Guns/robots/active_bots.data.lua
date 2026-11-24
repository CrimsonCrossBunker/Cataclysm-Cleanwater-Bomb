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

ccb.content.define_monster { id = "mon_crows_m240", copy_from = "mon_turret_rifle", default_faction = "military" }

ccb.content.define_monster {
    id = "mon_secubot",
    copy_from = "mon_secubot",
    name = ccb.content.plural_text("autonomous rifle TALON UGV", "autonomous rifle TALON UGVs"),
    description = ccb.content.text("A TALON unmanned ground vehicle equipped with a standard assault rifle.  It is a small tracked UGV with an array of motors and sensors covering its weapon mount."),
    starting_ammo = { rifle_ball = 30 },
    attacks = {
        {
            cooldown = 1,
            move_cost = 150,
            kind = "gun",
            gun = {
                weapon = "rifle_assault",
                ammo = "rifle_ball",
                skills = { { id = "gun", level = 8 }, { id = "rifle", level = 8 } },
                dexterity = 12,
                ranges = { { minimum = 0, maximum = 30, mode = "DEFAULT" } },
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
    id = "mon_talon_m202a1",
    copy_from = "mon_talon_m202a1",
    name = ccb.content.plural_text("autonomous launcher TALON UGV", "autonomous launcher TALON UGVs"),
    description = ccb.content.text("A TALON unmanned ground vehicle equipped with a revolver grenade launcher.  It is a small tracked UGV with an array of motors and sensors covering its weapon mount."),
    default_faction = "defense_bot",
    starting_ammo = { grenade_ammo_hedp = 6 },
    attacks = {
        {
            cooldown = 1,
            move_cost = 150,
            kind = "gun",
            gun = {
                weapon = "grenade_revolver",
                ammo = "grenade_ammo_hedp",
                skills = { { id = "gun", level = 8 }, { id = "launcher", level = 8 } },
                dexterity = 12,
                ranges = { { minimum = 0, maximum = 20, mode = "DEFAULT" } },
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

-- For later: needs the ability to preferentially target legs and arms
ccb.content.define_monster {
    id = "mon_turret_riot",
    copy_from = "mon_turret_riot",
    name = ccb.content.plural_text("riot control platform", "riot control platforms"),
    description = ccb.content.text("These TALON-derived riot control platforms were widely publicized a few years before the Cataclysm as a new semi-autonomous device that could fire less-lethal rounds with far more accuracy than a human, ensuring safer hits against a target's limbs.  They were quickly adopted by prisons and inner city police forces, where they demonstrated that 'less lethal' is not the same as 'non-lethal'.  In the days before the Cataclysm, massive stockrooms of the things were put into circulation.  On the bright side, although it shoots autonomously, it requires a human operator to relocate, so it's not so mobile anymore."),
    default_faction = "cop_bot",
    starting_ammo = { grenade_ammo_beanbag = 6 },
    attacks = {
        {
            cooldown = 1,
            move_cost = 150,
            kind = "gun",
            gun = {
                weapon = "grenade_revolver",
                ammo = "grenade_ammo_beanbag",
                skills = { { id = "gun", level = 8 }, { id = "rifle", level = 8 } },
                dexterity = 12,
                ranges = { { minimum = 0, maximum = 30, mode = "DEFAULT" } },
                lock_npc = true,
                lock_monster = true,
                laser_lock = false,
                targeting_cost = 200,
                targeting_extension = -10,
                targeting_sound = ccb.content.text("\"Universal curfew is in effect.  Please return to your home.  This unit is authorized to open fire.\""),
                targeting_volume = 50,
                empty_sound = ccb.content.text("a chk!"),
            },
        },
    },
}
