local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_CARDBOARD",
    line = ccb.content.text("I'm building a house out of cardboard.  The sandman doesn't want me to, but I told him to go fuck himself."),
    replies = {
        {
            text = ccb.content.text("Why cardboard?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_CARDBOARD2",
        },
        { text = ccb.content.text("The sandman?"), next_topic = "TALK_REFUGEE_BEGGAR_2_SANDMAN" },
        {
            text = ccb.content.text("Would you like me to give you some cardboard?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_GIVECARDBOARD",
        },
        {
            text = ccb.content.text("Why are you sitting out here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_REFUGEE",
        },
        {
            text = ccb.content.text("Are you seriously wearing a dinosaur costume?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_DINOSAUR",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_CARDBOARD2",
    line = ccb.content.text("There's so much of it now, and the zombies are afraid of it.  It's kept me safe so far.  The beta rays come from the center point of the zombie, so it hits the cardboard and can't penetrate.  The reflection can stop any further damage."),
    replies = {
        {
            text = ccb.content.text("Would you like me to give you some cardboard?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_GIVECARDBOARD",
        },
        {
            text = ccb.content.text("Why are you sitting out here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_REFUGEE",
        },
        {
            text = ccb.content.text("Are you seriously wearing a dinosaur costume?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_DINOSAUR",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
