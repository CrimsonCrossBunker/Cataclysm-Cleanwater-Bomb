local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Boris_CLEANUP",
    name = ccb.content.text("Find someone to clean up the back bay."),
    description = ccb.content.text("Boris in the refugee center is looking for at least five people to help clean up the back bay."),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_CONDITION",
    followup = "MISSION_REFUGEE_Boris_WORKSPACE",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Find a few people able to help clean the back, people without too much trauma there."),
        offer = ccb.content.text("Yes, please.  If you can ask around for someone who can help, I can gather the tools they will need and some payment for them."),
        accepted = ccb.content.text("You are a kind soul."),
        rejected = ccb.content.text("Ah well.  I can ask around myself, perhaps."),
        advice = ccb.content.text("Those of us here in the back have too many bad memories, but perhaps someone who didn't come with the original refugee groups would be less burdened."),
        inquire = ccb.content.text("Greetings, my friend.  Have you found anyone?"),
        success = ccb.content.text("This has great promise.  Perhaps something to keep me busy will help.  Here, I found some small money to thank you."),
        success_lie = ccb.content.text("I see….  Well I shall get things in order!"),
        failure = ccb.content.text("No worries.  Let me know if you want to try again."),
    },
    finish = {
        actions = {
            { item = "FMCNote", count = 5 },
            ccb.content.dialogue_actions.set_actor_value("speaker", "mission_completed_Boris_mission_1", "yes"),
            ccb.content.dialogue_actions.set_first_topic("TALK_REFUGEE_Boris_1b"),
            ccb.content.dialogue_actions.set_actor_value("speaker", "proven_worth_to_old_guard_representative", "yes"),
            { handler = "advance_counter_refugee_center_refugee_happiness_by_3" },
            ccb.content.dialogue_actions.update_map("boris_cleanup_garage", "evac_center_8"),
            ccb.content.dialogue_actions.update_map("boris_cleanup_back_bay", "evac_center_9"),
        },
    },
    complete_when = "complete_mission_refugee_boris_cleanup",
}
