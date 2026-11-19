local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_BOTCHED_EXODII_SURGERY_GOOD_CALL",
    line = ccb.content.text("Doc Stevens hesitate for an uncomfortable moment.  The saw slows down.  Then he nods and unclasps you.  You are free to go."),
    replies = {
        {
            text = ccb.content.text("Thanks, Doc.  See you some other time."),
            next_topic = "TALK_DONE",
        },
    },
}
