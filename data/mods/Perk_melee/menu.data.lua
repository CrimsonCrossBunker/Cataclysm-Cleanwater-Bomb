local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_FAIL",
    line = ccb.content.text("You don't have a perk point, or meet the prerequisites for this perk."),
    replies = {
        { text = ccb.content.text("Go Back."), next_topic = "TALK_PERK_MENU_MAIN" },
        { text = ccb.content.text("Quit."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MA_PERK_MENU_HELP",
    line = ccb.content.text("XP is gained by killing enemies, either by melee or ranged combat, with tougher enemies giving more XP.  You'll gain a perk point every time you level up, which can be used to unlock a perk through this menu.  Most perks are completely passive, and apply their effects automatically on movement, combat or waiting.\n\nPerks cannot be refunded or disabled once learned, consider your choices carefully."),
    replies = {
        { text = ccb.content.text("Go back."), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Quit."), next_topic = "TALK_DONE" },
    },
}
