local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_CROP_OVERSEER_PURCHASE_FIELD",
    line = ccb.content.text("350 merch should be enough to cover the purchase and the labor to plow it."),
    replies = {
        {
            text = ccb.content.text("[350 merch] Seems like a fair price.  I'll take it."),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "FMCNote", 350),
            actions = { actions.transfer_items("FMCNote", 350), actions.set_actor_value("interlocutor", "dialogue_tacoma_ranch_purchased_field_1", "yes"), actions.update_map("tacoma_commune_crop_overseer_field_1_plant", "ranch_camp_63"), actions.handler("dlg_a_dda_d1786efd3b7e") },
        },
        {
            text = ccb.content.text("I'm a bit short right now.  <end_talking_later>"),
            next_topic = "TALK_RANCH_CROP_OVERSEER",
            when = predicates.negate(predicates.has_inventory("speaker", "FMCNote", 350)),
        },
        {
            text = ccb.content.text("<end_talking_later>"),
            next_topic = "TALK_RANCH_CROP_OVERSEER",
            when = predicates.has_inventory("speaker", "FMCNote", 350),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
