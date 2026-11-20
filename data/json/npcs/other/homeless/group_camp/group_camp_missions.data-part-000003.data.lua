local ccb = require("ccb")

-- TO-DO - Dynamic response dialogs would be more natural to accept so many alternate items here and everywhere else these conditional item accept conditions appear.
ccb.content.define_mission {
    id = "MISSION_BUILD_CAMP_3",
    name = ccb.content.text("Refurbishments Pt. III"),
    description = ccb.content.text("Obtain 6 ropes."),
    goal = "MGOAL_CONDITION",
    difficulty = 1,
    value = 2500,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_BUILD_CAMP_4",
    finish = {
        map_updates = {
            {
                terrain = "homelesscamp_npc",
                layout = { nested = { { x = 0, y = 0, id = "homeless_camp_refurb_3" } } },
            },
        },
    },
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need some help."),
        offer = ccb.content.text("Our entrance is wide open so we're building a gate over it.  Problem is we don't have any ropes.  If you could find some for us, we'll pay you."),
        advice = ccb.content.text("If you can't find any rope around, one of our books should have something on rope-making.  Most plants can be woven into a halfway decent rope."),
        accepted = ccb.content.text("Thank you.  We'll be sure to compensate your efforts."),
        rejected = ccb.content.text("Alright, I can understand that.  I guess I'll have to get it myself."),
        inquire = ccb.content.text("Do you have my ropes?"),
        success = ccb.content.text("Thank you.  We'll start right away."),
        success_lie = ccb.content.text("I can tell you're lying.  I don't see shit."),
        failure = ccb.content.text("Ah, well.  It's no big deal."),
    },
    complete_when = "complete_mission_build_camp_3",
}

-- TO-DO - Dynamic response dialogs would be more natural to accept so many alternate items here and everywhere else these conditional item accept conditions appear.
ccb.content.define_mission {
    id = "MISSION_BUILD_CAMP_4",
    name = ccb.content.text("Refurbishments Pt. IV"),
    description = ccb.content.text("Obtain a wood saw."),
    goal = "MGOAL_CONDITION",
    difficulty = 1,
    value = 2500,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_BUILD_CAMP_5",
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need some help."),
        offer = ccb.content.text("We appreciate all of your help but we can't rely on everyone else to do things for us.  I'd be willing to buy a wood saw of some kind from you so we can cut our own wood as needed."),
        advice = ccb.content.text("A hardware store or lumbermill should have one."),
        accepted = ccb.content.text("Thank you.  We'll be sure to compensate your efforts."),
        rejected = ccb.content.text("Alright, I can understand that.  I guess I'll have to get it myself."),
        inquire = ccb.content.text("Do you have my saw?"),
        success = ccb.content.text("Thank you.  Pick what you want from our stash."),
        success_lie = ccb.content.text("I can tell you're lying.  I don't see shit."),
        failure = ccb.content.text("Ah, well.  It's no big deal."),
    },
    complete_when = "complete_mission_build_camp_4",
}
