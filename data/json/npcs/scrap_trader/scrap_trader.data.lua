local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "NPC_scrap_trader",
    class = "SCRAP_MERCHANT",
    gender = "male",
    suffix = ccb.content.text("scrapper"),
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_NPC_SCRAP_TRADER",
    faction = "wasteland_scavengers",
    missions_offered = "MISSION_SCRAP_TRADER_GET_25_MAGNETRON",
}

ccb.content.define_npc_class {
    id = "SCRAP_MERCHANT",
    name = ccb.content.text("Merchant"),
    job_description = ccb.content.text("I'm a local shopkeeper."),
    common = false,
    sells_belongings = false,
    strength = 4,
    traits = {
        { group = "BG_survival_story_RURAL" },
        { group = "Appearance_demographics" },
        { trait = "STRONGBACK" },
        { trait = "OUTDOORSMAN" },
        { trait = "STRONGSTOMACH" },
        { trait = "PAINRESIST" },
        { trait = "NIGHTVISION" },
        { trait = "QUICK" },
        { trait = "GOODCARDIO" },
        { trait = "TOUGH" },
        { trait = "ADRENALINE" },
        { trait = "NARCOLEPTIC" },
        { trait = "PROJUNK" },
        { trait = "MOODSWINGS" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 1, 2 } }, { constant = -1 } } } },
        { skill = "unarmed", bonus = { rng = { 0, 3 } } },
        { skill = "bashing", bonus = { rng = { 0, 3 } } },
        { skill = "melee", bonus = { rng = { 0, 3 } } },
        { skill = "dodge", bonus = { rng = { 0, 3 } } },
        { skill = "rifle", bonus = { rng = { 2, 5 } } },
        { skill = "gun", bonus = { rng = { 2, 5 } } },
        { skill = "fabrication", bonus = { rng = { 2, 5 } } },
        { skill = "mechanics", bonus = { rng = { 6, 8 } } },
        { skill = "driving", bonus = { rng = { 5, 6 } } },
        { skill = "swimming", bonus = { rng = { 3, 5 } } },
        { skill = "survival", bonus = { rng = { 0, 3 } } },
        { skill = "cooking", bonus = { rng = { 3, 5 } } },
    },
    worn = "SCRAP_MERCHANT_worn",
    weapon = "SCRAP_MERCHANT_weapon",
    carry = "SCRAP_MERCHANT_carried",
    shop_groups = {
        { id = "SCRAPPER_Shop", rigid = true },
        {
            id = "SCRAPPER_Shop_Specialty_Metals",
            rigid = true,
            condition_handler = "scrapper_specialty_metals_unlocked",
        },
        {
            id = "no_sell",
            rigid = true,
            refusal = ccb.content.text("<npcname> will never sell this"),
            condition_handler = "shopkeeper_stock_override_enabled",
        },
        { id = "fridges_and_freezers_tradeable" },
    },
    consumption_rates = "basic_shop_rates",
    price_rules = {
        { item = "scrap", price = 200, fixed_adjustment = 0 },
        { item = "nuts_bolts", price = 500, fixed_adjustment = 0 },
        { item = "sheet_metal_small", price = 400, fixed_adjustment = 0 },
        { item = "lc_steel_chunk", price = 400, fixed_adjustment = 0 },
        { item = "lc_steel_lump", price = 600, fixed_adjustment = 0 },
        { item = "sheet_metal", price = 500, fixed_adjustment = 0 },
        { item = "lc_steel_lump", price = 1200, fixed_adjustment = 0 },
        { item = "mc_steel_lump", price = 1600, fixed_adjustment = 0 },
        { item = "scrap_aluminum", price = 30, fixed_adjustment = 0 },
        { item = "hc_steel_lump", price = 2000, fixed_adjustment = 0 },
        { item = "scrap_bronze", price = 500, fixed_adjustment = 0 },
        { item = "bismuth", price = 2000, fixed_adjustment = 0 },
        { item = "zinc_metal", price = 2000, fixed_adjustment = 0 },
        { item = "lead", price = 2400, fixed_adjustment = 0 },
        { item = "scrap_copper", price = 140, fixed_adjustment = 0 },
        { item = "tin", price = 3600, fixed_adjustment = 0 },
        { item = "magnesium", price = 2000, fixed_adjustment = 0 },
        { item = "silver_small", price = 5600, fixed_adjustment = 0 },
        { item = "gold_small", price = 20000, fixed_adjustment = 0 },
        { item = "platinum_small", price = 30000, fixed_adjustment = 0 },
        { group = "fridges_and_freezers_tradeable", markup = 50 },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_NPC_SCRAP_TRADER_INTRO", "TALK_NPC_SCRAP_TRADER_STORY", "TALK_NPC_SCRAP_TRADER_FORT" },
    replies = {
        {
            text = ccb.content.text("I'd like to ask you a few questions."),
            next_topic = "TALK_FRIEND_CONVERSATION",
            when = predicates.handler("dlg_p_dda_2c514690302b"),
        },
        {
            text = ccb.content.text("Can I buy anything?"),
            next_topic = "TALK_SCRAP_TRADER_BULK_SELL",
        },
        {
            text = ccb.content.text("Any jobs you need done?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.all({ predicates.negate(predicates.assigned_missions(1, 1)), predicates.negate(predicates.assigned_missions(2)) }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_SCRAP_TRADER",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        yes = ccb.content.text("Hello there.  Nice to see you, <name_g>."),
        no = ccb.content.text("Haven't seen another face in quite a while.  Not a living one, at least.  State your business.  Maybe you got some use for some of this scrap metal?"),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "dialogue_first_meeting_knows_u", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you."),
            next_topic = "TALK_NPC_SCRAP_TRADER_INTRO",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } })),
        },
        {
            text = ccb.content.text("Hands up, <name_b>!"),
            trial = { kind = "intimidate", difficulty = 30 },
            success = {
                next_topic = "TALK_WEAPON_DROPPED",
                actions = { "drop_weapon" },
                opinion = { trust = -4, fear = 3 },
            },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } })),
        },
        {
            text = ccb.content.text("Pleasure to see you again, <name_g>."),
            next_topic = "TALK_NPC_SCRAP_TRADER_INTRO",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_SCRAP_TRADER_STORY",
    line = {
        when = predicates.has_trait("interlocutor", "BGSS_No_Past_2"),
        yes = ccb.content.text("I know I worked in salvage, but I don't remember much else about it.  I just remember finding this place and deciding to stay here."),
        no = {
            when = predicates.has_trait("interlocutor", "BGSS_No_Past_3"),
            yes = ccb.content.text("I know I worked in salvage, but I don't remember much else about it.  I just remember finding this place and deciding to stay here."),
            no = ccb.content.text("Well, I held a modest job here as a scrap yard worker.  Business was fair most days, but when <the_cataclysm> hit, I decided to head out here.  With all the craziness going on in the cities and whatnot, I decided to just stay here for while.  I figure someone might find a use for the leftover metal lying around, so I started selling it to anyone who passed by."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Why stay here of all places?"),
            next_topic = "TALK_NPC_SCRAP_TRADER_FORT",
        },
        { text = ccb.content.text("Hmm."), next_topic = "TALK_NONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_SCRAP_TRADER_FORT",
    line = {
        when = predicates.has_trait("interlocutor", "BGSS_No_Past_2"),
        yes = ccb.content.text("Well, this place had some barbed wire, metalworking tools, and plenty of supplies.  I made the walls myself.  I didn't know of anywhere else to go either."),
        no = {
            when = predicates.has_trait("interlocutor", "BGSS_No_Past_3"),
            yes = ccb.content.text("Well, this place had some barbed wire, metalworking tools, and plenty of supplies.  I made the walls myself.  I didn't know of anywhere else to go either."),
            no = ccb.content.text("Like I said, I came out here when the dead got pissed off.  This place had some barbed wire, metalworking tools, and plenty of stuff to make weapons out of.  Even the walls are my own making."),
        },
    },
    replies = {
        { text = ccb.content.text("Interesting."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text("Think I could stay here?"),
            next_topic = "TALK_NPC_SCRAP_TRADER_HOME_STAY",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_SCRAP_TRADER_INTRO",
    line = ccb.content.text("Do you need something?"),
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_NPC_SCRAP_TRADER_STORY",
        },
        {
            text = ccb.content.text("Why stay here of all places?"),
            next_topic = "TALK_NPC_SCRAP_TRADER_FORT",
        },
        {
            text = ccb.content.text("I'm looking for a specific, strange building.  I wonder if you've come across it in your travels?"),
            next_topic = "TALK_NPC_SCRAP_TRADER_EXODII_MISSION_WAREHOUSE",
            when = predicates.all({ predicates.has_mission("EXODII_MISSION_WAREHOUSE"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "asked_about_exodii_warehouse_mission" } })) }),
            actions = { actions.handler("w16b_a_dda_9812bef589e2") },
        },
        {
            text = ccb.content.text("Nah, see ya."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_SCRAP_TRADER_HOME_STAY",
    line = ccb.content.text("Sure, I'm fine with it.  There's a spare bed in the shed next door for anyone who needs it.  Just don't hog it.  Someone else might come along."),
    replies = {
        {
            text = ccb.content.text("Thanks, <name_g>."),
            next_topic = "TALK_NPC_SCRAP_TRADER_INTRO",
            actions = { actions.handler("dlg_a_dda_ce94fef0571f") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_SCRAP_TRADER_EXODII_MISSION_WAREHOUSE",
    line = {
        joined = {
            ccb.content.text("&You describe the warehouse to the best of your ability.  The scrap trader nods along, listening"),
            {
            when = predicates.any_equal({ "no", { scope = "interlocutor", key = "exodii_mission_wh_correct" } }),
            yes = ccb.content.text(", then shrugs.  \"No, sorry, not ringing any bells.\""),
            no = ccb.content.text(", then raises one eyebrow.  \"Not making any promises, but I did catch just a glimpse of a weird building one time that might be what you're looking for.\""),
        },
        },
    },
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "asked_about_exodii_warehouse_mission", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Oh well.  Thanks anyway.  I'll go ask around."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "no", { scope = "interlocutor", key = "exodii_mission_wh_correct" } }),
            actions = { actions.handler("dlg_a_dda_399f0cdb5f50") },
        },
    },
}

-- this is all the dialogue related to buying bulk metal or scrap.
ccb.content.define_dialogue_topic {
    id = "TALK_SCRAP_TRADER_BULK_SELL",
    line = {
        choices = { ccb.content.text("Sure thing.  I've got a few things on hand.  What'll ya have?") },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Let's take a look at your stock."),
            next_topic = "TALK_SCRAP_TRADER_BULK_SELL_END",
            native_actions = { "start_trade" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCRAP_TRADER_BULK_SELL_END",
    line = { choices = { ccb.content.text("Anything else you need?") } },
    replies = {
        { text = ccb.content.text("No, that's all."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("Find anything good?"),
            next_topic = "TALK_SCRAP_TRADER_ASK_INTERVAL",
        },
        {
            text = ccb.content.text("Can I have another look?"),
            next_topic = "TALK_SCRAP_TRADER_BULK_SELL_END",
            native_actions = { "start_trade" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCRAP_TRADER_ASK_INTERVAL",
    line = ccb.content.text("Nope, although I have a really good claim by the river.  Gonna go fetch them soon, be right back after <restock_time_point>."),
    replies = { { text = ccb.content.text("Well, good luck."), next_topic = "TALK_NPC_SCRAP_TRADER" } },
}
