local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_boomer_monochrome",
    name = ccb.content.plural_text("monochrome boomer", "monochrome boomers"),
    description = ccb.content.text("A rotund human body, bloated beyond belief.  Its entire body is tainted gray, and it seems to emit a pulsating distortion that saps color from the world around it.  Every few seconds the world around it seems to freeze, and its likely that any damage will easily detonate the distorted time the zombie barely holds within itself."),
    copy_from = "mon_boomer",
    symbol = "B",
    color = "light_gray",
    emissions = { { id = "xedra_monochrome_boomer_frozen_time", delay = "1 s" } },
    upgrade = false,
    inheritance = {
        add = { flags = { "STABILIZED_TIMELINE" } },
        remove = { attacks = { "boomer_bile" } },
        scale = { speed = 1.1 },
    },
    death = {
        outcome = {
            spell = { id = "xedra_death_boomer_monochrome", hit_self = true },
            message = ccb.content.text("Everything around the %s suddenly stops!"),
            corpse = "NO_CORPSE",
        },
    },
}

-- Keep zapback, remove the zombie suplexing you thing
ccb.content.define_monster {
    id = "mon_zombie_oa_agent",
    looks_like = "mon_zombie_bio_op",
    name = ccb.content.plural_text("former OA field agent", "former OA field agents"),
    description = ccb.content.text("This armored soldier zombie appears to have been some sort of special forces agent, with the letters \"OA\" prominently written on its armor.  The occasional odd spark emits from a rent in its armor."),
    copy_from = "mon_zombie_base",
    difficulty_adjustment = 5,
    hp = 120,
    speed = 95,
    color = "red_cyan",
    melee_skill = 5,
    melee_dice = 2,
    melee_sides = 6,
    melee_damage = { { type = "electric", amount = 4 } },
    luminance = 4,
    defense = { id = "ZAPBACK", chance = 75 },
    armor = { bash = 10, cut = 18, stab = 18, bullet = 25, electric = 3 },
    dissect = "dissect_mon_zombie_oa_agent",
    inheritance = {
        add = {
            weakpoint_sets = { "wps_humanoid_body_armor", "wps_humanoid_open_helmet", "wps_humanoid_gasmask" },
            families = { "prof_wp_syn_armored" },
            flags = { "ELECTRIC" },
        },
    },
    death = { drops = "mon_zombie_oa_agent_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_scientist",
    copy_from = "mon_zombie_scientist",
    dissect = "dissect_mon_zombie_scientist_xe",
}
