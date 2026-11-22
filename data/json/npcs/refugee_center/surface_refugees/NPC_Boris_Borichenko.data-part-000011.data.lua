local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_MakeDoWith2",
    line = ccb.content.gendered_line("Hmm, well it is not ideal but I appreciate you trying and being willing to help.  I will have to do my best despite the bad memories.  Thank you, my friend.", { "speaker" }),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_d027843b7b0d"), actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("OK, let's get to work."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_MakeDoWith3",
    line = ccb.content.gendered_line("Thank you for trying, my friend.  With you and me that will be five, I will do my best to be strong and assist in the cleanup.", { "speaker" }),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_6f847e7a3114"), actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("OK, let's get to work."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_MakeDoWith4",
    line = ccb.content.gendered_line("That is quite alright, four should be enough though I appreciate your offer.  Four people will make the job much easier and I will do my best even if it is painful.  My thanks, friend.", { "speaker" }),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_1771a2e9be11"), actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Good to hear.  I'm sure everyone will appreciate that place being cleaned up."),
            next_topic = "TALK_DONE",
        },
    },
}

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
