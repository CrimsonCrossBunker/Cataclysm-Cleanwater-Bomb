local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_radio_tower_reverberation_mp3_1",
    line = ccb.content.text("&Your comm is filled with static again and your HUD glitches.  Something, or someone, whispers an indiscernible word through the earpiece.  It then falls silent."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_mine_spiral_finale_s",
    line = ccb.content.text("Your comm is filled with static for a long moment before the faint sound of Pat's voice interrupts: \"I dunno what the fahk you're into down theah, but I'm recordin'.  Keep goin'!\""),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
