local ccb = require("ccb")
local actions = ccb.content.dialogue_actions
local predicates = ccb.content.dialogue_predicates



ccb.content.define_dialogue_topic {
    id = "TALK_MERCURIAL_DOCTOR_BIONICS",
    line = ccb.content.text("Sure, what are you looking for?"),
    replies = {
        {
            text = ccb.content.text("I was wondering if you could install a cybernetic implant…"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_aftershock_exoplanet_c1784e867903"),
            actions = { "bionic_install" },
        },
        {
            text = ccb.content.text("I was wondering if you could install a cybernetic implant in my friend here…"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_aftershock_exoplanet_c1784e867903"),
            actions = { "bionic_install_allies" },
        },
        {
            text = ccb.content.text("I need help removing an implant…"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_aftershock_exoplanet_c1784e867903"),
            actions = { "bionic_remove" },
        },
        {
            text = ccb.content.text("I need help removing an implant from one of my friends…"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_aftershock_exoplanet_c1784e867903"),
            actions = { "bionic_remove_allies" },
        },
        {
            text = ccb.content.text("Never mind."),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MERCURIAL_DOCTOR_AID",
    line = {
        when = predicates.has_effect("interlocutor", "currently_busy"),
        yes = ccb.content.text("Come back later, I need to take care of a few things first."),
        no = ccb.content.text("I can take a look at you or your companions if you have any injuries.  It'll cost you, of course."),
    },
    replies = {
        {
            text = ccb.content.text("[1200$, 30m] I need you to patch me up."),
            next_topic = "TALK_MERCURIAL_DOCTOR_AID_DONE",
            when = predicates.handler("w16b_p_aftershock_exoplanet_bffe506920cd"),
            actions = { actions.handler("w16b_a_aftershock_exoplanet_9b49a23fa9cc") },
        },
        {
            text = ccb.content.text("[2400$, 1h] I need you to patch my friends up."),
            next_topic = "TALK_MERCURIAL_DOCTOR_AID_DONE",
            when = predicates.handler("w16b_p_aftershock_exoplanet_a3b5aab47d45"),
            actions = { actions.handler("w16b_a_aftershock_exoplanet_277f1df6f74f") },
        },
        {
            text = ccb.content.text("I should be fine."),
            next_topic = "TALK_MERCURIAL_DOCTOR",
        },
    },
}
