local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Fatima_1a",
    line = {
        joined = {
            ccb.content.text("*futilely dusts a bit of grime on her coveralls, then looks at you.  \""),
            {
                choices = {
                    ccb.content.text("Hello again."),
                    ccb.content.text("Good to see you're still around."),
                    ccb.content.text("Oh, hi."),
                },
            },
            ccb.content.text("\""),
        },
    },
    replies = {
        {
            text = ccb.content.text("Hi, Fatima.  How are things?"),
            next_topic = "TALK_REFUGEE_Fatima_2",
        },
        { text = ccb.content.text("Hi, Fatima.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Fatima_1_firstmeet",
    line = ccb.content.text("Well, cool.  Anything I can help you with?"),
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Fatima_2",
    line = ccb.content.text("Oh, you know, the usual.  Trapped in a tight space with a bunch of strangers getting along tenuously at best.  Good times, good times."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Fatima_Background",
    line = ccb.content.text("Before <the_cataclysm> I had just finished welding school actually, and was about to start looking for a job.  That was fun, being a young Muslim woman in a Massachusetts trade college, let me tell you."),
    replies = {
        {
            text = ccb.content.text("Welding seems like a pretty non-traditional occupational choice; is there a story there?"),
            next_topic = "TALK_REFUGEE_Fatima_Welding",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Fatima_Welding",
    line = ccb.content.text("You'd be surprised actually!  Metal art has been part of Muslim traditions for years, although that's not why I got into it.  I'm not a very traditional girl.  My parents aren't very traditional either, but my grandparents are really old fashioned and strict.  My sister came out as gay and they made her life really hard; mom and dad thought she should keep it secret, but she didn't believe in that.  I always loved mechanics and working with my hands, so when they started harassing my parents about getting my sister and I married off to nice men so we'd stop being so immoral, I decided to pick a job I liked that would bother them as much as possible.  It was a good choice, not only did it make them livid but I love welding.  I love the feel of standing back and looking at my work, knowing I took a few chunks of scrap metal and made them into something useful.  I love how it feels to make it fit together perfectly.  It just puts me at peace.\n\nI… I do hope my grandparents are okay though.  They were old fashioned, and they made choices I didn't like, but they were family and I still have sweet memories of them from when I was little.  I've had to do a lot more thinking about God since <the_cataclysm>, and while I'd never agree with the decisions they made, I understand more why they thought they had to make them.  They just wanted the whole family to share their relationship with God, in their messed up way."),
    replies = {
        {
            text = ccb.content.text("Welding comes up a lot in my life.  Do you think you could teach me?"),
            next_topic = "TALK_REFUGEE_Fatima_Teach",
        },
    },
}
