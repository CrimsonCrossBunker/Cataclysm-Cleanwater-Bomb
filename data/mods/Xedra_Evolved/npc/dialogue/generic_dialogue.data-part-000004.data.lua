local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_STRANGER_NEUTRAL", "TALK_STRANGER_FRIENDLY" },
    on_enter = {
        {
            once = "meeting_human",
            actions = { actions.set_actor_value("speaker", "u_met_non_feral", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("[Paraclesian:Elemental] Oh you're much less aggressive than other humans.  Are you a different breed?"),
            next_topic = "TALK_ABOUT_FERALS_ELEMENTAL_POSITIVE",
            when = predicates.all({ predicates.any({ predicates.has_trait("speaker", "SYLPH"), predicates.has_trait("speaker", "IERDE"), predicates.has_trait("speaker", "SALAMANDER"), predicates.has_trait("speaker", "UNDINE"), predicates.has_trait("speaker", "ARVORE") }), predicates.any_equal({ "no", { scope = "speaker", key = "u_met_non_feral" } }) }),
            switch = true,
            default = false,
        },
        {
            text = ccb.content.text("[Paraclesian:Dollkin] Finally a normal human!  What's happened here?"),
            next_topic = "TALK_ABOUT_FERALS_HOMULLUS_POSITIVE",
            when = predicates.all({ predicates.has_trait("speaker", "HOMULLUS"), predicates.any_equal({ "no", { scope = "speaker", key = "u_met_non_feral" } }) }),
            switch = true,
            default = false,
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_STRANGER_SCARED", "TALK_STRANGER_WARY" },
    on_enter = {
        {
            once = "meeting_human",
            actions = { actions.set_actor_value("speaker", "u_met_non_feral", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("[Paraclesian:Elemental] Oh you're much less aggressive than other humans.  Are you a different breed?"),
            next_topic = "TALK_ABOUT_FERALS_ELEMENTAL_NEGATIVE",
            when = predicates.all({ predicates.any({ predicates.has_trait("speaker", "SYLPH"), predicates.has_trait("speaker", "IERDE"), predicates.has_trait("speaker", "SALAMANDER"), predicates.has_trait("speaker", "UNDINE"), predicates.has_trait("speaker", "ARVORE") }), predicates.any_equal({ "no", { scope = "speaker", key = "u_met_non_feral" } }) }),
            switch = true,
            default = false,
        },
        {
            text = ccb.content.text("[Paraclesian:Dollkin] Finally a normal human!  What's happened here?"),
            next_topic = "TALK_ABOUT_FERALS_HOMULLUS_NEGATIVE",
            when = predicates.all({ predicates.has_trait("speaker", "HOMULLUS"), predicates.any_equal({ "no", { scope = "speaker", key = "u_met_non_feral" } }) }),
            switch = true,
            default = false,
        },
    },
}
