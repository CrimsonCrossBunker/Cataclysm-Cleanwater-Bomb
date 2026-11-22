local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GUNSMITH_CONVERT_CONFIRM",
    line = ccb.content.text("Alright, that's <item_name:<u_val:general_artisans_gunsmith_ammo>>.  I can reload about 200 rounds in one day.  How many do you need?"),
    replies = {
        {
            text = ccb.content.text("[-$<u_val:number_artisans_gunsmith_sum0>, 50 rounds, 6 hours] See you later."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_0bf3200b5d1a"),
            actions = { actions.handler("dlg_a_dda_fb9c00491f16") },
            show_always = true,
        },
        {
            text = ccb.content.text("[-$<u_val:number_artisans_gunsmith_sum1>, 200 rounds, 1 day] See you later."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_3af1e0350a42"),
            actions = { actions.handler("dlg_a_dda_1de84d8c84eb") },
            show_always = true,
        },
        {
            text = ccb.content.text("[-$<u_val:number_artisans_gunsmith_sum3>, 600 rounds, 3 days] See you later."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_1ccca473ad19"),
            actions = { actions.handler("dlg_a_dda_1142e0b26599") },
            show_always = true,
        },
        {
            text = ccb.content.text("[-$<u_val:number_artisans_gunsmith_sum5>, 1000 rounds, 5 days] See you later."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_d2761de8f6a8"),
            actions = { actions.handler("dlg_a_dda_a9eb69af0032") },
            show_always = true,
        },
        {
            text = ccb.content.text("I changed my mind, let's look at the list again."),
            next_topic = "TALK_GUNSMITH_CONVERT_TO_TYPE",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_GUNSMITH_SERVICES",
        },
    },
}
