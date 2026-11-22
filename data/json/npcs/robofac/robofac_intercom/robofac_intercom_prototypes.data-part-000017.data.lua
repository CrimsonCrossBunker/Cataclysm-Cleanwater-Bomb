local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_HWP_EXODII_COMPLETE",
    line = {
        when = predicates.handler("dlg_p_dda_f6a45ea987e4"),
        yes = ccb.content.text("The project was a success!  The ammo is fairly rudimentary, but ultimately proved simple to manufacture, and has lent itself well to large magazines.  We will transfer a copy of the conversion kit in a moment; it is capable of accepting specialized magazines that we have just begun to produce ourselves.  Thank you for allowing us this opportunity."),
        no = ccb.content.text("Work is still ongoing.  These things can take time."),
    },
    on_enter = {
        { when = predicates.handler("dlg_p_dda_f6a45ea987e4"), actions = { actions.handler("dlg_a_dda_3e7802f824a8") } },
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_f6a45ea987e4"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_current_project"), actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing"), actions.clear_actor_value("speaker", "timer_hub_rnd_u_waiting_on_hub"), actions.handler("dlg_a_dda_7bdb5baa184c") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}
