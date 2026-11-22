local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP",
    line = ccb.content.text("What about the camp?"),
    replies = {
        {
            text = ccb.content.text("I want to assign you to work at this camp."),
            next_topic = "TALK_FRIEND_GUARD",
            when = predicates.handler("dlg_p_dda_c5904e1a60f2"),
            actions = { "assign_camp" },
        },
        {
            text = ccb.content.text("I want you to build a camp here."),
            next_topic = "TALK_HALLU_CAMP",
            when = predicates.has_trait("interlocutor", "HALLUCINATION"),
            switch = true,
        },
        {
            text = ccb.content.text("I want you to build a camp here."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_0a469b3f65f6"),
            actions = { "start_camp" },
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("Since we can't build a camp here, I want you to tell me where can we build a camp?"),
            next_topic = "TALK_CAMP_SITES",
            when = predicates.handler("dlg_p_dda_717555b46202"),
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("We need to abandon this camp."),
            next_topic = "TALK_ABANDON",
            when = predicates.handler("dlg_p_dda_c5904e1a60f2"),
        },
        {
            text = ccb.content.text("Show me what needs to be done at the camp."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c5904e1a60f2"),
            actions = { "basecamp_mission" },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ABANDON",
    line = ccb.content.gendered_line("Are you sure?", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Yes, I'm sure."),
            next_topic = "TALK_DONE",
            actions = { "abandon_camp" },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ALLY_DEBUG" },
    line = { when = predicates.conversation_state("radio"), yes = ccb.content.text(" *tshk* Not sure it works when I am that far."), no = ccb.content.text("Yes?") },
    replies = {
        {
            text = ccb.content.text("Trust me (+10 trust)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { trust = 10 } },
        },
        {
            text = ccb.content.text("Do not trust me (-10 trust)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { trust = -10 } },
        },
        {
            text = ccb.content.text("Fear me (+10 fear)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { fear = 10 } },
        },
        {
            text = ccb.content.text("Do not fear me (-10 fear)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { fear = -10 } },
        },
        {
            text = ccb.content.text("Fear me (+10 fear)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { fear = 10 } },
        },
        {
            text = ccb.content.text("Do not fear me (-10 fear)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { fear = -10 } },
        },
        {
            text = ccb.content.text("Value me (+10 value)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { value = 10 } },
        },
        {
            text = ccb.content.text("Do not value me (-10 value)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { value = -10 } },
        },
        {
            text = ccb.content.text("Be angry (+10 anger)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { anger = 10 } },
        },
        {
            text = ccb.content.text("Do not be angry (-10 anger)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { anger = -10 } },
        },
        {
            text = ccb.content.text("Owe me (+10 owed)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { owed = 10 } },
        },
        {
            text = ccb.content.text("Do not owe me (-10 owed)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { owed = -10 } },
        },
        {
            text = ccb.content.text("Favor me (+10 favors)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = {  } },
        },
        {
            text = ccb.content.text("Do not favor me (-10 favors)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = {  } },
        },
        {
            text = ccb.content.text("Train me."),
            next_topic = "TALK_TRAIN",
        },
        {
            text = ccb.content.text("Do a seminar."),
            next_topic = "TALK_TRAIN_SEMINAR",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
    },
}
