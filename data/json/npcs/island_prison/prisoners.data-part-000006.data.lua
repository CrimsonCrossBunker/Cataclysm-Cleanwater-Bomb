local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_ANNOYED",
    line = ccb.content.text("We don't have much space, and there's not much food.  Besides, I don't know you at all, and something tells me you won't survive another day."),
    replies = {
        {
            text = ccb.content.text("[STR 11] I'm tougher than it seems!"),
            next_topic = "TALK_PRISONER_LEADER_NO",
            when = predicates.minimum_attribute("speaker", "strength", 11),
        },
        {
            text = ccb.content.text("[Survival 2] I have some survival expertise!"),
            next_topic = "TALK_PRISONER_LEADER_NO",
            when = predicates.handler("dlg_p_dda_7fe93cb81db6"),
        },
        {
            text = ccb.content.text("I guess I need to find some other place…"),
            next_topic = "TALK_DONE",
        },
    },
}
