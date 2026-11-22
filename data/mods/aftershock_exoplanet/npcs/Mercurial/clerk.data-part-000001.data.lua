local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_AUGUSTMOON_GENETECH_TRADER", "TALK_AUGUSTMOON_GENETECH_WORKS" },
    line = ccb.content.text("&The Mercurial store is attended by a massive clerk, sleek scales adorn their massive forearms and slightly pointed ears.  They greet you with a voice that is both deep and melodious, \"Welcome to Mercurial Genetech, where we can help you unlock your potential.\""),
    replies = {
        {
            text = ccb.content.text("I'm looking into augments."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_any_trait("speaker", { "ESPER_ADVANCEMENT_OKAY", "ESPER_STARTER_ADVANCEMENT_OKAY" })),
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("I'm looking into augments.  I know the risks."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_aftershock_exoplanet_718eecbe9628"),
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("I'm looking into augments."),
            next_topic = "TALK_AUGUSTMOON_GENETECH_ESPER_WARNING",
            when = predicates.handler("dlg_p_aftershock_exoplanet_1cc1c1d49db6"),
        },
        {
            text = ccb.content.text("How does this Genetech stuff works?"),
            next_topic = "TALK_AUGUSTMOON_GENETECH_WORKS",
        },
        {
            text = ccb.content.text("Maybe later."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_AUGUSTMOON_GENETECH_WORKS" },
    line = ccb.content.text("&The clerk smiles, \"Our Genetech is a marvel of modern science, capable of rewriting your very DNA.  We offer a wide range of treatments, from the mundanely medical to the exotic.  You need only select one of our templates and visit one of our editing machines in both ends of this store.  If you ever have doubts, remember that all our treatments are reversible.\""),
}
