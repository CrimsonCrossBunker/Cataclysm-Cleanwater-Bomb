local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_8",
    line = ccb.content.text("Well now, my friend-o!  You just asked a mighty fine question.  Folks have been missing the little things in life.  New shoes, new cellphones, can't exactly go shopping, or, well, I guess you sorta can, if you mind the broken glass.  I left my wallet in an outdoorsman's store when I 'bought' this warmer coat.  Figured that's kinda it, you know?  It didn't matter anymore.  I don't think my insurance's going to pay out for any health care I get now.  I did what you see in the movies though, I rolled a joint with a hundred dollar bill.  Ended up coughing and rerolling it in regular paper though.  Was too harsh.  Just letting you know in case you get the smart idea of trying it."),
    replies = { { text = ccb.content.text("Go on."), next_topic = "TALK_REFUGEE_Draco_9" } },
}
