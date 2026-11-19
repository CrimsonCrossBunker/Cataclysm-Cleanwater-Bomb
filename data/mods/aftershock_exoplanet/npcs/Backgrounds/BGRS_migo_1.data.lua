local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGRS_MIGO_1_STORY1",
    line = ccb.content.text("Antes do Cataclisma eu era o cientista que encabeçava um laboratório militar no meu país.  Foram dias difíceis…"),
    replies = {
        { text = ccb.content.text("Where are you from?"), next_topic = "BGRS_MIGO_1_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGRS_MIGO_1_STORY2",
    line = ccb.content.text("Nós estávamos pesquisando um remédio que curasse um virus altamente letal na época, mas os resultados dos testes mostravam que o remédio era mais letal do que o próprio virus.  Então, ao invés de recolherem os remédios das prateleiras, eles nos forçaram a vendê-lo como sendo a cura para o vírus."),
    replies = {
        { text = ccb.content.text("Ummm?"), next_topic = "BGRS_MIGO_1_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGRS_MIGO_1_STORY3",
    line = ccb.content.text("Bem… aqueles sem cérebro seguiram cegamente o líder.  Quanto àqueles com algum cérebro… bom, acho que você está conversando com um deles agora"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
