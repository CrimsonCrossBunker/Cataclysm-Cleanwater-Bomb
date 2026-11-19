local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_BIONICS_DONE",
    line = {
        choices = {
            ccb.content.text("Now some protocol tests for brain damage.  Please stare at the light over there…"),
            ccb.content.text("It might take some days for your nervous system to adapt.  Come back if you experience any concerning symptoms like…"),
            ccb.content.text("I suggest you take it easy for a few days now."),
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_AID_DONE",
    line = {
        choices = {
            ccb.content.text("Take it easy now, or come back soon.  All the same to me."),
            ccb.content.gendered_line("Now try not to do whatever you did again.  No, don't tell me more.", { "speaker" }),
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_WORK",
    line = ccb.content.text("It takes resources to keep this show running: disinfectant, antibiotics, anesthetics, so on.  I'll give you a great price if you bring any of those."),
    replies = { { text = ccb.content.text("I'll keep that in mind."), next_topic = "TALK_ANCILLA_DOCTOR" } },
}
