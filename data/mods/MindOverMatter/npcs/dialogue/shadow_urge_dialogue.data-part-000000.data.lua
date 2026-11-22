local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_MOM_SHADOW_URGE_MACHINE" },
    line = {
        choices = {
            {
            when = predicates.handler("dlg_p_mindovermatter_e91697b237dd"),
            yes = ccb.content.text("&You sit down and activate the screen, trying to ignore your awkward positioning, and within a few moments are greeted with a login prompt.\n\n\"Project SHADOW URGE.  Enter login credentials.\""),
            no = ccb.content.text("&You poke at the computer, and while it does turn on and you see a login screen for a moment, it's quickly replaced with a popup that reads:\n\n\"No occupant detected.  SHADOW URGE functions unavailable.\""),
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("Input the SHADOW URGE access codes you have."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_KNOWN_PASS",
            when = predicates.handler("dlg_p_mindovermatter_021703ba852f"),
        },
        {
            text = ccb.content.text("Try a random username and password."),
            next_topic = "COMP_MOM_SHADOW_URGE_COMPUTER_RANDOM_PASS",
            when = predicates.handler("dlg_p_mindovermatter_f86c1b9c97f9"),
        },
        {
            text = ccb.content.text("Better sit down."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_mindovermatter_32f7e13ae876"),
        },
    },
}
