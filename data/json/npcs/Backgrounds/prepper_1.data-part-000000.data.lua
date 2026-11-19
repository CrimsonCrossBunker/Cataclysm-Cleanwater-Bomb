local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- If the player already confronted the Prepper about their shelter and is gated out of that part of the conversation, this allows the player to still have a fun chat about apocalypse theories with them.
ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_STORY1",
    line = ccb.content.gendered_line("Ooooh, boy.  I was ready for this.  The winds were blowing this way for years.  I had a full last man on earth shelter set up just out of town.  So, of course, just my luck: I was miles out of town for a work conference when China attacked and the world ended.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("What happened to you?"), next_topic = "BGSS_PREPPER_1_STORY2" },
        { text = ccb.content.text("What about your shelter?"), next_topic = "BGSS_PREPPER_1_LMOE" },
        {
            text = ccb.content.text("You said you could tell me more about the shelter if I wanted.  How did these things get built?"),
            next_topic = "BGSS_PREPPER_1_LMOE2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_BGSS_prepper_1_finished_quest" } }),
        },
        {
            text = ccb.content.text("What do you think happened?  You must have some interesting theories on why everything went to shit."),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE7",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_BGSS_prepper_1_asked_about_shelter" } }),
        },
        {
            text = ccb.content.text("Hey, uh…  I noticed you left a computer down in your shelter.  I didn't intend to pry, but you said I could go through everything.  So, I read a little of what you wrote.  You wanna talk about it?"),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE6",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "mission_BGSS_prepper_1_found_computer" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_BGSS_prepper_1_asked_about_shelter" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_BGSS_prepper_1_finished_quest" } }) }),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
