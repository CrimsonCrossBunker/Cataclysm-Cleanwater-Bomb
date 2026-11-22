local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CABIN_CHEMIST_BULK_SELL",
    line = {
        when = predicates.has_effect("interlocutor", "currently_busy"),
        yes = ccb.content.text("I'm out of some things, <name_g>.  It takes a while to source the good stuff - days usually - but I'm working hard to replace it.  What can I get you in the meantime?"),
        no = ccb.content.text("I'll see what I've got around here for you.  I've gotta warn you: it's gonna be expensive.  Hard to stay supplied in the apocalypse, you know.  What do you need?"),
    },
    replies = {
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("[10$]  I'll buy some bandages."),
            next_topic = "TALK_CABIN_CHEMIST_BULK_SELL_END",
            actions = { actions.handler("w16b_a_dda_38fb458cc012") },
        },
        {
            text = ccb.content.text("[40$]  I'll buy some aspirin."),
            next_topic = "TALK_CABIN_CHEMIST_BULK_SELL_END",
            actions = { actions.handler("w16b_a_dda_31798cba046f") },
        },
        {
            text = ccb.content.text("[50$]  I'll buy some sprayable fungicide."),
            next_topic = "TALK_CABIN_CHEMIST_BULK_SELL_END",
            when = predicates.negate(predicates.has_effect("interlocutor", "chemist_waiting_for_gas_fungicidal")),
            actions = { actions.handler("w16b_a_dda_bef675a8b944") },
        },
        {
            text = ccb.content.text("[50$]  I'll buy some powder fungicide."),
            next_topic = "TALK_CABIN_CHEMIST_BULK_SELL_END",
            when = predicates.negate(predicates.has_effect("interlocutor", "chemist_waiting_for_fungicide")),
            actions = { actions.handler("w16b_a_dda_90b121a26a40") },
        },
        {
            text = ccb.content.text("[50$]  I'll buy some disinfectant."),
            next_topic = "TALK_CABIN_CHEMIST_BULK_SELL_END",
            when = predicates.negate(predicates.has_effect("interlocutor", "chemist_waiting_for_disinfectant")),
            actions = { actions.handler("w16b_a_dda_699951ea0282") },
        },
        {
            text = ccb.content.text("[120$]  I'll buy some antibiotics."),
            next_topic = "TALK_CABIN_CHEMIST_BULK_SELL_END",
            when = predicates.negate(predicates.has_effect("interlocutor", "chemist_waiting_for_antibiotics")),
            actions = { actions.handler("w16b_a_dda_5ec2560186ec") },
        },
        {
            text = ccb.content.text("[140$]  I'll buy some antifungal drugs."),
            next_topic = "TALK_CABIN_CHEMIST_BULK_SELL_END",
            when = predicates.negate(predicates.has_effect("interlocutor", "chemist_waiting_for_antifungal")),
            actions = { actions.handler("w16b_a_dda_5a05faa5ecf4") },
        },
        {
            text = ccb.content.text("[200$]  I'll buy some black gunpowder."),
            next_topic = "TALK_CABIN_CHEMIST_BULK_SELL_END",
            when = predicates.negate(predicates.has_effect("interlocutor", "chemist_waiting_for_chem_black_powder")),
            actions = { actions.handler("w16b_a_dda_92d3caf53017") },
        },
        {
            text = ccb.content.text("[300$]  I'll buy some napalm."),
            next_topic = "TALK_CABIN_CHEMIST_BULK_SELL_END",
            when = predicates.negate(predicates.has_effect("interlocutor", "chemist_waiting_for_napalm")),
            actions = { actions.handler("w16b_a_dda_11d21b998c8f") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CABIN_CHEMIST_BULK_SELL_END",
    line = ccb.content.text("Is there anything else you need?"),
    replies = {
        {
            text = ccb.content.text("No, that's all."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("[10$]  I'll buy some bandages."),
            next_topic = "TALK_CABIN_CHEMIST_BULK_SELL_END",
            actions = { actions.handler("w16b_a_dda_d4fd5df8fea1") },
        },
        {
            text = ccb.content.text("[40$]  I'll buy some aspirin."),
            next_topic = "TALK_CABIN_CHEMIST_BULK_SELL_END",
            actions = { actions.handler("w16b_a_dda_e7223a8a52ba") },
        },
        {
            text = ccb.content.text("[50$]  I'll buy some sprayable fungicide."),
            next_topic = "TALK_CABIN_CHEMIST_BULK_SELL_END",
            when = predicates.negate(predicates.has_effect("interlocutor", "chemist_waiting_for_gas_fungicidal")),
            actions = { actions.handler("w16b_a_dda_6beb02908b54") },
        },
        {
            text = ccb.content.text("[50$]  I'll buy some powder fungicide."),
            next_topic = "TALK_CABIN_CHEMIST_BULK_SELL_END",
            when = predicates.negate(predicates.has_effect("interlocutor", "chemist_waiting_for_fungicide")),
            actions = { actions.handler("w16b_a_dda_e72cb0ba728b") },
        },
        {
            text = ccb.content.text("[50$]  I'll buy some disinfectant."),
            next_topic = "TALK_CABIN_CHEMIST_BULK_SELL_END",
            when = predicates.negate(predicates.has_effect("interlocutor", "chemist_waiting_for_disinfectant")),
            actions = { actions.handler("w16b_a_dda_0bc8fa32c4cc") },
        },
        {
            text = ccb.content.text("[120$]  I'll buy some antibiotics."),
            next_topic = "TALK_CABIN_CHEMIST_BULK_SELL_END",
            when = predicates.negate(predicates.has_effect("interlocutor", "chemist_waiting_for_antibiotics")),
            actions = { actions.handler("w16b_a_dda_1e4def38fe67") },
        },
        {
            text = ccb.content.text("[140$]  I'll buy some antifungal drugs."),
            next_topic = "TALK_CABIN_CHEMIST_BULK_SELL_END",
            when = predicates.negate(predicates.has_effect("interlocutor", "chemist_waiting_for_antifungal")),
            actions = { actions.handler("w16b_a_dda_1b27e0514798") },
        },
        {
            text = ccb.content.text("[200$]  I'll buy some black gunpowder."),
            next_topic = "TALK_CABIN_CHEMIST_BULK_SELL_END",
            when = predicates.negate(predicates.has_effect("interlocutor", "chemist_waiting_for_chem_black_powder")),
            actions = { actions.handler("w16b_a_dda_543125a2c97e") },
        },
        {
            text = ccb.content.text("[300$]  I'll buy some napalm."),
            next_topic = "TALK_CABIN_CHEMIST_BULK_SELL_END",
            when = predicates.negate(predicates.has_effect("interlocutor", "chemist_waiting_for_napalm")),
            actions = { actions.handler("w16b_a_dda_5abd30583796") },
        },
    },
}
