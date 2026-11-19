local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_nomex",
    name = ccb.content.plural_text("Nomex zombie", "Nomex zombies"),
    description = ccb.content.text("This zombie was a firefighter in its past life, still donned in its turnout equipment - said equipment has melded with its flesh, with the tough, flame resistant fibers becoming incorporated into its skin as armor and body mass."),
    looks_like = "mon_zombie_fireman",
    copy_from = "mon_zombie_fireman",
    color = "yellow",
    armor = { bash = 12, cut = 16, acid = 14, heat = 18, bullet = 10, electric = 4 },
    harvest = "zombie_nomex",
    hp = 100,
    upgrade = { half_life = 128, monster_group = "GROUP_FIREMAN_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_zombie_fireproof",
    name = ccb.content.plural_text("fireproof zombie", "fireproof zombies"),
    description = ccb.content.text("This zombie appears to have once been a firefighter or similar first responder, the wilted remains of its turnout gear clinging to it like a molted carapace.  Fibrous streaks resembling the fireproof materials of its gear run through its flesh like roots, giving the thing a mottled, off-yellow appearance as it prowls on all fours."),
    copy_from = "mon_zombie_hunter",
    default_faction = "zombie",
    color = "brown_yellow",
    symbol = "Z",
    hp = 120,
    armor = { bash = 15, cut = 18, acid = 14, heat = 22, bullet = 11, electric = 4 },
    harvest = "zombie_nomex",
    upgrade = false,
    inheritance = {
        add = {
            move_skills = { climb = 6 },
            weakpoint_sets = { "wps_humanoid_turnout_gear", "wps_humanoid_full_helmet" },
            families = { "prof_wp_syn_armored", "prof_wp_nat_armored" },
            flags = { "ACIDPROOF", "FIREPROOF" },
        },
        remove = { attacks = { "bite" } },
    },
    death = { drops = "mon_zombie_fireman_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_fireproof_grappler",
    name = ccb.content.plural_text("fireproof grappler", "fireproof grapplers"),
    description = ccb.content.text("This zombie appears to have once been a firefighter or similar first responder, its body having ripped through and absorbed the majority of its uniform.  Its torso and back are swollen, and its muscles are marbled with knotted growths resembling the Nomex fibers of its former gear, feeding into lanky arms that drag on the floor."),
    copy_from = "mon_zombie_grappler",
    default_faction = "zombie",
    symbol = "Z",
    armor = { bash = 15, cut = 18, acid = 14, heat = 22, bullet = 11, electric = 4 },
    hp = 120,
    color = "black_yellow",
    harvest = "zombie_nomex",
    upgrade = false,
    inheritance = {
        add = {
            weakpoint_sets = { "wps_humanoid_turnout_gear", "wps_humanoid_full_helmet" },
            families = { "prof_wp_syn_armored", "prof_wp_nat_armored" },
            flags = { "ACIDPROOF", "FIREPROOF", "RANGED_ATTACKER" },
        },
        remove = { attacks = { "bite_humanoid" } },
    },
    death = { drops = "mon_zombie_fireman_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_fireproof_brute",
    name = ccb.content.plural_text("fireproof brute", "fireproof brutes"),
    description = ccb.content.text("This zombie appears to have once been a firefighter or similar first responder, but the uniform is hardly recognizable at this point, as the thing has grown new flesh and muscle overtop.  Its sinewy body has taken on a composition similar to the uniform's fire-resistant fabric, most of it congealed into a pair of clubs on the ends of its hands."),
    copy_from = "mon_zombie_brute",
    default_faction = "zombie",
    symbol = "Z",
    armor = { bash = 15, cut = 18, acid = 14, heat = 22, bullet = 11, electric = 4 },
    color = "red_yellow",
    harvest = "zombie_nomex",
    upgrade = false,
    hp = 130,
    inheritance = {
        add = {
            weakpoint_sets = { "wps_humanoid_turnout_gear", "wps_humanoid_full_helmet" },
            families = { "prof_wp_syn_armored", "prof_wp_nat_armored" },
            flags = { "ACIDPROOF", "FIREPROOF", "PUSH_VEH" },
        },
        remove = { attacks = { "bite_humanoid", "grab" } },
    },
    death = { drops = "mon_zombie_fireman_death_drops" },
}
