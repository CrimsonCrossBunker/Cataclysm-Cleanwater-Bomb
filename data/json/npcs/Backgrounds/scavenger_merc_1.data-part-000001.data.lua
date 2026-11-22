local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_SCAVENGER_MERC_1_FUCKOFF",
    line = ccb.content.gendered_line("No dice.  You asked me to come along.  This is what you get.  If you don't like it, I'll take my fee and go back to the center.  Ain't hard to find contracts.", { "speaker" }),
    on_enter = {
        { opinion = { fear = -1 } },
    },
    replies = {
        {
            text = ccb.content.text("Fine, then.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 20000 }) },
        },
        {
            text = ccb.content.text("Have it your way."),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 20000 }) },
        },
    },
}
