local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jane_Medical_Buy",
    line = ccb.content.text("I could always use more bandages, disinfectant, and the like.  What do you have?"),
    repeat_replies = {
        {
            items = {
                "adhesive_bandages", "antibiotics", "arm_splint", "leg_splint", "bandages",
                "disinfectant", "medical_gauze",
            },
            reply = { text = ccb.content.text("I have <topic_item>."), next_topic = "TALK_DELIVER_ASK" },
        },
    },
    replies = {
        {
            text = ccb.content.text("I don't have anything right now.  <done_conversation_section>"),
            next_topic = "TALK_GODCO_Jane_2",
        },
        {
            text = ccb.content.text("I don't have anything right now.  I'll come back with something later."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jane_Angry",
    line = ccb.content.text("Fuck off <name_b>.  I've had it with your tormenting antics, I don't want anything to do with you right now."),
    replies = { { text = ccb.content.text("Fine then, have it your way."), next_topic = "TALK_DONE" } },
}
