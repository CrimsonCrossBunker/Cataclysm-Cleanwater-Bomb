local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_Liam_CHAT",
    line = {
        choices = {
            ccb.content.text("Before things ended did you see any of the interviews with some of the remaining Wampanoag?  They kept saying things about other races coming back to this planet.  That's crazy, right?"),
            ccb.content.text("A few nights after I got here, I saw lights in the woods off in the distance.  I don't know why, but I ran back into the house turned off all the lights and closed the blinds.  It was just so eerie!"),
        },
    },
    on_enter = {
        {
            actions = {
                "morale_chat_activity",
                actions.add_effect("interlocutor", "asked_to_socialize", { turns = 7000 }),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("We're always gonna be friends, right?  Even with the apocalypse… changing us?"),
            next_topic = "TALK_FRIEND_Liam_CHAT_Friends4ever",
        },
        {
            text = ccb.content.text("What do you miss most about the internet?"),
            next_topic = "TALK_FRIEND_Liam_CHAT_Internet",
        },
        {
            text = ccb.content.text("Now that we've got no responsibilities, is there anything you'd like to see or do?"),
            next_topic = "TALK_FRIEND_Liam_CHAT_Goals",
        },
        {
            text = ccb.content.text("What do you think the rest of the world is like these days?"),
            next_topic = "TALK_FRIEND_Liam_CHAT_World",
        },
        {
            text = ccb.content.text("Do you miss any food from the old days?"),
            next_topic = "TALK_FRIEND_Liam_CHAT_Food",
        },
    },
}
