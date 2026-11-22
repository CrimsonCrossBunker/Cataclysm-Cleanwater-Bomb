local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Robot",
    line = ccb.content.text("Robot?  What assert is f'r it?  Ahold…\"  Rubik stops for a moment, as if thinking.  \"Ah, an automate?  No, this'n be flesh 'n blood as ye be, encased in a shell o' metal an' wire.  Not so much flesh as there were.  The wire is amixed an' afloat with the flesh, all as one, kennit."),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "knowledge_rubik_is_cyborg_u_knows_exodiilore", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("<fcl_exodii_cyborg_question>"),
            false_text = ccb.content.text("[INT 9] So you're a cyborg of some kind?  That's awesome.  How do I become a cyborg?"),
            text_when = predicates.handler("dlg_p_dda_d292f701cba7"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize",
            when = predicates.all({ predicates.minimum_attribute("speaker", "intelligence", 9), predicates.negate(predicates.any({ predicates.has_mission("RUBIK_ANUS_FETICK"), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_anusfetick" } }), predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") })) }),
            actions = { actions.set_actor_value("speaker", "knowledge_exodization_u_knows_exodiilore", "yes") },
        },
        {
            text = ccb.content.text("I don't have any idea what you mean.  You're kind of a robot, but you're also flesh and blood?"),
            next_topic = "TALK_EXODII_MERCHANT_Robot2",
        },
        {
            text = ccb.content.text("What are you meaning 'razzing up our green and brown'?"),
            next_topic = "TALK_EXODII_MERCHANT_Purpose2",
        },
        {
            text = ccb.content.text("I don't understand a word you're saying."),
            next_topic = "TALK_EXODII_MERCHANT_Dialect",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
