local ccb = require("ccb")
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
