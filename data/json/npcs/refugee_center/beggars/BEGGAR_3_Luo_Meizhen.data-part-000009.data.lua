local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_INSULTED",
    line = ccb.content.gendered_line("Oooooh.  Oh.  You did not just fucking go there.  Let's leave the fatties to die, hey?  Wanna know how easy it is to find fucking *thyroid medication* after the apocalypse, asshat?  Besides, there are more skills than heavy lifting needed now… no, you know what?  Screw it.  You're not worth my time.", { "speaker" }),
    on_enter = {
        {
            actions = {
                actions.add_effect("interlocutor", "insulted_luo", { turns = 28800 }),
                actions.set_actor_value("interlocutor", "general_conversation_dont_insult_luo", "yes"),
            },
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
