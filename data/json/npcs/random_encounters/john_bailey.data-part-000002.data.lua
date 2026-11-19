local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_Shopping",
    line = ccb.content.text("I don't really know.  Food stocks aren't too bad for me and mine, I found a stock of canned goods early on that will last us for a while yet.  I don't use a gun if I can avoid it, too noisy.  I notice these guys seem to keep a lot of building supplies though, and trying to get a vehicle downtown to loot a hardware store or a lumberyard is suicide, so I think that's where they're going to get my money.  I wonder if they deliver."),
    replies = {
        {
            text = ccb.content.text("What do you know about this place?"),
            next_topic = "TALK_RC_John_Bailey_RefCenter",
        },
        {
            text = ccb.content.text("Where are you headed next?"),
            next_topic = "TALK_RC_John_Bailey_OnMyWay",
        },
        {
            text = ccb.content.text("Who is \"you and yours\"?"),
            next_topic = "TALK_RC_John_Bailey_Faction",
        },
        {
            text = ccb.content.text("Are you looking for work?"),
            next_topic = "TALK_RC_John_Bailey_Work",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Sounds about the same as me, yep.  I'd better get back to it."),
            next_topic = "TALK_DONE",
        },
    },
}
