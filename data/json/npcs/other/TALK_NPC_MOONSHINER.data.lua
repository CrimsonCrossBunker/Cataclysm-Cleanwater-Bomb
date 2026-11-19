local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_MOONSHINER_STORY",
    line = ccb.content.gendered_line("I run this distillery you're standing in, before <the_cataclysm> it wasn't so legal with the law.  I was in <city> making a deal on my product when a horde of rioters busted in, so I ran for it.  I thought my business would be a nice place to stay, so I came out here.", { "interlocutor" }),
    replies = { { text = ccb.content.text("Huh."), next_topic = "TALK_NONE" } },
}
