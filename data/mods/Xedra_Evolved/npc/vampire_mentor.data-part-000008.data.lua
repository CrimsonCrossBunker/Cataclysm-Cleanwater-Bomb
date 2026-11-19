local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_BECOME_STRONGER" },
    line = {
        when = predicates.has_trait("speaker", "VAMPIRE3"),
        yes = ccb.content.text("You are ready for the next step.  However, I must warn you: there is no coming back from that.  Your vampirism will become impossible to lose.  Do you wish to proceed?"),
        no = ccb.content.text("Your vampirism isn't potent enough.  Come back when your mortal hungers will begin to be replaced by immortal hungers.  They are the signs that your power increased enough to withstand what you'll gain from my help."),
    },
    replies = {
        {
            text = ccb.content.text("I am certain.  Make me more powerful."),
            when = predicates.has_trait("speaker", "VAMPIRE3"),
            next_topic = "TALK_VAMPIRE_MENTOR_POWER",
        },
        {
            text = ccb.content.text("I do not wish to be struck as a vampire forever."),
            when = predicates.has_trait("speaker", "VAMPIRE3"),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Got it.  See you."),
            when = predicates.negate(predicates.has_trait("speaker", "VAMPIRE3")),
            next_topic = "TALK_DONE",
        },
    },
}
