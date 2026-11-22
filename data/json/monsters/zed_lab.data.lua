local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_labsecurity",
    name = "zombie security guard",
    description = "A shambling human corpse wearing a gray uniform and a bulletproof vest with \"SECURITY\" emblazoned across the front.  It looks like this guard was quite physically fit before its death; it moves quickly and powerfully, albeit clumsily.",
    copy_from = "mon_zombie_base",
    default_faction = "science",
    color = "blue",
    hp = 100,
    speed = 85,
    melee_skill = 5,
    melee_sides = 4,
    grab_strength = 30,
    categories = { "CLASSIC" },
    armor = {
        bash = 4,
        cut = 6,
        stab = 4,
        bullet = 4,
        electric = 2,
    },
    upgrade = { half_life = 140, monster_group = "GROUP_SOLDIER_UPGRADE" },
    attacks = {
        { id = "grab", cooldown = 7 },
        { id = "bite_humanoid", minimum_damage_multiplier = 0.7, cooldown = 5 },
        { id = "scratch_humanoid" },
    },
    death = { drops = "mon_zombie_labsecurity_death_drops" },
    inheritance = {
        add = {
            flags = { "CLUMSY_ATTACKS" },
            weakpoint_sets = { "wps_humanoid_body_armor" },
            families = { "prof_wp_syn_armored" },
        },
    },
}
