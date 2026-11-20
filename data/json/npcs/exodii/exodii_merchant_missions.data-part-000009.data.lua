local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_jaryi",
    line = ccb.content.text(
        --~ No, I'm not calling you jaryi.  Jaryi is my mother's mother.  It's a King's Landing word for a grandmother, I'm making a little joke at you.
        "Ha, not callin' y'me jaryi.  Jaryi be the mother-twice.  'Tis but a King's Landing assert f'r a grandmother, Rubik's makin' a chestnut at ye."),
    replies = {
        {
            text = ccb.content.text("That word doesn't sound like any of the other Anglic words you've used, though.  What's it from?"),
            next_topic = "TALK_EXODII_MERCHANT_jaryi2",
        },
        {
            text = ccb.content.text("What were you talking about before?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_intro1",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}
