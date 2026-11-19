local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_COP_1_STORY1",
    line = ccb.content.text("I enforced the rules.  Small area, not a lot of responsibility.  We got orders without even really knowing what they meant.  At some point one of the spear men told me it was a foreign attack, something in the water supply… I don't know if I believe it now, but at the time it was the best explanation.  At first it was weird, a few people - <zombies> - fighting like rabid animals.  Then it got worse.  I tried to control things, but it was just me and a few other big violent types against a riot.  Then things really got fucked up."),
    replies = {
        { text = ccb.content.text("What happened?"), next_topic = "BGSS_COP_1_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_COP_1_STORY2",
    line = ccb.content.text("A big-ass hole opened up right in the middle of everything, and a nightmarish demon crawled out.  We shot at it, but bullets just bounced off.  Got a lot of people in the crossfire.  It started just devouring people like pemmican into a gullet that looked like a rotting asshole with teeth, and… well, I lost my nerve.  I ran.  I think I might have been the only person to escape.  I haven't been able to even look at my face since then."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
