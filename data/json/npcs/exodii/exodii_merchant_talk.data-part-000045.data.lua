local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Oh, we can teleport along as we need to.  We send the scrap along, then the food, and shake off some baddies, you understand.  It's no good for you though, it won't take too much flesh and bone.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Survival",
    line = ccb.content.text("Oh, us can wobble along as needs.  Sends the scrap back, brings in the foods, and shakes off a willie or three, kennit.  No good for you, won't take too much meat-an'-bone."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "knowledge_exodization_u_knows_exodiilore", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Well… could you help me fix that?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize",
            when = predicates.negate(predicates.any({ predicates.has_mission("RUBIK_ANUS_FETICK"), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_anusfetick" } }), predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") })),
        },
        {
            text = ccb.content.text("Wait.  I thought you were still flesh and bone, under that metal."),
            next_topic = "TALK_EXODII_MERCHANT_Survival2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_rubik_is_cyborg_u_knows_exodiilore" } }),
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
