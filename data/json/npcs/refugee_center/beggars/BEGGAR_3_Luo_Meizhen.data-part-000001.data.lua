local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3",
    line = {
        when = predicates.has_effect("interlocutor", "insulted_luo"),
        yes = ccb.content.gendered_line("Fuck off, dickwaddle.", { "speaker" }),
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_luo_recruited" } }),
            yes = ccb.content.text("Yo.  Anyone else keen on moving from this bus stop to your tent city?"),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_conversation_dont_insult_luo" } }),
                yes = {
                    when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_conversation_apology_luo" } }),
                    yes = {
                        when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
                        yes = ccb.content.text("Hey there.  Good to see you again."),
                        no = ccb.content.text("Careful, I'm getting hangry again and am not totally responsible for my own actions."),
                    },
                    no = ccb.content.gendered_line("Look, I'm sorry for freaking out earlier.  You might be an asshole but I'm sure you didn't mean it like that.  My blood sugar is hella low, I get a bit cranky.  We cool?", { "speaker" }),
                },
                no = {
                    when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
                    yes = ccb.content.gendered_line("Hey there, not-asshole.  Good to see you again.", { "speaker" }),
                    no = ccb.content.text("Don't bother with these assholes."),
                },
            },
        },
    },
    replies = {
        {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_beggars_recruited" } }),
            text = ccb.content.text("I've talked to the others, and they're all willing to come.  So, you joining us?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_RECRUITED2",
        },
        {
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")), predicates.negate(predicates.has_effect("interlocutor", "insulted_luo")) }),
            text = ccb.content.text("What's up?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_COMPLAIN",
        },
        {
            when = predicates.all({ predicates.has_effect("interlocutor", "beggar_has_eaten"), predicates.negate(predicates.has_effect("interlocutor", "insulted_luo")) }),
            text = ccb.content.text("What's up?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_INTRO",
        },
        {
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")), predicates.negate(predicates.has_effect("interlocutor", "insulted_luo")) }),
            text = ccb.content.text("I might have some food for you.  Are you hungry?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_GIVE_FOOD",
        },
        {
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_conversation_apology_luo" } })), predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_conversation_dont_insult_luo" } }), predicates.negate(predicates.has_effect("interlocutor", "insulted_luo")) }),
            text = ccb.content.text("We're cool.  Sorry for insulting you earlier."),
            actions = { actions.set_actor_value("interlocutor", "general_conversation_apology_luo", "yes") },
            next_topic = "TALK_REFUGEE_BEGGAR_3_APOLOGY",
        },
        {
            when = predicates.all({ predicates.has_item("speaker", "veggy_tainted"), predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_recruit_luo_attempt_recruit" } }), predicates.negate(predicates.has_effect("interlocutor", "insulted_luo")) }),
            text = ccb.content.text("I found a sample of alien fungus for you."),
            next_topic = "TALK_REFUGEE_BEGGAR_3_MYCUS4_RECRUIT",
        },
        {
            when = predicates.all({ predicates.has_item("speaker", "veggy_tainted"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_recruit_luo_attempt_recruit" } })), predicates.negate(predicates.has_effect("interlocutor", "insulted_luo")) }),
            text = ccb.content.text("I found a sample of alien fungus for you."),
            next_topic = "TALK_REFUGEE_BEGGAR_3_MYCUS4_NOTREADY",
            actions = { actions.set_actor_value("interlocutor", "general_recruit_luo_owed", "yes") },
        },
        { text = ccb.content.text("Ok… see ya."), next_topic = "TALK_DONE" },
    },
}
