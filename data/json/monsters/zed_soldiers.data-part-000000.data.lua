local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_soldier",
    name = ccb.content.plural_text("zombie soldier", "zombie soldiers"),
    description = ccb.content.text("Once a soldier, it is dressed head to toe in combat gear and carries itself rather steadily for a zombie."),
    copy_from = "mon_zombie_base",
    categories = { "CLASSIC" },
    hp = 100,
    speed = 80,
    color = "light_green_green",
    melee_skill = 5,
    melee_sides = 6,
    vision_day = 30,
    grab_strength = 30,
    attacks = {
        { id = "grab" },
        { id = "scratch_humanoid" },
        { id = "bite_humanoid", cooldown = 5, minimum_damage_multiplier = 0.8 },
    },
    upgrade = { half_life = 168, monster_group = "GROUP_SOLDIER_UPGRADE" },
    armor = { bash = 12, cut = 25, bullet = 20, electric = 3 },
    inheritance = {
        add = {
            weakpoint_sets = { "wps_humanoid_body_armor", "wps_humanoid_open_helmet" },
            families = { "prof_wp_syn_armored" },
        },
        remove = { flags = { "STUMBLES" } },
    },
    death = { drops = "mon_zombie_soldier_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_soldier_blackops_1",
    name = ccb.content.plural_text("black-ops zombie", "black-ops zombies"),
    description = ccb.content.text("This soldier zombie's skin radiates a sort of shadowy smoke that obscures its outline, making its camouflage even harder to see against the background.  In the darkness it would be nigh invisible."),
    copy_from = "mon_zombie_base",
    looks_like = "mon_zombie_soldier",
    hp = 120,
    speed = 90,
    color = "light_green_green",
    scents_tracked = { "sc_human", "sc_fetid" },
    melee_skill = 6,
    melee_sides = 6,
    dodge = 3,
    bleed_rate = 50,
    vision_day = 30,
    vision_night = 35,
    harvest = "zombie_humanoid_shadow",
    attacks = {
        { id = "grab" },
        { id = "scratch_humanoid" },
        {
            id = "bite_humanoid",
            cooldown = 8,
            damage = { { type = "stab", amount = 8, armor_multiplier = 0.8 } },
        },
    },
    upgrade = { half_life = 180, monster = "mon_zombie_soldier_blackops_2" },
    armor = { bash = 12, cut = 25, bullet = 20, electric = 3 },
    inheritance = {
        add = {
            flags = { "SMELLS", "NIGHT_INVISIBILITY" },
            weakpoint_sets = { "wps_humanoid_body_armor", "wps_humanoid_open_helmet" },
            families = { "prof_wp_syn_armored" },
        },
        remove = { flags = { "STUMBLES" } },
    },
    death = { drops = "mon_zombie_soldier_death_drops" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_zombie_soldier_no_weakpoints",
    name = ccb.content.text_without_extraction("zombie soldier test only", "zombie soldier test only"),
    description = ccb.content.text_without_extraction("This zombie soldier is used by hardcoded dps logic and for testing purposes only."),
    copy_from = "mon_zombie_soldier",
    dodge = 1,
    inheritance = {
        add = { flags = { "NOT_HALLUCINATION" } },
        remove = {
            weakpoint_sets = {
                "wps_humanoid_body",
                "wps_vital_organs",
                "wps_eyes",
                "wps_humanoid_body_armor",
                "wps_humanoid_open_helmet",
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_soldier_blackops_2",
    name = ccb.content.plural_text("hunter-killer zombie", "hunter-killer zombies"),
    description = ccb.content.text("Fragments of visible uniform hint that this monstrosity was once a soldier.  Anything human is invisible, hidden inside a sheath of living shadow.  It moves with preternatural fluidity and grace."),
    copy_from = "mon_zombie_soldier_blackops_1",
    looks_like = "mon_zombie_soldier_blackops_1",
    bleed_rate = 0,
    upgrade = false,
    inheritance = {
        add = {
            attacks = { { cooldown = 10, maximum_range = 3, kind = "leap" } },
            flags = { "KEENNOSE" },
        },
        offset = { hp = 20, speed = 10, melee_skill = 1, dodge = 1, vision_night = 15 },
    },
}
