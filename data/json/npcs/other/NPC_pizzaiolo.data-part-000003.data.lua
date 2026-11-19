local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_pizzaiolo_Background",
    line = ccb.content.gendered_line("I'm just a regular pizzaiolo.  My father was a pizzaiolo, my grandfather was a pizzaiolo and I also became a pizzaiolo.  I was making pizza my whole life, until some American <name_b>s ruined my business!  I couldn't do anything about this, but now, with <the_cataclysm> and <zombies> around, I have a chance to get my revenge!", { "interlocutor" }),
}
