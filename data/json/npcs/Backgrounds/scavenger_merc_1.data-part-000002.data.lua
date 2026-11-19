local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_SCAVENGER_MERC_1_NICETRY",
    line = ccb.content.text("I respect where you're coming from, but no.  Not interested.  If you don't like it, I can find another boss easy enough."),
    replies = {
        {
            text = ccb.content.text("Fine, then.  <done_conversation_section>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 20000 }) },
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("Have it your way."),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 20000 }) },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_SCAVENGER_MERC_1_STORY2_BADGERME",
    line = ccb.content.text("<swear!>  You're just gonna keep badgering me about this forever, aintcha.  Fine.  Bring me a bottle of single malt, we share a drink, I tell you the story."),
    replies = {
        {
            text = ccb.content.text("I'll get looking for that.  <done_conversation_section>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("I'll get back to you on that."),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_SCAVENGER_MERC_1_STORY2_OKAY",
    line = ccb.content.text("Yeah, okay.  I can respect that.  How about this: bring me a bottle of single malt, we share a drink, I tell you the story."),
    replies = {
        {
            text = ccb.content.text("I'll get looking for that.  <done_conversation_section>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("I'll get back to you on that."),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "TALK_DONE",
        },
    },
}
