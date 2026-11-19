local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BEM_JABBERWOCK_1",
    line = {
        when = predicates.has_mission("BEM_jabberwock_mission"),
        yes = ccb.content.text("&You see one more traumatized face, all too many and too frequent for any help to be worthwhile."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_bem_completed_bem_jabberwock" } }),
            yes = ccb.content.text("&You see one more traumatized face, all too many and too frequent for any help to be worthwhile."),
            no = ccb.content.gendered_line("&The mercenary stares intently at a stain in the ceiling, firmly clutching a now cold cup of soup.  No one else seems to be very concerned about this.", { "interlocutor" }),
        },
    },
    replies = {
        {
            text = ccb.content.text("Attempt a friendly approach."),
            next_topic = "BEM_JABBERWOCK_2",
            when = predicates.negate(predicates.any({ predicates.has_mission("BEM_jabberwock_mission"), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_bem_completed_bem_jabberwock" } }) })),
        },
        { text = ccb.content.text("Leave the traveler to their trauma."), next_topic = "TALK_DONE" },
    },
}
