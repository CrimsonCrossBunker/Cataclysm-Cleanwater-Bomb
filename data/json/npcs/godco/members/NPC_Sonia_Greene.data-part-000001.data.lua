local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Sonia_Tunes",
    line = {
        choices = {
            {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_completed_sonia_guitar_fixed" } }),
                yes = ccb.content.text("Just playing some good ol' tunes.  There's so much negativity around here, someone's gotta cheer people up, ya know?"),
                no = ccb.content.text("Nothin' much, just sitting around and biding my time, getting any work I can.  I might play something to cheer everyone up, if my guitar wasn't busted."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Is there anything I can help you with?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
