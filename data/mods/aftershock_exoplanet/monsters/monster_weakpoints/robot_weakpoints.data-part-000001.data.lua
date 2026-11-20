local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_weakpoint_set {
    id = "afs_wps_robot_explode",
    points = {
        {
            id = "power_plant",
            name = ccb.content.text("the exposed reactor"),
            coverage = 5,
            difficulty = { melee = 4, ranged = 5 },
            when = predicates.has_effect("interlocutor", "maimed_armor"),
            attack_coverage = { melee = 0 },
            armor_multiplier = { all = 2 },
            effects = {
                {
                    chance = 100,
                    message = ccb.content.text("The %s sounds a nuclear alarm horn as its power plant detunes!  Run!"),
                    damage_percent = { 2, 100 },
                    on_hit = "eject_damaged_reactor",
                },
            },
        },
    },
}
