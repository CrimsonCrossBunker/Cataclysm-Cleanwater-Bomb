local ccb = require("ccb")

ccb.content.define_mission {
    id = "EXODII_MISSION_MEET_FREE_MERCHANTS",
    name = ccb.content.text("Go to the Refugee Center and negotiate a trade deal between the Free Merchants and the Exodii.  Don't forget to take the Exodii \"talk-rad talk-vid\"."),
    goal = "MGOAL_NULL",
    destination = "evac_center_18",
    start = {
        target = { terrain = "evac_center_18", special = "evac_center", reveal_radius = 4, random = false },
    },
    finish = { handler = "mark_mission_completed_exodii_mission_meet_free_merchants" },
    difficulty = 5,
    value = 2,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = "",
        offer = "",
        accepted = "",
        rejected = "",
        advice = "",
        inquire = "",
        success = "",
        success_lie = "",
        failure = "",
    },
}
