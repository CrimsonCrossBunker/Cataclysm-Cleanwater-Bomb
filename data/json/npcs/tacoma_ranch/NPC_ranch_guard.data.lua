local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_GUARD",
    line = {
        choices = {
            ccb.content.text("I'm not in charge here, you're looking for someone else…"),
            ccb.content.text("Keep civil or I'll bring the pain."),
            ccb.content.text("Just on watch, move along."),
            {
                when = predicates.actor_state("speaker", "male"),
                yes = {
                    choices = { ccb.content.text("Sir."), ccb.content.text("Rough out there, isn't it?") },
                },
                no = {
                    choices = {
                        ccb.content.text("Ma'am"),
                        ccb.content.text("Ma'am, you really shouldn't be traveling out there."),
                    },
                },
            },
        },
    },
    replies = { { text = ccb.content.text("Don't mind me…"), next_topic = "TALK_DONE" } },
}
