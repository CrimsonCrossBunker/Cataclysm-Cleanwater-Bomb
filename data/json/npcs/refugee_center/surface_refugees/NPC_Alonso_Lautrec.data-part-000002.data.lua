local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_2",
    line = {
        when = predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } }),
        yes = ccb.content.text("Well, it's a lot better now that you're here.  Nice to see a familiar face."),
        no = ccb.content.text("Now that you are here, everything.  Is there anything Alonso can… *do for you*?"),
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_Forward",
    line = {
        when = predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } }),
        yes = ccb.content.text("You know me, I gotta be me, right?"),
        no = ccb.content.text("Alonso cannot help himself, in the face of someone so fine as you."),
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_CalledOut1",
    line = {
        joined = {
            {
                when = predicates.actor_state("speaker", "male"),
                yes = ccb.content.text("Aw man"),
                no = ccb.content.text("Aw come on"),
            },
            ccb.content.text(", why you gotta be like that?  I'm just tryin' to get an air of mystery okay?  Nobody wants to be with a slutty guy from Brooklyn, but Alonso the mysterious is another story."),
        },
    },
    replies = {
        {
            text = ccb.content.text("And how is that working out for you?"),
            next_topic = "TALK_REFUGEE_Alonso_CalledOut2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
