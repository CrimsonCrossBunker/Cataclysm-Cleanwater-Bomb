local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_CONFIG",
    line = ccb.content.text("What settings would you like to modify?"),
    replies = {
        {
            text = ccb.content.text("Notifications"),
            next_topic = "TALK_PERK_MENU_CONFIG_NOTIFICATIONS",
        },
        {
            text = ccb.content.text("Exp to level"),
            next_topic = "TALK_PERK_MENU_CONFIG_EXP_TO_LEVEL",
        },
        { text = ccb.content.text("Requirements"), next_topic = "TALK_PERK_MENU_REQUIREMENTS" },
        { text = ccb.content.text("Back"), next_topic = "TALK_PERK_MENU_MAIN" },
    },
}
