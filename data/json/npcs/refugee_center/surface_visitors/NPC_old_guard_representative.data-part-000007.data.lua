local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_REP_3",
    name = ccb.content.text("Find Source of Robots"),
    description = ccb.content.text("Go to the supposed source of the weird robots marked on your map and report back to the Old Guard representative what you've seen."),
    goal = "MGOAL_CONDITION",
    difficulty = 2,
    value = 10000,
    start = {
        target = { terrain = "exodii_base_x0y3z0", special = "exodii_base", reveal_radius = 5 },
        handler = "set_world_old_guard_rep_scouting_to_1",
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_OLD_GUARD_REP_4",
    dialogue = {
        describe = ccb.content.text("Got a weird one for you this time…"),
        offer = ccb.content.text("I don't usually hear much from command, but we got a message by radio recently.  You might be the right choice to look into it for me.  There've been reports of weird robots and things wandering around since things went south.  Dunno how, but apparently command tracked down what they think is the source.  They want someone to go check out who is making these, and if we can get any tech or assistance from them.  This is strictly recon, you understand: could be a hostile entity, so do not engage directly.  Report back to me when you've found out something."),
        accepted = ccb.content.text("Thanks, once you know who it is, report back to me and I'll pass that on."),
        rejected = ccb.content.text("Come back when you get a chance, if there's any chance these things are on our side, we need all the help we can get."),
        advice = ccb.content.text("If you see any weird machines around, do not engage.  Sneak away, I'd say.  They seem to be hostile to zombies, but that doesn't mean they can tell you aren't one."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Great work, wasn't sure what I was sending you after."),
        success_lie = ccb.content.text("That's a shame, a damn shame.  Wish you could have learned more.  Thanks for trying."),
        failure = ccb.content.text("Damn… let's hope we can try again sometime."),
    },
    finish = { handler = "set_factional_questline_mission_oldguard-exodii_to_encountered_base" },
    complete_when = "complete_mission_old_guard_rep_3",
}
