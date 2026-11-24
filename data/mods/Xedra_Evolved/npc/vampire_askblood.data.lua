local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND", "TALK_FRIEND_Liam", "TALK_FRIEND_Luo" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Can I drink some of your blood?  I really need some of it."),
            next_topic = "TALK_FRIEND_FOLLOWER_BLOODFEED_YES",
            when = predicates.handler("dlg_p_xedra_evolved_a5fcb59a7720"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND", "TALK_FRIEND_Liam", "TALK_FRIEND_Luo" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Can I drink some of your blood?  I really need some of it."),
            next_topic = "TALK_FRIEND_FOLLOWER_BLOODFEED_KINDA",
            when = predicates.handler("dlg_p_xedra_evolved_5eb635ad05fd"),
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND", "TALK_FRIEND_Liam", "TALK_FRIEND_Luo" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Can I drink some of your blood?  I really need some of it."),
            next_topic = "TALK_FRIEND_FOLLOWER_BLOODFEED_NOPE",
            when = predicates.handler("dlg_p_xedra_evolved_6cda2b3c8c80"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_FOLLOWER_BLOODFEED_NOPE",
    line = ccb.content.text("Nope.  I'm not going to be your blood bag.  Find someone else for that."),
    replies = {
        {
            text = ccb.content.text("Got it.  Can we talk about something else?"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text("Got it.  See you later."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_FOLLOWER_BLOODFEED_IMPOSSIBLE",
    line = ccb.content.text("(As you approach to ask about letting you drink their blood, your senses tell you that whatever blood they have in their veins wouldn't nourish you at all, so you decide to not ask your question)"),
    replies = {
        { text = ccb.content.text("(Ask them about something else)"), next_topic = "TALK_FRIEND" },
        { text = ccb.content.text("(Go do something else)"), next_topic = "TALK_DONE" },
    },
}
