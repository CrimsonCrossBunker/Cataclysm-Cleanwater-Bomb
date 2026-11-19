local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_PROFESSOR_1_STORY1",
    line = ccb.content.text("I'm actually a science teacher.  I'd been doing research for the last six months.  I can't imagine things would have been good where I was teaching… I'm not sure anyone made it out.  I was out camping by a lake, ostensibly working on the finishing touches for a paper, but mostly just sipping whisky.  Those were good days.  Then came <the_cataclysm>, the explosions, the <zombies>.  My campsite was crushed by a fearsome beast, just collateral damage from a huge fight between a bunch of different things that didn't seem to get along well.  I was already busy running frantically by then."),
    replies = {
        {
            text = ccb.content.text("Do you think there's some way your knowledge could help us understand all this?"),
            next_topic = "BGSS_PROFESSOR_1_SCIENCEHELP",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PROFESSOR_1_SCIENCEHELP",
    line = ccb.content.text("Hard to say.  I'm not really an organic chemist, I did geological chemistry.  I'm at a loss to how that relates, but if you come across something where my knowledge would help I'll gladly offer it."),
    replies = {
        {
            text = ccb.content.text("Cool.  What did you say before that?"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
