local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

-- Appears in the refugee center as a guard with custom dialogue.
ccb.content.define_npc {
    id = "evac_guard3",
    suffix = ccb.content.text("Guard"),
    class = "NC_FREE_MERCH_GUARD",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_EVAC_GUARD3",
    faction = "free_merchants",
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3",
    line = ccb.content.text("Keep to yourself and you won't find any problems."),
    replies = {
        {
            text = ccb.content.text("What do you do around here?"),
            next_topic = "TALK_EVAC_GUARD3_NEW",
        },
        {
            text = ccb.content.text("Got tips for avoiding trouble?"),
            next_topic = "TALK_EVAC_GUARD3_RULES",
        },
        {
            text = ccb.content.text("Have you seen anyone who might be hiding something?"),
            next_topic = "TALK_EVAC_GUARD3_HIDE1",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_NEW",
    line = ccb.content.gendered_line("I haven't been here for long but I do my best to watch who comes and goes.  You can't always predict who will bring trouble.", { "interlocutor" }),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_EVAC_GUARD3" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_RULES",
    line = ccb.content.text("Keep your head down and stay out of my way."),
    replies = { { text = ccb.content.text("OK…"), next_topic = "TALK_EVAC_GUARD3" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_HIDE1",
    line = ccb.content.text("Like what?"),
    replies = {
        { text = ccb.content.text("I'm not sure…"), next_topic = "TALK_EVAC_GUARD3_WASTE" },
        {
            text = ccb.content.text("Like they could be working for someone else?"),
            next_topic = "TALK_EVAC_GUARD3_HIDE2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_HIDE2",
    line = ccb.content.gendered_line("You're new here, who the hell put you up to this crap?", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Get bent, traitor!"),
            trial = { kind = "intimidate", difficulty = 20, modifiers = { { score = "FEAR", scale = 3 } } },
            success = { next_topic = "TALK_EVAC_GUARD3_HOSTILE", actions = { actions.handler("dlg_a_dda_3e3cfcb1ca64") } },
            failure = { next_topic = "TALK_EVAC_GUARD3_INSULT" },
        },
        {
            text = ccb.content.text("Got something to hide?"),
            trial = { kind = "persuade", difficulty = 10, modifiers = { { score = "TRUST", scale = 3 } } },
            success = { next_topic = "TALK_EVAC_GUARD3_DEAD", actions = { actions.handler("dlg_a_dda_08eb32f903c4") } },
            failure = { next_topic = "TALK_EVAC_GUARD3_INSULT" },
        },
        {
            text = ccb.content.text("Sorry, I didn't mean to offend you…"),
            next_topic = "TALK_EVAC_GUARD3_WASTE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_WASTE",
    line = ccb.content.text("If you don't get on with your business I'm going to have to ask you to leave and not come back."),
    replies = { { text = ccb.content.text("Sorry."), next_topic = "TALK_EVAC_GUARD3" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_DEAD",
    line = ccb.content.text("That's it, you're dead!"),
    replies = {
        { text = ccb.content.text("I didn't mean it!"), next_topic = "TALK_DONE" },
        { text = ccb.content.text("…"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_HOSTILE",
    line = ccb.content.text("You must really have a death wish!"),
    replies = {
        { text = ccb.content.text("I didn't mean it!"), next_topic = "TALK_DONE" },
        { text = ccb.content.text("…"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_INSULT",
    line = ccb.content.text("We don't put-up with garbage like you, finish your business and get the hell out."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
