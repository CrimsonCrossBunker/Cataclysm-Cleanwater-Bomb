local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_GUARD3" },
    replies = {
        {
            text = ccb.content.text("[Premonition] *Check for anything amiss*"),
            next_topic = "TALK_EVAC_GUARD3_danger_sense",
            when = predicates.handler("dlg_p_mindovermatter_222d75bf80b0"),
        },
        {
            text = ccb.content.text("[Sense Hostility] *Determine if <npc_name> is a threat*"),
            next_topic = "TALK_EVAC_GUARD3_sense_hostility",
            when = predicates.handler("dlg_p_mindovermatter_5b3ce0810487"),
        },
        {
            text = ccb.content.text("[Telepathy] *Read <npc_name>'s mind*"),
            next_topic = "TALK_EVAC_GUARD3_scan",
            when = predicates.handler("dlg_p_mindovermatter_8333d7767a16"),
        },
        {
            text = ccb.content.text("It's you."),
            next_topic = "TALK_EVAC_GUARD3_direct_accusation",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_refugee_center_traitor_deep_scanned_evac_guard_3" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_GUARD3_danger_sense" },
    line = ccb.content.text("&You open up your senses and the hair on the back of your neck immediately stands up.  Something could go very wrong for you at any moment."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_EVAC_GUARD3" } },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_GUARD3_sense_hostility" },
    line = ccb.content.text("&You barely open up your senses before you're met with an overpowering sense of menace.  <npc_name> isn't planning to kill you at this exact second but that could change at any moment."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_EVAC_GUARD3" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_scan",
    line = {
        choices = {
            ccb.content.text("«Just what I need.  Come on, leave me alone.»"),
            ccb.content.text("«How am I supposed to…ugh, just go away.»"),
            ccb.content.text("«Who does this asshole think he is?»"),
        },
    },
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_EVAC_GUARD3",
        },
        {
            text = ccb.content.text("[Telepathy 8+] *Go deeper*."),
            next_topic = "TALK_EVAC_GUARD3_deep_scan",
            when = predicates.handler("dlg_p_mindovermatter_88041846ca42"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_GUARD3_deep_scan" },
    line = ccb.content.text("&It's only a moment, but that's enough.  You are looking from behind a tree onto a road where a crude roadblock has been set up.  There's a refugee bus, one of the same ones parked outside the refugee center, stopped at the roadblock, and as the driver gets out to look at the roadblock, there's a loud crack and two spots of red appear on his chest and leg.  As he begins to fall and the people in the bus start screaming, the raiders emerge from the trees, already running with guns raised."),
    replies = {
        {
            text = ccb.content.text("*Withdraw from <npc_name>'s mind*."),
            actions = {
                actions.set_actor_value("speaker", "dialogue_refugee_center_traitor_deep_scanned_evac_guard_3", "yes"),
            },
            next_topic = "TALK_EVAC_GUARD3_post_scan",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_GUARD3_post_scan" },
    line = ccb.content.text("&Only a few moments have passed.  <npc_name> hasn't noticed anything amiss."),
    replies = {
        { text = ccb.content.text("…"), next_topic = "TALK_EVAC_GUARD3" },
        {
            text = ccb.content.text("It's you."),
            next_topic = "TALK_EVAC_GUARD3_direct_accusation",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_refugee_center_traitor_deep_scanned_evac_guard_3" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_GUARD3_direct_accusation" },
    line = ccb.content.text("What the hell are you talking about?"),
    replies = {
        {
            text = ccb.content.text("He was only a child, <npc_name>, and you killed him.  Do you remember the blood on his Superman shirt?"),
            next_topic = "TALK_EVAC_GUARD3_witch",
            opinion = { fear = 4 },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_GUARD3_witch" },
    line = ccb.content.text("I didn't tell you my na-\"  <npc_name>'s face goes white.  \"What the fuck!  You some kind of freak?"),
    replies = {
        {
            text = ccb.content.text("It's over.  Give up."),
            next_topic = "TALK_EVAC_GUARD3_DEAD",
            actions = { actions.handler("dlg_a_mindovermatter_6abd6bb21f81") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_WEAPON_TELEPORT_DISAMED",
    line = ccb.content.text("*stares at you with eyes wide as their weapon vanishes into thin air.  Their mouth works silently but no sounds come out."),
    replies = {
        {
            text = ccb.content.text("Get out of here or you'll be next."),
            trial = { kind = "intimidate", difficulty = 8, modifiers = { { score = "FEAR", scale = 6 } } },
            success = { next_topic = "TALK_EVAC_GUARD3_SUCCESS_TELEPORT_LEAVE", actions = { "flee", actions.handler("dlg_a_mindovermatter_c86cc50b1935") } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_WEAPON_TELEKIN_DISAMED",
    line = ccb.content.text("*starts as the weapon is ripped out of their hands and falls to the floor.  \"Holy shit!  What the fuck?!\""),
    replies = {
        {
            text = ccb.content.text("Leave or I'll do the same to you."),
            trial = { kind = "intimidate", difficulty = 10, modifiers = { { score = "FEAR", scale = 5 } } },
            success = { next_topic = "TALK_EVAC_GUARD3_SUCCESS_TELEKIN_LEAVE", actions = { "flee", actions.handler("dlg_a_mindovermatter_22abd5d5205c") } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_DEAD",
    replies = {
        {
            text = ccb.content.text("[Telekinesis Check] *Try to rip <npc_name>'s weapon away*"),
            when = predicates.has_trait("speaker", "TELEKINETIC"),
            switch = false,
            trial = { kind = "condition", when = predicates.handler("w16b_p_mindovermatter_70afe4b589ba") },
            success = { next_topic = "TALK_EVAC_GUARD3_WEAPON_TELEKIN_DISAMED", actions = { "drop_weapon" }, opinion = { fear = 3 } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
        {
            text = ccb.content.text("[Brilliant Flash Check] *blind <npc_name>*"),
            when = predicates.handler("w16b_p_mindovermatter_565c74480300"),
            switch = true,
            trial = { kind = "condition", when = predicates.handler("w16b_p_mindovermatter_09912424515c") },
            success = { next_topic = "TALK_DONE", actions = { "hostile", actions.add_effect("interlocutor", "blind", { turns = 10 }), actions.add_effect("interlocutor", "stunned", { turns = 2 }) } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile", actions.handler("w16b_a_mindovermatter_d7b3b5a1ce40") } },
        },
        {
            text = ccb.content.text("[Sensory Deprivation Check] *Shut off <npc_name>'s senses*."),
            when = predicates.handler("w16b_p_mindovermatter_627938b5e45e"),
            switch = false,
            trial = { kind = "condition", when = predicates.handler("w16b_p_mindovermatter_de50508b98fe") },
            success = { next_topic = "TALK_DONE", actions = { "hostile", actions.add_effect("interlocutor", "blind", { turns = 10 }), actions.add_effect("interlocutor", "deaf", { turns = 10 }) } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile", actions.handler("w16b_a_mindovermatter_ef9e812dba71") } },
        },
        {
            text = ccb.content.text("[Synaptic Overload Check] *Attack <npc_name>'s mind*."),
            when = predicates.handler("w16b_p_mindovermatter_5d9f1d316b29"),
            switch = false,
            trial = { kind = "condition", when = predicates.handler("w16b_p_mindovermatter_ad6aaaef15cb") },
            success = { next_topic = "TALK_DONE", actions = { "hostile", actions.handler("w16b_a_mindovermatter_8320ce7ac59d"), actions.add_effect("interlocutor", "stunned", { turns = 2 }) } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile", actions.handler("w16b_a_mindovermatter_06ef1401087c") } },
        },
        {
            text = ccb.content.text("[Transposition Check] *Teleport away <npc_name>'s weapon*."),
            when = predicates.handler("w16b_p_mindovermatter_173db33ea2a2"),
            switch = false,
            trial = { kind = "condition", when = predicates.handler("w16b_p_mindovermatter_4534f337ac5d") },
            success = { next_topic = "TALK_EVAC_GUARD3_WEAPON_TELEPORT_DISAMED", actions = { actions.handler("w16b_a_mindovermatter_b75defa2996d") }, opinion = { fear = 5 } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile", actions.handler("w16b_a_mindovermatter_d7a86c032c0c") } },
        },
        {
            text = ccb.content.text("[Oubliette Check] *Banish <npc_name> to another dimension*."),
            when = predicates.handler("w16b_p_mindovermatter_9fcc35c61aba"),
            switch = false,
            trial = { kind = "condition", when = predicates.handler("w16b_p_mindovermatter_69827bfb1407") },
            success = { next_topic = "TALK_DONE", actions = { actions.add_effect("interlocutor", "stunned", { turns = 2 }), actions.handler("w16b_a_mindovermatter_3c497b6f0cc4"), actions.finish_mission("MISSION_OLD_GUARD_REP_2", { step = 1 }), actions.handler("w16b_a_mindovermatter_9b073108e17a") } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile", actions.handler("w16b_a_mindovermatter_c698f1c12500") } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_SUCCESS_TELEKIN_LEAVE",
    line = ccb.content.text("Alright, alright, I'm leaving.  Holy shit."),
    replies = {
        {
            text = ccb.content.text("Good."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_mindovermatter_0b6d848660cb"), actions.finish_mission("MISSION_OLD_GUARD_REP_2", { step = 1 }) },
        },
        {
            text = ccb.content.text("I changed my mind.  You're better off in the ground."),
            next_topic = "TALK_DONE",
            actions = { "hostile", actions.handler("w16b_a_mindovermatter_8d82a9a67e04") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_SUCCESS_TELEPORT_LEAVE",
    line = ccb.content.text("*immediately backs away.  They never turn their back on you, but in a few moments they go out the door and are gone."),
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_mindovermatter_0b6d848660cb"), actions.finish_mission("MISSION_OLD_GUARD_REP_2", { step = 1 }) },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "remove_refugee_center_traitor_because_banished",
    layout = {
        npc_removals = { { id = "evac_guard3", x = 0, y = 0 } },
    },
}
