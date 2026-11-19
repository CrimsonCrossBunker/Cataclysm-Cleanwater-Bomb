local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_Intro1a",
    line = ccb.content.text("'Ow long's it been since the mess happened?"),
    replies = { { text = ccb.content.text("[Tell them.]"), next_topic = "TALK_EXODII_MERCHANT_Talk_Intro2" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_Intro1b",
    line = ccb.content.text("Thank ye.  When you an' Rubik first met, how long'd it been since the mess begun?"),
    replies = { { text = ccb.content.text("[Tell them.]"), next_topic = "TALK_EXODII_MERCHANT_Talk_Intro2" } },
}
