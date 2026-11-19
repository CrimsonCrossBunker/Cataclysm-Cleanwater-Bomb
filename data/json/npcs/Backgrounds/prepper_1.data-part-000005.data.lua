local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE3_BEMEAN",
    line = ccb.content.text("I guess I know exactly how much to trust you now."),
    replies = {
        {
            text = ccb.content.text("You sure do."),
            next_topic = "TALK_DONE",
            opinion = { anger = 1, value = -1, trust = -1 },
        },
        {
            text = ccb.content.text("This is the world now.  If I didn't take it, someone else would have."),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE3_BENICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE3_BENICE",
    line = ccb.content.gendered_line("I suppose that's true.  Still not a very nice way to break the news to someone you accidentally robbed…", { "speaker" }),
    replies = {
        { text = ccb.content.text("You're right, sorry."), next_topic = "TALK_FRIEND_CONVERSATION" },
        {
            text = ccb.content.text("I'm just doing what I have to do.  Stick with me and we'll find plenty of stuff to replace it."),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE4",
    line = ccb.content.text("Oh…  Yeah, that would definitely do it.  It's a shame someone already got in.  I had a lot of stuff saved up there.  But I suppose it wouldn't matter much now."),
    replies = {
        {
            text = ccb.content.text("Stick with me and we'll find plenty of stuff to replace it."),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE4_BEHONEST",
    line = ccb.content.gendered_line("I guess I can't judge.  I've made some fucked up decisions, too.  Taken some things that aren't mine.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("I'm sorry.  I'm sure we can find lots of stuff to replace whatever I took."),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE4_FAILLIE",
    line = ccb.content.gendered_line("You're not really a good liar.  I built that thing like a fortress.  No one would just break into it.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Well…  I did.  And that's just how it goes.  It wasn't even that difficult."),
            next_topic = "TALK_DONE",
            opinion = { anger = 3, trust = -2 },
        },
        {
            text = ccb.content.text("I'm sorry.  I guess I just didn't know how to tell you I needed what was in it."),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE4_FAILLIE2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE4_FAILLIE2",
    line = ccb.content.gendered_line("Just don't lie about it.  I understand your life was probably in danger.  I can see past that.  Trust me, I've been in sticky situations before.  Tell the truth next time.", { "interlocutor" }),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE5",
    line = ccb.content.text("&<npc_name> inhales sharply and breaks eye contact.\n\n\"I…  I mean, I can sympathize with someone who thinks that way…  The government lies all the time and they're probably out there somewhere STILL lying.  But nah, I wouldn't leave my computer laying around, unprotected.\""),
    replies = {
        {
            text = ccb.content.text("Are you sure?  It kind of feels like it might be yours by the way you're acting…"),
            trial = {
                kind = "persuade",
                difficulty = 30,
                modifiers = {
                    { score = "TRUST", scale = 1 },
                    { score = "VALUE", scale = 1 },
                    { score = "ANGER", scale = -2 },
                },
            },
            success = { next_topic = "BGSS_PREPPER_1_FOUND_LMOE6" },
            failure = { next_topic = "BGSS_PREPPER_1_FOUND_LMOE6_FAILLIE", opinion = { trust = -1 } },
        },
        {
            text = ccb.content.text("There was a bunch of notes about Chinese bio-weapons and this guy who worked at an airport…  If you want to talk about it, we can."),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE6_FAILLIE",
        },
        {
            text = ccb.content.text("But you DID leave your computer unprotected.  AND full of evidence.  It's exactly what a government agent would need to track you down…  Someone like me…"),
            next_topic = "BGSS_PREPPER_1_SHARELOOTFAILURE3",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE6_FAILLIE",
    line = ccb.content.text("Nope.  Not mine.  Listen, maybe we shouldn't talk about this right now."),
    replies = {
        {
            text = ccb.content.text("Why not?  Now that it's all finally come to a head, maybe some of your theories are right."),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE6",
        },
        {
            text = ccb.content.text("OK, I understand.  Sorry for being nosy."),
            next_topic = "TALK_DONE",
        },
    },
}
