local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE3",
    line = ccb.content.text("I know all the grown-ups worry about us, but I think we can adapt better than them in the long run.  Chris - my cousin - has some interesting thoughts on the matter."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "u_heard_about_chris", "yes"),
                actions.set_actor_value("speaker", "u_heard_about_chris_ideas", "yes"),
            },
        },
    },
    replies = {
        { text = ccb.content.text("Where can I find Chris?"), next_topic = "TALK_LUKE_CHRIS" },
        {
            text = ccb.content.text("What sort of ideas does Chris have?"),
            next_topic = "TALK_LUKE_CHRIS2",
        },
        {
            text = ccb.content.text("That is a good idea, what do you need?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text("I'm not interested right now.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
