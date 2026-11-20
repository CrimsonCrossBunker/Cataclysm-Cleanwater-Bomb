local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Metal",
    line = ccb.content.text(
        --~ I realized that it was a no-brainer question.  There was only one other option, you see, if I didn't join the Exodii.
        "Us'n saw this were a pidgeon's road, I'd razz.  Only one way, I'm ken, if I'm not to join the rank an' file."),
    replies = {
        {
            text = ccb.content.text("I think I know what you mean.  The only way to survive is to… \"upgrade\".  Can you help me with that?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize",
            when = predicates.negate(predicates.any({ predicates.has_mission("RUBIK_ANUS_FETICK"), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_anusfetick" } }), predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") })),
            actions = {
                actions.set_actor_value("speaker", "knowledge_exodization_u_knows_exodiilore", "yes"),
            },
        },
        {
            text = ccb.content.text("What are you meaning with 'razzing up our green and brown'?"),
            next_topic = "TALK_EXODII_MERCHANT_Purpose2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
