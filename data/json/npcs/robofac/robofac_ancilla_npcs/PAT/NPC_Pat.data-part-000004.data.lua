local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_SMOKES_MAKE_FRIENDS_2",
    line = ccb.content.text("After a few somber moments the conversation turns to baseball, which Pat is passionate about and seems to miss.  A few minutes later Pat starts to clean up.  \"THAT was the most fun I've had in a while.  Good to make'a friend.  I'll clean up, yeah?  Swing by again sometime, maybe we can shoot the shit or work on somethin' togethah.\""),
    on_enter = {
        {
            actions = {
                "morale_chat_activity",
                actions.add_effect("interlocutor", "asked_to_socialize", { turns = 7000 }),
            },
        },
    },
    replies = { { text = ccb.content.text("See you around, Pat."), next_topic = "TALK_DONE" } },
}
