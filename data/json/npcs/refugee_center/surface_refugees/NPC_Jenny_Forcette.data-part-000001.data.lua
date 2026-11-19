local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_1",
    line = ccb.content.text("*is a thin woman in her early thirties, with the sort of pale, freckled skin that looks like it would burn if she thought too hard about the sun.  Her clothes and bearing suggest she might once have been carefully put-together, but she now has the harried look of someone with too many worries and too little sleep.  She looks up from a laptop and smiles as you approach.  \"Hi there.  Haven't see you around here before.  I'm Jenny, Jenny Forcette.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Jenny_Forcette", "yes"),
                actions.set_first_topic("TALK_REFUGEE_JENNY_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice meeting you.  What are you doing on that computer?"),
            next_topic = "TALK_REFUGEE_JENNY_2",
        },
        {
            text = ccb.content.text("Nice meeting you.  I'd best get going, though."),
            next_topic = "TALK_DONE",
        },
    },
}
