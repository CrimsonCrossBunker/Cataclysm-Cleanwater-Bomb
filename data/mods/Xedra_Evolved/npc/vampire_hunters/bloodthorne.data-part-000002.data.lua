local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_OFFER_CURE",
    line = {
        choices = {
            {
            when = predicates.handler("w16b_p_xedra_evolved_a36fde5af7fe"),
            yes = ccb.content.text("Before that, you must starve yourself of blood so I know you genuinely want to be freed.  Return to me when you will show symptoms of blood starvation and I will cure you."),
            no = ccb.content.text("You starved yourself of blood.  Good.  Now lie there on the dirt and stay perfectly still while the heartvines do their work.  It'll take half an hour, it'll hurt and you'll probably need a few days to recover, but you won't become another victim of this curse."),
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("Go ahead."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_xedra_evolved_f917d87baf9c"),
            actions = { actions.handler("w16b_a_xedra_evolved_e185a1582968") },
        },
        {
            text = ccb.content.text("Go ahead."),
            next_topic = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_CURE_WARNING",
            when = predicates.handler("w16b_p_xedra_evolved_8a7c92bf3c2d"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_CURE_WARNING",
    line = {
        choices = {
            ccb.content.text("I must warn you before we start.  Your weakened body and your potent vampirism mean that the heartvines will cause severe damage to your body.  You could die from the procedure.  Are you sure you want to do this?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("I will find another way."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Do it.  <color_red>This might literally kill you.</color>"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_xedra_evolved_e185a1582968") },
        },
    },
}
