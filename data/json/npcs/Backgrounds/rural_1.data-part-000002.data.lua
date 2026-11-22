local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_RURAL_1_STORY3",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_BGSS_rural_1_started_quest" } }),
        yes = ccb.content.gendered_line("That was the first thing to really shake me out of it.  I didn't really have any very close friends, but there were people back in town I cared about a bit.  I had sent some texts, but I hadn't really twigged that they hadn't replied for days.  I got in my truck and tried to get back to town.  Didn't get far before I hit a <zombie> infested pileup blocking the highway, and that's when I started to put it all together.  Never did get to town.  Unfortunately I led the <zombies> back to my farm, and had to bug out of there.  And now I'm here with you.", { "interlocutor" }),
        no = ccb.content.gendered_line("That was the first thing to really shake me out of it.  I didn't really have any very close friends, but there were people back in town I cared about a bit.  I had sent some texts, but I hadn't really twigged that they hadn't replied for days.  I got in my truck and tried to get back to town.  Didn't get far before I hit a <zombie> infested pileup blocking the highway, and that's when I started to put it all together.  Never did get to town.  Unfortunately I led the <zombies> back to my farm, and had to bug out of there.  Might go back and clear it out, someday.", { "interlocutor" }),
    },
    replies = {
        {
            text = ccb.content.text("I could help you clear out your farm if you wanted.  You just have to show me the way…"),
            when = predicates.handler("w16b_p_dda_90b0afd7b6d0"),
            trial = { kind = "persuade", difficulty = 30, modifiers = { { score = "TRUST", scale = 6 }, { score = "VALUE", scale = 3 }, { score = "ANGER", scale = -6 } } },
            success = { next_topic = "BGSS_RURAL_1_FARMSUCCESS", actions = { actions.handler("w16b_a_dda_31d3731a9cd1") } },
            failure = { next_topic = "BGSS_RURAL_1_FARMFAILURE", actions = { actions.handler("w16b_a_dda_73816ff3f794"), actions.set_actor_value("speaker", "general_BGSS_rural_1_asked_about_quest", "yes") }, opinion = { trust = -1 } },
        },
        {
            text = ccb.content.text("Thanks for telling me that.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("<end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}
