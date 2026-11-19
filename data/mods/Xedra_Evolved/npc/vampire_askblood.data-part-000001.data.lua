local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND", "TALK_FRIEND_Liam", "TALK_FRIEND_Luo" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Can I drink some of your blood?  I really need some of it."),
            next_topic = "TALK_FRIEND_FOLLOWER_BLOODFEED_IMPOSSIBLE",
            when = predicates.all({ predicates.has_any_trait("speaker", { "VAMPIRE", "DHAMPIR_FANGS" }), predicates.any({ predicates.has_flag("interlocutor", "BLEED_IMMUNE"), predicates.has_trait("interlocutor", "ACIDBLOOD"), predicates.has_trait("interlocutor", "THRESH_CRUSTACEAN"), predicates.has_trait("interlocutor", "THRESH_INSECT"), predicates.has_trait("interlocutor", "THRESH_CEPHALOPOD"), predicates.has_trait("interlocutor", "THRESH_GASTROPOD"), predicates.has_trait("interlocutor", "BLOOD_OF_SAINTS"), predicates.has_trait("interlocutor", "VAMPIRE") }) }),
        },
    },
}
