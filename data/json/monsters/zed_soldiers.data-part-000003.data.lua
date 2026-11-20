local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_armored",
    name = ccb.content.plural_text("armored zombie", "armored zombies"),
    description = ccb.content.text("Despite being encased in a what was once a nigh-impenetrable combat exoskeleton, something still managed to kill this soldier."),
    copy_from = "mon_zombie_base",
    difficulty_adjustment = 5,
    hp = 120,
    speed = 50,
    color = "white_red",
    melee_skill = 5,
    melee_dice = 3,
    melee_sides = 6,
    weakpoint_sets = { "wps_humanoid_full_helmet" },
    weakpoints = {
        {
            name = ccb.content.text("a crack in the armor"),
            armor_multiplier = { bullet = 0.5, cut = 0.5, stab = 0.25, bash = 0.25 },
            coverage = 4,
            attack_coverage = { broad = 0.75 },
            difficulty = { ranged = 7, melee = 5 },
            id = "a crack in the armor",
        },
    },
    bleed_rate = 0,
    vision_day = 30,
    upgrade = false,
    armor = { bash = 64, cut = 64, acid = 20, heat = 20, bullet = 51, electric = 10 },
    inheritance = {
        add = { families = { "prof_wp_syn_armored" }, flags = { "PULP_PRYING" } },
        remove = {
            flags = { "STUMBLES", "GRABS", "PUSH_MON" },
            attacks = { "bite_humanoid", "scratch_humanoid", "grab" },
        },
    },
    death = { drops = "mon_zombie_armored_death_drops" },
}
