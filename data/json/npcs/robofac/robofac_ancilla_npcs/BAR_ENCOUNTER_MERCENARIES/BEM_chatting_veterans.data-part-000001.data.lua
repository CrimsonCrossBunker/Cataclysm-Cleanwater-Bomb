local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BEM_CHATTING_VETERANS_HEAR",
    line = ccb.content.text("&The veterans seem happy to have you, and you listen as the older mercenary narrates <merc_story>.\n\nYou all share some drinks while going over the details and as the conversation winds down."),
    on_enter = { { actions = { actions.add_effect("speaker", "drunk", { turns = 1200 }) } } },
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            actions = { "end_conversation" },
            next_topic = "TALK_DONE",
        },
    },
}
