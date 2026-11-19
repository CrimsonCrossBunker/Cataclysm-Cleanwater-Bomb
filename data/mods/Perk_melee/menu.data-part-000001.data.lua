local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_MA_PERK_MENU_MAIN",
    line = ccb.content.text("Level <u_val:ma_current_level>.\n<u_val:num_ma_perks> perk points to spend.\nCurrent EXP: <u_val:ma_available_exp>.\nEXP to next level: <u_val:ma_exp_to_perk>."),
    replies = {
        { text = ccb.content.text("Tempo Techniques."), next_topic = "TALK_MA_PERK_MENU_TEMPO" },
        {
            text = ccb.content.text("Momentum Techniques."),
            next_topic = "TALK_MA_PERK_MENU_MOMENTUM",
        },
        { text = ccb.content.text("Insight Techniques."), next_topic = "TALK_MA_PERK_MENU_INSIGHT" },
        {
            text = ccb.content.text("Defensive Stance Techniques."),
            next_topic = "TALK_MA_PERK_MENU_POISE",
        },
        {
            text = ccb.content.text("Standalone Techniques."),
            next_topic = "TALK_MA_PERK_MENU_STANDALONE",
        },
        { text = ccb.content.text("Help."), next_topic = "TALK_MA_PERK_MENU_HELP" },
        { text = ccb.content.text("Quit."), next_topic = "TALK_DONE" },
    },
}
