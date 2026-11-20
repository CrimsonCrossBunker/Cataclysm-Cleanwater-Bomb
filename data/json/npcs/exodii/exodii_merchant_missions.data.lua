local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_EXODII_LABYRINTHS_INTRO",
    name = ccb.content.text("Exodii Labyrinths"),
    description = ccb.content.text("Rubik told me about a place described as interdimensional \"labyrinths\", where I might find all manner of things, including bionics.  He said I can go scout them out if I'm interested in trying to bring back valuable salvage.  I should go downstairs in the castle, and find a terminal next to a metal ring.  Somehow, using that will send me there."),
    goal = "MGOAL_NULL",
    destination = "exodii_base_x0y0z0",
    difficulty = 5,
    value = 0,
    start = {
        target = { terrain = "exodii_base_x0y0z0", special = "exodii_base", reveal_radius = 2, random = false },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}
