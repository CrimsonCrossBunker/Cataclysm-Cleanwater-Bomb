local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BEM_HUMAN_SAMPLE_1",
    line = {
        when = predicates.has_mission("BEM_human_sample_mission"),
        yes = ccb.content.text("Not in the mood for a talk, sorry."),
        no = ccb.content.gendered_line("&The mercenary stares at the window, and speaks in a quiet and terse manner.  \"I have a client looking for a medical-grade human biopsy sample, no questions asked.  Are you the right one for the job?\"", { "interlocutor" }),
    },
    replies = {
        {
            text = ccb.content.text("Oh yes.  I actually have one right here."),
            when = predicates.all({ predicates.has_inventory("speaker", "human_sample", 1), predicates.negate(predicates.has_mission("BEM_human_sample_mission")) }),
            next_topic = "BEM_HUMAN_SAMPLE_FINISH",
        },
        {
            text = ccb.content.text("I might be."),
            when = predicates.negate(predicates.has_mission("BEM_human_sample_mission")),
            next_topic = "BEM_HUMAN_SAMPLE2",
        },
        {
            text = ccb.content.text("No, but I might be looking to buy some."),
            when = predicates.negate(predicates.has_mission("BEM_human_sample_mission")),
            next_topic = "BEM_HUMAN_SAMPLE_BUY",
        },
        {
            text = ccb.content.text("No, not at all."),
            when = predicates.negate(predicates.has_mission("BEM_human_sample_mission")),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Sure, whatever."),
            when = predicates.has_mission("BEM_human_sample_mission"),
            next_topic = "TALK_DONE",
        },
    },
}
