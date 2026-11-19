local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4",
    line = {
        when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
        yes = ccb.content.gendered_line("Thanks again for the grub, my friend.", { "speaker" }),
        no = ccb.content.text("Hey, are you a big fan of survival of the fittest?"),
    },
    replies = {
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("Why do you ask?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_TALK1",
        },
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("Sorry, not interested."),
            next_topic = "TALK_DONE",
        },
        {
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
            text = ccb.content.text("Nice to see you too, what's up?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_TALK1",
        },
        {
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
            text = ccb.content.text("Nice to see you.  I gotta be going though."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_TALK1",
    line = {
        when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
        yes = ccb.content.text("Oh you know, the usual: sittin' out here until I starve to death, playin' cards with Dave, that kinda thing."),
        no = ccb.content.text("Because I sure ain't fit, so I'm sittin' out here until I starve to death.  Help a poor sickly soul out?"),
    },
    replies = {
        {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_beggars_recruited" } }),
            text = ccb.content.text("I've talked to the others, and they're all willing to come.  So, you joining us?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_RECRUITED",
        },
        {
            text = ccb.content.text("I could maybe help you out… want something to eat?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_GIVE_FOOD",
        },
        {
            text = ccb.content.text("What's wrong with you?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_TALK2",
        },
        {
            text = ccb.content.text("They won't let you in because you're sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_SICKLY",
        },
        {
            text = ccb.content.text("How did you even get here if you're so sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_ARRIVAL",
        },
        {
            text = ccb.content.text("Why are you camped out here if they won't let you in?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_CAMPOUT",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_GIVE_FOOD",
    line = {
        when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
        yes = ccb.content.text("That's awful kind of you, you really are a wonderful person."),
        no = ccb.content.gendered_line("Oh, wow!  You're a real gem, you know that?  Thanks for even thinking of it.", { "speaker" }),
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I'm sorry, I was wrong.  I can't help you."),
            next_topic = "TALK_DONE",
        },
    },
    repeat_replies = {
        {
            categories = { "food" },
            reply = {
                text = ccb.content.text("Here, you can have this <topic_item>."),
                next_topic = "TALK_REFUGEE_BEGGAR_4_GAVE_FOOD",
            },
        },
    },
}
