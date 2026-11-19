local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_family",
    line = {
        choices = {
            ccb.content.text("I used to, me and my mother were pretty close.  I didn't know my father very well for the first four years of my life, he was always out on deployment with the Navy someplace.  Me and him got to know each other after he retired from the service, we'd always go fishing on Sunday afternoons for years.  My mother though, she was the sweetest lady you'd ever meet, always took care of me and Dad.  Now they're gone, been that way for the last three years."),
        },
    },
    replies = {
        {
            text = ccb.content.text("You're mother must've been very nice."),
            next_topic = "TALK_GODCO_guard_food_mother",
        },
        {
            text = ccb.content.text("What was your father like?"),
            next_topic = "TALK_GODCO_guard_food_father",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_guard_food_idlechat",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_mother",
    line = {
        choices = {
            ccb.content.text("She sure was, helped me through some very hard times in my life.  I used to be bullied in middle school, whenever I'd get beat up, she'd always help clean me up and tell me I'd be alright.  She had this recipe for peach casserole too, best one in the world.  It was hard for me when she passed, but I found some solace right here in this Church.  We'd always been religious, but this one just clicked for me, ya know?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("Is that why you joined the Church?"),
            next_topic = "TALK_GODCO_guard_food_church",
        },
        {
            text = ccb.content.text("What was your father like?"),
            next_topic = "TALK_GODCO_guard_food_father",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_guard_food_idlechat",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_father",
    line = {
        choices = {
            ccb.content.text("He was a nice fellow, taught me everything I know about firearms, wildlife, and sailing.  We lived next to this big ol' lake, so we had plenty of opportunities to catch bass and catfish.  He'd skin and filet them, and we'd have it for dinner.  My mother always cooked them, and she was great at it."),
        },
    },
    replies = {
        {
            text = ccb.content.text("You're mother sounds very nice, what was she like?"),
            next_topic = "TALK_GODCO_guard_food_mother",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_guard_food_idlechat",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_church",
    line = {
        choices = {
            ccb.content.text("Yeah, her death was hard on me.  I wound up goin' here one day, and I felt something come over me, like I belonged here.  I haven't left since, and I've been able to move on with them."),
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_guard_food_idlechat",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
