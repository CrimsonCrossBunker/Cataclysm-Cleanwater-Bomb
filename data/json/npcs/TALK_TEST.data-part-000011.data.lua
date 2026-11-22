local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_COMPARE_INT_OP",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("Two = five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_ce4c1dc2145d"),
        },
        {
            text = ccb.content.text("Two == five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_ce4c1dc2145d"),
        },
        {
            text = ccb.content.text("Two != five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_bb158f4d9754"),
        },
        {
            text = ccb.content.text("Two <= five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c1731e2fa3b9"),
        },
        {
            text = ccb.content.text("Two >= five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_24a5044163c9"),
        },
        {
            text = ccb.content.text("Two < five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_f4b958fc8ef3"),
        },
        {
            text = ccb.content.text("Two > five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_6288704ce042"),
        },
        {
            text = ccb.content.text("Five = five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_22605a00be9f"),
        },
        {
            text = ccb.content.text("Five == five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_22605a00be9f"),
        },
        {
            text = ccb.content.text("Five != five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_77c226e13c5a"),
        },
        {
            text = ccb.content.text("Five <= five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_37248ea12a17"),
        },
        {
            text = ccb.content.text("Five >= five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_5399cdd1bdb2"),
        },
        {
            text = ccb.content.text("Five < five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_fb3111db504f"),
        },
        {
            text = ccb.content.text("Five > five."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_041ace24eff5"),
        },
        {
            text = ccb.content.text("Five = two."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_2ad236a7138a"),
        },
        {
            text = ccb.content.text("Five == two."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_2ad236a7138a"),
        },
        {
            text = ccb.content.text("Five != two."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_e36c8ed15a11"),
        },
        {
            text = ccb.content.text("Five <= two."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_ac70001677cd"),
        },
        {
            text = ccb.content.text("Five >= two."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c8d1256a1445"),
        },
        {
            text = ccb.content.text("Five < two."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_e83c8a5dc991"),
        },
        {
            text = ccb.content.text("Five > two."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_f1643b5e2873"),
        },
    },
}
