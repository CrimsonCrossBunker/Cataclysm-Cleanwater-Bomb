local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CHRONOMANCER_SPELL_MENU_FAIL",
    line = ccb.content.text("You either don't have enough insight or you fail to meet the prerequisites for this power."),
    replies = {
        { text = ccb.content.text("Go Back."), next_topic = "TALK_CHRONOMANCER_INSIGHT_MENU_MAIN" },
        { text = ccb.content.text("Quit."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CHRONOMANCER_TRAIT_MENU_FAIL",
    line = ccb.content.text("You either don't have enough insight or you fail to meet the prerequisites to resolve this issue."),
    replies = {
        { text = ccb.content.text("Go Back."), next_topic = "TALK_CHRONOMANCER_INSIGHT_MENU_MAIN" },
        { text = ccb.content.text("Quit."), next_topic = "TALK_DONE" },
    },
}
