local ccb = require("ccb")

ccb.content.define_weakpoint_set {
    id = "afs_wps_moxie_infested",
    points = {
        {
            id = "afs_wps_moxie_infested_upper_body",
            name = ccb.content.text("the upper body"),
            coverage = 65,
            effects = {
                {
                    chance = 100,
                    message = ccb.content.text("One of the parasites is dislodged by the blow."),
                    damage_percent = { 2, 100 },
                    on_hit = "moxie_parasite_hit",
                },
            },
        },
    },
}
