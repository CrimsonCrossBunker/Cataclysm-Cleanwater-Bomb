local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CABIN_CHEMIST_STORY",
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "dialogue_story_told_u_backstory", "yes") },
        },
    },
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_story_told_u_backstory" } }),
        yes = ccb.content.gendered_line("Like I said before, I'm a chemist.  I've been living out here for a while, decided to set up shop in this old cabin.  I even found some good equipment out here, and a couple useful things here in the cupboards.  I decided to stay right here.", { "interlocutor" }),
        no = ccb.content.gendered_line("I used to be a chemist.  Well, I am a chemist.  I've been living out here in the wilderness for a little while now since <the_cataclysm>.  Lucky enough, I even found some good equipment out here, though unfortunately missing some of the more sensitive and expensive stuff.  I found a couple useful things here in the cupboards, but other than that, entirely empty.  So, I moved in.", { "interlocutor" }),
    },
    replies = { { text = ccb.content.text("Hmm."), next_topic = "TALK_NONE" } },
}
