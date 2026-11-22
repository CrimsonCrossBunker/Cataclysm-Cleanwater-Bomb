local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_DEFENSE_MODE_MAIN_MENU", "TALK_DEFENSE_MODE_ENEMY_SELECTION", "TALK_DEFENSE_MODE_ADVANCED_GAME_OPTIONS", "TALK_DEFENSE_MODE_DIFFICULTY_SELECTION_MENU", "TALK_DEFENSE_MODE_CUSTOM_DIFFICULTY_MENU" },
    replies = {
        {
            text = ccb.content.text("Play!"),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_defense_mode_dae3c9a0a9a2"),
            actions = { actions.handler("w16b_a_defense_mode_296a9ff5a306") },
        },
    },
}
