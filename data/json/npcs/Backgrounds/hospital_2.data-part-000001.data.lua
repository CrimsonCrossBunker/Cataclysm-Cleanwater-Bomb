local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_2_NOTYET",
    line = ccb.content.text("No.  I can't.  Just, no."),
    replies = {
        {
            text = ccb.content.text("Sorry… I'll let you be."),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 14000 }) },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_2_STORY2",
    line = ccb.content.gendered_line("A young mother.  I know she was a mother, because I delivered her baby.  Sweet girl, she… she had a good sense of humor.  She came in, spitting that black goo, fighting the orderlies, dead from a bullet wound through the chest.  That's when I… I don't know if I woke up, finally, or if I finally went crazy.  Either way, I broke.  I broke a lot earlier than my colleagues, and that's the only reason I lived.  I skipped out, went to a dead corner of the hospital I used to hide in when I was a resident.  An old stairwell leading to a closed-off unit the maintenance staff were using to store old equipment.  I hid there for hours, while I listened to the world crumbling outside and inside.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("How did you get out of there?"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "BGSS_HOSPITAL_2_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "TALK_DONE",
        },
    },
}
