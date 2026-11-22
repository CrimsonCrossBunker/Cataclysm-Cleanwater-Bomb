local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_Dnd",
    line = ccb.content.text("Yeah, I play.  I ran a campaign for a while with some of my friends, we'd play after school.  I don't know where they are now, though.  Do you wanna play some?"),
    replies = {
        {
            text = ccb.content.text("Sure, I'm up for it."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_7cc77414dbc2") },
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Jeremiah_2",
        },
        {
            text = ccb.content.text("No thanks.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
