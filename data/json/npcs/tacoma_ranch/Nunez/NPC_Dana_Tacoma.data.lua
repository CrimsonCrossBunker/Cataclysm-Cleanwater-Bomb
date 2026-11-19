local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Dana_Pregnancy",
    line = ccb.content.text("*shrugs.  \"We got our hands on a few boxes of test strips so that's good.  Being stressed isn't good for conception and I've been pretty fuckin' stressed for a while.  I like our chances a lot better now, that's for sure.  And, well, we've got our own private space at least.\"  She smirks and then blushes slightly, hiding it by fiddling with her baking project."),
    replies = {
        {
            text = ccb.content.text("What's with the trailer?"),
            next_topic = "TALK_TACOMA_Dana_Trailer1",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
