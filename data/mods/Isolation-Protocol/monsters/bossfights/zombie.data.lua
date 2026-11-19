local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_zombie_survivor_no_weakpoints",
    name = ccb.content.text_without_extraction("zombie survivor test only", "zombie survivor test only"),
    description = ccb.content.text_without_extraction("This zombie survivor is used by hardcoded dps logic and for testing purposes only."),
    copy_from = "mon_zombie_survivor",
    speed = 90,
    dodge = 3,
    attacks = {
        { reference = "SHRIEK", cooldown = 20 },
        { id = "bite_humanoid", cooldown = 5, minimum_damage_multiplier = 1 },
        { id = "grab", cooldown = 7 },
    },
    inheritance = {
        add = { flags = { "NOT_HALLUCINATION" } },
        remove = {
            weakpoint_sets = {
                "wps_humanoid_body", "wps_vital_organs", "wps_eyes", "wps_humanoid_light_armor",
                "wps_humanoid_open_helmet",
            },
        },
    },
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
