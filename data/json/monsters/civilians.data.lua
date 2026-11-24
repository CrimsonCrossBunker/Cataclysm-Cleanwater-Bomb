local ccb = require("ccb")

-- They are human after all
ccb.content.define_monster {
    id = "mon_civilian_panic",
    name = ccb.content.plural_text("panicked person", "panicked persons"),
    description = ccb.content.text("This hysterical individual has a faint, yet fading, glint of intelligence in their bloodshot eyes.  They sometimes scream in fear and behave clearly irrationally.  This will quite likely cause their demise at the hands of the undead horde rather quickly."),
    looks_like = "mon_dementia",
    default_faction = "human",
    body_type = "human",
    species = { "HUMAN" },
    materials = { "hflesh" },
    weakpoint_sets = { "wps_humanoid_body", "wps_vital_organs", "wps_eyes" },
    chat_topics = { "TALK_CIVILIAN_PANIC" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 75,
    speed = 90,
    symbol = "@",
    color = "white",
    difficulty_adjustment = 2,
    aggression = -50,
    morale = -50,
    vision_day = 10,
    melee_dice = 1,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 3 } },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    attacks = { { reference = "PARROT_AT_DANGER", cooldown = 0 } },
    harvest = "human",
    dissect = "dissect_human_sample_single",
    pathing = { max_distance = 30, open_doors = true, avoid_traps = true, avoid_sharp = true },
    upgrade = { half_life = 4, grow_at_age = 1, monster_group = "GROUP_CIVILIANS_UPGRADE" },
    dodge = 1,
    zombify_into = "mon_zombie",
    flags = {
        "SEES",
        "HEARS",
        "WARM",
        "HUMAN",
        "CAN_OPEN_DOORS",
        "PATH_AVOID_DANGER",
        "CONVERSATION",
        "GUILT_HUMAN",
    },
    death = {
        drops = "default_zombie_death_drops",
        outcome = { spell = { id = "death_guilt", min_level = 6 } },
    },
}

-- Will not be able to do this in their current mental state:
ccb.content.define_monster {
    id = "mon_civilian_stationary",
    name = ccb.content.plural_text("petrified person", "petrified persons"),
    description = ccb.content.text("They just stand there, staring into the void, with a vacant expression on their face.  Barely moving, they will probably fall to the undead horde soon."),
    pathing = { max_distance = 30, open_doors = false, avoid_traps = false, avoid_sharp = false },
    speed = 20,
    difficulty_adjustment = 0,
    copy_from = "mon_civilian_panic",
}

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

ccb.content.define_monster {
    id = "mon_civilian_zombiefighter",
    name = ccb.content.plural_text("futile fighter", "futile fighters"),
    description = ccb.content.text("Obviously, this aggravated yet rallied person has lost their wits and tries to fight the undead with just a knife in their hands."),
    copy_from = "mon_civilian_panic",
    chat_topics = { "TALK_CIVILIAN_FIGHTER" },
    difficulty_adjustment = 3,
    aggressive_to_characters = false,
    aggression = 100,
    morale = 100,
    melee_skill = 2,
    attacks = { { id = "feral_weapon_knife_combat_low_skill" } },
    melee_dice = 2,
    melee_sides = 3,
    death = {
        drops = {
            kind = "collection",
            items = {
                { group = "default_zombie_death_drops", probability = 100 },
                { group = "survivor_knife", probability = 100 },
            },
        },
    },
}

-- Range starts from 0 to get some shots out
ccb.content.define_monster {
    id = "mon_civilian_zombiegunner",
    name = ccb.content.plural_text("armed fighter", "armed fighters"),
    description = ccb.content.text("Handgun in hand, this person is determined to make a last stand against the horde."),
    copy_from = "mon_civilian_panic",
    chat_topics = { "TALK_CIVILIAN_GUNNER" },
    difficulty_adjustment = 3,
    aggressive_to_characters = false,
    aggression = 100,
    morale = 100,
    melee_skill = 2,
    melee_dice = 2,
    melee_sides = 3,
    starting_ammo = { ["9mm"] = 10 },
    attacks = {
        {
            cooldown = 10,
            move_cost = 150,
            kind = "gun",
            gun = {
                weapon = "civilian_glock19",
                ammo = "9mm",
                skills = { { id = "gun", level = 2 }, { id = "pistol", level = 3 } },
                dexterity = 8,
                perception = 10,
                ranges = { { minimum = 0, maximum = 14, mode = "DEFAULT" } },
                lock_player = false,
                description = ccb.content.text("The gunman fires their sidearm!"),
            },
            when = "monster_attack_armed",
        },
    },
    death = {
        drops = {
            kind = "collection",
            items = {
                { group = "default_zombie_death_drops", probability = 100 },
                { item = "glock_19", probability = 100, charges = { 0, 6 } },
            },
        },
    },
}

-- So they are not perpetually fleeing despite lying in a hospital bed
ccb.content.define_monster {
    id = "mon_civilian_icu",
    name = ccb.content.plural_text("hospitalized person", "hospitalized persons"),
    description = ccb.content.text("This person is severely ill in some form or another, requiring intensive care that is not available anymore after the Cataclysm.  There is nothing you can do for them."),
    chat_topics = { "TALK_CIVILIAN_ICU" },
    speed = 0,
    morale = 0,
    upgrade = { monster = "mon_zombie_crawler" },
    zombify_into = "mon_zombie_crawler",
    copy_from = "mon_civilian_stationary",
    inheritance = { remove = { flags = { "SEES", "HEARS" } } },
}

ccb.content.define_monster {
    id = "mon_civilian_parent",
    name = ccb.content.plural_text("terrified parent", "terrified parents"),
    attacks = { { reference = "PARROT", cooldown = 0 } },
    description = ccb.content.text("Obsessed with finding their offspring, they scour the environment for certain death."),
    chat_topics = { "TALK_CIVILIAN_PARENT" },
    copy_from = "mon_civilian_panic",
}

-- They are human after all
ccb.content.define_monster {
    id = "mon_civilian_panic_robofac_chop_shop",
    name = ccb.content.plural_text("panicked person", "panicked persons"),
    description = ccb.content.text("This hysterical individual has a faint, yet fading, glint of intelligence in their bloodshot eyes.  They sometimes scream in fear and behave clearly irrationally.  This will quite likely cause their demise at the hands of the undead horde rather quickly."),
    looks_like = "mon_dementia",
    default_faction = "human",
    body_type = "human",
    species = { "HUMAN" },
    materials = { "hflesh" },
    weakpoint_sets = { "wps_humanoid_body", "wps_vital_organs", "wps_eyes" },
    chat_topics = { "TALK_CIVILIAN_PANIC" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 75,
    speed = 90,
    symbol = "@",
    color = "white",
    difficulty_adjustment = 2,
    aggression = -50,
    morale = -50,
    vision_day = 10,
    melee_dice = 1,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 3 } },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    attacks = { { reference = "PARROT_AT_DANGER", cooldown = 0 } },
    harvest = "human",
    dissect = "dissect_human_sample_single",
    pathing = { max_distance = 30, open_doors = false, avoid_traps = false, avoid_sharp = false },
    dodge = 1,
    zombify_into = "mon_zombie",
    flags = {
        "SEES",
        "HEARS",
        "WARM",
        "HUMAN",
        "CAN_OPEN_DOORS",
        "PATH_AVOID_DANGER",
        "CONVERSATION",
        "GUILT_HUMAN",
    },
    death = {
        drops = "default_zombie_death_drops",
        outcome = { spell = { id = "death_guilt", min_level = 6 } },
    },
}

ccb.content.define_monster {
    id = "mon_civilian_stationary_robofac_chop_shop",
    name = ccb.content.plural_text("petrified person", "petrified persons"),
    description = ccb.content.text("They just stand there, staring into the void, covered in filth and with a vacant expression on their face."),
    speed = 20,
    difficulty_adjustment = 0,
    copy_from = "mon_civilian_panic_robofac_chop_shop",
}

ccb.content.define_monster {
    id = "mon_civilian_parent_robofac_chop_shop",
    name = ccb.content.plural_text("terrified parent", "terrified parents"),
    attacks = { { reference = "PARROT", cooldown = 0 } },
    description = ccb.content.text("Covered in filth, this person is still clearly obsessed with finding their missing offspring."),
    chat_topics = { "TALK_CIVILIAN_PARENT" },
    copy_from = "mon_civilian_panic_robofac_chop_shop",
}
