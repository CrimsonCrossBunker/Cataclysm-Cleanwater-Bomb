local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_RED_DINOSAURS",
    line = ccb.content.text("They just started showing up about the same time it all fell apart.  They attack the caravans and the bandits both.  Hungry bastards.  All dinosaurs are shoot on sight.  We don't eat them, they're probably poisoned with whatever got the dead ones.  Just leave them for the crows.  Same with the eggs."),
    replies = {
        {
            text = ccb.content.text("Kill all dinosaurs, interesting…"),
            next_topic = "TALK_MISSION_LIST",
        },
        { text = ccb.content.text("Probably not important."), next_topic = "TALK_OLD_GUARD_RED" },
    },
}
