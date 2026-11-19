local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_DEFENSE_MODE_MAIN_MENU",
    line = ccb.content.text("Hello, and welcome to Defense Mode!  Please alter the options as you desire, then we'll get started!"),
    replies = {
        {
            text = ccb.content.text("Enemy Options"),
            next_topic = "TALK_DEFENSE_MODE_ENEMY_SELECTION",
        },
        {
            text = ccb.content.text("Preset Game Options"),
            next_topic = "TALK_DEFENSE_MODE_PRESET_GAME_MENU",
        },
        {
            text = ccb.content.text("Advanced Game Options"),
            next_topic = "TALK_DEFENSE_MODE_ADVANCED_GAME_OPTIONS",
        },
        {
            text = ccb.content.text("Difficulty Options"),
            next_topic = "TALK_DEFENSE_MODE_DIFFICULTY_SELECTION_MENU",
        },
    },
}
