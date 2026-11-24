local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_1a",
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Have you seen anything that could help me?"),
            next_topic = "TALK_REFUGEE_Draco_changeling_breadcrumb",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_changeling_breadcrumb",
    line = ccb.content.text("The last fifteen years or so before the Cataclysm were weirder than the years before that don't you remember?  Well anyway before the end of things, I used to travel across New England as a wandering musician earning my keep as I could.  There were good times and there were hard times; and once when things were at their hardest I was starving and cold and playing my guitar on the shore of the lake.  A swan boat glides up to the shore quiet as a mouse, a tall elegantly dressed man stepped out of the boat and asked me to come play for them at the 'bonum collis'.  Being more hungry than I was scared, I went with him."),
    replies = {
        {
            text = ccb.content.text("What happened next?"),
            next_topic = "TALK_REFUGEE_Draco_changeling_breadcrumb1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_changeling_breadcrumb1",
    line = ccb.content.text("So I get the boat and it moves smooth as silk across the lake, no sound or vibration but the waves against the hull.  I never see anyone or anything guiding the boat or making it move.  Anyway we arrived at an island in the lake and as we approached I can hear laughter and music.  Once we landed, they had me sign a contract which I'd figured would just be an NDA not to talk about the rich peoples party island.  Turns out I signed a contract to play music every night for three months for the price of room and board."),
    replies = {
        {
            text = ccb.content.text("You've got to be kidding."),
            next_topic = "TALK_REFUGEE_Draco_changeling_breadcrumb2",
        },
        {
            text = ccb.content.text("I can't believe this story.  Goodbye."),
            next_topic = "TALK_DONE",
        },
    },
}

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
