local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "CWH_CONFUSED_1_IDEAS2",
    line = ccb.content.text("What, don't you remember?  No, sorry, that's not fair, it was a weird time.  OK, well, I guess this all started with the riots, didn't it?  We were just leading our lives, doing our jobs, and then people started rioting.  Not the usual protests that turned violent or anything, either, people just started breaking shit.  Some people tried to downplay it but I saw what I saw I think.  I don't know what caused it, they said it was some kind of drug or toxin in the water?  Still, I didn't really realize how bad it was getting at first.  Somewhere along the way the \"rioters\" started getting up and walking around with holes in their chests, and that's when the real panic took over.  The next few days - or weeks, not really sure - are a blur to me.  You'd have to ask someone else how we got from there to total collapse."),
    replies = { { text = ccb.content.text("Thanks for filling me in."), next_topic = "TALK_FRIEND" } },
}
