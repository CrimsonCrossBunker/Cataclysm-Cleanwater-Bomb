local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_2_STORY4",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_BGSS_hospital_2_started_quest" } }),
        yes = ccb.content.gendered_line("Well, I still didn't have any food.  Eventually I had to climb down the side of the building… so I did, as quietly as I could.  It was night, and I have pretty good nightvision.  Apparently the zombies don't, because I was able to slip right past them and steal a bicycle that was just laying on the side of the road.  I'd kind of scouted out my route from above… I'm not from a big city, the hospital was the tallest building around.  I avoided the major military blockades, and headed out of town towards a friend's old cabin.  I had to fight off a couple of the <zombies>, but I managed to avoid any big fuss, by some miracle.", { "interlocutor" }),
        no = ccb.content.gendered_line("Well, I still didn't have any food.  Eventually I had to climb down the side of the building… so I did, as quietly as I could.  It was night, and I have pretty good nightvision.  Apparently the zombies don't, because I was able to slip right past them and steal a bicycle that was just laying on the side of the road.  I'd kind of scouted out my route from above… I'm not from a big city, the hospital was the tallest building around.  I avoided the major military blockades, and headed out of town towards a friend's old cabin.  I had to fight off a couple of the <zombies>, but I managed to avoid any big fuss, by some miracle.  I never made it to the cabin, but that's not important now.", { "interlocutor" }),
    },
    replies = {
        {
            text = ccb.content.text("What did you see, up there on the roof?"),
            next_topic = "BGSS_HOSPITAL_2_ROOF",
        },
        {
            text = ccb.content.text("Any chance you could point the way to that cabin for me?"),
            when = predicates.handler("w16b_p_dda_f49cb36318c1"),
            trial = { kind = "persuade", difficulty = 40, modifiers = { { score = "TRUST", scale = 5 }, { score = "VALUE", scale = 2 }, { score = "ANGER", scale = -6 } } },
            success = { next_topic = "BGSS_HOSPITAL_2_CABINSUCCESS", actions = { actions.handler("w16b_a_dda_bff2189d5b26") } },
            failure = { next_topic = "BGSS_HOSPITAL_2_CABINFAILURE", actions = { actions.handler("w16b_a_dda_e1e3d10f9e00"), actions.set_actor_value("speaker", "general_BGSS_hospital_2_asked_about_quest", "yes") }, opinion = { trust = -1 } },
        },
        {
            text = ccb.content.text("Thanks for telling me all that.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("<end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}
