local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE_Truck_Bomb",
    line = ccb.content.text("How does this all come together?"),
    replies = {
        {
            text = ccb.content.text("Well, we are going to turn this truck into a bomb that'll give us a big enough opening in the tower to let out some of the heat and gas.  But small enough that it won't kill Barry unless it's right next to him."),
            next_topic = "TALK_ISHERWOOD_LUKE_Truck_Bomb_Is_Crazy",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE_Truck_Bomb_Is_Crazy",
    line = ccb.content.text("Are you serious?  This is your brother we are risking here!"),
    replies = {
        {
            text = ccb.content.text("Exactly, and I wouldn't do anything to risk him unnecessarily."),
            next_topic = "TALK_ISHERWOOD_LUKE_Truck_Bomb_Plan",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
