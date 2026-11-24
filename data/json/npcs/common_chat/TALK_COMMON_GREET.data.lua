local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_STRANGER_NEUTRAL", "TALK_STRANGER_FRIENDLY" },
    replies = {
        {
            text = ccb.content.text("Another survivor!  We should travel together."),
            next_topic = "TALK_SUGGEST_FOLLOW",
        },
        { text = ccb.content.text("What are you doing?"), next_topic = "TALK_DESCRIBE_MISSION" },
        { text = ccb.content.text("Can I do anything for you?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text("Care to trade?"),
            next_topic = "TRADE_HALLU",
            when = predicates.has_trait("interlocutor", "HALLUCINATION"),
            switch = true,
            default = false,
        },
        {
            text = ccb.content.text("Care to trade?"),
            next_topic = "TALK_DONE",
            native_actions = { "start_trade" },
            switch = true,
            default = false,
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_STRANGER_SCARED", "TALK_STRANGER_WARY" },
    replies = {
        {
            text = ccb.content.text("[Put away weapon.]"),
            next_topic = "TALK_STRANGER_NEUTRAL",
            when = predicates.handler("dlg_p_dda_41e985c27ed5"),
            actions = { "player_weapon_away" },
            opinion = { trust = 2, fear = -2 },
        },
        {
            text = ccb.content.text("[Drop weapon.]"),
            next_topic = "TALK_STRANGER_NEUTRAL",
            when = predicates.handler("dlg_p_dda_3985a08230de"),
            actions = { "player_weapon_drop" },
            opinion = { trust = 4, fear = -3 },
        },
        {
            text = ccb.content.text("Don't worry, I'm not going to hurt you."),
            trial = { kind = "persuade", difficulty = 50, modifiers = { { score = "BRAVERY", scale = 2 }, { score = "FEAR", scale = -2 }, { score = "TRUST", scale = 2 } } },
            success = { next_topic = "TALK_STRANGER_NEUTRAL", actions = { "stranger_neutral" }, opinion = { trust = 1, fear = -1 } },
            failure = { next_topic = "TALK_DONE", actions = { "flee" } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = {
        "TALK_STRANGER_NEUTRAL", "TALK_STRANGER_FRIENDLY", "TALK_STRANGER_SCARED", "TALK_STRANGER_WARY",
        "TALK_MISSION_DESCRIBE_URGENT",
    },
    replies = {
        {
            text = ccb.content.text("Drop your weapon!"),
            when = predicates.all({ predicates.actor_state("interlocutor", "has_weapon"), predicates.negate(predicates.actor_state("interlocutor", "friendly")) }),
            trial = { kind = "intimidate", difficulty = 30 },
            success = {
                next_topic = "TALK_WEAPON_DROPPED",
                native_actions = { "drop_weapon" },
                opinion = { trust = 4, fear = -3 },
            },
            failure = { next_topic = "TALK_DONE", native_actions = { "hostile" } },
        },
        {
            text = ccb.content.text("Get out of here or I'll kill you."),
            when = predicates.negate(predicates.actor_state("interlocutor", "friendly")),
            trial = { kind = "intimidate", difficulty = 20 },
            success = { next_topic = "TALK_DONE", native_actions = { "flee" } },
            failure = { next_topic = "TALK_DONE", native_actions = { "hostile" } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_STRANGER_FRIENDLY",
    line = ccb.content.text("Hey there, <name_g>."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_STRANGER_NEUTRAL",
    line = ccb.content.text("Hello there."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_STRANGER_WARY",
    line = ccb.content.text("Okay, no sudden movements…"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_STRANGER_SCARED",
    line = ccb.content.text("Keep your distance!"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_STRANGER_AGGRESSIVE",
    line = { when = predicates.actor_state("speaker", "has_weapon"), yes = ccb.content.text("<drop_it>"), no = ccb.content.text("This is my territory, <name_b>.") },
    replies = {
        {
            text = ccb.content.text("[Drop weapon.]"),
            next_topic = "TALK_DEMAND_LEAVE",
            when = predicates.handler("dlg_p_dda_3985a08230de"),
            actions = { "player_weapon_drop" },
        },
        {
            text = ccb.content.text("Calm down.  I'm not going to hurt you."),
            trial = { kind = "persuade", difficulty = 30, modifiers = { { score = "BRAVERY", scale = 1 }, { score = "AGGRESSION", scale = -3 }, { score = "ALTRUISM", scale = 2 }, { score = "FEAR", scale = -2 }, { score = "TRUST", scale = 3 } } },
            success = { next_topic = "TALK_STRANGER_WARY", actions = { "stranger_neutral" }, opinion = { trust = 1, fear = -1 } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
        {
            text = ccb.content.text("Screw you, no."),
            trial = { kind = "intimidate", difficulty = 25, modifiers = { { score = "BRAVERY", scale = 1 }, { score = "AGGRESSION", scale = -3 }, { score = "ALTRUISM", scale = 2 }, { score = "FEAR", scale = -2 }, { score = "TRUST", scale = 3 } } },
            success = { next_topic = "TALK_STRANGER_SCARED", actions = { "stranger_neutral" }, opinion = { trust = -2, fear = 1, anger = 1 } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MUG",
    line = { when = predicates.actor_state("speaker", "has_weapon"), yes = ccb.content.text("<drop_it>"), no = ccb.content.text("<hands_up>") },
    replies = {
        {
            text = ccb.content.text("Calm down.  I'm not going to hurt you."),
            trial = { kind = "persuade", difficulty = 35, modifiers = { { score = "BRAVERY", scale = 1 }, { score = "AGGRESSION", scale = -3 }, { score = "ALTRUISM", scale = 2 }, { score = "FEAR", scale = -2 }, { score = "TRUST", scale = 3 } } },
            success = { next_topic = "TALK_STRANGER_WARY", actions = { "stranger_neutral" }, opinion = { trust = 1, fear = -1 } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
        {
            text = ccb.content.text("Screw you, no."),
            trial = { kind = "intimidate", difficulty = 30, modifiers = { { score = "BRAVERY", scale = 1 }, { score = "AGGRESSION", scale = -3 }, { score = "ALTRUISM", scale = 2 }, { score = "FEAR", scale = -2 }, { score = "TRUST", scale = 3 } } },
            success = { next_topic = "TALK_STRANGER_SCARED", actions = { "stranger_neutral" }, opinion = { trust = -2, fear = 1, anger = 1 } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
        {
            text = ccb.content.text("[Drop weapon.]"),
            next_topic = "TALK_MUG",
            when = predicates.handler("dlg_p_dda_3985a08230de"),
            actions = { "player_weapon_drop" },
        },
        {
            text = ccb.content.text("[Put hands up.]"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.actor_state("speaker", "has_weapon")),
            actions = { "start_mugging" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WEAPON_DROPPED",
    line = {
        when = predicates.actor_state("interlocutor", "male"),
        yes = ccb.content.text("*drops his weapon."),
        no = ccb.content.text("*drops her weapon."),
    },
    replies = {
        {
            text = ccb.content.text("Now get out of here."),
            next_topic = "TALK_DONE",
            native_actions = { "flee" },
            opinion = { trust = -1, fear = -2, anger = -2 },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DEMAND_LEAVE",
    line = ccb.content.gendered_line("Now get out of here, before I kill you.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Okay, I'm going."),
            next_topic = "TALK_DONE",
            native_actions = { "player_leaving" },
            opinion = { fear = -1 },
        },
    },
}
