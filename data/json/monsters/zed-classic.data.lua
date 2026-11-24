local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_base",
    abstract = true,
    name = "zombie",
    description = "A human body, swaying as it moves, an unstoppable rage visible in its oily black eyes.",
    default_faction = "zombie",
    symbol = "Z",
    body_type = "human",
    color = "light_green",
    volume = "62500 ml",
    mass = "81500 g",
    harvest = "zombie_humanoid",
    decay = "zombie_decay_bone_human_skull",
    fungalize_into = "mon_zombie_dusted",
    burn_into = "mon_zombie_scorched",
    hp = 80,
    speed = 70,
    aggression = 100,
    morale = 100,
    melee_skill = 4,
    melee_dice = 2,
    melee_sides = 3,
    grab_strength = 20,
    vision_night = 3,
    flags = {
        "SEES",
        "HEARS",
        "STUMBLES",
        "WARM",
        "GRABS",
        "BASHES",
        "GROUP_BASH",
        "POISON",
        "NO_BREATHE",
        "REVIVES",
        "PUSH_MON",
        "FILTHY",
        "UNBREAKABLE_MORALE",
        "VENOM_IMMUNE",
    },
    species = { "ZOMBIE", "HUMAN" },
    weakpoint_sets = { "wps_humanoid_body", "wps_vital_organs", "wps_eyes" },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie" },
    materials = { "flesh" },
    armor = { electric = 1 },
    melee_damage = {
        { type = "cut", amount = 0 },
    },
    upgrade = { half_life = 120, monster_group = "GROUP_ZOMBIE_UPGRADE" },
    attacks = {
        { reference = "PARROT", cooldown = 400 },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
        { id = "grab", cooldown = 2 },
        { id = "bite_humanoid", cooldown = 5 },
        { id = "scratch_humanoid" },
    },
    revive_forms = {
        { monster = "mon_fungal_mound", when = "w16b_rev_dda_8cdff51a3b28" },
    },
    death = { drops = "default_zombie_death_drops" },
}

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

ccb.content.define_monster {
    id = "mon_zombie_hazmat",
    name = ccb.content.plural_text("hazmat zombie", "hazmat zombies"),
    description = ccb.content.text("This zombie is completely encased in a protective suit that apparently failed to protect it from whatever this infection is.  At least it can't bite you from inside that suit."),
    copy_from = "mon_zombie",
    color = "white_green",
    melee_skill = 3,
    weakpoints = {
        {
            name = ccb.content.text("a tear in its hazmat suit"),
            armor_multiplier = { all = 0.5 },
            coverage = 5,
            difficulty = { ranged = 3, melee = 1 },
            attack_coverage = { broad = 0.65 },
            id = "a tear in its hazmat suit",
        },
    },
    armor = { bash = 5, cut = 4, bullet = 3, electric = 5 },
    inheritance = {
        add = {
            weakpoint_sets = { "wps_humanoid_gasmask" },
            families = { "prof_wp_syn_armored" },
            flags = { "ACIDPROOF" },
        },
        remove = { attacks = { "bite_humanoid", "scratch_humanoid" } },
    },
    death = { drops = "mon_zombie_hazmat_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_rot",
    name = ccb.content.plural_text("decayed zombie", "decayed zombies"),
    description = ccb.content.text("A once-dead human corpse.  Its discolored, swollen flesh is riddled with festering wounds and open sores.  It smells indescribably awful."),
    copy_from = "mon_zombie_base",
    hp = 55,
    speed = 60,
    color = "light_green_yellow",
    melee_skill = 1,
    melee_sides = 2,
    grab_strength = 15,
    fungalize_into = "mon_zombie_rot_dusted",
    emissions = { { id = "emit_nauseating_smell", delay = "1 s" } },
    upgrade = { half_life = 172, monster_group = "GROUP_ZOMBIE_DECAYED_UPGRADE" },
    inheritance = { add = { flags = { "GEN_DORMANT", "CLUMSY_ATTACKS" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_swat",
    name = ccb.content.plural_text("SWAT zombie", "SWAT zombies"),
    description = ccb.content.text("This zombie was part of a specialized unit of law enforcement.  It still wears a battered armor with the SWAT logo emblazoned on the front.  The protective mask makes its head a difficult target, but also prevents it from biting you."),
    copy_from = "mon_zombie_cop",
    hp = 90,
    speed = 75,
    melee_sides = 5,
    grab_strength = 30,
    upgrade = { half_life = 152, monster = "mon_zombie_kevlar_0" },
    armor = { bash = 10, cut = 16, bullet = 18, electric = 3 },
    inheritance = {
        add = {
            weakpoint_sets = { "wps_humanoid_body_armor", "wps_humanoid_open_helmet" },
            families = { "prof_wp_syn_armored" },
            flags = { "CLUMSY_ATTACKS" },
        },
        remove = { attacks = { "bite_humanoid" } },
    },
    death = { drops = "mon_zombie_swat_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_tough",
    name = ccb.content.plural_text("tough zombie", "tough zombies"),
    description = ccb.content.text("This was once an athletic human, now a brutal monster.  Its facial features are twisted into an expression of pure rage."),
    copy_from = "mon_zombie_base",
    hp = 100,
    speed = 85,
    color = "light_red",
    melee_dice = 3,
    melee_damage = { { type = "cut", amount = 1 } },
    dodge = 1,
    grab_strength = 30,
    attacks = {
        { id = "grab", cooldown = 7 },
        { id = "bite_humanoid", cooldown = 5, minimum_damage_multiplier = 0.7 },
        { id = "scratch_humanoid" },
    },
    fungalize_into = "mon_zombie_tough_dusted",
    armor = { bash = 2, cut = 1, bullet = 1, electric = 2 },
    inheritance = {
        add = {
            weakpoint_sets = { "wps_humanoid_head_small" },
            flags = { "GEN_DORMANT", "CLUMSY_ATTACKS" },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_resort_dancer",
    name = ccb.content.plural_text("sleek zombie", "sleek zombies"),
    description = ccb.content.text("This zombie is rather sleek and scantily clothed."),
    copy_from = "mon_zombie",
    looks_like = "mon_zombie",
    upgrade = { half_life = 120, monster_group = "GROUP_ZOMBIE_UPGRADE" },
    death = { drops = "mon_zombie_resort_dancer_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_resort_bouncer",
    name = ccb.content.plural_text("bouncer zombie", "bouncer zombies"),
    description = ccb.content.text("This muscular zombie is dressed in the tattered remnants of a security uniform."),
    copy_from = "mon_zombie_tough",
    death = { drops = "mon_zombie_resort_bouncer_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_resort_staff",
    copy_from = "mon_zombie",
    looks_like = "mon_zombie",
    death = { drops = "mon_zombie_resort_staff_death_drops" },
}
