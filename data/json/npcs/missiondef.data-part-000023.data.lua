local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_LEARN_ABOUT_CATTAIL_JELLY",
    name = ccb.content.text("Gather cattail stalks to create cattail jelly"),
    description = ccb.content.text("Gather <color_yellow>60 cattail stalks</color> from the swamp and bring them back to <color_light_red>learn how to craft cattail jelly</color>.  Raise your <color_yellow>survival skill to at least 1</color> by harvesting cattail stalks.  <color_yellow>Bring back the provided bag with the 60 cattail stalks in them</color> as well."),
    goal = "MGOAL_CONDITION",
    difficulty = 1,
    value = 0,
    generic_rewards = false,
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    start = { target = { terrain = "forest_water", reveal_radius = 3 }, actions = { { item = "swag_bag" } } },
    finish = {
        actions = {
            ccb.content.dialogue_actions.transfer_items("cattail_stalk", 60),
            ccb.content.dialogue_actions.transfer_items("swag_bag"),
            { handler = "prepare_60_cattail_stalks" },
            { handler = "teach_cattail_jelly" },
            ccb.content.dialogue_actions.notify_player(ccb.content.text("You learn how to craft cattail jelly.")),
            { item = "cattail_jelly", count = 5, container = "bag_zipper" },
        },
    },
    dialogue = {
        describe = ccb.content.text("Medical services are a little sparse following <the_cataclysm>, but people have been surviving using their wits and the bounty of Mother Nature for a long time.  Care to learn a little?"),
        offer = ccb.content.text("Did you know that cattails are a source of a jelly that works as an antiseptic and analgesic?  Something like that is likely to be mighty helpful out here.  I want you to take this bag, head to the nearest swamp, collect 60 cattail stalks, and bring them back here.  In exchange, I'll show you how to harvest the jelly."),
        accepted = ccb.content.text("Great!  <color_yellow>This bag should be big enough to hold all of the stalks we'll need.  Don't forget to bring it back.</color>"),
        rejected = ccb.content.text("Your loss."),
        advice = ccb.content.text("The cattails grow in the fresh water in swamps.  You can't miss them."),
        inquire = ccb.content.text("Got those cattail stalks yet?  Don't forget to <color_yellow>bring back my bag with the stalks in them</color> and to work on improving your survival skill as well."),
        success = ccb.content.text("Great!  Hand them over and I'll show you how this works."),
        success_lie = ccb.content.text("OK, then hand them over."),
        failure = ccb.content.text("Well, that's a shame."),
    },
    complete_when = "complete_mission_learn_about_cattail_jelly_swag_bag",
}
