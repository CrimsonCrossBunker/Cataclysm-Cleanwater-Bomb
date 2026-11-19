local ccb = require("ccb")

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
