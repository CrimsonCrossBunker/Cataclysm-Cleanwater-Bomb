local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_changeling_breadcrumb2",
    line = ccb.content.text("Long story short, I played for them every night like the contract said, it was a good bit better than starving to death.  I saw and heard some of the craziest things while I was there and other humans came and made deals and went.  They told me that this particular 'sith' had strict rules about how to treat people and that I was quite lucky to be here.  It didn't feel like they considered themselves 'people'.  Anyway when my contract was up they said they'd quite enjoyed my time with them and gave me some gifts to help me get along once I'd left their island.  When society broke down I thought about heading there to see if they were still there.  I chickened out when I realized how far it was compared to my evacuation point.  Course, here I am among the unwanted masses, maybe you'll find them there if you decide to go look."),
    replies = {
        {
            text = ccb.content.text("Maybe I'll check it out."),
            next_topic = "TALK_DONE",
            actions = { actions.offer_mission("MISSION_DRACO_FAE") },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_DRACO_FAE",
    name = ccb.content.text("Go check out this island"),
    description = ccb.content.text("This is where the island I agreed to a strange deal is.  I wonder if they're still there."),
    goal = "MGOAL_CONDITION",
    difficulty = 3,
    start = { target = { terrain = "boann_sidhe_island", special = "Boann's Island", reveal_radius = 6 } },
    value = 5000,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("Have you checked on them?"),
        success = ccb.content.text("Good, that's one less thing to worry about."),
        success_lie = ccb.content.text("I'm glad to hear they are fine.  Why haven't they been by then?"),
        failure = ccb.content.text("At least you came back with your life…"),
    },
    complete_when = "complete_mission_draco_fae",
}
