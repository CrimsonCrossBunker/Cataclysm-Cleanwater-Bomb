local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_MERC_1_RETURN_TO_HUB",
    name = ccb.content.text("Return to Hub 01"),
    description = ccb.content.text("With the source of the radio tower's interference fixed, return to Hub 01 with Cranberry."),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "robofachq_surface_entrance",
    difficulty = 0,
    value = 0,
    start = {
        target = { terrain = "robofachq_surface_entrance", special = "hub_01", reveal_radius = 1, z = 0 },
    },
    finish = {
        actions = {
            "stop_following",
            { handler = "advance_favor_owed_to_u_robofac_merc_1_favor_by_1" },
            ccb.content.dialogue_actions.clear_actor_value("interlocutor", "general_robofac_merc_1_temporal_follower"),
            ccb.content.dialogue_actions.set_actor_value("speaker", "general_robofac_merc_1_helped_with_missions", "yes"),
            { handler = "reward_robofac_merc_trust" },
            { handler = "reward_robofac_merc_value" },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("Let's get back home."),
        accepted = ccb.content.text("Alright, let's be off.  You don't mind taking point, right?"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("Hey, you have a map, don't you?  You can use mine, if you need."),
        inquire = ccb.content.text("Are we there yet?"),
        success = ccb.content.text("Thanks a lot for having my back.  Like I said, I owe you one."),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}
