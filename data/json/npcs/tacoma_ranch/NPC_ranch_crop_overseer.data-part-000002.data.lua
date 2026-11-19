local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_CROP_OVERSEER_FIELD",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_tacoma_ranch_purchased_field_1" } }),
        yes = ccb.content.text("Back to check on your field?  What can I help you with?"),
        no = {
            when = predicates.has_trait("interlocutor", "NPC_CONSTRUCTION_LEV_1"),
            yes = ccb.content.text("Back to check on your field?  What can I help you with?"),
            no = ccb.content.text("There's a field on the other side of the house that isn't being used for anything right now.  We're willing to let you purchase it for your own agricultural enterprises if you're interested."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Tell me more about this field."),
            next_topic = "TALK_RANCH_CROP_OVERSEER_FIELD_ASK_PURCHASE",
            when = predicates.all({ predicates.negate(predicates.has_trait("interlocutor", "NPC_CONSTRUCTION_LEV_1")), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_tacoma_ranch_purchased_field_1" } })) }),
        },
        {
            text = ccb.content.text("Can you build a fence around my field?"),
            next_topic = "TALK_RANCH_CROP_OVERSEER_FIELD_ASK_UPGRADE_FENCE",
            when = predicates.any({ predicates.all({ predicates.has_trait("interlocutor", "NPC_CONSTRUCTION_LEV_1"), predicates.negate(predicates.has_trait("interlocutor", "NPC_CONSTRUCTION_LEV_2")) }), predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_tacoma_ranch_purchased_field_1" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_tacoma_ranch_purchased_field_1_fence" } })) }) }),
        },
        {
            text = ccb.content.text("I'm looking to expand my field…"),
            next_topic = "TALK_RANCH_CROP_OVERSEER_FIELD_ASK_CONVERT_FIELD",
            when = predicates.has_any_trait("interlocutor", { "NPC_CONSTRUCTION_LEV_1", "NPC_CONSTRUCTION_LEV_2" }),
        },
        {
            text = ccb.content.text("I'd like to plant some seeds…"),
            next_topic = "TALK_RANCH_CROP_OVERSEER_FIELD_PLANT_SEEDS",
            when = predicates.any({ predicates.has_trait("interlocutor", "NPC_CONSTRUCTION_LEV_1"), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_tacoma_ranch_purchased_field_1" } }) }),
        },
        {
            text = ccb.content.text("I'd like to harvest some plants…"),
            next_topic = "TALK_RANCH_CROP_OVERSEER_FIELD_HARVEST_PLANTS",
            when = predicates.any({ predicates.has_trait("interlocutor", "NPC_CONSTRUCTION_LEV_1"), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_tacoma_ranch_purchased_field_1" } }) }),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
