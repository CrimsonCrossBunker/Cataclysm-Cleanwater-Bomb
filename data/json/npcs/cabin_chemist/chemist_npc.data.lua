local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "NPC_cabin_chemist",
    class = "NC_CHEM_MERCHANT",
    suffix = ccb.content.text("chemist"),
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_NPC_CABIN_CHEMIST",
    faction = "wasteland_scavengers",
    missions_offered = "MISSION_CABIN_CHEMIST_GET_analytical_set_basic",
}

ccb.content.define_npc_class {
    id = "NC_CHEM_MERCHANT",
    name = ccb.content.text("Chemist"),
    job_description = ccb.content.text("I make and sell chemicals"),
    common = false,
    traits = {
        { group = "BG_survival_story_RURAL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    intelligence = { rng = { 1, 2 } },
    shop_groups = { { id = "cabin_chemist_sell", rigid = true } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "speech", bonus = { rng = { 0, 2 } } },
        { skill = "firstaid", bonus = { rng = { 1, 2 } } },
        { skill = "cooking", bonus = { rng = { 1, 2 } } },
        { skill = "chemistry", bonus = { rng = { 3, 5 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_NPC_CABIN_CHEMIST", "TALK_NPC_CABIN_CHEMIST_INTRO" },
    replies = {
        {
            text = ccb.content.text("Who are you?"),
            next_topic = "TALK_NPC_CABIN_CHEMIST_STORY",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_story_told_u_backstory" } })), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }) }),
        },
        {
            text = ccb.content.text("Could you tell me about yourself again?"),
            next_topic = "TALK_NPC_CABIN_CHEMIST_STORY",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_story_told_u_backstory" } }), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }) }),
        },
        {
            text = ccb.content.text("I'd like to ask you a few questions."),
            next_topic = "TALK_FRIEND_CONVERSATION",
            when = predicates.handler("dlg_p_dda_2c514690302b"),
        },
        {
            text = ccb.content.text("What is this place?"),
            next_topic = "TALK_NPC_CABIN_CHEMIST_HOME",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        },
        {
            text = ccb.content.text("Brewed anything new lately?"),
            next_topic = "TALK_NPC_CABIN_CHEMIST_ASK_INTERVAL",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        },
        {
            text = ccb.content.text("Care to trade?"),
            next_topic = "TALK_NPC_CABIN_CHEMIST_INTRO",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("I'd like to buy in bulk."),
            next_topic = "TALK_CABIN_CHEMIST_BULK_SELL",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_trade_mass_chem_tradeable" } }) }),
        },
        {
            text = ccb.content.text("Any jobs you need done?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }), predicates.negate(predicates.assigned_missions(1, 1)), predicates.negate(predicates.assigned_missions(2)) }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CABIN_CHEMIST",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        yes = ccb.content.text("It's nice to see you again <u_name>.  What can I do for you?"),
        no = ccb.content.gendered_line("It's nice to see a new face around here.  I'm <npc_name>, it's a pleasure meeting you.", { "interlocutor" }),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "dialogue_first_meeting_knows_u", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you too, I'm <u_name>."),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } })),
            next_topic = "TALK_NPC_CABIN_CHEMIST_INTRO",
        },
        {
            text = ccb.content.text("Hands up!  Hand over everything you've got, and nobody gets hurt!"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } })),
            trial = { kind = "intimidate", difficulty = 30 },
            success = {
                next_topic = "TALK_WEAPON_DROPPED",
                actions = { "drop_weapon" },
                opinion = { trust = -4, fear = 3 },
            },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CABIN_CHEMIST_INTRO",
    line = ccb.content.text("So, what can I do for you?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CABIN_CHEMIST_ASK_INTERVAL",
    line = ccb.content.text("Unfortunately, I'm still gathering resources and cooking new stuff.  Maybe ask again after <restock_time_point>."),
    replies = {
        {
            text = ccb.content.text("Alright.  thanks nonetheless."),
            next_topic = "TALK_NPC_CABIN_CHEMIST_INTRO",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CABIN_CHEMIST_STORY",
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "dialogue_story_told_u_backstory", "yes") },
        },
    },
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_story_told_u_backstory" } }),
        yes = ccb.content.gendered_line("Like I said before, I'm a chemist.  I've been living out here for a while, decided to set up shop in this old cabin.  I even found some good equipment out here, and a couple useful things here in the cupboards.  I decided to stay right here.", { "interlocutor" }),
        no = ccb.content.gendered_line("I used to be a chemist.  Well, I am a chemist.  I've been living out here in the wilderness for a little while now since <the_cataclysm>.  Lucky enough, I even found some good equipment out here, though unfortunately missing some of the more sensitive and expensive stuff.  I found a couple useful things here in the cupboards, but other than that, entirely empty.  So, I moved in.", { "interlocutor" }),
    },
    replies = { { text = ccb.content.text("Hmm."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CABIN_CHEMIST_HOME",
    line = ccb.content.gendered_line("Not my place, just somewhere I ended up.  Some old shack, maybe a hunting cabin or something more… criminal, at least judging by some of what I found on the shelves.  You certainly wouldn't attract much attention synthesizing illegal substances all the way out here, that's all I'm saying.  I found it while I was trying to escape all the <zombies> in the city, and I decided to stay.", { "interlocutor" }),
    replies = { { text = ccb.content.text("Hmm."), next_topic = "TALK_NONE" } },
}

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
