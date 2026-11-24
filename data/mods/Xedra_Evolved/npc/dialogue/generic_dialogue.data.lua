local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_MUG", "TALK_STRANGER_AGGRESSIVE" },
    replies = {
        {
            text = ccb.content.text("[Autumn Glamour] *Use Scarecrow's Mien*."),
            when = predicates.handler("dlg_p_xedra_evolved_5a52ac7f915d"),
            trial = { kind = "condition", when = predicates.handler("dlg_p_xedra_evolved_91d05d3070a1") },
            success = { next_topic = "TALK_MUG_SCARECROW_MIEN_USED", actions = { actions.add_effect("speaker", "effect_changeling_autumn_scare_humans", { turns = 15 }), actions.handler("dlg_a_xedra_evolved_72b8fc8b39b8") }, opinion = { fear = 5 } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile", actions.handler("dlg_a_xedra_evolved_50775eaa3d7a") } },
        },
        {
            text = ccb.content.text("<color_light_green>[Hypnotic Gaze] *Look directly into their eyes*</color>."),
            next_topic = "TALK_HYPNOTIC_GAZE_USED",
            when = predicates.handler("dlg_p_xedra_evolved_937b74baf8cf"),
            actions = { actions.handler("dlg_a_xedra_evolved_08365a1060b5") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_MUG_SCARECROW_MIEN_USED" },
    line = ccb.content.text("*blanches and takes a step back before turning and fleeing."),
    replies = {
        {
            text = ccb.content.text("Watch them go."),
            next_topic = "TALK_DONE",
            native_actions = { "flee" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_HYPNOTIC_GAZE_USED" },
    line = {
        when = predicates.has_any_trait("speaker", { "VAMPIRE4", "PSYCHOPATH" }),
        yes = ccb.content.text("*stares stupidly as you meet <mypossesivepronoun> gaze and overwhelm <mypossesivepronoun> pitiful mind.  Pathetic.  Like a lamb awaiting the slaughter."),
        no = ccb.content.text("*stares blankly as you meet <mypossesivepronoun> gaze and overwhelm <mypossesivepronoun> mind.  As <mypossesivepronoun> hands fall listlessly to <mypossesivepronoun> sides, <mypossesivepronoun> gaze becomes unfocused and <mypossesivepronoun> mouth drops half-open."),
    },
    replies = {
        {
            text = ccb.content.text("Ha.  Mortals are nothing but cattle."),
            next_topic = "TALK_DONE",
            when = predicates.has_any_trait("speaker", { "VAMPIRE4", "PSYCHOPATH" }),
        },
        {
            text = ccb.content.text("Well, that's one problem solved."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_any_trait("speaker", { "VAMPIRE4", "PSYCHOPATH" })),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_STOLE_ITEM",
    replies = {
        {
            text = ccb.content.text("<color_light_green>[Hypnotic Gaze] *Look directly into their eyes*</color>."),
            next_topic = "TALK_HYPNOTIC_GAZE_USED",
            when = predicates.handler("dlg_p_xedra_evolved_937b74baf8cf"),
            actions = { actions.handler("dlg_a_xedra_evolved_545c60862204") },
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_ABOUT_FERALS_ELEMENTAL_POSITIVE",
    line = ccb.content.text("You mean the ferals?  Almost everyone left alive will try to kill you just like the zombies out there."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ABOUT_FERALS_ELEMENTAL_NEGATIVE",
    line = ccb.content.text("You mean the ferals?  How can you not know about the ferals?  Is this a trap?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ABOUT_FERALS_HOMULLUS_POSITIVE",
    line = ccb.content.text("When the world broke it seems like it broke most people's minds and locked them in on a single response to everything around them."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ABOUT_FERALS_HOMULLUS_NEGATIVE",
    line = ccb.content.text("Where have you been?  It's the end of the world and most people have gone crazy!  Are you trying to distract me?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
