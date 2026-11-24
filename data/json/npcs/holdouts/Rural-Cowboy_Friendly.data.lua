local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- A rural holdout survivor trying to stay safe
ccb.content.define_npc {
    id = "RURAL_HOLDOUT_FRIENDLY",
    class = "NC_COWBOY",
    attitude = 0,
    suffix = ccb.content.text("Survivor cowboy"),
    mission = "GUARD",
    chat = "TALK_COWBOYFR_MAIN",
    faction = "no_faction",
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYFR_MAIN",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyfr" } }),
        yes = ccb.content.text("Hello again."),
        no = ccb.content.text("Ayuh, I was thinkin' it's just another monstah skulkin' about.  Who are you?"),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_first_meeting_talked_to_cowboyfr", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Just a survivor, looking around.  What are you doing here?"),
            next_topic = "TALK_COWBOYFR_INTRODUCTION",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyfr" } })),
        },
        {
            text = ccb.content.text("What did you before all this?"),
            next_topic = "TALK_COWBOYFR_BACKGROUND",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyfr" } }),
        },
        {
            text = ccb.content.text("Is there something I can do for you?"),
            next_topic = "TALK_COWBOYFR_HELP",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyfr" } }),
        },
        {
            text = ccb.content.text("How about we travel together?"),
            next_topic = "TALK_COWBOYFR_FOLLOW",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyfr" } }),
        },
        {
            text = ccb.content.text("What's with the accent?"),
            next_topic = "TALK_COWBOYFR_ACCENT",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyfr" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYFR_BACKGROUND",
    line = ccb.content.gendered_line("I worked on a ranch not too fah from here 'fore it all went down.  I'd love ta get back ta what I did - taking care of horses, cows, all sorts of animals, makin' sure the fields stay safe an' all that.  But now?  I dunno, man.  Just tryin' ta survive, I suppose.  Hopefully, tha world will get back togetha' one day and I can put mah skills ta use doin' what I like.", { "interlocutor" }),
    replies = { { text = ccb.content.text("Let's hope it will."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYFR_INTRODUCTION",
    line = ccb.content.gendered_line("I was just sort of wanderin' around, hoping ta maybe find some bettah gear.  Decided ta rest up, 'eard someone walkin', and, well, here we are.", { "interlocutor" }),
    replies = { { text = ccb.content.text("I see."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYFR_HELP",
    line = ccb.content.text("Can't say I can think of summin' specific right now.  Gotta say though, maybe it oughta be a good idea for us ta travel togetha' - safety in numbers an' all that."),
    replies = {
        { text = ccb.content.text("I'll think about it."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text("Is it a good idea to trust a stranger like me this easily?"),
            next_topic = "TALK_COWBOYFR_TRUST",
        },
        {
            text = ccb.content.text("Sounds like a good idea - want to join me, then?"),
            next_topic = "TALK_COWBOYFR_FOLLOW",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYFR_FOLLOW",
    line = ccb.content.text("Wicked.  Been around the old road long enough ta know how ta handle myself in a pinch.  Knew my way around a gun ever since my da taught me when I was a kid, so ya don't have ta worry about me doing my part."),
    replies = {
        {
            text = ccb.content.text("On a second thought, let me think about it a bit more."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Great!  <lets_go>"),
            next_topic = "TALK_DONE",
            native_actions = { "follow" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYFR_TRUST",
    line = ccb.content.text("Don't have much of a choice, do I?  On my own, a monstah will get lucky sooner or later, and even if I kill it, bleedin' out in some alley is not summin' I fancy.  Plus, we just had a nice, civil chat where no one tried ta kill the otha', so I reckon we're off to ah' good start, all things considered."),
    replies = {
        {
            text = ccb.content.text("Fair enough.  Want to travel with me, then?"),
            next_topic = "TALK_COWBOYFR_FOLLOW",
        },
        {
            text = ccb.content.text("Can't say I really agree.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYFR_ACCENT",
    line = ccb.content.text("Wha', nevah been ta Boston 'ave ya?  Hope you're not 'avin a hahd time keepin' up with me, but if ya get used ta it, wicked good fun, let me tell ya."),
    replies = {
        { text = ccb.content.text("I like it."), next_topic = "TALK_NONE" },
        { text = ccb.content.text("I hate it."), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Okay then."), next_topic = "TALK_NONE" },
    },
}
