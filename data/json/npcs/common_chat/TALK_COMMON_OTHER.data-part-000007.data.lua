local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_TRAIN_NPC_START",
    line = ccb.content.text("Alright, show me how it's done."),
    replies = {
        {
            text = ccb.content.text("Okay, let's begin."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_9860d3f75191"),
            actions = { "start_training_npc" },
            switch = true,
        },
        {
            text = ccb.content.text("Okay.  Lead the way."),
            next_topic = "TALK_DONE",
            actions = { "lead_to_safety" },
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("No, we'll be okay here."),
            next_topic = "TALK_TRAIN_NPC_FORCE",
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TRAIN_SEMINAR_START",
    line = ccb.content.text("Alright, who should participate?"),
    replies = {
        {
            text = ccb.content.text("Let's see…"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_9860d3f75191"),
            actions = { "start_training_seminar" },
            switch = true,
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TRAIN_START",
    line = ccb.content.text("Alright, let's begin."),
    replies = {
        {
            text = ccb.content.text("Sounds good."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_9860d3f75191"),
            actions = { "start_training" },
            switch = true,
        },
        {
            text = ccb.content.text("Okay.  Lead the way."),
            next_topic = "TALK_DONE",
            actions = { "lead_to_safety" },
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("No, we'll be okay here."),
            next_topic = "TALK_TRAIN_FORCE",
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DENY_TRAIN",
    line = { when = predicates.handler("dlg_p_dda_8baf563d07a6"), yes = ccb.content.text("I can't train you properly while you're operating a vehicle!"), no = { when = predicates.handler("dlg_p_dda_11f4fe0cf4dc"), yes = ccb.content.text("I can't train you properly while I'm operating a vehicle!"), no = {
                when = predicates.handler("dlg_p_dda_7d19faa96245"),
                yes = ccb.content.text("I'm too thirsty, give me something to drink."),
                no = {
                    when = predicates.handler("dlg_p_dda_43c2f4328d3c"),
                    yes = ccb.content.text("I'm too hungry, give me something to eat."),
                    no = {
                        when = predicates.handler("dlg_p_dda_ea60ec832f23"),
                        yes = ccb.content.gendered_line("I'm too tired, let me rest first.", { "interlocutor" }),
                        no = {
                            when = predicates.has_effect("interlocutor", "asked_to_train"),
                            yes = ccb.content.text("Give it some time, I'll show you something new later…"),
                            no = ccb.content.text("I have some reason for denying you training."),
                        },
                    },
                },
            } } },
    replies = {
        {
            text = ccb.content.text("Ah, okay."),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DENY_TRAIN_SEMINAR",
    line = { when = predicates.handler("dlg_p_dda_8baf563d07a6"), yes = ccb.content.text("We'll talk about a training seminar after you're done operating that vehicle."), no = { when = predicates.handler("dlg_p_dda_11f4fe0cf4dc"), yes = ccb.content.text("I can't host a seminar while I'm operating a vehicle!"), no = {
                when = predicates.handler("dlg_p_dda_7d19faa96245"),
                yes = ccb.content.text("I'm too thirsty, give me something to drink."),
                no = {
                    when = predicates.handler("dlg_p_dda_43c2f4328d3c"),
                    yes = ccb.content.text("I'm too hungry, give me something to eat."),
                    no = {
                        when = predicates.handler("dlg_p_dda_ea60ec832f23"),
                        yes = ccb.content.gendered_line("I'm too tired, let me rest first.", { "interlocutor" }),
                        no = {
                            when = predicates.has_effect("interlocutor", "asked_to_train"),
                            yes = ccb.content.text("Give it some time, we'll talk about a training seminar later…"),
                            no = ccb.content.text("I have some reason to refuse hosting a training seminar."),
                        },
                    },
                },
            } } },
    replies = {
        {
            text = ccb.content.text("Ah, okay."),
            next_topic = "TALK_NONE",
        },
    },
}
