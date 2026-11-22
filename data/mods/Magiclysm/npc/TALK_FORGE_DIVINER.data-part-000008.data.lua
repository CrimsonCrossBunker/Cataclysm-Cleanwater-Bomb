local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_FUNGAL_BLOOM",
    line = ccb.content.text("I can almost smell them through the crystal ball.  Disturbing.  I'll mark the location on your map for one denarius.  Good luck.  You might need it."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_FUNGAL_BLOOM"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
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
    id = "TALK_FORGE_LORD_DIVINER_FUNGAL_TOWER",
    line = ccb.content.text("Scrying on these things makes me uneasy, but I'll mark the location on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_FUNGAL_TOWER"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
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
    id = "TALK_FORGE_LORD_DIVINER_FUNGAL_FLOWERS",
    line = ccb.content.text("I can't even number the times I've scraped this mess off of the forge.  It's like walking into a spider web at an hundred miles an hour, and the web also smells terribly and tries to eat you.  At least the magical torches the forgemaster has installed help a bit.  See, the Mycus fears fire, and for good reasons.  Anyways, I'll mark the location on your map for one denarius.  Don't eat the fruit."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_FUNGAL_FLOWERS"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
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
