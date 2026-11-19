local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_INTRO_3",
    line = {
        when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
        yes = ccb.content.text("Ah, yes, our cybernetic visitor.  Would you be willing to tell us more about the cyborgs that did this to you?"),
        no = ccb.content.text("Ah, it's you.  Mind giving your fellow American information regarding possible terrorist cyborgs?"),
    },
    replies = {
        {
            text = ccb.content.text("You know what?  I've changed my mind.  I'll do your dirty work.  Give me some time to chat up these folks."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodii_transdimensional_u_knows_exodiilore" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "u_give_robofac_exodii_info" } })) }),
        },
        {
            text = ccb.content.text("Please… I stopped being an American the moment the government left us to fend for ourselves."),
            when = predicates.negate(predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC")),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Maybe some other time…"),
            when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Fine.  I'll tell you about these inter-dimensional beings."),
            next_topic = "TALK_ROBOFAC_ABOUT_EXODII_2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodii_transdimensional_u_knows_exodiilore" } }),
        },
    },
}
