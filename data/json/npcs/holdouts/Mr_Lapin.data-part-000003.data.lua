local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_WARRENER_ISHERWOOD_MISSION_ACCEPTED",
    line = ccb.content.text("It can be quite a hike depending on your transportation.  Lot of bad news between here and there."),
    replies = {
        { text = ccb.content.text("Don't worry, I'll be careful."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("Just a walk in the woods."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WARRENER_WORLD_OPTIMISTIC",
    line = ccb.content.text("If I teach one hundred people how to raise rabbits, that's potentially a hundred communities given food and fur before those people teach anyone else."),
    replies = {
        {
            text = ccb.content.text("That's the most hopeful thing I've heard so far."),
            next_topic = "TALK_WARRENER",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LAPIN_FIREFLY",
    line = ccb.content.text("A traveler brought this to me in return for some rabbits.  Said that he'd gotten it from a scientist out in the swamps but it took up too much space in his car."),
    replies = { { text = ccb.content.text("It's quite unique!"), next_topic = "TALK_WARRENER" } },
}
