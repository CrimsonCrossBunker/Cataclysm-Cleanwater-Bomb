local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_SHELTER",
    line = {
        choices = {
            ccb.content.text("Well, I guess it's just us."),
            ccb.content.text("At least we've got shelter."),
        },
    },
    replies = {
        { text = ccb.content.text("What should we do now?"), next_topic = "TALK_SHELTER_PLANS" },
        { text = ccb.content.text("Any tips?"), next_topic = "TALK_SHELTER_ADVICE" },
        { text = ccb.content.text("Can I do anything for you?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text("Want to travel with me?"),
            next_topic = "TALK_SUGGEST_FOLLOW",
            when = predicates.negate(predicates.actor_state("interlocutor", "following")),
        },
        {
            text = ccb.content.text("Let's trade items."),
            when = predicates.has_trait("interlocutor", "NPC_STARTING_NPC"),
            next_topic = "TALK_SHELTER",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Let's trade items."),
            when = predicates.negate(predicates.has_trait("interlocutor", "NPC_STARTING_NPC")),
            next_topic = "TALK_NONE",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Want to share some useful items with me?"),
            next_topic = "TALK_SHARE_EQUIPMENT",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
