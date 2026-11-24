local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Flavor
ccb.content.define_npc {
    id = "ranch_crop_overseer",
    suffix = ccb.content.text("Crop Overseer"),
    class = "NC_BOUNTY_HUNTER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RANCH_CROP_OVERSEER",
    faction = "tacoma_commune",
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_CROP_OVERSEER",
    line = ccb.content.text("I hope you are here to do business."),
    replies = {
        {
            text = ccb.content.text("The doctor needs some help building an anesthetic machine.  Do you have anything that could help?"),
            next_topic = "TALK_RANCH_GENERIC_ANESTHETIC_FOR_DOCTOR",
            when = predicates.all({ predicates.has_mission("MISSION_RANCH_DOCTOR_MEDICAL_ANESTHETIC"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_tacoma_ranch_doctor_anesthetic_asked" } })) }),
            actions = { actions.set_actor_value("interlocutor", "mission_tacoma_ranch_doctor_anesthetic_asked", "yes") },
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_RANCH_CROP_OVERSEER_JOB",
        },
        {
            text = ccb.content.text("I figured you might be looking for some help…"),
            next_topic = "TALK_RANCH_CROP_OVERSEER",
            actions = { actions.handler("dlg_a_dda_7768cd91cb4b") },
        },
        {
            text = ccb.content.text("I'm interested in investing in agriculture…"),
            next_topic = "TALK_RANCH_CROP_OVERSEER_FIELD",
            when = predicates.all({ predicates.negate(predicates.has_trait("interlocutor", "NPC_CONSTRUCTION_LEV_1")), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_tacoma_ranch_purchased_field_1" } })) }),
        },
        {
            text = ccb.content.text("I'd like to discuss my field…"),
            next_topic = "TALK_RANCH_CROP_OVERSEER_FIELD",
            when = predicates.any({ predicates.has_trait("interlocutor", "NPC_CONSTRUCTION_LEV_1"), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_tacoma_ranch_purchased_field_1" } }) }),
        },
        {
            text = ccb.content.text("What do you need done?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_CROP_OVERSEER_JOB",
    line = ccb.content.text("My job is to manage our outpost's agricultural production.  I'm constantly searching for trade partners and investors to increase our capacity.  If you are interested, I typically have tasks that I need assistance with."),
    replies = {
        {
            text = ccb.content.text("I'll keep that in mind."),
            next_topic = "TALK_RANCH_CROP_OVERSEER",
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_CROP_OVERSEER_FIELD_ASK_PURCHASE",
    line = ccb.content.text("We'll help plow the land and put up a sign to let everybody know it's yours.  Once it's plowed, you can hire some workers to plant or harvest the crops for a small fee of course.  Oh, and if you're growing anything we have a demand for, we'll gladly take it off your hands after the harvest."),
    replies = {
        {
            text = ccb.content.text("I'm interested.  How much is it going to cost?"),
            next_topic = "TALK_RANCH_CROP_OVERSEER_PURCHASE_FIELD",
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
