local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_ANT",
    line = ccb.content.text("I see a giant ant cutting down a tree with her mandibles.  Did you know that worker ants are all female?  I see her friends around her as well.  I'll mark the location on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_ANTS"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
        },
        {
            text = ccb.content.text("I can't afford that right now."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GET_MONEY",
            when = predicates.negate(predicates.has_item("speaker", "denarius")),
        },
        {
            text = ccb.content.text("About something else…"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Nevermind."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_ACID_ANT",
    line = ccb.content.text("I see a giant ant lobbing globs of acids at a group of unfortunate dogs.  It seems to be quite effective.  I'll mark the location on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_ACID_ANTS"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
        },
        {
            text = ccb.content.text("I can't afford that right now."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GET_MONEY",
            when = predicates.negate(predicates.has_item("speaker", "denarius")),
        },
        {
            text = ccb.content.text("About something else…"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Nevermind."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_DERMATIK",
    line = ccb.content.text("Why would you ever want to get close to those creatures?  Don't you know they lay eggs inside of other creatures!?  Including humans!  Well, if you're sure you want to go there, I'll mark the location on your map for one denarius.  But don't come crying to me if you get poked full of dermatik larvae.  Seriously, don't.  I would like to keep my lunch.  If they do give you problems though, you might find that drinking mugwort oil helps.  It's made with, uh, mugwort.  And oil.  I think."),
    replies = {
        {
            text = ccb.content.text("Sure, why not."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_DERMATIK"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
        },
        {
            text = ccb.content.text("I can't afford that right now."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GET_MONEY",
            when = predicates.negate(predicates.has_item("speaker", "denarius")),
        },
        {
            text = ccb.content.text("On second <freaking> thought…"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Nope!  Fuck this.  I'm out."),
            next_topic = "TALK_DONE",
        },
    },
}
