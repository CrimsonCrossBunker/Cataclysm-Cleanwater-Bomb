local ccb = require("ccb")

-- Copied from zombie cop
-- Uses a baton for melee attacks
ccb.content.define_monster {
    id = "mon_civilian_police",
    name = ccb.content.plural_text("overconfident officer", "overconfident officers"),
    description = ccb.content.text("Gun in hand, this police officer is determined to make a last stand against the horde."),
    copy_from = "mon_civilian_panic",
    difficulty_adjustment = 5,
    aggressive_to_characters = false,
    aggression = 100,
    morale = 100,
    vision_day = 50,
    vision_night = 3,
    weakpoint_sets = { "wps_humanoid_body", "wps_vital_organs", "wps_eyes", "wps_humanoid_body_armor" },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_syn_armored" },
    chat_topics = { "TALK_CIVILIAN_OFFICER" },
    melee_skill = 6,
    melee_dice = 2,
    melee_sides = 4,
    melee_damage = { { type = "bash", amount = 5 } },
    zombify_into = "mon_zombie_cop",
    starting_ammo = { ["40fmj"] = 10 },
    attacks = {
        {
            cooldown = 10,
            move_cost = 150,
            kind = "gun",
            gun = {
                weapon = "civilian_cop_glock22",
                ammo = "40fmj",
                skills = { { id = "gun", level = 2 }, { id = "pistol", level = 3 } },
                dexterity = 8,
                perception = 10,
                ranges = { { minimum = 2, maximum = 14, mode = "DEFAULT" } },
                lock_player = false,
                description = ccb.content.text("The officer fires their Glock 22!"),
            },
            when = "monster_attack_armed",
        },
    },
    armor = { bash = 6, cut = 6, stab = 6, bullet = 6, electric = 2 },
    inheritance = { add = { flags = { "DROPS_AMMO", "WIELDED_WEAPON" } } },
    death = {
        drops = {
            kind = "collection",
            items = {
                { group = "mon_zombie_cop_death_drops", probability = 100 },
                { item = "glock_22", probability = 100, charges = { 0, 6 } },
            },
        },
    },
}

-- Copied from zombie cop
-- Unwieldy rifle butt for melee
-- Range starts from 0 to get some shots out
ccb.content.define_monster {
    id = "mon_civilian_police_rifle",
    name = ccb.content.plural_text("overconfident officer", "overconfident officers"),
    description = ccb.content.text("Rifle in hand, this police officer is determined to make a last stand against the horde."),
    copy_from = "mon_civilian_panic",
    difficulty_adjustment = 5,
    aggressive_to_characters = false,
    aggression = 100,
    morale = 100,
    vision_day = 50,
    vision_night = 3,
    weakpoint_sets = { "wps_humanoid_body", "wps_vital_organs", "wps_eyes", "wps_humanoid_body_armor" },
    families = { "prof_intro_biology", "prof_physiology", "prof_wp_syn_armored" },
    chat_topics = { "TALK_CIVILIAN_OFFICER" },
    melee_skill = 4,
    melee_dice = 2,
    melee_sides = 4,
    melee_damage = { { type = "bash", amount = 3 } },
    zombify_into = "mon_zombie_cop",
    starting_ammo = { ["223"] = 20 },
    attacks = {
        {
            cooldown = 10,
            move_cost = 100,
            kind = "gun",
            gun = {
                weapon = "civilian_AR-15",
                ammo = "223",
                skills = { { id = "gun", level = 2 }, { id = "rifle", level = 3 } },
                dexterity = 8,
                perception = 10,
                ranges = { { minimum = 0, maximum = 14, mode = "DEFAULT" } },
                lock_player = false,
                description = ccb.content.text("The officer fires their AR-15!"),
            },
            when = "monster_attack_armed",
        },
    },
    armor = { bash = 6, cut = 6, stab = 6, bullet = 6, electric = 2 },
    inheritance = { add = { flags = { "DROPS_AMMO", "WIELDED_WEAPON" } } },
    death = {
        drops = {
            kind = "collection",
            items = {
                { group = "mon_zombie_cop_death_drops", probability = 100 },
                { group = "modular_ar15", probability = 100, charges = { 0, 6 } },
            },
        },
    },
}
