local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Dana_1",
    line = ccb.content.gendered_line("*stands in the middle of a cramped kitchen, covered in flour.  The scene looks reminiscent of easier times, but the illusion is broken as he apron shifts to reveal a heavy machete and holstered pistol on her belt.  She looks up as you approach, then beams in recognition.  \"Welcome to Dana's Bakery, stranger!\"  She laughs brightly.  \"Glad you made out this way.  What can I do for you?\"", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Hi Dana, how are things here?"),
            next_topic = "TALK_TACOMA_Dana_2",
        },
        {
            text = ccb.content.text("Got any bread for sale?"),
            next_topic = "TALK_TACOMA_Dana_Baking",
        },
        {
            text = ccb.content.text("Hello, Dana!  What's with the trailer?"),
            next_topic = "TALK_TACOMA_Dana_Trailer1",
        },
        {
            text = ccb.content.text("Hey, Pablo!  Dana said you had some plans to build a bakery?"),
            next_topic = "TALK_TACOMA_Dana_Bakery1",
            when = predicates.any_equal({ "knows", { scope = "speaker", key = "knowledge_tacoma_bakery" } }),
        },
        {
            text = ccb.content.text("Nice to see you Dana, I'm just checking in."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Dana_2",
    line = ccb.content.text("Not bad.  Much better than before.  Pablo and I have privacy, and the folks here actually appreciate my bread instead of paying me a pittance for it and then taking it to the basement without so much as a 'thanks'."),
    replies = {
        {
            text = ccb.content.text("What's with the trailer?"),
            next_topic = "TALK_TACOMA_Dana_Trailer1",
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
