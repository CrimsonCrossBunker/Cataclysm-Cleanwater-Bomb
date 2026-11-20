local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_FIND_VAMPIRE_HUNTER_BASE",
    name = ccb.content.text("Find the building from the smudged map."),
    description = ccb.content.text("You found a map pointing to a building on a vampire's corpse.  Going there might not be safe, but it will surely be worth it."),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "lodge_VH_ground1",
    difficulty = 1,
    value = 0,
    start = { target = { terrain = "lodge_VH_ground1", special = "Vampire Hunter Lodge" } },
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
