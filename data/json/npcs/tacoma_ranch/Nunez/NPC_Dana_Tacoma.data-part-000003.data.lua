local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Dana_Trailer1",
    line = ccb.content.text("Ha, this thing!\"  She dusts the flour off her hands and tucks a loose lock of hair back behind her ear.  \"You remember, we signed on as caravan hands to get us out here.  Well, we had a bunch of stops along the way first.  We were headed to a little group of survivors that snagged themselves a huge stock of dry food somehow, and passed this trailer sales yard smack dab in the middle of nowhere, nobody to be seen for miles.  Pablo managed to sweet talk the group into taking a rest stop there.  We searched the yard, and a lot of the stuff wasn't suitable, but this baby was ready to go.  Long story short, we got the keys to that vintage truck outside, hitched this thing up, and upgraded our caravan."),
    replies = {
        {
            text = ccb.content.text("How did you get the keys to the truck?"),
            next_topic = "TALK_TACOMA_Dana_TrailerKeys",
        },
        {
            text = ccb.content.text("What made this trailer so good?"),
            next_topic = "TALK_TACOMA_Dana_Trailer2",
        },
        {
            text = ccb.content.text("Any luck with the pregnancy?"),
            next_topic = "TALK_TACOMA_Dana_Pregnancy",
            when = predicates.any_equal({ "knows", { scope = "speaker", key = "knowledge_dana_pregnancy" } }),
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
