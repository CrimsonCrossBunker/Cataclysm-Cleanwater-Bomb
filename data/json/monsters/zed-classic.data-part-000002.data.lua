local ccb = require("ccb")

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
