local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Dana_TrailerKeys",
    line = ccb.content.text("*turns serious.  \"We went inside the dealership to see if they were there.  Owner was still in there.  I… I think he took his own life, maybe figured destroying the brain would keep him from reviving.  It… it didn't.  The shotgun took out enough though, he couldn't, uh, he couldn't really see.  Just this miserable, half-faced… we put him down.  I think we did him a favor, if there was any of him left in there.  Didn't feel wrong going through his pockets.  Gross, but not wrong.\"  She blows out a stream of air, sending a small cloud of flour rising in the air, then shrugs."),
    replies = {
        {
            text = ccb.content.text("What made this trailer so good?"),
            next_topic = "TALK_TACOMA_Dana_Trailer2",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
