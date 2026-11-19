local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_2_NOTYET",
    line = ccb.content.text("I appreciate the sentiment, but I don't think it would.  Drop it."),
    replies = {
        {
            text = ccb.content.text("OK."),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 7000 }) },
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 7000 }) },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_2_FUCKOFF",
    line = ccb.content.text("Oh, just shut the fuck up already.  This doesn't have anything to do with you, or with us."),
    replies = {
        {
            text = ccb.content.text("…"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 14000 }) },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_2_STORY2",
    line = {
        choices = {
            {
                when = predicates.actor_state("interlocutor", "female"),
                yes = ccb.content.text("All right, fine.  I had someone.  I lost him."),
                no = ccb.content.text("All right, fine.  I had someone.  I lost her."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("What happened?"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "BGSS_LOST_PARTNER_2_STORY3",
        },
        {
            text = ccb.content.text("Never mind.  Sorry I brought it up."),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "TALK_DONE",
        },
    },
}
