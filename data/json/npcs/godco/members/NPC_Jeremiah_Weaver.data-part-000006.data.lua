local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_Plans",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_mission_jeremiah_apprentice" } }),
        yes = ccb.content.text("I don't know, exactly.  I think I'll stay here and do what I can for the community."),
        no = ccb.content.text("I'd like to study herbology with Kostas, it seems like a useful skill these days.  I do feel bad for Jane though, she's a skilled doctor and nobody here cares, they all just think any illness can be prayed away."),
    },
    replies = {
        {
            text = ccb.content.text("When do you plan on starting that apprenticeship?"),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_convince_kostas" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_kostas_teach_jeremiah" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_mission_jeremiah_apprentice" } })) }),
            next_topic = "TALK_GODCO_Jeremiah_Apprenticeship",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Jeremiah_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
