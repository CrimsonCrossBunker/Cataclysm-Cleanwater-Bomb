local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_Apprenticeship",
    line = ccb.content.text("Well…  Kostas is a bit unsure about teaching me, for some reason.  If you could change his mind, I'd pay you some \"icons\", what we've started using for money around here."),
    replies = {
        {
            text = ccb.content.text("No thanks.  <done_conversation_section>"),
            next_topic = "TALK_GODCO_Jeremiah_2",
        },
        {
            text = ccb.content.text("I'll see what I can do for you."),
            actions = { actions.set_actor_value("speaker", "general_mission_convince_kostas", "yes") },
            next_topic = "TALK_DONE",
        },
    },
}
