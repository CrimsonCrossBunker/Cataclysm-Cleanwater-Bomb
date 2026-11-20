local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_VAMPIRE_HUNTER_DOCTOR_FIND_GINSENG",
    name = ccb.content.text("Find some elder ginseng for Blaine"),
    goal = "MGOAL_CONDITION",
    description = ccb.content.text("Blaine needs elder ginseng for the life extension potion and has asked you to bring some to him."),
    difficulty = 7,
    value = 50000,
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
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
