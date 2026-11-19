local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_SWAMPER",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_swamper" } }),
        yes = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_eating_asked_about_eating" } }),
            yes = ccb.content.text("The eaters will be fed."),
            no = ccb.content.text("Welcome.  Are you hungry friend?"),
        },
        no = ccb.content.text("You look hungry friend.  So much hunger in this world.  This is the time of the eaters."),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_first_meeting_talked_to_swamper", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Hello.  Who are the eaters?"),
            next_topic = "TALK_SWAMPER_EATING",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_eating_asked_about_eating" } })),
            actions = { actions.set_actor_value("speaker", "dialogue_eating_asked_about_eating", "yes") },
        },
        {
            text = ccb.content.text("So about the eaters…"),
            next_topic = "TALK_SWAMPER_EATING",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_eating_asked_about_eating" } }),
        },
        {
            text = ccb.content.text("You mentioned some pretenders before.  What does that mean?"),
            next_topic = "TALK_SWAMPER_PRETENDER",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_NC_SWAMPER_MISSION_1" } }),
        },
        {
            text = ccb.content.text("Would you like to join me on my travels?"),
            next_topic = "TALK_SUGGEST_FOLLOW_SWAMPER",
            when = predicates.negate(predicates.actor_state("interlocutor", "following")),
        },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_SWAMPER",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Is there a way I can help feed the eaters?"),
            next_topic = "TALK_MISSION_LIST_SWAMPER",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_eating_asked_about_eating" } }),
        },
        {
            text = ccb.content.text("I have to get going.  Take care, CEO Baronyx."),
            next_topic = "TALK_DONE",
        },
    },
}
