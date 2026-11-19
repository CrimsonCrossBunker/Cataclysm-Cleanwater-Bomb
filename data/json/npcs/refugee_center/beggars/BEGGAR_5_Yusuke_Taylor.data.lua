local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_5_TRAVEL2",
    line = ccb.content.text("Huh.  Getting those three to sign on to a suicide mission is quite the feat… sounds like you're pretty dedicated to this.  OK, I'm with you.  Let's round up the others and hit the road."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "general_recruit_beggars_recruited", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Right.  <lets_go>"),
            next_topic = "TALK_DONE",
            actions = { "follow" },
        },
    },
}
