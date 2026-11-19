local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_RIPPER_MAIN" },
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "player_has_met", "yes") },
            once = "ripper_intro_complete",
        },
    },
    line = ccb.content.text("&The ripper glances up at you as you approach, eyes briefly flicking over you before returning to the screen of their wrist computer.  They don't say anything, but it's clear they are waiting for you to make the first move."),
    replies = {
        {
            text = ccb.content.text("Lets trade."),
            next_topic = "TALK_SALVOR_RIPPER_MAIN",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("[Ancient Mercurial ID codes] I've found something you want.  Lets talk about real things."),
            next_topic = "TALK_SALVOR_MERCURIAL_IDENTS",
            when = predicates.has_item("speaker", "ruin_data_mercurial_id"),
        },
        {
            text = ccb.content.text("What is it that you do here?"),
            next_topic = "TALK_SALVOR_RIPPER_EXPLAIN",
        },
        { text = ccb.content.text("That's all for now."), next_topic = "TALK_DONE" },
    },
}
