local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "COMP_SD_EXODII_DISTRESS_BEACON_1",
    line = ccb.content.text("&There is an electronic whirr, following by a click and a high-pitched ringing that slowly fades.  The screen turns on and garbled text and images cover the screen.  It is either some language you do not understand, or a series of confounding errors.  Three circle dominate the top of the screen - after just a few seconds, one circle lights up orange."),
    replies = { { text = ccb.content.text("[Step away]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_SD_EXODII_DISTRESS_BEACON_2",
    line = ccb.content.text("&There is an electronic whirr, following by a click and a high-pitched ringing that slowly fades.  The screen turns on and garbled text and images cover the screen.  It is either some language you do not understand, or a series of confounding errors.  Three circle dominate the top of the screen - after just a few seconds, two circles light up orange."),
    replies = { { text = ccb.content.text("[Step away]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_SD_EXODII_DISTRESS_BEACON_3",
    line = ccb.content.text("&There is an electronic whirr, following by a click and a high-pitched ringing that slowly fades.  The screen turns on and garbled text and images cover the screen.  It is either some language you do not understand, or a series of confounding errors.  Three circle dominate the top of the screen - after just a few seconds, all three circles light up orange.\n\nImmediately, three similar dots appear on the garbled image, and after a few punctuated corrections, the image morphs into a highly pixelated topological map.  A fourth, blinking light appears.  You make note if its location in reference to the three terminals you've visited."),
    replies = { { text = ccb.content.text("[Step away]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_SD_EXODII_DISTRESS_BEACON_4",
    line = ccb.content.text("&There is an electronic whirr, following by a click and a high-pitched ringing that slowly fades.  A familiar topological map forms.  You glean no new information from it."),
    replies = { { text = ccb.content.text("[Step away]"), next_topic = "TALK_DONE" } },
}
