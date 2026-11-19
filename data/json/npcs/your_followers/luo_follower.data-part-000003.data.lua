local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- TK: custom chat topics here that actually include small talk that expands her character, while still giving the socialize bonus.
ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_LUO_CHAT",
    line = ccb.content.gendered_line("Seen any good movies lately?", { "speaker" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<chitchat_player_responses>"),
            next_topic = "TALK_DONE",
            switch = true,
            actions = {
                "morale_chat_activity",
                actions.add_effect("interlocutor", "asked_to_socialize", { turns = 7000 }),
            },
        },
    },
}
