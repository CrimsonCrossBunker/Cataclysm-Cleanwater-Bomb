local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_STOLE_ITEM",
    replies = {
        {
            text = ccb.content.text("[Telepathy Check] What are you talking about?  This is mine."),
            when = predicates.handler("dlg_p_mindovermatter_8333d7767a16"),
            switch = true,
            trial = { kind = "condition", when = predicates.handler("dlg_p_mindovermatter_a42101192724") },
            success = { next_topic = "TALK_TELEPATHY_ALLOW_KEEP_ITEM" },
            failure = { next_topic = "TALK_DISALLOW_KEEP_ITEM" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TELEPATHY_ALLOW_KEEP_ITEM",
    line = {
        choices = {
            ccb.content.text("Oh, I…I don't know what I was thinking.  I…sorry."),
            ccb.content.text("It is?  Oh, it…it is.  Right.  Right."),
            ccb.content.text("I…I thought that…never mind."),
            ccb.content.text("But you…no, I thought…I just…"),
            ccb.content.text("What?  But that's…we've had…how did you…"),
        },
    },
    replies = {
        {
            text = ccb.content.text("That's right."),
            next_topic = "TALK_DONE",
            actions = { "remove_stolen_status", actions.handler("dlg_a_mindovermatter_2cfa11e32d4b") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MUG_TELEKINESIS_USED",
    line = {
        when = predicates.actor_state("interlocutor", "male"),
        yes = {
            choices = {
                ccb.content.text("*'s weapon flies out of his hands.\n\n\"<freaking> <name_b>!  You some kind of witch?\""),
                ccb.content.text("*'s weapon flies out of his hands and he lets out a startled yelp."),
            },
        },
        no = {
            choices = {
                ccb.content.text("*'s weapon flies out of her hands.\n\n\"<freaking> <name_b>!  You some kind of witch?\""),
                ccb.content.text("*'s weapon flies out of her hands and she lets out a startled yelp."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Get out of here before I do worse."),
            trial = { kind = "intimidate", difficulty = 10, modifiers = { { score = "FEAR", scale = 3 } } },
            success = { next_topic = "TALK_DONE", native_actions = { "flee" } },
            failure = { next_topic = "TALK_DONE", native_actions = { "hostile" } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_STRANGER_SCARED",
    replies = {
        {
            text = ccb.content.text("[Mood Stablization Check] I'm not going to hurt you."),
            when = predicates.handler("dlg_p_mindovermatter_36a04c7d320b"),
            trial = { kind = "condition", when = predicates.handler("dlg_p_mindovermatter_695b06c33141") },
            success = { next_topic = "TALK_STRANGER_NEUTRAL", actions = { "stranger_neutral" }, opinion = { trust = 3, fear = -1 } },
            failure = { next_topic = "TALK_DONE", actions = { "flee", actions.handler("dlg_a_mindovermatter_67f27142b7a4") } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_STRANGER_WARY",
    replies = {
        {
            text = ccb.content.text("[Mood Stablization Check] I'm not going to hurt you."),
            when = predicates.handler("dlg_p_mindovermatter_36a04c7d320b"),
            trial = { kind = "condition", when = predicates.handler("dlg_p_mindovermatter_695b06c33141") },
            success = { next_topic = "TALK_STRANGER_NEUTRAL", actions = { "stranger_neutral" }, opinion = { trust = 3, fear = -1 } },
            failure = { next_topic = "TALK_DONE", actions = { "flee", actions.handler("dlg_a_mindovermatter_67f27142b7a4") } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_MUG", "TALK_STRANGER_AGGRESSIVE" },
    replies = {
        {
            text = ccb.content.text("[Far Hand Check] *Try to rip their weapon out of their hands*."),
            when = predicates.handler("w16b_p_mindovermatter_5178bf197518"),
            trial = { kind = "condition", when = predicates.handler("w16b_p_mindovermatter_0e5dd30e7184") },
            success = { next_topic = "TALK_MUG_TELEKINESIS_USED", actions = { "drop_weapon" }, opinion = { fear = 3 } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile", actions.handler("w16b_a_mindovermatter_88a1e35636f2") } },
        },
        {
            text = ccb.content.text("[Brilliant Flash Check] *blind <npc_name>*"),
            when = predicates.handler("w16b_p_mindovermatter_565c74480300"),
            trial = { kind = "condition", when = predicates.handler("w16b_p_mindovermatter_09912424515c") },
            success = { next_topic = "TALK_DONE", actions = { "hostile", actions.add_effect("interlocutor", "blind", { turns = 10 }), actions.add_effect("interlocutor", "stunned", { turns = 2 }) } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile", actions.handler("w16b_a_mindovermatter_7c80882918f6") } },
        },
        {
            text = ccb.content.text("[Mood Stablization Check] You don't want to hurt me."),
            when = predicates.handler("w16b_p_mindovermatter_d5e2d9347d85"),
            trial = { kind = "condition", when = predicates.handler("w16b_p_mindovermatter_54688e1cd366") },
            success = { next_topic = "TALK_STRANGER_NEUTRAL", actions = { "stranger_neutral" }, opinion = { trust = 3, fear = -1 } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile", actions.handler("w16b_a_mindovermatter_d7b3b5a1ce40") } },
        },
        {
            text = ccb.content.text("[Sensory Deprivation Check] *Shut off <npc_name>'s senses*."),
            when = predicates.handler("w16b_p_mindovermatter_627938b5e45e"),
            trial = { kind = "condition", when = predicates.handler("w16b_p_mindovermatter_6efc18558042") },
            success = { next_topic = "TALK_DONE", actions = { "hostile", actions.add_effect("interlocutor", "blind", { turns = 10 }), actions.add_effect("interlocutor", "deaf", { turns = 10, intensity = 3 }) } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile", actions.handler("w16b_a_mindovermatter_ef9e812dba71") } },
        },
        {
            text = ccb.content.text("[Neural Spasms Check] *Paralyze <npc_name>*."),
            when = predicates.handler("w16b_p_mindovermatter_4c3b877b2dbf"),
            trial = { kind = "condition", when = predicates.handler("w16b_p_mindovermatter_f2f0ac88a66c") },
            success = { next_topic = "TALK_DONE", actions = { "hostile", actions.handler("w16b_a_mindovermatter_6a0121d8b531") } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile", actions.handler("w16b_a_mindovermatter_78222e552e7e") } },
        },
        {
            text = ccb.content.text("[Synaptic Overload Check] *Attack <npc_name>'s mind*."),
            when = predicates.handler("w16b_p_mindovermatter_9ac155185f5f"),
            trial = { kind = "condition", when = predicates.handler("w16b_p_mindovermatter_fdc240a8ecb2") },
            success = { next_topic = "TALK_DONE", actions = { "hostile", actions.handler("w16b_a_mindovermatter_8cda4b563028"), actions.add_effect("interlocutor", "stunned", { turns = 2 }) } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile", actions.handler("w16b_a_mindovermatter_06ef1401087c") } },
        },
    },
}
