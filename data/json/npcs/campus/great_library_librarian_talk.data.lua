local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GREAT_LIBRARY_LIBRARIAN_MoreBooks",
    line = ccb.content.text("Yes we are.  We still have some of our original collection, but far too much of it was stolen or destroyed, and of course it was far from complete even before.  Some of us go out to try and rebuild the collection from towns nearby, but mostly we rely on people passing through like you.  We especially want anything rare and hard to find."),
    replies = {
        {
            text = ccb.content.text("I'll keep that in mind."),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_Talk",
        },
    },
}
