local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_FAIL",
    line = ccb.content.text("You don't have a perk point, or meet the prerequisites for this perk."),
    replies = {
        { text = ccb.content.text("Go Back."), next_topic = "TALK_PERK_MENU_MAIN" },
        { text = ccb.content.text("Quit."), next_topic = "TALK_DONE" },
    },
}
