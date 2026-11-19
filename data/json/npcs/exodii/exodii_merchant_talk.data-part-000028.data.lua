local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- To understand how, you've gotta think eleven-dimensionally.  We'll open up a gate and teleport out, the same as we came.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Base2",
    line = ccb.content.text("For an' how, ye be needin' to think wi' them elevens o' directions, kennit?  Us'll open a gate an' wibble-an-wobble.  Same as us came."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "knowledge_exodii_transdimensional_u_knows_exodiilore", "yes"),
            },
        },
    },
    replies = {
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
