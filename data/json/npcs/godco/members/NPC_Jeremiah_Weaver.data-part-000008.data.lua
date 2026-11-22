local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_Kostas_Convinced",
    line = ccb.content.text("That's great!  Thanks <name_g>, here's the money."),
    replies = {
        {
            text = ccb.content.text("You're welcome."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_5e691b19a919"), actions.clear_actor_value("speaker", "general_mission_kostas_teach_jeremiah"), actions.set_actor_value("interlocutor", "general_mission_jeremiah_apprentice", "yes") },
        },
    },
}
