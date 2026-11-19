local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_TRIFACET",
    line = ccb.content.text("We already have a similar model in better condition but this one is useful as a reference."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_yrax_robot", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_yrax_robot" }, { "yes" }),
            },
            once = "yrax_trade",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_TRIAKIS",
    line = ccb.content.text("We can probably gain some insight from studying this unit, but it appears seriously damaged."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_yrax_robot", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_yrax_robot" }, { "yes" }),
            },
            once = "yrax_trade",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_GOLDEN_MONOLITH",
    line = ccb.content.text("That is quite a lot of broken metal, let's hope R&D can at least salvage some materials."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_yrax_robot", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_yrax_robot" }, { "yes" }),
            },
            once = "yrax_trade",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_DELTA",
    line = ccb.content.text("We don't need all of your glossy scrap."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_yrax_robot", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_yrax_robot" }, { "yes" }),
            },
            once = "yrax_trade",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_QUADRAPHRACT_LEG",
    line = ccb.content.text("We witnessed it as a part of larger construct."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_yrax_robot", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_yrax_robot" }, { "yes" }),
            },
            once = "yrax_trade",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_QUADRAPHRACT",
    line = ccb.content.text("I'm impressed you managed to drag it inside.  We gonna need to fix the lift after this one."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_yrax_robot", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_yrax_robot" }, { "yes" }),
            },
            once = "yrax_trade",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_BOT_YRAX_TRIFACET",
    line = ccb.content.text("I believe we already have similar model already but is nice to have more, it will allow us be more active in our research."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_yrax_robot", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_yrax_robot" }, { "yes" }),
            },
            once = "yrax_trade",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_BOT_YRAX_TRIAKIS",
    line = ccb.content.text("Oh what an interesting piece.  R&D will have a field day with it."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_yrax_robot", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_yrax_robot" }, { "yes" }),
            },
            once = "yrax_trade",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_BOT_GOLDEN_MONOLITH",
    line = ccb.content.text("I assume you were trying to figure out limits of the hm12.  I guess they are right here."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_yrax_robot", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_yrax_robot" }, { "yes" }),
            },
            once = "yrax_trade",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_BOT_YRAX_DELTA",
    line = ccb.content.text("I doubt we can get a lot of information from this drone but thanks."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_yrax_robot", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_yrax_robot" }, { "yes" }),
            },
            once = "yrax_trade",
        },
    },
}
