local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Corrie_FirstmeetA", "TALK_GODCO_Corrie_FirstmeetB", "TALK_GODCO_Corrie_FirstmeetC", "TALK_GODCO_Corrie_2", "TALK_GODCO_Corrie_Story", "TALK_GODCO_Corrie_Mission", "TALK_GODCO_Corrie_Mood" },
    replies = {
        {
            text = ccb.content.text("How did you get here?"),
            next_topic = "TALK_GODCO_Corrie_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things, living here?"),
            next_topic = "TALK_GODCO_Corrie_Mood",
        },
        {
            text = ccb.content.text("Are the non-joinees treating you fairly?"),
            next_topic = "TALK_GODCO_Corrie_Community",
        },
        {
            text = ccb.content.text("Want to come with me?"),
            next_topic = "TALK_GODCO_Corrie_Recruit",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_completed_godco_corrie_machine" } }),
        },
        {
            text = ccb.content.text("What needs to be done?"),
            next_topic = "TALK_GODCO_Corrie_Mission",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "in-progress", { scope = "interlocutor", key = "mission_completed_godco_corrie_machine" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_completed_godco_corrie_machine" } })) }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_1",
    line = {
        when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
        yes = ccb.content.text("&Corrie briefly glances at you and shoots a glare.  \"What do you want?\""),
        no = ccb.content.text("Hey there, <name_g>.  Welcome to the losers club."),
    },
    replies = {
        {
            text = ccb.content.text("I'm just passing through."),
            next_topic = "TALK_GODCO_Corrie_FirstmeetA",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_corrie" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_corrie", "yes") },
        },
        {
            text = ccb.content.text("Nice to meet you."),
            next_topic = "TALK_GODCO_Corrie_FirstmeetB",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_corrie" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } }) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_corrie", "yes") },
        },
        {
            text = ccb.content.text("Nice to meet you."),
            next_topic = "TALK_GODCO_Corrie_FirstmeetC",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_corrie" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_corrie", "yes") },
        },
        {
            text = ccb.content.text("Hey Corrie, you free?"),
            next_topic = "TALK_GODCO_Corrie_2",
            when = predicates.handler("dlg_p_dda_06a93d0b5574"),
        },
        {
            text = ccb.content.text("Hey Corrie, you free?"),
            next_topic = "TALK_GODCO_Corrie_Angry",
            when = predicates.handler("dlg_p_dda_7dcd2efc660f"),
        },
        {
            text = ccb.content.text("Hey Corrie.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_corrie" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_FirstmeetA",
    line = ccb.content.text("Well if that's the case, I don't suppose you could help out struggling survivors, do you?"),
    replies = { { text = ccb.content.text("Sorry, not interested."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_FirstmeetB",
    line = ccb.content.text("Hey, we're on the same boat, aren't we?"),
    replies = {
        {
            text = ccb.content.text("What needs to be done?"),
            next_topic = "TALK_GODCO_Corrie_Mission",
        },
        { text = ccb.content.text("Sorry, not interested."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_FirstmeetC",
    line = ccb.content.text("Just so you know, a lot of the folks here might not take to kindly to your appearance.  I'm cool with it, though."),
    replies = {
        {
            text = ccb.content.text("Why would that be?"),
            next_topic = "TALK_GODCO_Corrie_You_Mutant",
        },
        {
            text = ccb.content.text("Thank you for your politeness and generosity.  I'll be seeing you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_2",
    line = {
        choices = { ccb.content.text("Sure.  I can clear a few minutes of my oh-so hectic schedule.") },
    },
    replies = { { text = ccb.content.text("Sorry Corrie.  <end_talking_leave>"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_Story",
    line = ccb.content.text("&Corrie blankly stares at the wall for a moment.  \"Me and my friends were in the cities when it hit, I was the only one to make it out.  Some gigantic horror… devoured… everything in its way.  There was a memorial service and all, organized by the church-goers.  By far the nicest thing they've done for me.\""),
    replies = {
        {
            text = ccb.content.text("Sorry for bringing it up.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Sorry for bringing it up.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_Community",
    line = ccb.content.text("Like second-class citizens, that's how they treat us."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_Mood",
    line = ccb.content.text("I'm just here, really.  I'm the local mechanic around here, I just fiddle with the machinery.  Just about all of it is a <freaking> <name_b>, older than dirt and nearly unfixable.  They're running a wood-fire generator for power, the <freaking> thing is the noisiest clunker I've ever heard."),
    replies = {
        {
            text = ccb.content.text("How have things changed after that deal with Helena?"),
            next_topic = "TALK_GODCO_Corrie_Result_rewardIcon",
            when = predicates.all({ predicates.any_equal({ "icon", { scope = "speaker", key = "mission_reward_godco_machine_reward" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_reward_unclaimed_machine_reward" } }) }),
        },
        {
            text = ccb.content.text("How have things changed after that deal with Helena?"),
            next_topic = "TALK_GODCO_Corrie_Result_rewardRation",
            when = predicates.all({ predicates.any_equal({ "ration", { scope = "speaker", key = "mission_reward_godco_machine_reward" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_reward_unclaimed_machine_reward" } }) }),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("No rest for the weary…"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_Result_rewardIcon",
    line = ccb.content.text("Not much.  I told you not to go for the icons."),
    replies = {
        {
            text = ccb.content.text("Sorry to hear that.  <done_conversation_section>"),
            actions = {
                actions.set_actor_value("interlocutor", "mission_completed_godco_corrie_machine", "yes"),
                actions.set_actor_value("speaker", "mission_completed_godco_corrie_machine", "yes"),
                actions.clear_actor_value("speaker", "mission_reward_unclaimed_machine_reward"),
            },
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("No rest for the weary…"),
            actions = {
                actions.set_actor_value("interlocutor", "mission_completed_godco_corrie_machine", "yes"),
                actions.set_actor_value("speaker", "mission_completed_godco_corrie_machine", "yes"),
                actions.clear_actor_value("speaker", "mission_reward_unclaimed_machine_reward"),
            },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_Result_rewardRation",
    line = ccb.content.text("Yeah, yeah they have.  I've noticed a change in attitude towards us, the new guys.  Positive ones.  Things might be looking up, a little bit."),
    replies = {
        {
            text = ccb.content.text("How about some food as payment?"),
            next_topic = "TALK_GODCO_Corrie_Result_rewardIcon1",
            actions = {
                actions.set_actor_value("interlocutor", "mission_completed_godco_corrie_machine", "yes"),
                actions.set_actor_value("speaker", "mission_completed_godco_corrie_machine", "yes"),
                actions.clear_actor_value("speaker", "mission_reward_unclaimed_machine_reward"),
            },
        },
        {
            text = ccb.content.text("Maybe you can teach me something as payment?"),
            next_topic = "TALK_TRAIN",
            when = predicates.actor_state("interlocutor", "offers_skill_training"),
            actions = {
                actions.set_actor_value("interlocutor", "mission_completed_godco_corrie_machine", "yes"),
                actions.set_actor_value("speaker", "mission_completed_godco_corrie_machine", "yes"),
                actions.clear_actor_value("speaker", "mission_reward_unclaimed_machine_reward"),
            },
        },
        {
            text = ccb.content.text("Glad to help.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
            actions = { actions.set_actor_value("speaker", "mission_completed_godco_corrie_machine", "yes") },
        },
        {
            text = ccb.content.text("Glad to help.  See you around, Corrie."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "mission_completed_godco_corrie_machine", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_Result_rewardIcon1",
    line = ccb.content.text("Oh, I completely forget.  Here you are."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_7ce525ad4b34") } },
    },
    replies = {
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_Mission",
    line = ccb.content.text("Basic repairs and upkeep, mostly.  The generator in the basement is on its last legs, so I've been thinking about building a solar array for this place.  Helena's against it, but I want to change her mind.  All I need are a few spare parts."),
    replies = {
        {
            text = ccb.content.text("I can help you get the items you need."),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_Recruit",
    line = ccb.content.text("Sure, I'll come.  I hate staying here, and you've gone out of your way to help me.  I appreciate that, <name_g>."),
    replies = {
        {
            text = ccb.content.text("<lets_go>"),
            next_topic = "TALK_DONE",
            actions = { "follow", actions.handler("dlg_a_dda_22a5bb9a10f5") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_You_Mutant",
    line = ccb.content.text("Nearly everyone here went to a church that was a bit… out there, shall we say.  They hate what they call \"mutants\", how some creatures and people have physically changed inexplicably after everything went to shit.  I'm glad they didn't kill you on the spot, not many people are left out there."),
    replies = {
        {
            text = ccb.content.text("Well, thank's for telling me.  <done_conversation_section>"),
            next_topic = "TALK_GODCO_Corrie_2",
        },
        {
            text = ccb.content.text("Wow.  This place is fucking crazy, I'm outta here."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_Angry",
    line = ccb.content.text("No, not really.  It's not like I've got any business with you anyways."),
    replies = {
        {
            text = ccb.content.text("What's the attitude for?"),
            next_topic = "TALK_GODCO_Corrie_Angry_Pressed",
        },
        { text = ccb.content.text("I'm outta here then."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_Angry_Pressed",
    line = ccb.content.text("You know freaking well what I'm upset about <name_b>.  Now go away."),
    replies = { { text = ccb.content.text("See you later <name_b>."), next_topic = "TALK_DONE" } },
}
