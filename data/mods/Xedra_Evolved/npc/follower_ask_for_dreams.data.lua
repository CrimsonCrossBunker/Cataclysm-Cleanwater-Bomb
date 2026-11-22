local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND_FOLLOWER_CAST_SPELL" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("You could produce some dreamdross?"),
            next_topic = "TALK_PRODUCE_DREAMDROSS",
            when = predicates.handler("dlg_p_xedra_evolved_3a5567108775"),
            actions = { actions.handler("dlg_a_xedra_evolved_e9fbf4617322") },
        },
        {
            text = ccb.content.text("[Ask them to produce dreamdross]"),
            next_topic = "TALK_PRODUCE_DREAMDROSS",
            when = predicates.all({ predicates.any({ predicates.has_trait("interlocutor", "HOMULLUS_DREAMWALKER"), predicates.has_trait("interlocutor", "CHANGELING_NOBLE_DREAMWALKER") }), predicates.negate(predicates.has_effect("interlocutor", "effect_follower_summoned_dross")) }),
            actions = { actions.handler("dlg_a_xedra_evolved_e76c503af014") },
        },
        {
            text = ccb.content.text("[Ask them to produce dreamdross]"),
            next_topic = "TALK_CANNOT_PRODUCE_DREAMDROSS_MANA",
            when = predicates.handler("dlg_p_xedra_evolved_b585fe569540"),
        },
        {
            text = ccb.content.text("[Ask them to produce dreamdross]"),
            next_topic = "TALK_CANNOT_PRODUCE_DREAMDROSS_TIME",
            when = predicates.all({ predicates.any({ predicates.has_trait("interlocutor", "HOMULLUS_DREAMWALKER"), predicates.has_trait("interlocutor", "CHANGELING_NOBLE_DREAMWALKER") }), predicates.has_effect("interlocutor", "effect_follower_summoned_dross") }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRODUCE_DREAMDROSS",
    line = ccb.content.text("*<npc_name> cups <mypronoun> hands and closes <mypronoun> eyes, and over a few seconds, several fragments of shining metal slowly appear in a soft shimmering light.  <mypronoun> hands them to you."),
    replies = {
        {
            text = ccb.content.text("[Ask them to produce more dreamdross]"),
            next_topic = "TALK_PRODUCE_DREAMDROSS",
            when = predicates.handler("dlg_p_xedra_evolved_3a5567108775"),
            actions = { actions.handler("dlg_a_xedra_evolved_df03cb825851") },
        },
        {
            text = ccb.content.text("[Ask them to produce more dreamdross]"),
            next_topic = "TALK_CANNOT_PRODUCE_DREAMDROSS_MANA",
            when = predicates.handler("dlg_p_xedra_evolved_8f5a48321ea0"),
        },
        {
            text = ccb.content.text("Thanks.  Can we talk about something else?"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Thanks.  See you later."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CANNOT_PRODUCE_DREAMDROSS_MANA",
    line = ccb.content.text("I can't do that right now.  I need time to recover my mana."),
    replies = {
        {
            text = ccb.content.text("Got it.  Can we talk about something else?"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("Got it.  See you later."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CANNOT_PRODUCE_DREAMDROSS_TIME",
    line = ccb.content.text("I can't do that right now.  I need time to gather more dreamdross."),
    replies = {
        {
            text = ccb.content.text("Got it.  Can we talk about something else?"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("Got it.  See you later."), next_topic = "TALK_DONE" },
    },
}
