local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Refugees1",
    line = {
        when = predicates.handler("dlg_p_dda_3b14879c9833"),
        yes = ccb.content.text("For better or worse, we're a community now.  Fatima and I work together a fair bit, and I consider Dana, Draco, and Aleesha my friends, and so of course I've gotten to know Dana's husband Pedro too.  The Borichenkos are their own sweet brand of messed up, like all of us.  The Singhs have each other, and keep mostly to themselves.  Vanessa and I don't see eye to eye, but I'm still glad she's here.  Uyen and Rhyzaea are always bickering about leadership decisions, as if they made those kind of calls.  What did you want to know?"),
        no = ccb.content.text("Well, there's a bunch of us.  We're starting to form a bit of a community.  Fatima and I work together a fair bit, and I've been hanging out with Dana, Draco, and Aleesha quite a lot.  I don't know the Borichenko bunch, the Singhs, Vanessa, Uyen, or Rhyzaea quite as well, but we've talked.  What did you want to know?"),
    },
    replies = {
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
