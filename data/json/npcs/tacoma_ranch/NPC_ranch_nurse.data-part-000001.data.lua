local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_NURSE_JOB",
    line = ccb.content.text("I was a practicing nurse, so I've taken over the medical responsibilities of the outpost till we can locate a physician."),
    replies = { { text = ccb.content.text("OK."), next_topic = "TALK_RANCH_NURSE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_NURSE_HIRE",
    line = ccb.content.text("I'm willing to pay a premium for medical supplies that you might be able to scavenge up.  I also have a few miscellaneous jobs from time to time."),
    repeat_replies = {
        {
            items = {
                "ifak", "antibiotics", "aspirin", "ibuprofen", "acetaminophen", "naproxen", "bandages",
                "adhesive_bandages", "bfipowder", "chem_hydrogen_peroxide", "codeine", "dayquil",
                "disinfectant", "flu_shot", "morphine", "nyquil", "oxycodone", "poppy_pain",
                "poppysyrup", "quikclot", "thyme_oil", "tramadol", "weak_antibiotic", "cattail_jelly",
            },
            reply = { text = ccb.content.text("Delivering <topic_item>."), next_topic = "TALK_DELIVER_ASK" },
        },
    },
    replies = {
        {
            text = ccb.content.text("What kind of jobs do you have for me?"),
            next_topic = "TALK_MISSION_LIST",
        },
        { text = ccb.content.text("Not now."), next_topic = "TALK_RANCH_NURSE" },
    },
}
