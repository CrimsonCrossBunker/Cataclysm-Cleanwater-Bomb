local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_beetle_solar_reverberation",
    name = ccb.content.plural_text("giant solar beetle", "giant solar beetles"),
    description = ccb.content.text("Giant beetle-like robot with a glistening blue plastic shell, its open elytra is covered with curved solar panels.  Despite it's robotic appearance, it motions like an organic creature."),
    copy_from = "mon_diving_beetle_small",
    default_faction = "beetle_solar",
    move_skills = { swim = 0 },
    materials = { "iflesh", "plastic", "glass" },
    color = "light_blue",
    aggression = -100,
    morale = 0,
    melee_skill = 2,
    dodge = 1,
    vision_night = 4,
    harvest = "arachnid_beetle_solar",
    dissect = "dissect_insect_sample_single",
    weakpoint_sets = { "wps_arthropod", "wps_arthropod_beetle" },
    anger_triggers = {},
    fear_triggers = { "FIRE", "FRIEND_ATTACKED", "FRIEND_DIED", "HURT" },
    armor = { bash = 7, cut = 9, bullet = 10, electric = 2 },
    inheritance = {
        add = { flags = { "PATH_AVOID_DANGER", "PATH_AVOID_FALL" } },
        remove = { flags = { "WATER_CAMOUFLAGE" } },
    },
}

ccb.content.define_monster {
    id = "mon_beetle_solar_starving_reverberation",
    name = ccb.content.plural_text("malnourished giant solar beetle", "malnourished giant solar beetles"),
    description = ccb.content.text("Giant beetle-like robot with a scratched blue plastic shell, the exterior of its open elytra is covered with curved solar panels.  Despite weak attempts, it can't move."),
    melee_skill = 0,
    dodge = 0,
    harvest = "arachnid_beetle_solar_starving",
    copy_from = "mon_beetle_solar_reverberation",
    hp = 30,
    inheritance = { add = { flags = { "IMMOBILE" } } },
}
