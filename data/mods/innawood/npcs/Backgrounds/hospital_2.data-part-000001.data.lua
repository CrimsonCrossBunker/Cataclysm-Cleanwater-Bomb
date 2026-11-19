local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_2_STORY2",
    line = ccb.content.text("A young mother.  I know she was a mother, because I delivered her baby.  Sweet girl, she… she had a good sense of humor.  She came in, spitting that black goo, fighting the orderlies, dead from a spear wound through the chest.  That's when I… I don't know if I woke up, finally, or if I finally went crazy.  Either way, I broke.  I broke a lot earlier than my colleagues, and that's the only reason I lived.  I skipped out and hid for hours, while I listened to the world crumbling outside and inside."),
    replies = {
        {
            text = ccb.content.text("How did you get out of there?"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "BGSS_HOSPITAL_2_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "TALK_DONE",
        },
    },
}
