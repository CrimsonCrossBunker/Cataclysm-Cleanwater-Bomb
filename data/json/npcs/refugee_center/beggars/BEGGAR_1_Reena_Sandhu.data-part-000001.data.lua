local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_reena_recruited" } }),
        yes = {
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
            yes = ccb.content.text("So, any luck with convincing the others to come on your crazy adventure yet?"),
            no = ccb.content.gendered_line("I'm sorry to say it after all you've done for me, but… I don't suppose you've got anything to eat?", { "speaker" }),
        },
        no = {
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
            yes = ccb.content.text("Thank you again.  I really appreciate the food."),
            no = {
                when = predicates.wears("speaker", "badge_marshal"),
                yes = ccb.content.text("Please, help me.  I need food.  Aren't you their sheriff?  Can't you help me?"),
                no = ccb.content.text("Please, help me.  I need food."),
            },
        },
    },
    replies = {
        {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_beggars_recruited" } }),
            text = ccb.content.text("I've talked to the others, and they're all willing to come.  So, you joining us?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_RECRUITED",
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_INTRO",
        },
        {
            text = ccb.content.text("Hey, here, I might have some food for you.  Let me check."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_GIVE_FOOD",
        },
        {
            text = ccb.content.text("Get away from me."),
            next_topic = "TALK_DONE",
            opinion = { trust = -1, value = -1, anger = 1 },
        },
        { text = ccb.content.text("…"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1_INTRO",
    line = {
        joined = {
            ccb.content.text("They won't let me in.  They say they're too full.  I'm allowed to camp out here as long as I keep it clean and don't make a fuss"),
            {
                when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
                yes = ccb.content.text(", but I'm reduced to begging to survive."),
                no = ccb.content.text(", but I'm so hungry."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Why don't you go somewhere else?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_LEAVE",
        },
        {
            text = ccb.content.text("Why don't you scavenge your own food?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_SCAVENGE",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_EXPERTISE",
        },
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("I might have some food for you.  Let me check."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_GIVE_FOOD",
        },
        {
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
            text = ccb.content.text("I've got some more food, if you want it."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_GIVE_FOOD",
        },
        {
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("I'm sorry, I can't help you."),
            next_topic = "TALK_DONE",
        },
    },
}
