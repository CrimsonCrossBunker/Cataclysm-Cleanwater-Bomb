local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_2",
    line = ccb.content.text("I thought asking about each other's emotions went out of style after <the_cataclysm>.  Uhm, okay then.  I'm fine, I guess."),
    replies = {
        {
            text = ccb.content.text("I noticed you're holding a D&D handbook.  Do you play much?"),
            next_topic = "TALK_GODCO_Jeremiah_Dnd",
        },
        {
            text = ccb.content.text("I've convinced Kostas to take you on."),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_kostas_teach_jeremiah" } }),
            next_topic = "TALK_GODCO_Jeremiah_Kostas_Convinced",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
