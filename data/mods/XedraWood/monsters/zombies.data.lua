local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_crawler",
    copy_from = "mon_zombie_crawler",
    weakpoint_sets = { "wps_humanoid_zombie_body" },
    upgrade = false,
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_zombie_rot",
    copy_from = "mon_zombie_rot",
    description = ccb.content.text("A once-dead human corpse.  Its discolored, swollen flesh is riddled with festering wounds and open sores.  Even at a distance, the smell nearly makes you gag."),
    weakpoint_sets = { "wps_humanoid_zombie_body" },
    attack_effects = {
        { id = "pre_flu", duration = 432000, chance = 2 },
        { id = "rat_bite_fever", duration = 345600, chance = 3 },
    },
    emissions = { { id = "emit_nauseating_smell", delay = "1 s" } },
    upgrade = false,
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_zombie_tough",
    copy_from = "mon_zombie_tough",
    weakpoint_sets = { "wps_humanoid_zombie_body" },
    upgrade = false,
    death = { drops = "hollow_warrior_death_drops" },
}

ccb.content.define_monster {
    id = "mon_devourer",
    copy_from = "mon_devourer",
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_zombie_acidic",
    copy_from = "mon_zombie_acidic",
    upgrade = false,
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_zombie_spitter",
    copy_from = "mon_zombie_spitter",
    upgrade = false,
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_zombie_corrosive",
    copy_from = "mon_zombie_corrosive",
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_zombie_gasbag",
    copy_from = "mon_zombie_gasbag",
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_zombie_crawler_pupa_decoy",
    copy_from = "mon_zombie_crawler_pupa_decoy",
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_zombie_crawler_pupa",
    copy_from = "mon_zombie_crawler_pupa",
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_zombie_grabber",
    copy_from = "mon_zombie_grabber",
    upgrade = false,
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_zombie_grappler",
    copy_from = "mon_zombie_grappler",
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_zombie_hollow",
    copy_from = "mon_zombie_hollow",
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_zombie_hulk",
    copy_from = "mon_zombie_hulk",
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_zombie_hunter",
    copy_from = "mon_zombie_hunter",
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_zombie_mancroc",
    copy_from = "mon_zombie_mancroc",
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_zombie_regenerating",
    copy_from = "mon_zombie_regenerating",
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_zombie_biter",
    copy_from = "mon_zombie_biter",
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_zombie_predator",
    copy_from = "mon_zombie_predator",
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_zombie_screecher",
    copy_from = "mon_zombie_screecher",
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_zombie_shady",
    copy_from = "mon_zombie_shady",
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_zombie_shrieker",
    copy_from = "mon_zombie_shrieker",
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_zombie_smoker",
    copy_from = "mon_zombie_smoker",
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_smoker_brute",
    copy_from = "mon_smoker_brute",
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_zombie_winged",
    copy_from = "mon_zombie_winged",
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_zombie_brute_winged",
    copy_from = "mon_zombie_brute_winged",
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_skeleton",
    copy_from = "mon_skeleton",
    upgrade = false,
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_skeleton_brute",
    copy_from = "mon_skeleton_brute",
    death = { drops = "hollow_one_death_drops_zombie" },
}

ccb.content.define_monster {
    id = "mon_skeleton_hulk",
    copy_from = "mon_skeleton_hulk",
    death = { drops = "hollow_one_death_drops_zombie" },
}
