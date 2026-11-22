local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_lighthouse",
    line = ccb.content.text("Are we there yet, <name_g>?"),
    replies = {
        {
            text = ccb.content.text("I want you to use this item."),
            next_topic = "TALK_lighthouse_man_lighthouse",
            actions = { "npc_gets_item_to_use" },
        },
        {
            text = ccb.content.text("We're here."),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.actor_state("interlocutor", "mission_complete"),
            actions = { "stop_following", actions.set_first_topic("TALK_lighthouse_man_1") },
        },
        {
            text = ccb.content.text("Almost."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_cleaning",
    line = ccb.content.text("Is it safe, my <name_g>?"),
    replies = {
        {
            text = ccb.content.text("Yes.  Ground floor is clear."),
            next_topic = "TALK_lighthouse_man_cleaned",
            when = predicates.handler("dlg_p_dda_fec335eb9be6"),
            actions = { actions.handler("dlg_a_dda_a7048e987687") },
        },
        {
            text = ccb.content.text("Yes.  First floor is clear."),
            next_topic = "TALK_lighthouse_man_cleaned",
            when = predicates.handler("dlg_p_dda_68b8f4637593"),
            actions = { actions.handler("dlg_a_dda_a7048e987687") },
        },
        {
            text = ccb.content.text("Yes.  Second floor is clear."),
            next_topic = "TALK_lighthouse_man_cleaned",
            when = predicates.handler("dlg_p_dda_29d23b48e708"),
            actions = { actions.handler("dlg_a_dda_a7048e987687") },
        },
        {
            text = ccb.content.text("Yes.  Third floor is clear."),
            next_topic = "TALK_lighthouse_man_cleaned",
            when = predicates.handler("dlg_p_dda_98ac3e0825da"),
            actions = { actions.handler("dlg_a_dda_a7048e987687") },
        },
        {
            text = ccb.content.text("Yes.  Fourth floor is clear."),
            next_topic = "TALK_lighthouse_man_cleaned",
            when = predicates.handler("dlg_p_dda_da9c2bf37a4d"),
            actions = { actions.handler("dlg_a_dda_a7048e987687") },
        },
        {
            text = ccb.content.text("Yes.  Top floor is clear."),
            next_topic = "TALK_lighthouse_man_cleaned_done",
            when = predicates.handler("dlg_p_dda_b06a4ea01e6e"),
            actions = { actions.handler("dlg_a_dda_a7048e987687") },
        },
        {
            text = ccb.content.text("Looks like that's over."),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.handler("dlg_p_dda_2a9fd24c7bad"),
            actions = { actions.handler("dlg_a_dda_a7048e987687") },
        },
        {
            text = ccb.content.text("Not yet."),
            next_topic = "TALK_DONE",
        },
    },
}
