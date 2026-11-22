local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_CROP_OVERSEER_UPGRADE_FENCE_LEGACY",
    line = ccb.content.text("We'll have to divert a decent amount of lumber from our other projects for the fence, but we can get it done for 200 merch."),
    replies = {
        {
            text = ccb.content.text("[200 merch] Alright, build me a fence."),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "FMCNote", 200),
            actions = { actions.transfer_items("FMCNote", 200), actions.replace_mutation("interlocutor", "NPC_CONSTRUCTION_LEV_2"), actions.handler("dlg_a_dda_dff7082eac58") },
        },
        {
            text = ccb.content.text("I don't have that much right now.  <end_talking_later>"),
            next_topic = "TALK_RANCH_CROP_OVERSEER",
            when = predicates.negate(predicates.has_inventory("speaker", "FMCNote", 200)),
        },
        {
            text = ccb.content.text("<end_talking_later>"),
            next_topic = "TALK_RANCH_CROP_OVERSEER",
            when = predicates.has_inventory("speaker", "FMCNote", 200),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_CROP_OVERSEER_UPGRADE_FENCE",
    line = ccb.content.text("We'll have to divert a decent amount of lumber from our other projects for the fence, but we can get it done for 300 merch."),
    replies = {
        {
            text = ccb.content.text("[300 merch] Alright, build me a fence."),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "FMCNote", 300),
            actions = { actions.transfer_items("FMCNote", 300), actions.set_actor_value("interlocutor", "dialogue_tacoma_ranch_purchased_field_1_fence", "yes"), actions.update_map("tacoma_commune_crop_overseer_field_1_fence", "ranch_camp_63"), actions.handler("dlg_a_dda_dff7082eac58") },
        },
        {
            text = ccb.content.text("I don't have that much right now.  <end_talking_later>"),
            next_topic = "TALK_RANCH_CROP_OVERSEER",
            when = predicates.negate(predicates.has_inventory("speaker", "FMCNote", 300)),
        },
        {
            text = ccb.content.text("<end_talking_later>"),
            next_topic = "TALK_RANCH_CROP_OVERSEER",
            when = predicates.has_inventory("speaker", "FMCNote", 300),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_CROP_OVERSEER_FIELD_ASK_CONVERT_FIELD",
    line = {
        when = predicates.has_trait("interlocutor", "NPC_CONSTRUCTION_LEV_2"),
        yes = ccb.content.text("We can plow some more land around your field to give you room for more plants.  Any existing plants or items in the way will be destroyed.  The fence will also get moved and expanded.  Everything can be done for 200 merch.  Still interested?"),
        no = ccb.content.text("We can plow some more land around your field to give you room for more plants.  Any existing plants or items in the way will be destroyed.  It'll only cost 100 merch to expand.  Still interested?"),
    },
    replies = {
        {
            text = ccb.content.text("[200 merch] Yeah, let's do it."),
            next_topic = "TALK_NONE",
            when = predicates.all({ predicates.has_inventory("speaker", "FMCNote", 200), predicates.has_trait("interlocutor", "NPC_CONSTRUCTION_LEV_2") }),
            actions = { actions.transfer_items("FMCNote", 200), actions.handler("dlg_a_dda_03a40bed2326"), actions.set_actor_value("interlocutor", "dialogue_tacoma_ranch_purchased_field_1", "yes"), actions.set_actor_value("interlocutor", "dialogue_tacoma_ranch_purchased_field_1_fence", "yes"), actions.update_map("tacoma_commune_crop_overseer_field_1_plant", "ranch_camp_63"), actions.update_map("tacoma_commune_crop_overseer_field_1_fence", "ranch_camp_63") },
        },
        {
            text = ccb.content.text("[100 merch] Yeah, let's do it."),
            next_topic = "TALK_NONE",
            when = predicates.all({ predicates.has_inventory("speaker", "FMCNote", 100), predicates.has_trait("interlocutor", "NPC_CONSTRUCTION_LEV_1"), predicates.negate(predicates.has_trait("interlocutor", "NPC_CONSTRUCTION_LEV_2")) }),
            actions = { actions.transfer_items("FMCNote", 100), actions.handler("dlg_a_dda_c4d2591970dd"), actions.set_actor_value("interlocutor", "dialogue_tacoma_ranch_purchased_field_1", "yes"), actions.update_map("tacoma_commune_crop_overseer_field_1_plant", "ranch_camp_63") },
        },
        {
            text = ccb.content.text("<end_talking_later>"),
            next_topic = "TALK_RANCH_CROP_OVERSEER",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_CROP_OVERSEER_FIELD_PLANT_SEEDS",
    line = ccb.content.text("We'll plant the field with your choice of crop if you are willing to finance it.  When the crop is ready to harvest, you can have us liquidate it or harvest it for you.  Planting will cost 1 merch per plot."),
    replies = {
        {
            text = ccb.content.text("[1 merch / plot] I'd like to plant some seeds."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_d4729b31132d") },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_RANCH_CROP_OVERSEER",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_CROP_OVERSEER_FIELD_HARVEST_PLANTS",
    line = ccb.content.text("You can either have us liquidate the crop and give you the cash or pay us to harvest it for you.  Harvesting will cost 1 merch per plot."),
    replies = {
        {
            text = ccb.content.text("[1 merch / plot] I'd like to harvest the field."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_8d92a1464a92") },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_RANCH_CROP_OVERSEER",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
