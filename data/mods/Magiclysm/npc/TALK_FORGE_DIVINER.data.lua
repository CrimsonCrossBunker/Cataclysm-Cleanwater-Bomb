local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_MALIGNANCE",
    line = ccb.content.text("The Malignance is the cause for much of our woes.  It is the force animating the zombies.  It is responsible for the portal storms, and it seems to be absolutely bursting with hate.  Valzain theorizes that it used to be a fundamental force of nature or perhaps a school of magic that somehow grew conscious, or perhaps had a consciousness imposed on it.  Allegedly, the Mi-Go speak of a time before it existed, or perhaps a time in which it wasn't so dangerous.  By now, it is everywhere on Earth.  As far as I can tell, it builds no structures and has no bases of operation, so there is no place I can point you towards.  Sorry."),
    replies = {
        { text = ccb.content.text("About something else…"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Nevermind."), next_topic = "TALK_DONE" },
    },
}
