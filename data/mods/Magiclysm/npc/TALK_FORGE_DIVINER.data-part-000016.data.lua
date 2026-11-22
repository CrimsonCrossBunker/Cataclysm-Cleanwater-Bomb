local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_LOVECRAFTIAN",
    line = ccb.content.text("There are these city-sized creatures called Void Leviathans that live in the vast nether regions between realities.  Sometimes they used to wash up onto Earths that had recently had a Cataclysm.  Caused all kinds of trouble, they did, so Valzain made it so they would spawn underground instead.  I can mark the marooned corpse of one such creature on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_LOVECRAFTIAN"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
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
