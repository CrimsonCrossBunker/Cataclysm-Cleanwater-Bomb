local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_RADIO",
    replies = {
        {
            text = ccb.content.text("Please go to this location."),
            next_topic = "TALK_GOTO_LOCATION_RADIO",
            actions = { "goto_location" },
        },
        {
            text = ccb.content.text("Stay at your current position."),
            next_topic = "TALK_DONE",
            actions = { "assign_guard" },
        },
        {
            text = ccb.content.text("Show me what needs to be done at the camp."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c5904e1a60f2"),
            actions = { "basecamp_mission" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ACTIVITIES",
    line = { when = predicates.actor_state("interlocutor", "has_activity"), yes = ccb.content.text("I'm currently <current_activity>."), no = ccb.content.text("I'm not doing much currently.") },
    replies = {
        {
            text = ccb.content.text("I meant what are your goals?"),
            next_topic = "TALK_DESCRIBE_MISSION",
        },
        {
            text = ccb.content.text("Carry on."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Please stop your current activity."),
            next_topic = "TALK_DONE",
            when = predicates.actor_state("interlocutor", "has_activity"),
            actions = { "revert_activity" },
        },
        {
            text = ccb.content.text("Please sort out some of these items nearby."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "sort_loot" },
        },
        {
            text = ccb.content.text("Please do any construction work that you can."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_construction" },
        },
        {
            text = ccb.content.text("Please do any mining work that you can."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_mining" },
        },
        {
            text = ccb.content.text("Please go mop the area."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_mopping" },
        },
        {
            text = ccb.content.text("Please study from a book."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_read" },
        },
        {
            text = ccb.content.text("Please study from an e-book."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_eread" },
        },
        {
            text = ccb.content.text("Please study from books you have in order."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_read_repeatedly" },
        },
        {
            text = ccb.content.text("Please study from books in study zones."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_study" },
        },
        {
            text = ccb.content.text("Please start deconstructing any vehicles in a deconstruction zone."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_vehicle_deconstruct" },
        },
        {
            text = ccb.content.text("Please start repairing any vehicles in a repair zone."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_vehicle_repair" },
        },
        {
            text = ccb.content.text("Please chop logs into planks."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_chop_plank" },
        },
        {
            text = ccb.content.text("Please butcher any corpses that you can."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_butcher" },
        },
        {
            text = ccb.content.text("Please chop any trees in the designated areas."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_chop_trees" },
        },
        {
            text = ccb.content.text("Please go catch some fish."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_fishing" },
        },
        {
            text = ccb.content.text("Please do some farming work."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_farming" },
        },
        {
            text = ccb.content.text("Please disassemble anything in the designated areas."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_disassembly" },
        },
        {
            text = ccb.content.text("Can you craft this item?"),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_craft" },
        },
    },
}
