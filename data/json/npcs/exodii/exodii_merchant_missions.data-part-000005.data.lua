local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_explain",
    line = ccb.content.text(
        --~ Have you seen our big stompy quads?  There's a lot of things we're good at, but sneaky and subtle we aren't.  If we want a meet cute, first we've got to lay out the hempen mats.
        "Hat ye kennt our great clanks an' stompers?  There be many a thing we can do right good, but for the supple an' smooth, we b'ain't.  Wish'n we to make a meet-cute, must we first lay out the hempen mats."),
    replies = {
        {
            text = ccb.content.text("Hold up, did you just say \"meet cute\"?"),
            next_topic = "TALK_EXODII_MERCHANT_Meetcute",
        },
        {
            text = ccb.content.text("I am guessing it doesn't matter, but what do you mean about hempen mats?"),
            actions = { actions.set_actor_value("speaker", "rubik_personal_questions", "hempen_mats") },
            next_topic = "TALK_EXODII_MERCHANT_Hempen1",
        },
        {
            text = ccb.content.text("OK, fine.  Tell me more about this job that you can't do."),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_intro1",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}
