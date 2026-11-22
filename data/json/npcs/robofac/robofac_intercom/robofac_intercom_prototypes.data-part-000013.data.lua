local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_HEW_UPGRADE_COMPLETE",
    line = {
        when = predicates.handler("dlg_p_dda_479e16cc31b2"),
        yes = ccb.content.text("The NRE has been integrated into the HEW."),
        no = ccb.content.text("Work is still ongoing."),
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_479e16cc31b2"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_current_project"), actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing"), actions.clear_actor_value("speaker", "timer_hub_rnd_u_waiting_on_hub"), actions.handler("dlg_a_dda_26411ca6123b") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_IVAS_COMPLETE",
    line = {
        when = predicates.handler("dlg_p_dda_479e16cc31b2"),
        yes = ccb.content.text("We've reverse engineered the headset and were able to 'trim the fat,' so to speak, as a good deal of the internals were dedicated to GPS and other non-functional devices.  We've been able to produce a superior in-house version and have integrated it into our standard recon helmet.  We ask that you keep detailed notes on its function for us.  If you die, we will send a field team to retrieve it, so please don't damage it."),
        no = ccb.content.text("Work is still ongoing."),
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_479e16cc31b2"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_current_project"), actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing"), actions.clear_actor_value("speaker", "timer_hub_rnd_u_waiting_on_hub"), actions.handler("dlg_a_dda_3f4de49eb783") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_INTERCOM_HWP_EXODII", "TALK_ROBOFAC_INTERCOM_HWP_EXODII_1", "TALK_ROBOFAC_INTERCOM_HWP_EXODII_2" },
    line = ccb.content.text("Excuse me for a moment.\"  The intercom turns off abruptly.  It comes back on after roughly a minute, and when it speaks again, another voice is on the other side, speaking carefully.\n\n\"Yes… the Exodii.  We have yet to make contact, but we are keenly interested in their capabilities and technology.  If you were to provide us with, say, five rounds, in addition to the rifle itself and a magazine suitable for it, we believe we would be able to replicate the parts.  We expect it to take three days of research.\"\n\n\"Please note that the requested materials will not be returned, as they are likely to be damaged during research."),
    replies = {
        {
            text = ccb.content.text("[5 12.3ln, PA md. 68 magazine, PA md. 68] Is this what you need?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_HWP_EXODII_STARTED",
            when = predicates.all({ predicates.has_inventory("speaker", "pamd68", 1), predicates.has_inventory("speaker", "exodiiBRmag", 1), predicates.has_inventory("speaker", "123ln", 5) }),
            actions = { actions.handler("dlg_a_dda_851bba12780b") },
        },
        {
            text = ccb.content.text("[5 12.3ln, PS md. 71z magazine, PS md. 71z] Is this what you need?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_HWP_EXODII_STARTED",
            when = predicates.all({ predicates.has_inventory("speaker", "pamd71z", 1), predicates.has_inventory("speaker", "exodiiminimag", 1), predicates.has_inventory("speaker", "123ln", 5) }),
            actions = { actions.handler("dlg_a_dda_4b2a0f82b77b") },
        },
        {
            text = ccb.content.text("Why not contact them directly?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_HWP_EXODII_1",
            when = predicates.handler("dlg_p_dda_2271d9d05c70"),
        },
        {
            text = ccb.content.text("I've met them already.  They seem friendly; if you'd like to reach out to them yourself, I'm sure that they could help."),
            next_topic = "TALK_ROBOFAC_INTERCOM_HWP_EXODII_2",
            when = predicates.handler("dlg_p_dda_87d61a034b3e"),
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}
