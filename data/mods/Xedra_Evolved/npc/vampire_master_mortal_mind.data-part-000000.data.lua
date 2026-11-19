local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

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
