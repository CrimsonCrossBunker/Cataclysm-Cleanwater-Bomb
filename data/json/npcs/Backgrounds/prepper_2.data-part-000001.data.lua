local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_2_MAPS",
    line = ccb.content.text("Yeah, I do.  I'd be willing to part with them for, say, $1000.  Straight from your ATM account, no cash cards."),
    replies = {
        {
            text = ccb.content.text("[$1000] You have a deal."),
            next_topic = "BGSS_PREPPER_2_SOLD",
            when = predicates.handler("dlg_p_dda_e48f5767fe4f"),
            actions = { actions.handler("dlg_a_dda_59e0479701fb") },
        },
        {
            text = ccb.content.text("Whatever's in that map benefits both of us."),
            when = predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDNO")),
            trial = { kind = "persuade", difficulty = 40, modifiers = { { score = "VALUE", scale = 3 }, { score = "TRUST", scale = 1 } } },
            success = { next_topic = "BGSS_PREPPER_2_SOLD" },
            failure = { next_topic = "BGSS_PREPPER_2_NOSALE" },
        },
        {
            text = ccb.content.text("How 'bout you fucking hand it over and I don't get pissed off?"),
            when = predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDNO")),
            trial = { kind = "intimidate", difficulty = 30, modifiers = { { score = "BRAVERY", scale = -1 }, { score = "FEAR", scale = 3 } } },
            success = { next_topic = "BGSS_PREPPER_2_SOLD" },
            failure = { next_topic = "BGSS_PREPPER_2_NOSALE" },
        },
        {
            text = ccb.content.text("Sorry for changing the subject.  What was it you were saying?"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("<end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_2_SOLD",
    line = ccb.content.text("All right.  Here they are."),
    replies = {
        {
            text = ccb.content.text("Thanks!  <done_conversation_section>"),
            next_topic = "TALK_NONE",
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }), actions.handler("dlg_a_dda_5f087cab1ae3") },
        },
        {
            text = ccb.content.text("Thanks!  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }), actions.handler("dlg_a_dda_5f087cab1ae3") },
        },
        {
            text = ccb.content.text("Thanks!  <end_talking>"),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }), actions.handler("dlg_a_dda_5f087cab1ae3") },
        },
    },
}
