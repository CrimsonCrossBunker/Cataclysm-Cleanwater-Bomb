local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "MSU14_PRE_DOCS",
    line = ccb.content.text("&Listing all saved files:\nA. P-144MS TALON UGV platform - Generative optimizations"),
    replies = {
        {
            text = ccb.content.text("View and print the Talon Schematics."),
            next_topic = "MSU14_DOCS_SUCCESS",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "computer_hacking_msu14_printed_docs" } })),
        },
        {
            text = ccb.content.text("View and print the Talon Schematics."),
            next_topic = "MSU14_DOCS_FAILURE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "computer_hacking_msu14_printed_docs" } }),
        },
        { text = ccb.content.text("Return."), next_topic = "MSU14_MAIN" },
    },
}
