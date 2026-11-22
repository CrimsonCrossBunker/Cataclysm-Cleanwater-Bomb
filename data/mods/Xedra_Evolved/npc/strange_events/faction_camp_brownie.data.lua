local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "XE_STRANGE_EVENT_BROWNIE_MEETS_BROWNIE",
    line = {
        choices = {
            {
            joined = {
                ccb.content.text("&The brownie starts when it sees you and makes ready to vanish, then it takes a closer look at you."),
                {
                when = predicates.has_trait("speaker", "UNKNOWING_CHANGELING_NOBLE"),
                yes = {
                    when = predicates.actor_state("speaker", "male"),
                    yes = ccb.content.text("  \"My apologies for entering your court without your leave, my lord.  I beg pardon.  Now, if you will excuse me…\""),
                    no = ccb.content.text("  \"My apologies for entering your court without your leave, my lady.  I beg pardon.  Now, if you will excuse me…\""),
                },
                no = ccb.content.text("\"Oh. Oh!  I'm terribly sorry, I didn't realize there was already one of us here.  I'll take my leave.\""),
            },
                ccb.content.text("  They turn as if to go."),
            },
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("Us?  What are you talking about?"),
            next_topic = "XE_STRANGE_EVENT_BROWNIE_FEW_BROWNIE_TRAITS_YET",
            when = predicates.handler("dlg_p_xedra_evolved_332cbb5e6240"),
        },
        {
            text = ccb.content.text("Leave already?  Why not join me?"),
            next_topic = "XE_STRANGE_EVENT_BROWNIE_MEDIUM_BROWNIE_TRAITS",
            when = predicates.handler("dlg_p_xedra_evolved_004b9d023580"),
        },
        {
            text = ccb.content.text("Why not join my court?"),
            next_topic = "XE_STRANGE_EVENT_BROWNIE_YOU_ARE_NOBLE",
            when = predicates.has_trait("speaker", "UNKNOWING_CHANGELING_NOBLE"),
        },
        {
            text = ccb.content.text("I will.  Get out."),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("speaker", "UNKNOWING_CHANGELING_NOBLE"),
            actions = { actions.handler("dlg_a_xedra_evolved_bdceae3aaeee") },
        },
        {
            text = ccb.content.text("Well, goodbye."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_xedra_evolved_fbe7cdc8fe88") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "XE_STRANGE_EVENT_BROWNIE_FEW_BROWNIE_TRAITS_YET",
    line = {
        choices = {
            ccb.content.text("&The brownie looks at you closely.  \"You don't know?  Oh dear, you don't know, do you?  Well, it's not my place to tell you, you'll have to figure it out.  That's part of why they put you here, after all.\"  Before you can get in another word, the brownie spins in a circle and vanishes."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Wait, I-"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_xedra_evolved_87ec93251ecd") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "XE_STRANGE_EVENT_BROWNIE_MEDIUM_BROWNIE_TRAITS",
    line = {
        choices = {
            ccb.content.text("&The brownie shakes their head.  \"It's a generous offer, but no thank you.  I'm looking for a place I can make my mark without the mortals breathing down my back.  Given another few decades you'll probably understand, if this world has that long.  And if not, well, I'll see you Under the Hill.\"  Before you can get in another word, the brownie spins in a circle and vanishes."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Farewell then."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_xedra_evolved_9addf16f3519") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "XE_STRANGE_EVENT_BROWNIE_YOU_ARE_NOBLE",
    line = {
        choices = {
            ccb.content.text("&The brownie shakes their head.  \"I thank you for the generous offer, but no, my road doesn't end here.  I have a long way to travel yet, and by your leave, I had best take the first step on it.\""),
        },
    },
    replies = {
        {
            text = ccb.content.text("Farewell then."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_xedra_evolved_437c7ccacbd1") },
        },
    },
}
