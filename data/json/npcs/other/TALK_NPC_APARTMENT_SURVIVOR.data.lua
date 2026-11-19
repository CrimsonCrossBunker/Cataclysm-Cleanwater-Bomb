local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_APARTMENT_SURVIVOR_STORY",
    line = ccb.content.gendered_line("I used to live here before <the_cataclysm>.  I was asleep when a horde of <zombies> busted through the front, and in the chaos I wound up here.  When the screaming stopped, I peaked out the door to find my neighbor stumbling about with his face half-eaten, and I haven't left since.", { "interlocutor" }),
    replies = { { text = ccb.content.text("Wow."), next_topic = "TALK_NONE" } },
}
