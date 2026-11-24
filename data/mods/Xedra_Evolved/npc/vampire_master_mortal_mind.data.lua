local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- This should include all NPCs the player can immediately ask to follow them for free, and those who already follow.
ccb.content.define_dialogue_topic {
    id = {
        "TALK_FRIEND", "TALK_STRANGER_NEUTRAL", "TALK_STRANGER_FRIENDLY", "TALK_STRANGER_SCARED",
        "TALK_STRANGER_WARY", "TALK_MISSION_DESCRIBE_URGENT", "TALK_NC_FARMER", "TALK_SURVIVOR_CHEF",
        "TALK_homeless_survivor", "TALK_shelter_survivors", "TALK_GUN_STORE_SURVIVOR",
        "TALK_NPC_MOONSHINER", "TALK_NPC_PREPPER_SURVIVOR", "TALK_CYBORG_1", "TALK_meteorologist_1",
        "TALK_NPC_HOMELESS_SURVIVOR", "TALK_NPC_APARTMENT_SURVIVOR", "TALK_CITY_COP", "TALK_FRIEND_Liam",
        "TALK_FRIEND_Luo", "TALK_NPC_EVAC_SURVIVOR", "TALK_NPC_CAMPER_SURVIVOR",
        "TALK_CARAVAN_REFUGEE_B1", "TALK_CARAVAN_REFUGEE_B2", "TALK_MI-GO_PRISONER1",
        "TALK_COWBOYN_MAIN", "TALK_COWBOYFR_MAIN",
    },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("[Use your powers to affect their mind]"),
            next_topic = "TALK_MASTER_MORTAL_MIND",
            when = predicates.all({ predicates.negate(predicates.has_trait("interlocutor", "BLOOD_OF_SAINTS")), predicates.negate(predicates.has_trait("interlocutor", "RENFIELD")), predicates.negate(predicates.has_trait("interlocutor", "VAMPIRE")), predicates.has_trait("speaker", "VAMPIRE_MASTER_MORTAL_MIND") }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MASTER_MORTAL_MIND",
    line = ccb.content.text("[You ponder your options and think about the blood you have in you]\n\nYou could spend a little blood to slightly influence their opinion of you.\n\nYou could spend more blood to make them your friend.\n\nOr you could spend a massive amount of blood to turn them into a renfield, a human obsessed with serving their vampire masters.  In this case the master is you."),
    replies = {
        {
            text = ccb.content.text("[Spend a little blood to make them like you a bit more]"),
            next_topic = "TALK_NONE",
            when = predicates.handler("dlg_p_xedra_evolved_a18ecb6198e3"),
            actions = { actions.handler("dlg_a_xedra_evolved_de526d4c4753") },
            opinion = { trust = 1, value = 1 },
        },
        {
            text = ccb.content.text("[Spend a moderate amount of blood to make them your friend]"),
            next_topic = "TALK_NONE",
            when = predicates.handler("dlg_p_xedra_evolved_a18ecb6198e3"),
            actions = { actions.handler("dlg_a_xedra_evolved_f1354bc7dded") },
            opinion = { trust = 3, fear = -1, value = 3, anger = -2 },
        },
        {
            text = ccb.content.text("[Spend a massive amount of blood to make them your renfield]"),
            next_topic = "TALK_YOUR_NEW_RENFIELD",
            when = predicates.handler("dlg_p_xedra_evolved_5f31aeb28f16"),
            actions = { actions.handler("dlg_a_xedra_evolved_1f9c71875b83"), actions.replace_mutation("interlocutor", "RENFIELD"), "follow" },
            opinion = { trust = 30, fear = -5, value = 30, anger = -30 },
        },
        {
            text = ccb.content.text("[Don't spend any blood]"),
            next_topic = "TALK_NONE",
            when = predicates.handler("dlg_p_xedra_evolved_a18ecb6198e3"),
        },
        {
            text = ccb.content.text("[You do not have enough blood in you to manipulate someone's mind]"),
            next_topic = "TALK_NONE",
            when = predicates.handler("dlg_p_xedra_evolved_ea187e67e5c3"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_YOUR_NEW_RENFIELD",
    line = ccb.content.text("[As your blood is consumed to reshape who they are, you see something die in their eyes, replaced by an obsession to follow your orders]"),
    replies = {
        { text = ccb.content.text("I want to discuss with you."), next_topic = "TALK_FRIEND" },
        {
            text = ccb.content.text("Just follow me and my orders for now."),
            next_topic = "TALK_DONE",
        },
    },
}
