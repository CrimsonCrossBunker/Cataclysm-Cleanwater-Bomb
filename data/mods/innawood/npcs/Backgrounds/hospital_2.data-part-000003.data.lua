local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_2_STORY4",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_BGSS_hospital_2_started_quest" } }),
        yes = ccb.content.text("Well, I still didn't have any food.  Eventually I had to climb down… so I did, as quietly as I could.  It was night, and I have pretty good nightvision.  Apparently the giant bugs don't, because I was able to slip right past them and get away.  I'd kind of scouted out my route from above…  I avoided the major spiked blockades, and headed out towards a friend's place.  I had to fight off a couple of the <zombies>, but I managed to avoid any big fuss, by some miracle."),
        no = ccb.content.text("Well, I still didn't have any food.  Eventually I had to climb down… so I did, as quietly as I could.  It was night, and I have pretty good nightvision.  Apparently the giant bugs don't, because I was able to slip right past them and get away.  I'd kind of scouted out my route from above…  I avoided the major spiked blockades, and headed out towards a friend's place.  I had to fight off a couple of the <zombies>, but I managed to avoid any big fuss, by some miracle.  I never made it to the where I was going, but that's not important now."),
    },
    replies = {
        {
            text = ccb.content.text("What did you see, up there?"),
            next_topic = "BGSS_HOSPITAL_2_ROOF",
        },
        {
            text = ccb.content.text("Thanks for telling me all that.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
