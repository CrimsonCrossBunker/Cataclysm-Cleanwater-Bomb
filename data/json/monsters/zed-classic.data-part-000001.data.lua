local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_beekeeper",
    name = ccb.content.plural_text("scarred zombie", "scarred zombies"),
    description = ccb.content.text("A deformed human body, its skin transformed into one thick, calloused envelope of scar tissue."),
    copy_from = "mon_zombie_base",
    hp = 70,
    speed = 60,
    color = "light_red",
    melee_skill = 3,
    melee_sides = 4,
    melee_damage = { { type = "cut", amount = 2 } },
    fungalize_into = "mon_beekeeper_dusted",
    upgrade = false,
    armor = { bash = 6, cut = 8, bullet = 6, electric = 1 },
    inheritance = {
        add = {
            weakpoint_sets = { "wps_natural_armor" },
            families = { "prof_wp_nat_armored" },
            flags = { "CLUMSY_ATTACKS" },
        },
    },
    death = {
        drops = {
            kind = "collection",
            groups = { { id = "default_zombie_clothes", weight = 100 }, { id = "hive", weight = 80 } },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zombie",
    copy_from = "mon_zombie_base",
    categories = { "CLASSIC" },
    inheritance = { add = { flags = { "CLUMSY_ATTACKS" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_cop",
    name = ccb.content.plural_text("zombie cop", "zombie cops"),
    description = ccb.content.text("A human body covered by a weather-beaten and badly damaged set of police gear."),
    copy_from = "mon_zombie",
    color = "blue",
    melee_skill = 5,
    melee_sides = 4,
    vision_day = 30,
    upgrade = false,
    armor = { bash = 6, cut = 6, stab = 6, bullet = 6, electric = 2 },
    inheritance = {
        add = {
            weakpoint_sets = { "wps_humanoid_body_armor", "wps_humanoid_open_helmet" },
            families = { "prof_wp_syn_armored" },
        },
    },
    death = { drops = "mon_zombie_cop_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_crawler",
    name = ccb.content.plural_text("crawling zombie", "crawling zombies"),
    description = ccb.content.text("This human corpse drags itself along slowly with its arms.  Its legs are damaged beyond repair."),
    copy_from = "mon_zombie",
    hp = 60,
    speed = 20,
    color = "pink_green",
    melee_skill = 2,
    vision_day = 10,
    weakpoint_sets = { "wps_humanoid_head_big" },
    attacks = {
        { id = "grab", attack_upper = false },
        { id = "bite_humanoid", attack_upper = false, cooldown = 5 },
        { id = "scratch_humanoid", attack_upper = false },
    },
    fungalize_into = "mon_zombie_crawler_dusted",
    upgrade = { half_life = 120, monster_group = "GROUP_ZOMBIE_CRAWLER_UPGRADE" },
    inheritance = { add = { flags = { "ATTACK_LOWER", "GEN_DORMANT" } }, remove = { flags = { "PUSH_MON" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_fat",
    name = ccb.content.plural_text("fat zombie", "fat zombies"),
    description = ccb.content.text("Stumbling as it moves, this corpse of an overweight human regards its surroundings with an empty black gaze."),
    copy_from = "mon_zombie",
    hp = 95,
    speed = 55,
    color = "green",
    melee_skill = 3,
    melee_sides = 4,
    fungalize_into = "mon_zombie_fat_dusted",
    upgrade = { half_life = 128, monster_group = "GROUP_ZOMBIE_FAT" },
    armor = { bash = 5, cut = 3, bullet = 2, electric = 2 },
    inheritance = {
        add = { weakpoint_sets = { "wps_humanoid_head_small" }, flags = { "GEN_DORMANT" } },
        scale = { volume = 1.5, mass = 1.5 },
    },
}

-- Slightly stronger, but can't bite because of the gear.
ccb.content.define_monster {
    id = "mon_zombie_fireman",
    name = ccb.content.plural_text("firefighter zombie", "firefighter zombies"),
    description = ccb.content.text("A decaying human body clad in tattered firefighting gear.  It staggers aimlessly, reeking of smoke and decay.  Its protective mask prevents it from attempting to bite you."),
    copy_from = "mon_zombie",
    color = "yellow",
    melee_skill = 5,
    melee_dice = 3,
    grab_strength = 30,
    upgrade = { half_life = 128, monster = "mon_zombie_nomex" },
    armor = { bash = 6, cut = 6, acid = 3, heat = 10, bullet = 5, electric = 4 },
    inheritance = {
        add = {
            weakpoint_sets = { "wps_humanoid_turnout_gear", "wps_humanoid_full_helmet" },
            families = { "prof_wp_syn_armored" },
            flags = { "ACIDPROOF" },
        },
        remove = { attacks = { "bite_humanoid" } },
    },
    death = { drops = "mon_zombie_fireman_death_drops" },
}
