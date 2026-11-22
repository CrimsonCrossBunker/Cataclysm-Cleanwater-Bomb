local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Can you teach me about those glowing boxes?"),
            next_topic = "TALK_TEACH_PARACLESIAN_COMPUTERS_SURE",
            when = predicates.handler("dlg_p_xedra_evolved_e41f1ff7873a"),
            actions = { actions.handler("dlg_a_xedra_evolved_a0f8c07ea720") },
        },
        {
            text = ccb.content.text("Can you teach me about those glowing boxes?"),
            next_topic = "TALK_TEACH_PARACLESIAN_COMPUTERS_NO",
            when = predicates.handler("dlg_p_xedra_evolved_1b42dfc646dd"),
        },
        {
            text = ccb.content.text("Can you teach me how to use your thinking machines?"),
            next_topic = "TALK_TEACH_PARACLESIAN_HOMULLUS_COMPUTERS_SURE",
            when = predicates.handler("dlg_p_xedra_evolved_03bb319fd371"),
            actions = { actions.handler("dlg_a_xedra_evolved_a0f8c07ea720") },
        },
        {
            text = ccb.content.text("Can you teach me how to use your thinking machines?"),
            next_topic = "TALK_TEACH_PARACLESIAN_HOMULLUS_COMPUTERS_NO",
            when = predicates.handler("dlg_p_xedra_evolved_5d87aaebc246"),
        },
        {
            text = ccb.content.text("What are these devices filled with lightning?  Can you teach me about them?"),
            next_topic = "TALK_TEACH_PARACLESIAN_ELECTRONICS_SURE",
            when = predicates.handler("dlg_p_xedra_evolved_8d2fba5ec62c"),
            actions = { actions.handler("dlg_a_xedra_evolved_c9aa1c3c2fda") },
        },
        {
            text = ccb.content.text("What are these devices filled with lightning?  Can you teach me about them?"),
            next_topic = "TALK_TEACH_PARACLESIAN_ELECTRONICS_NO",
            when = predicates.handler("dlg_p_xedra_evolved_9496abe6d689"),
        },
        {
            text = ccb.content.text("I can feel the lightning in these mortal artifacts.  Can you tell me how to harness it?"),
            next_topic = "TALK_TEACH_PARACLESIAN_ELECTRONICS_SURE",
            when = predicates.handler("dlg_p_xedra_evolved_9ce0d1312c56"),
            actions = { actions.handler("dlg_a_xedra_evolved_c9aa1c3c2fda") },
        },
        {
            text = ccb.content.text("I can feel the lightning in these mortal artifacts.  Can you tell me how to harness it?"),
            next_topic = "TALK_TEACH_PARACLESIAN_SYLPH_ELECTRONICS_NO",
            when = predicates.handler("dlg_p_xedra_evolved_24000ffc3f7f"),
        },
        {
            text = ccb.content.text("Can you teach me to use these galvanic mechanisms?"),
            next_topic = "TALK_TEACH_PARACLESIAN_HOMULLUS_ELECTRONICS_SURE",
            when = predicates.handler("dlg_p_xedra_evolved_34d8ebf4a392"),
            actions = { actions.handler("dlg_a_xedra_evolved_c9aa1c3c2fda") },
        },
        {
            text = ccb.content.text("Can you teach me to use these galvanic mechanisms?"),
            next_topic = "TALK_TEACH_PARACLESIAN_HOMULLUS_ELECTRONICS_NO",
            when = predicates.handler("dlg_p_xedra_evolved_d090792edc84"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEACH_PARACLESIAN_COMPUTERS_SURE",
    line = {
        choices = {
            ccb.content.text("Box-  You mean, phones?  Computers?  Oh, sure.  Just let me know when."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Thank you."),
            next_topic = "TALK_FRIEND",
            actions = {
                actions.set_actor_value("interlocutor", "asked_faction_npc_about_paraclesian_computer_teaching_high", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEACH_PARACLESIAN_COMPUTERS_NO",
    line = {
        choices = {
            ccb.content.text("Box-  You mean, phones?  Computers?  I'm sorry, I don't really know much about that stuff."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Alas."),
            next_topic = "TALK_FRIEND",
            actions = {
                actions.set_actor_value("interlocutor", "asked_faction_npc_about_paraclesian_computer_teaching_low", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEACH_PARACLESIAN_HOMULLUS_COMPUTERS_SURE",
    line = {
        choices = { ccb.content.text("\"Thinking machines\"? You mean computers?  Oh, sure, if you want.") },
    },
    replies = {
        {
            text = ccb.content.text("Thank you."),
            next_topic = "TALK_FRIEND",
            actions = {
                actions.set_actor_value("interlocutor", "asked_faction_npc_about_paraclesian_computer_teaching_high", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEACH_PARACLESIAN_HOMULLUS_COMPUTERS_NO",
    line = {
        choices = {
            ccb.content.text("\"Thinking machines\"? You mean computers?  I'm sorry, I don't really know much about that stuff."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Very well."),
            next_topic = "TALK_FRIEND",
            actions = {
                actions.set_actor_value("interlocutor", "asked_faction_npc_about_paraclesian_computer_teaching_low", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEACH_PARACLESIAN_ELECTRONICS_SURE",
    line = {
        choices = {
            ccb.content.text("Filled with lightning?  You mean tasers?  No, you-  Oh, oh, I see, you want to know about electricity.  Yeah, I can teach you.  Just let me know when."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Thank you."),
            next_topic = "TALK_FRIEND",
            actions = {
                actions.set_actor_value("interlocutor", "asked_faction_npc_about_paraclesian_electronics_teaching_high", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEACH_PARACLESIAN_ELECTRONICS_NO",
    line = {
        choices = {
            ccb.content.text("Filled with lightning?  You mean like, circuits and stuff?  I'm sorry, I don't really know enough to explain it all to you."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Alas."),
            next_topic = "TALK_FRIEND",
            actions = {
                actions.set_actor_value("interlocutor", "asked_faction_npc_about_paraclesian_electronics_teaching_low", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEACH_PARACLESIAN_SYLPH_ELECTRONICS_SURE",
    line = {
        choices = {
            ccb.content.text("The lightning?  You mean electricity?  Yeah, I can teach you.  Just let me know when."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Thank you."),
            next_topic = "TALK_FRIEND",
            actions = {
                actions.set_actor_value("interlocutor", "asked_faction_npc_about_paraclesian_electronics_teaching_high", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEACH_PARACLESIAN_SYLPH_ELECTRONICS_NO",
    line = {
        choices = {
            ccb.content.text("Lightning?  Like, a taser or something?  Or do you mean batteries?  I'm sorry, I don't really know enough to explain it all to you."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Alas."),
            next_topic = "TALK_FRIEND",
            actions = {
                actions.set_actor_value("interlocutor", "asked_faction_npc_about_paraclesian_electronics_teaching_low", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEACH_PARACLESIAN_HOMULLUS_ELECTRONICS_SURE",
    line = {
        choices = {
            ccb.content.text("Gal-what?  Wait, you mean electronics?  Yeah, I can teach you.  Just let me know when."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Thank you."),
            next_topic = "TALK_FRIEND",
            actions = {
                actions.set_actor_value("interlocutor", "asked_faction_npc_about_paraclesian_electronics_teaching_high", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEACH_PARACLESIAN_HOMULLUS_ELECTRONICS_NO",
    line = {
        choices = { ccb.content.text("Gal-what?  I'm sorry, I don't know what you're talking about.") },
    },
    replies = {
        {
            text = ccb.content.text("Ah.  Oh well."),
            next_topic = "TALK_FRIEND",
            actions = {
                actions.set_actor_value("interlocutor", "asked_faction_npc_about_paraclesian_electronics_teaching_low", "yes"),
            },
        },
    },
}
