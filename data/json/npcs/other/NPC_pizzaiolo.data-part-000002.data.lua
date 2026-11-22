local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_pizzaiolo_following",
    line = ccb.content.text("Are we there yet, my <name_g>?"),
    replies = {
        {
            text = ccb.content.text("We're here, <name_g>.  Let's celebrate."),
            next_topic = "TALK_pizzaiolo_celebrate",
            when = predicates.all({ predicates.actor_state("interlocutor", "mission_complete"), predicates.has_item("speaker", "cake2") }),
            actions = { "mission_success", "clear_mission", actions.handler("dlg_a_dda_da9f396845ea") },
        },
        {
            text = ccb.content.text("Be patient.  We'll be there soon, <name_g>"),
            next_topic = "TALK_DONE",
        },
    },
}
