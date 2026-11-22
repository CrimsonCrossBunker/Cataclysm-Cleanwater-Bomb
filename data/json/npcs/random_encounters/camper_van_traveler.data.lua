local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_NPC_CAMPER_VAN_TRAVELER", "TALK_NPC_CAMPER_VAN_TRAVELER_DESTINATION", "TALK_NPC_CAMPER_VAN_TRAVELER_BACKSTORY", "TALK_NPC_CAMPER_VAN_TRAVELER_LEAVING_WHEN" },
    replies = {
        {
            text = ccb.content.text("Do you have anything that you'd like to sell?"),
            next_topic = "TALK_NPC_CAMPER_VAN_TRAVELER_TRADE",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        },
        {
            text = ccb.content.text("I'd like to ask you a few questions."),
            next_topic = "TALK_FRIEND_CONVERSATION",
            when = predicates.handler("w16b_p_dda_b49f7ca57e70"),
        },
        {
            text = ccb.content.text("I'm looking for a specific, strange building.  I wonder if you've heard anything about it?"),
            next_topic = "TALK_NPC_CAMPER_VAN_TRAVELER_EXODII_MISSION_WAREHOUSE",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }), predicates.has_mission("EXODII_MISSION_WAREHOUSE"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "asked_about_exodii_warehouse_mission" } })) }),
            actions = { actions.handler("w16b_a_dda_9812bef589e2") },
        },
        {
            text = ccb.content.text("Where did you say you were going again?"),
            next_topic = "TALK_NPC_CAMPER_VAN_TRAVELER_DESTINATION",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_NPC_CAMPER_VAN_TRAVELER_BACKSTORY",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        },
        {
            text = ccb.content.text("I'd like to ask you a few questions."),
            next_topic = "TALK_FRIEND_CONVERSATION",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        },
        {
            text = ccb.content.text("Have you found anything out of the ordinary out in the wastes?"),
            next_topic = "TALK_NPC_CAMPER_VAN_TRAVELER_INTERESTING_THINGS",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_camper_van_traveler_gave_directions" } })) }),
            actions = { actions.handler("w16b_a_dda_f1418abfd320"), actions.set_actor_value("interlocutor", "dialogue_camper_van_traveler_gave_directions", "yes") },
            switch = true,
        },
        {
            text = ccb.content.text("Have you found anything out of the ordinary out in the wastes?"),
            next_topic = "TALK_NPC_CAMPER_VAN_TRAVELER_INTERESTING_THINGS",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_camper_van_traveler_gave_directions" } }) }),
            switch = true,
            default = true,
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CAMPER_VAN_TRAVELER",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        yes = ccb.content.text("<greet>"),
        no = ccb.content.gendered_line("I didn't think anyone was around here.  Pleased to meet you, I'm <npc_name>.", { "interlocutor" }),
    },
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "dialogue_first_meeting_knows_u", "yes"), actions.handler("w16b_a_dda_8585463a3e0a") } },
    },
    replies = {
        {
            text = ccb.content.text("What's in that RV of yours?  Couldn't be anything you need, so hand over your stuff."),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } })),
            trial = { kind = "intimidate", difficulty = 30 },
            success = { next_topic = "TALK_WEAPON_DROPPED", actions = { "drop_weapon" }, opinion = { trust = -4, fear = 3 } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
        {
            text = ccb.content.text("Good to meet you too.  What are you doing out here?"),
            next_topic = "TALK_NPC_CAMPER_VAN_TRAVELER_DESTINATION",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } })),
        },
        {
            text = ccb.content.text("<end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}
