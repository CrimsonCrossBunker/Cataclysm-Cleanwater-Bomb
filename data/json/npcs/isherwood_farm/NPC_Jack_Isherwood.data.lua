local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Patriarch of the Isherwood family.
ccb.content.define_npc {
    id = "isherwood_jack",
    unique_name = ccb.content.text("Jack Isherwood"),
    gender = "male",
    class = "NC_ISHERWOOD_JACK",
    attitude = 0,
    mission = "GUARD",
    age = 73,
    height = 184,
    chat = "TALK_ISHERWOOD_JACK",
    missions_offered = "MISSION_ISHERWOOD_JACK_1",
    faction = "isherwood_family",
}

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_JACK",
    name = ccb.content.text("Jack Isherwood"),
    job_description = ccb.content.text("I'm the patriarch of the Isherwood family"),
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    perception = { one_in = 4 },
    worn = "NC_Isherwood_male_worn",
    weapon = "NC_ISHERWOOD_rifle",
    shop_groups = "NC_ISHERWOOD_JACK_misc",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "speech", bonus = { rng = { 2, 4 } } },
        { skill = "gun", bonus = { rng = { 4, 8 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "survival", bonus = { rng = { 3, 6 } } },
        { skill = "pistol", bonus = { rng = { 3, 6 } } },
        { skill = "rifle", bonus = { rng = { 4, 8 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_JACK",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("Is that a U.S. Marshal's badge you're wearing?"),
        no = ccb.content.gendered_line("Hello traveler, what brings you here?", { "speaker" }),
    },
    replies = {
        {
            text = ccb.content.text("Yes, I'm a marshal."),
            next_topic = "TALK_LEAVE_NOW_MARSHAL_JACK",
            actions = { "hostile" },
            opinion = { trust = -20, value = -20 },
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_LEAVE_NOW_MARSHAL_JACK",
            opinion = { trust = -20, value = -20 },
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("I'm here to deliver some resources."),
            next_topic = "TALK_ISHERWOOD_JACK_RESOURCES",
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_scavenge_for_Jack_Isherwood" } }) }),
        },
        {
            text = ccb.content.text("This is a lot of land, you been here since the collapse?"),
            next_topic = "TALK_ISHERWOOD_JACK_TALK1",
            actions = {
                actions.set_actor_value("speaker", "u_met_Jack_Isherwood", "yes"),
                actions.set_actor_value("speaker", "u_met_an_isherwood", "yes"),
            },
        },
        {
            text = ccb.content.text("Hey, good to see you again."),
            next_topic = "TALK_ISHERWOOD_JACK_TOPICS",
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_Jack_Isherwood" } }) }),
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
        {
            text = ccb.content.text("Have anything to trade?"),
            next_topic = "TALK_ISHERWOOD_JACK",
            actions = { "start_trade" },
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
        {
            text = ccb.content.text("Hey, when would more of this stuff be ready?"),
            next_topic = "TALK_ISHERWOOD_JACK_RESTOCK",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_JACK_RESTOCK",
    line = ccb.content.text("Around <restock_time_point>."),
    replies = { { text = ccb.content.text("Alright then, bye."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_JACK_TALK1",
    line = ccb.content.text("I live here with my wife, this is our family's land.  My daughter's family and son live down the road."),
    replies = {
        {
            text = ccb.content.text("Your whole family survived?"),
            next_topic = "TALK_ISHERWOOD_JACK2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JACK_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_JACK2",
    line = ccb.content.text("We've had our losses… now we stay close to home, preparing for trouble.  We've always taken disaster preparedness seriously, but we didn't expect anything like this though."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JACK_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_JACK_FARM",
    line = ccb.content.text("Even out here we've had some attacks and seen… other things.  We have been working on our defenses, but it takes time.  We've been able to keep up with the crops and animals though so we won't have to risk our necks for supplies."),
    replies = {
        {
            text = ccb.content.text("What sort of defenses do you want?"),
            next_topic = "TALK_FARM_DEFENSE",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JACK_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FARM_DEFENSE",
    line = ccb.content.text("We want to put up more fencing and build some look out spots, maybe lay some traps for the monsters.  We could use some extra resources.  If you want to bring me logs, sand, clay, wire, nails, wood planks, and metal chunks, I'll give you signed chits you can use to buy goods from any of the family."),
    replies = {
        {
            text = ccb.content.text("Sounds reasonable, I'll see what I can do."),
            next_topic = "TALK_NONE",
            actions = { actions.set_actor_value("speaker", "u_scavenge_for_Jack_Isherwood", "yes") },
        },
        {
            text = ccb.content.text("I'm not interested right now.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_JACK_WIFE",
    line = ccb.content.text("Claire and I have been together for 40 years now, couldn't run this place without her.  She's quite the herbalist too, been real useful lately.  She is probably in the house, you should stop in."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "u_learned_claire_herbalist", "yes") } } },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JACK_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_JACK_DAUGHTER",
    line = ccb.content.text("Jesse and her family live up at the horse farm.  Her husband, Carlos, may have some jobs for you."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "u_learned_about_jesse", "yes") } } },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JACK_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_JACK_BROTHER",
    line = ccb.content.text("Eddie's dairy is at the end of the road.  It's just him and his son since Barry was taken by that thing in the woods."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "u_learned_about_eddie", "yes") } } },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JACK_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LEAVE_NOW_MARSHAL_JACK",
    line = ccb.content.text("You should get off my land, the government proved its incompetence with this catastrophe."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_JACK_TOPICS",
    line = ccb.content.text("Go on…"),
    replies = {
        {
            text = ccb.content.text("I'm here to deliver some resources."),
            next_topic = "TALK_ISHERWOOD_JACK_RESOURCES",
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_scavenge_for_Jack_Isherwood" } }) }),
        },
        {
            text = ccb.content.text("A farm must be a pretty safe place these days."),
            next_topic = "TALK_JACK_FARM",
        },
        {
            text = ccb.content.text("Tell me about your wife, is she around?"),
            next_topic = "TALK_JACK_WIFE",
        },
        {
            text = ccb.content.text("Your daughter lives down the road?"),
            next_topic = "TALK_JACK_DAUGHTER",
        },
        {
            text = ccb.content.text("Where is your brother's place?"),
            next_topic = "TALK_JACK_BROTHER",
        },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_ISHERWOOD_JACK",
            native_actions = { "start_trade" },
        },
        { text = ccb.content.text("Can I do anything for you?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_JACK_RESOURCES",
    line = ccb.content.text("Excellent.  What've you brought us?"),
    repeat_replies = {
        {
            items = {
                "log", "2x4", "wood_panel", "wood_sheet", "material_sand", "clay_lump", "nail",
                "lc_wire", "rock", "lc_steel_chunk", "mc_steel_chunk", "hc_steel_chunk",
                "ch_steel_chunk", "qt_steel_chunk", "lc_steel_lump", "mc_steel_lump", "hc_steel_lump",
                "ch_steel_lump", "qt_steel_lump",
            },
            reply = { text = ccb.content.text("Delivering <topic_item>."), next_topic = "TALK_DELIVER_ASK" },
        },
    },
    replies = {
        {
            text = ccb.content.text("That's all for now.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("That's all for now.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_JACK_1",
    name = ccb.content.text("Find 10 3 L jars"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 3,
    value = 20000,
    item = "jar_3l_glass_sealed",
    item_count = 10,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_ISHERWOOD_JACK_2",
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = { item_rewards = { { item = "veggy_pickled", count = 12, container = "jar_3l_glass_sealed" } } },
    dialogue = {
        describe = ccb.content.text("I could use some help scavenging."),
        offer = ccb.content.text("We could use some 3 liter jars to preserve our produce.  Can you bring me 10 large three liter jars?  I'll give you some preserves in exchange."),
        accepted = ccb.content.text("Thank you.  It's important to preserve foods while we can."),
        rejected = ccb.content.text("Oh well.  I'll see if I can find another way, thanks."),
        advice = ccb.content.text("Grocery stores, house kitchens, there's plenty of places to look."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Wow, perfect.  Thanks.  Here's your reward."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("I wonder where all the jars went…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_JACK_2",
    name = ccb.content.text("Find 100 wheat seeds"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 3,
    value = 20000,
    item = "seed_wheat",
    item_count = 100,
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = {
        handler = "mark_u_did_jack_missions",
        item_rewards = {
            { item = "tomato", count = 25 },
            { item = "onion", count = 25 },
            { item = "cucumber", count = 25 },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I do have some more scavenging for you."),
        offer = ccb.content.text("We could use some seeds for the next planting season.  Can you bring me 100 wheat seeds?  I'll give you some fresh produce."),
        accepted = ccb.content.text("Thank you.  It's important to preserve healthy foods while we can."),
        rejected = ccb.content.text("Oh well.  I'll see if I can find another supplier, thanks."),
        advice = ccb.content.text("Grocery stores, house kitchens, there's plenty of places to look."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Wow, perfect.  Thanks.  Here's your reward."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("I wonder where all the seeds went…"),
    },
}
