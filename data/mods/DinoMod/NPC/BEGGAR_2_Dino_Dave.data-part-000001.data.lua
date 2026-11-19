local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_DINO2",
    line = ccb.content.text("I know all kinds of weird useless stuff.  I've seen things at churches, I've seen things on farms, I've seen whole exhibits way out, a whole zoo even.  And there's someone pretending to be me, but it's not me, because I would know.  Or you would know.  One of us would be us.  Those Swampers, they know what's happening.  They're creatures of light come back to save us all.  Or eat us, I forget.  Oh and that Old Guard Repo Man hates them and Red is out there somewhere in the great red yonder."),
    replies = {
        {
            text = ccb.content.text("Yes.  How do I find the someone pretending to be you?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_DINO_Directions",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_REACH_FAKE_DAVE")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_fake_dave" } })) }),
        },
        {
            text = ccb.content.text("What was that about cardboard?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_CARDBOARD",
        },
        {
            text = ccb.content.text("Why are you sitting out here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_REFUGEE",
        },
        { text = ccb.content.text("I think I have to get going…"), next_topic = "TALK_DONE" },
    },
}
