local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_BROKER_STORY",
    line = {
        choices = {
            ccb.content.gendered_line("I was homeless for a while before <the_cataclysm>.  I met some buddies out on the road and we were camping out here.  Now we're just scraping by on what we can find, mostly.  We're willing to trade, though.  Who knows, you might find yourself a good deal.", { "interlocutor" }),
            ccb.content.text("Making ends meet, even in the worst circumstances.  We've been camping out here now, trading with whoever passes by.  If something catches your eye, let me know."),
            ccb.content.text("We got tired of being out on the road and decided to stay here for a bit.  We've found a lot of useful stuff out and about, so if you see anything you need I'll make you a deal."),
        },
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_first_meeting_told_about_buddies", "yes"),
            },
        },
    },
    replies = { { text = ccb.content.text("Hm."), next_topic = "TALK_NONE" } },
}
