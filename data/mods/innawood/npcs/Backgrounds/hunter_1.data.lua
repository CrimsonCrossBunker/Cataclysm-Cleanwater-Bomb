local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_HUNTER_1_STORY1",
    line = ccb.content.text("I live way out in the middle of nowhere.  I hear it was easier the farther out you were, the big bad monsters liked to go where there were a lot of people ready and waiting to be taken.  Doesn't matter to me, I was out on my end-of-winter hunting trip, I'd been out for a week already.  First clue I had things were going wrong was when I saw a fluffy pink mushroom cloud out near a big burned up field, way out in the middle of nowhere.  I didn't think much about that.  Then I was attacked by a dream demon."),
    replies = {
        { text = ccb.content.text("A demon?"), next_topic = "BGSS_HUNTER_1_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HUNTER_1_STORY2",
    line = ccb.content.text("Yeah, it was like a… like a big soft shelled crab, with tentacle mouths, and it kept talking in different voices.  I saw it before it saw me, and I capped it with my blunderbuss.  That just pissed it off, but I got another shot off while it charged me.  It got me, but I managed to end it first.  I figured out shit had hit the oyster shell, somehow.  Headed to my shelter and camped out there for a while, but I had to skip out when a bunch of giant bees showed up and trashed the place.  I ran into you not much later."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
    },
}
