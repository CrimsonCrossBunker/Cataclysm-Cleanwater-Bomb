local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_SPIDERS_WEB",
    line = ccb.content.text("I see a grove covered in webs.  And legs.  So many legs.  I'll mark the location on your map for one denarius.  Just don't bring any of them back here."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_SPIDER_WEB"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
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
    id = "TALK_FORGE_LORD_DIVINER_SPIDERS_PIT",
    line = ccb.content.text("There is a burrow not too far away that is absolutely crawling with spiders.  Probably.  I didn't get a close look.  And I don't intend to.  I'll mark the location on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_SPIDER_PIT"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
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
    id = "TALK_FORGE_LORD_DIVINER_SPIDERS_DEMON",
    line = ccb.content.text("Fascinating creatures, really.  They have evolved a way to channel their innate mana into potent fire spells.  Some demonic spider queens collect magical items as well.  Perhaps they have a way of absorbing the mana in them and use it for themselves?  I'll mark the lair of such a queen on your map for one denarius.  You might want to bring fire resistant clothing."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_SPIDER_DEMON"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
        },
        {
            text = ccb.content.text("I can't afford that right now."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GET_MONEY",
            when = predicates.negate(predicates.has_item("speaker", "denarius")),
        },
        {
            text = ccb.content.text("No thanks.  Giant fire-breathing spiders are no joke."),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Nevermind."),
            next_topic = "TALK_DONE",
        },
    },
}
