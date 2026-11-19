local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_CROP_OVERSEER_FIELD_ASK_UPGRADE_FENCE",
    line = ccb.content.text("Sure, we could build a sturdy picket fence around it that will keep most wildlife from nibbling at your crops.  Your crop yields will increase slightly as well."),
    replies = {
        {
            text = ccb.content.text("I'm interested.  How much is it going to cost?"),
            next_topic = "TALK_RANCH_CROP_OVERSEER_UPGRADE_FENCE_LEGACY",
            when = predicates.all({ predicates.has_trait("interlocutor", "NPC_CONSTRUCTION_LEV_1"), predicates.negate(predicates.has_trait("interlocutor", "NPC_CONSTRUCTION_LEV_2")) }),
        },
        {
            text = ccb.content.text("I'm interested.  How much is it going to cost?"),
            next_topic = "TALK_RANCH_CROP_OVERSEER_UPGRADE_FENCE",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_tacoma_ranch_purchased_field_1" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_tacoma_ranch_purchased_field_1_fence" } })) }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later>"),
            next_topic = "TALK_RANCH_CROP_OVERSEER",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
