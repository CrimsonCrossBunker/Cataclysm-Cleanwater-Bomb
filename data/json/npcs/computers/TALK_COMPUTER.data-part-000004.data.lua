local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "COMP_FIND_REFUGEE_CENTER",
    line = ccb.content.text("REFUGEE CENTER FOUND!  IF YOU HAVE ANY FEEDBACK CONCERNING YOUR VISIT PLEASE CONTACT\n THE DEPARTMENT OF EMERGENCY MANAGEMENT PUBLIC AFFAIRS OFFICE.\n THE LOCAL OFFICE CAN BE REACHED BETWEEN THE HOURS OF 9AM AND\n 4PM AT 555-0164.\n\nIF YOU WOULD LIKE TO SPEAK WITH SOMEONE IN PERSON OR WOULD LIKE\nTO WRITE US A LETTER PLEASE SEND IT TO…"),
    replies = {
        {
            text = ccb.content.text("Make a note of the location."),
            next_topic = "COMP_REFUGEE_CENTER_MAIN",
            when = predicates.handler("dlg_p_dda_42ddc9da4019"),
            actions = { actions.assign_mission("MISSION_REACH_REFUGEE_CENTER"), actions.handler("dlg_a_dda_5052c3e074b4") },
        },
        {
            text = ccb.content.text("Press any key."),
            next_topic = "COMP_REFUGEE_CENTER_MAIN",
            when = predicates.handler("dlg_p_dda_93430a4f1409"),
        },
    },
}
