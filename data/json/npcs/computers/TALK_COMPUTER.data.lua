local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "COMP_REFUGEE_CENTER_MAIN",
    line = ccb.content.text("The computer awaits input…"),
    replies = {
        { text = ccb.content.text("Emergency Message."), next_topic = "COMP_EMERGENCY_MESSAGE" },
        {
            when = predicates.has_mission("MISSION_OLD_GUARD_NEC_COMMO_2"),
            text = ccb.content.text("Disable External Power"),
            next_topic = "COMP_DISABLE_EXTERNAL_POWER",
        },
        { text = ccb.content.text("Contact Us"), next_topic = "COMP_FIND_REFUGEE_CENTER" },
        { text = ccb.content.text("Log off."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_EMERGENCY_MESSAGE",
    line = ccb.content.text("GREETINGS CITIZEN.  A BIOLOGICAL ATTACK HAS TAKEN PLACE AND A STATE OF EMERGENCY HAS BEEN DECLARED.  EMERGENCY PERSONNEL WILL BE AIDING YOU SHORTLY.  TO ENSURE YOUR SAFETY PLEASE FOLLOW THE STEPS BELOW.\n 1. DO NOT PANIC.\n 2. REMAIN INSIDE THE BUILDING.\n 3. SEEK SHELTER IN THE BASEMENT.\n 4. USE PROVIDED GAS MASKS.\n 5. AWAIT FURTHER INSTRUCTIONS."),
    replies = { { text = ccb.content.text("Press any key."), next_topic = "COMP_REFUGEE_CENTER_MAIN" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_DISABLE_EXTERNAL_POWER",
    line = ccb.content.text("--ACCESS GRANTED--\nMission Complete!"),
    replies = {
        {
            text = ccb.content.text("Press any key."),
            next_topic = "COMP_REFUGEE_CENTER_MAIN",
            actions = { actions.finish_mission("MISSION_OLD_GUARD_NEC_COMMO_2", { step = 1 }) },
        },
    },
}

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
