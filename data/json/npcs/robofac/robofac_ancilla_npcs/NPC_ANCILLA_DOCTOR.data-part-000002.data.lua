local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_SWAPPED_INTERFACE_AGAIN",
    line = ccb.content.text("&Everything after that moment is a blur in your memory.  You wake up.  For a moment, you're back in your bed.  Was the cataclysm all a dream?  Then you look around, and see Doc Stevens.  You come to your senses."),
    replies = {
        {
            text = ccb.content.text("Well, I feel pretty much the same.  Seems like there weren't any complications!"),
            next_topic = "TALK_ANCILLA_DOCTOR_SWAPPED_INTERFACE_AGAIN_2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_SWAPPED_INTERFACE_AGAIN_2",
    line = ccb.content.text("&Doc Stevens stares at you confusedly.  Then he squints at you.  Then he just shrugs his shoulders.  \"Yeah, what you said… same for me.  I think.\"  Then the doctor's eyes go wide and he raises his eyebrows.  He takes a sharp breath.  Then he turns and walks away."),
    replies = { { text = ccb.content.text("…What?"), next_topic = "TALK_DONE" } },
}
