local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_REACH_FAKE_DAVE",
    name = ccb.content.text("Find fake Dino Dave"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 2,
    value = 60000,
    start = { target = { terrain = "hunter_shack", reveal_radius = 5, special = "Swamp Shack" } },
    origins = { "ORIGIN_SECONDARY" },
    destination = "hunter_shack",
    dialogue = {
        describe = ccb.content.text("It must be an alien probe…"),
        offer = ccb.content.text("I think the shack was that way.  Might have cleared out but who knows.  Watch out for space lasers."),
        accepted = ccb.content.text("You'll see, it's just like I say."),
        rejected = ccb.content.text("You'll see, it's just like I say."),
        advice = ccb.content.text("There aren't a lot of things to have faith for in the world today, but if I were you I would bring some cardboard."),
        inquire = ccb.content.text("Did you see the probe?"),
        success = ccb.content.text("I knew it.  Good."),
        success_lie = ccb.content.text("I knew it.  Good."),
        failure = ccb.content.text("Could have been another shack.  I don't know, lots going on."),
    },
}
