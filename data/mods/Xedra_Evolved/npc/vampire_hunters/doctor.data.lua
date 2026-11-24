local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- He sells cure & some medical supplies.  Very interested by alchemical recipes and magical/high-science medical treatments.
-- His main goal is to break the vampires' monopoly on agelessness and perfect health to reduce the amount of new vampires.  A very hard goal to reach even before the cataclysm, but he'll try nonetheless.
ccb.content.define_npc {
    id = "vampire_hunter_doctor",
    suffix = ccb.content.text("hunter"),
    class = "NC_vampire_hunter_doctor",
    unique_name = ccb.content.text("Blaine Weiss"),
    gender = "male",
    attitude = 0,
    mission = "NULL",
    chat = "TALK_HUNTER_DOCTOR",
    personality = { aggression = 0, bravery = 6, collector = 6, altruism = 8 },
    faction = "vampire_hunters",
}

-- Worked as a doctor and performed medical research but little else.  Has a crossbow mainly for self-defense.
-- He's also the de facto cook due to him being the best available for this task.
ccb.content.define_npc_class {
    id = "NC_vampire_hunter_doctor",
    name = ccb.content.text("doctor"),
    job_description = ccb.content.text("I tend up wounded hunters."),
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_African" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    strength = { rng = { 1, 2 } },
    dexterity = { rng = { 1, 2 } },
    intelligence = { rng = { 3, 4 } },
    perception = { rng = { 1, 2 } },
    sells_belongings = false,
    shop_groups = { { id = "hunter_doctor_sold_items", rigid = true } },
    consumption_rates = "basic_shop_rates",
    worn = "VAMPIRE_HUNTER_DEFAULT_worn",
    weapon = "VAMPIRE_HUNTER_DEFAULT_CROSSBOW_wield",
    skills = {
        { skill = "rifle", bonus = { rng = { 2, 3 } } },
        { skill = "gun", bonus = { rng = { 2, 3 } } },
        { skill = "firstaid", bonus = { rng = { 6, 7 } } },
        { skill = "chemistry", bonus = { rng = { 6, 7 } } },
        { skill = "cooking", bonus = { rng = { 6, 7 } } },
        { skill = "dodge", bonus = { rng = { 0, 1 } } },
        { skill = "deduction", bonus = { rng = { 1, 2 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_DOCTOR_GIVE_CURE",
    line = {
        choices = { ccb.content.text("Here you go.  It should be more than enough to treat the affliction.") },
    },
    replies = {
        { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_DOCTOR_AID_DONE",
    line = {
        choices = { ccb.content.text("All patched up.  Your current wounds will heal up nicely now.") },
    },
    replies = {
        { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_DOCTOR_INTRO",
    line = {
        choices = {
            ccb.content.text("Normally I would tend to the wounded and do medical research, but with our relative safety and limited free time I mostly sell medical supplies these days.  I'm also the cook because nobody else here is good at cooking.  I would be surprised if one of them prepared an edible lung confit, let alone one that tastes good."),
        },
    },
    replies = {
        {
            text = ccb.content.text("[Show him your notes on aspirin improvement]"),
            next_topic = "TALK_HUNTER_DOCTOR_SHARE_ASPIRIN",
            when = predicates.all({ predicates.has_item("speaker", "alchemy_recipe_extra_str_aspirin"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "shared_with_hunter_doctor_aspirin" } })) }),
            actions = { actions.set_actor_value("speaker", "shared_with_hunter_doctor_aspirin", "yes"), actions.handler("dlg_a_xedra_evolved_39dc5675bdd6") },
        },
        {
            text = ccb.content.text("[Show him your notes on overcharged energy drinks]"),
            next_topic = "TALK_HUNTER_DOCTOR_SHARE_RAGE_DRINK",
            when = predicates.all({ predicates.has_item("speaker", "alchemy_recipe_blackout_rage_drink"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "shared_with_hunter_doctor_rage_drink" } })) }),
            actions = { actions.set_actor_value("speaker", "shared_with_hunter_doctor_rage_drink", "yes"), actions.handler("dlg_a_xedra_evolved_39dc5675bdd6") },
        },
        {
            text = ccb.content.text("[Show him your notes on precognition-inducing hallucinogens]"),
            next_topic = "TALK_HUNTER_DOCTOR_SHARE_LSD",
            when = predicates.all({ predicates.has_item("speaker", "alchemy_recipe_prophets_lsd"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "shared_with_hunter_doctor_prophets_lsd" } })) }),
            actions = { actions.set_actor_value("speaker", "shared_with_hunter_doctor_prophets_lsd", "yes"), actions.handler("dlg_a_xedra_evolved_39dc5675bdd6") },
        },
        {
            text = ccb.content.text("[Show him your notes on the elixir of life]"),
            next_topic = "TALK_HUNTER_DOCTOR_SHARE_LIFE_ELIXIR",
            when = predicates.all({ predicates.has_item("speaker", "alchemy_recipe_life_extension_potion"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "shared_with_hunter_doctor_life_extension_potion" } })) }),
            actions = { actions.set_actor_value("speaker", "shared_with_hunter_doctor_life_extension_potion", "yes"), actions.handler("dlg_a_xedra_evolved_39dc5675bdd6") },
        },
        {
            text = ccb.content.text("I'll buy some supplies."),
            next_topic = "TALK_HUNTER_DOCTOR",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Could you give me some supplies?"),
            next_topic = "TALK_HUNTER_DOCTOR",
            when = predicates.handler("dlg_p_xedra_evolved_0a508fa5baff"),
            actions = { "start_trade", actions.handler("dlg_a_xedra_evolved_9f27406266ec") },
        },
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

-- When hidding currently unavailable items will be added, sharing the aspirin and rage drink recipes will add the resulting items to his stock.  For now he has them in stock but won't let you buy them.
ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_DOCTOR_SHARE_ASPIRIN",
    line = {
        choices = {
            ccb.content.text("[Blaine copies the recipe on a paper sheet]  These painkillers will surely prove useful when someone will get injured.  Thanks."),
        },
    },
    replies = {
        { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_DOCTOR_SHARE_RAGE_DRINK",
    line = {
        choices = {
            ccb.content.text("[Blaine copies the recipe on a paper sheet]  This concoction should result in cardiac arrest, but if it doesn't it will give a boost to our hunters when needed.  Thanks."),
        },
    },
    replies = {
        { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_DOCTOR_SHARE_LSD",
    line = {
        choices = {
            ccb.content.text("[Blaine copies the recipe on a paper sheet]  What a complex ingredient list.  This would be hard to produce before <the_cataclysm>, but now it's beyond reasonable with the resources I got here.  Thanks anyway for sharing the recipe."),
        },
    },
    replies = {
        { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_DOCTOR_SHARE_LIFE_ELIXIR",
    line = {
        choices = {
            ccb.content.text("[Blaine copies the recipe on a paper sheet]  If it is true, the only ingredient I lack is elder ginseng.  Could you please bring me some?  This would be a favor I won't forget soon."),
        },
    },
    replies = {
        {
            text = ccb.content.text("I'll find some."),
            next_topic = "TALK_HUNTER_DOCTOR_FIND_GINSENG_ACCEPT",
            actions = { actions.assign_mission("MISSION_VAMPIRE_HUNTER_DOCTOR_FIND_GINSENG") },
        },
        {
            text = ccb.content.text("I'm not interested in doing that."),
            next_topic = "TALK_HUNTER_DOCTOR_FIND_GINSENG_REFUSE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_DOCTOR_FIND_GINSENG_ACCEPT",
    line = {
        choices = {
            ccb.content.text("Splendid!  With it, we will be one step closer of breaking the vampires' monopoly on agelessness!  Bring it here, and I'll prepare it for Leonard.  This rejuvenation will be very beneficial to his health and ability to flee this place alongside us if vampires or something else wreck it down."),
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_DOCTOR_FIND_GINSENG_REFUSE",
    line = {
        choices = {
            ccb.content.text("I get it.  Who wants to search for a needle of a plant in a state-wide haystack for little personal gain?  However, If you somehow find this elder ginseng I'll gladly buy it."),
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_DOCTOR_FIND_GINSENG_COMPLETE",
    line = {
        choices = {
            ccb.content.text("Thanks so much for this ginseng!  With it, I'll take less than an hour to make the potion.  We do not have more demand for elder ginseng for now, but I again thank you for this service."),
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_VAMPIRE_HUNTER_DOCTOR_FIND_GINSENG",
    name = ccb.content.text("Find some elder ginseng for Blaine"),
    goal = "MGOAL_CONDITION",
    description = ccb.content.text("Blaine needs elder ginseng for the life extension potion and has asked you to bring some to him."),
    difficulty = 7,
    value = 50000,
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = "",
        offer = "",
        accepted = "",
        rejected = "",
        advice = "",
        inquire = "",
        success = "",
        success_lie = "",
        failure = "",
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_DOCTOR",
    line = {
        choices = {
            {
            when = predicates.has_trait("speaker", "VAMPIRE"),
            yes = {
                choices = {
                    {
                    when = predicates.handler("w16b_p_xedra_evolved_952e7812cbf7"),
                    yes = ccb.content.text("I can give you some cure for your vampirism.  You helped us, so I'll help you in turn."),
                    no = ccb.content.text("Looking to buy the cure to your vampirism?  I would give it for free if I could, but its ingredients are so hard to find now.  Phyliss can help you if you're desperate."),
                },
                },
            },
            no = {
                choices = {
                    ccb.content.text("Welcome."),
                    ccb.content.text("Hello."),
                    ccb.content.text("Hi."),
                    ccb.content.text("You need something?"),
                },
            },
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("I have the ginseng you asked for."),
            next_topic = "TALK_HUNTER_DOCTOR_FIND_GINSENG_COMPLETE",
            when = predicates.all({ predicates.has_item("speaker", "xe_elder_ginseng"), predicates.any_equal({ "yes", { scope = "speaker", key = "shared_with_hunter_doctor_life_extension_potion" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "gave_hunter_doctor_elder_ginseng" } })) }),
            actions = { actions.transfer_items("xe_elder_ginseng"), actions.set_actor_value("speaker", "gave_hunter_doctor_elder_ginseng", "yes"), actions.finish_mission("MISSION_VAMPIRE_HUNTER_DOCTOR_FIND_GINSENG", { success = true }), actions.handler("w16b_a_xedra_evolved_11c9ecaecc8c") },
        },
        {
            text = ccb.content.text("[Show him your notes on aspirin improvement]"),
            next_topic = "TALK_HUNTER_DOCTOR_SHARE_ASPIRIN",
            when = predicates.all({ predicates.has_item("speaker", "alchemy_recipe_extra_str_aspirin"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "shared_with_hunter_doctor_aspirin" } })) }),
            actions = { actions.set_actor_value("speaker", "shared_with_hunter_doctor_aspirin", "yes"), actions.handler("w16b_a_xedra_evolved_3a02bfb200e3") },
        },
        {
            text = ccb.content.text("[Show him your notes on overcharged energy drinks]"),
            next_topic = "TALK_HUNTER_DOCTOR_SHARE_RAGE_DRINK",
            when = predicates.all({ predicates.has_item("speaker", "alchemy_recipe_blackout_rage_drink"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "shared_with_hunter_doctor_rage_drink" } })) }),
            actions = { actions.set_actor_value("speaker", "shared_with_hunter_doctor_rage_drink", "yes"), actions.handler("w16b_a_xedra_evolved_3a02bfb200e3") },
        },
        {
            text = ccb.content.text("[Show him your notes on precognition-inducing hallucinogens]"),
            next_topic = "TALK_HUNTER_DOCTOR_SHARE_LSD",
            when = predicates.all({ predicates.has_item("speaker", "alchemy_recipe_prophets_lsd"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "shared_with_hunter_doctor_prophets_lsd" } })) }),
            actions = { actions.set_actor_value("speaker", "shared_with_hunter_doctor_prophets_lsd", "yes"), actions.handler("w16b_a_xedra_evolved_3a02bfb200e3") },
        },
        {
            text = ccb.content.text("[Show him your notes on the elixir of life]"),
            next_topic = "TALK_HUNTER_DOCTOR_SHARE_LIFE_ELIXIR",
            when = predicates.all({ predicates.has_item("speaker", "alchemy_recipe_life_extension_potion"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "shared_with_hunter_doctor_life_extension_potion" } })) }),
            actions = { actions.set_actor_value("speaker", "shared_with_hunter_doctor_life_extension_potion", "yes"), actions.handler("w16b_a_xedra_evolved_3a02bfb200e3") },
        },
        {
            text = ccb.content.text("I'll buy some cure.  [10$]"),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_xedra_evolved_e23f13094bcb"),
            actions = { actions.handler("w16b_a_xedra_evolved_d9fb058089f3") },
        },
        {
            text = ccb.content.text("I'd like to have some cure."),
            next_topic = "TALK_HUNTER_DOCTOR_GIVE_CURE",
            when = predicates.handler("w16b_p_xedra_evolved_bd4c4a567679"),
            actions = { actions.handler("w16b_a_xedra_evolved_067e0015be5d") },
        },
        {
            text = ccb.content.text("[30m] Could you patch me up?"),
            next_topic = "TALK_HUNTER_DOCTOR_AID_DONE",
            when = predicates.handler("w16b_p_xedra_evolved_952e7812cbf7"),
            actions = { "give_aid", actions.handler("w16b_a_xedra_evolved_79c405cd4be8") },
        },
        {
            text = ccb.content.text("[1h] Could you to patch my friends up?"),
            next_topic = "TALK_HUNTER_DOCTOR_AID_DONE",
            when = predicates.handler("w16b_p_xedra_evolved_dfec4b4de226"),
            actions = { "give_all_aid", actions.handler("w16b_a_xedra_evolved_fa5f4419f53a") },
        },
        {
            text = ccb.content.text("What's your role here?"),
            next_topic = "TALK_HUNTER_DOCTOR_INTRO",
        },
        {
            text = ccb.content.text("Do you have something to trade?"),
            next_topic = "TALK_HUNTER_DOCTOR",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Do you have some free things for me?"),
            next_topic = "TALK_HUNTER_DOCTOR",
            when = predicates.handler("w16b_p_xedra_evolved_952e7812cbf7"),
            actions = { "start_trade", actions.handler("w16b_a_xedra_evolved_cf46f00fa379") },
        },
        {
            text = ccb.content.text("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
