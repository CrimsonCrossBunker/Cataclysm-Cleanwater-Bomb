local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_pizzaiolo_celebrate",
    line = ccb.content.gendered_line("Ah, home sweet home.  It feels like I haven't been here for ages.  Fuck, it looks so horrible now.  I guess it's because of <the_cataclysm>.  Thank you for bringing me here, <name_g>.  Let's eat the cake.", { "interlocutor" }),
    replies = { { text = ccb.content.text("[*NOM-NOM*]"), next_topic = "TALK_pizzaiolo_celebrate1" } },
}
