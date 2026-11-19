local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_BIONICS_BIONIC_LIMB_PROPOSE_SWAP",
    line = ccb.content.text("&The Doc stares at you confusedly.  \"Give me a second.\"\n\nThe Doc pulls out a two-way radio and steps out of the room and down the hall.  They're gone for several minutes before they return, setting the radio down on the table.\n\n\"Well, I talked to the bosses, and yup, we're a go.  In fact, I've been authorized to give you a discount.  You'll be the first of the new Cybernetic Limb Enhancement Program, yeah?"),
    replies = {
        {
            text = ccb.content.text("Alright, let's talk about limb replacement."),
            next_topic = "TALK_ANCILLA_DOCTOR_BIONICS_BIONIC_LIMB_REPLACEMENT_1",
        },
        {
            text = ccb.content.text("I'll keep that in mind.  See you around."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_BIONICS_BIONIC_LIMB_REPLACEMENT_1",
    line = ccb.content.text("Let's get you checked out.  Climb up onto the automated surgical suite here, yeah?"),
    replies = {
        {
            text = ccb.content.text("[Climb onto the bed by the surgical robot]"),
            next_topic = "TALK_ANCILLA_DOCTOR_BIONICS_BIONIC_LIMB_REPLACEMENT_2",
        },
        { text = ccb.content.text("Actually, maybe another time."), next_topic = "TALK_DONE" },
    },
}
