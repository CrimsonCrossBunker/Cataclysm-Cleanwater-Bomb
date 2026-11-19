local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

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
