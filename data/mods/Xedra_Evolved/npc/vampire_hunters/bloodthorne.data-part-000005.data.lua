local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_SELL_SAMPLES",
    line = {
        choices = {
            {
            when = predicates.handler("dlg_p_xedra_evolved_79ce6c0fc7d3"),
            yes = ccb.content.text("I'll take as many as you offer."),
            no = {
                choices = {
                    {
                    when = predicates.handler("dlg_p_xedra_evolved_3f092d269806"),
                    yes = ccb.content.text("You started hunting nature spirits?  Good!  Don't feel bad about them.  If they won't use their powers against the bloodsuckers, we will take these powers for ourselves to fight this war."),
                    no = {
                        choices = {
                            {
                            when = predicates.handler("dlg_p_xedra_evolved_e5045d407662"),
                            yes = ccb.content.text("I'll have to offer less help per sample, as I can't keep giving favors away for so little."),
                            no = ccb.content.text("The more samples, the better.  I'll need as many as possible so I may make more Bloodthorne druids someday."),
                        },
                        },
                    },
                },
                },
            },
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("[Sell her 1 arvore sample]"),
            next_topic = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_SELL_SAMPLES",
            when = predicates.has_item("speaker", "arvore_sample"),
            actions = { actions.transfer_items("arvore_sample"), actions.handler("dlg_a_xedra_evolved_222ea183fbd2") },
        },
        {
            text = ccb.content.text("[Sell her 5 arvore samples]"),
            next_topic = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_SELL_SAMPLES",
            when = predicates.has_inventory("speaker", "arvore_sample", 5),
            actions = { actions.transfer_items("arvore_sample", 5), actions.handler("dlg_a_xedra_evolved_c270fbcc5a33") },
        },
        {
            text = ccb.content.text("[Sell her 10 arvore samples]"),
            next_topic = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_SELL_SAMPLES",
            when = predicates.has_inventory("speaker", "arvore_sample", 10),
            actions = { actions.transfer_items("arvore_sample", 10), actions.handler("dlg_a_xedra_evolved_1dee5cbf43dc") },
        },
        {
            text = ccb.content.text("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
