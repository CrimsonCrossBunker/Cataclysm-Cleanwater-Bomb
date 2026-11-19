local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "MISSION_RANCH_DOCTOR_MEDICAL_ANESTHETIC_DELIVERED",
    line = ccb.content.text("Thanks, this will help a lot."),
    replies = {
        { text = ccb.content.text("Glad to help."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
