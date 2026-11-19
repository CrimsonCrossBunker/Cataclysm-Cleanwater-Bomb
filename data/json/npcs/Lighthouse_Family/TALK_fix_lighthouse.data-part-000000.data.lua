local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND", "TALK_GIVE_ITEM", "TALK_USE_ITEM", "TALK_RADIO" },
    replies = {
        {
            text = ccb.content.text("You said that you have experience in electrical engineering…"),
            next_topic = "TALK_ENG_LIGHTHOUSE",
            when = predicates.all({ predicates.has_any_trait("interlocutor", { "Exp_Eng_Electrical2", "Exp_Eng_Electrical1Fake2", "Exp_Eng_Electrical0Fake2" }), predicates.has_mission("MISSION_lighthouse_man_5") }),
        },
    },
}
