local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CAMPER_SURVIVOR_STORY",
    line = ccb.content.gendered_line("I was out here camping when <the_cataclysm> disturbed me.  I didn't know anything was wrong until two <zombies> stumbled up here, and tried to kill me.  I figured staying here would be my best bet, away from the cities.", { "interlocutor" }),
    replies = { { text = ccb.content.text("Wow."), next_topic = "TALK_NONE" } },
}
