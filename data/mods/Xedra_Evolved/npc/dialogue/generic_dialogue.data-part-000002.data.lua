local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_HYPNOTIC_GAZE_USED" },
    line = {
        when = predicates.has_any_trait("speaker", { "VAMPIRE4", "PSYCHOPATH" }),
        yes = ccb.content.text("*stares stupidly as you meet <mypossesivepronoun> gaze and overwhelm <mypossesivepronoun> pitiful mind.  Pathetic.  Like a lamb awaiting the slaughter."),
        no = ccb.content.text("*stares blankly as you meet <mypossesivepronoun> gaze and overwhelm <mypossesivepronoun> mind.  As <mypossesivepronoun> hands fall listlessly to <mypossesivepronoun> sides, <mypossesivepronoun> gaze becomes unfocused and <mypossesivepronoun> mouth drops half-open."),
    },
    replies = {
        {
            text = ccb.content.text("Ha.  Mortals are nothing but cattle."),
            next_topic = "TALK_DONE",
            when = predicates.has_any_trait("speaker", { "VAMPIRE4", "PSYCHOPATH" }),
        },
        {
            text = ccb.content.text("Well, that's one problem solved."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_any_trait("speaker", { "VAMPIRE4", "PSYCHOPATH" })),
        },
    },
}
