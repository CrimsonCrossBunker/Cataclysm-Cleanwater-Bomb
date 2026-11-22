local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CONVERSATION_DANGER",
    line = ccb.content.gendered_line("Are you sure?  This doesn't seem like a particularly safe place for small talk…", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("It's fine, we've got a moment."),
            next_topic = "TALK_FRIEND_CONVERSATION",
            when = predicates.any({ predicates.has_flag("interlocutor", "BG_SURVIVAL_STORY"), predicates.has_trait("interlocutor", "NPC_STATIC_NPC") }),
            switch = true,
        },
        {
            text = ccb.content.text("It's fine, we've got a moment."),
            next_topic = "TALK_FRIEND_CONVERSATION",
            actions = { actions.replace_mutation("interlocutor", "BGSS_No_Past_1") },
            switch = true,
        },
        {
            text = ccb.content.text("Good point, let's find a more appropriate place."),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("You're right.  <lets_go>"),
            next_topic = "TALK_DONE",
        },
    },
}
