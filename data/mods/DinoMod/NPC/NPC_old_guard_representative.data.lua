local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP",
    replies = {
        {
            text = ccb.content.text("What can you tell me about the dinosaurs?"),
            next_topic = "TALK_OLD_GUARD_REP_DINOSAURS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_DINOSAURS",
    line = ccb.content.text("They just started showing up about the same time it all fell apart.  They attack the caravans and the bandits both.  Hungry bastards.  All dinosaurs are shoot on sight.  We don't eat them, they're probably poisoned with whatever got the dead ones.  Best to burn and bury them.  Same with the eggs.  We have a team out working on wiping them all out in the region.  Check the mass graves.  Talk to Red there."),
    replies = { { text = ccb.content.text("Probably for the best."), next_topic = "TALK_OLD_GUARD_REP" } },
}
