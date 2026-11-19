local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = {
        "TALK_GREAT_LIBRARY_LIBRARIAN_OutsideWorld", "TALK_GREAT_LIBRARY_LIBRARIAN_OutsideWorld1",
        "TALK_GREAT_LIBRARY_LIBRARIAN_OutsideWorld2",
    },
    line = ccb.content.text("Some, here and there.  My responsibilities keep me here but I have spoken with traveling merchants.  They thought we wanted guns and were confused that we wished to trade books for books.  I must assume that most of the other survivors are more violent and less scholarly."),
    replies = {
        {
            text = ccb.content.text("Are there any other settlements around?"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_Robofac",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_free_merchants_u_hub01_breadcrumb_accepted" } })),
        },
        {
            text = ccb.content.text("Are there any other settlements around?"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_OutsideWorld2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_free_merchants_u_hub01_breadcrumb_accepted" } }),
        },
        {
            text = ccb.content.text("That's fine for now."),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_Talk",
        },
    },
}
