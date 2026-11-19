local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Pablo_Bakery-Engineer1",
    line = ccb.content.text("I… I honestly don't know why I didn't think of that.  I could even have asked the supply caravans to do it.  If it comes down to it though, I trust you more than them.  Would you mind?"),
    on_enter = {
        {
            actions = {
                actions.assign_mission("MISSION_TACOMA_Pablo_Message"),
                actions.set_actor_value("speaker", "message_jenny_tacoma_mill", "helped"),
            },
        },
    },
    replies = {
        { text = ccb.content.text("Sure.  <done_conversation_section>"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Sure, I'll see what I can do."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Pablo_Bakery-RootCellar1",
    line = ccb.content.text("Oh… oh, ok!  It's a good thing you showed me this, my basic guesses missed some important points.  Thanks, this will be helpful for a lot more than just the bakery."),
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "rootcellar_tacoma_bakery", "helped") },
        },
    },
    replies = {
        {
            text = ccb.content.text("No problem.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("Any time!  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}
