local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYN_BACKGROUND",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cowboyn_cowboynmota" } }),
        yes = ccb.content.gendered_line("I already told you.  Don't want to go through it again.", { "interlocutor" }),
        no = ccb.content.gendered_line("Lived in a nearby town.  Normal life.  9 to 5 job.  When it all happened, we ran away to find some safety.  But there's no safety anymore, is there?", { "interlocutor" }),
    },
    replies = {
        {
            text = ccb.content.text("Wait, 'we'?"),
            next_topic = "TALK_COWBOYN_PARTNER",
            when = predicates.any({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cowboynmota" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cowboynmots" } })) }),
        },
        {
            text = ccb.content.text("Right.  Okay."),
            next_topic = "TALK_COWBOYN_MAIN",
            when = predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cowboynmota" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cowboynmots" } }) }),
        },
    },
}
