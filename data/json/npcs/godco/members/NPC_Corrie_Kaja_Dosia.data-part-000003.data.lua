local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

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
