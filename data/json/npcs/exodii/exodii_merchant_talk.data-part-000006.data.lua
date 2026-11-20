local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_DoSomething",
    line = ccb.content.text(
        --~ Of course, what can I do for you?
        "Sure as can,\" the gravelly voice takes on an unmistakeable 'customer service' tone.  \"What'll ye tass this'n for?"),
    replies = {
        {
            text = ccb.content.text("What've you got for trade?"),
            native_actions = { "start_trade" },
            next_topic = "TALK_EXODII_MERCHANT_DoneTrade",
        },
        {
            text = ccb.content.text("I think I'm ready to try becoming a cyborg now."),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_anusfetick" } }), predicates.negate(predicates.has_trait("speaker", "CBM_Interface")), predicates.negate(predicates.has_trait("speaker", "NL_CBM_Interface")), predicates.negate(predicates.has_flag("speaker", "NO_CBM_INSTALLATION")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "Rubik_exodized_u" } })) }),
            next_topic = "TALK_EXODII_MERCHANT_ExodizeMe2",
        },
        {
            text = ccb.content.text("Any chance you could help me get some of those sweet bionic upgrades?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodization_u_knows_exodiilore" } }), predicates.negate(predicates.any({ predicates.has_mission("RUBIK_ANUS_FETICK"), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_anusfetick" } }), predicates.negate(predicates.has_trait("speaker", "CBM_Interface")), predicates.negate(predicates.has_trait("speaker", "NL_CBM_Interface")), predicates.negate(predicates.has_flag("speaker", "NO_CBM_INSTALLATION")) })) }),
        },
        {
            text = ccb.content.text("Would you be willing to sell some of your robots?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_exodii_rubik_offered_robosell" } }),
            next_topic = "TALK_EXODII_MERCHANT_Robot_Buy",
        },
        {
            text = ccb.content.text("Can you help me with CBM surgery?"),
            next_topic = "TALK_EXODII_MERCHANT_Bionic_Install",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface"), predicates.has_trait("speaker", "Hub01_CBM_Interface") }),
        },
        {
            text = ccb.content.text("Can you turn me into a cyborg RIGHT NOW?  I'm a developer for this game, you know."),
            when = predicates.has_trait("speaker", "DEBUG_NODMG"),
            next_topic = "TALK_EXODII_MERCHANT_ExodizeTest",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("Actually, I changed my mind.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
