local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Matriarch of the Isherwood family.
ccb.content.define_npc {
    id = "isherwood_claire",
    unique_name = ccb.content.text("Claire Isherwood"),
    gender = "female",
    class = "NC_ISHERWOOD_CLAIRE",
    attitude = 0,
    mission = "GUARD",
    age = 67,
    height = 153,
    chat = "TALK_ISHERWOOD_CLAIRE",
    missions_offered = "MISSION_ISHERWOOD_CLAIRE_1",
    faction = "isherwood_family",
}

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_CLAIRE",
    name = ccb.content.text("Claire Isherwood"),
    job_description = ccb.content.text("I'm the matriarch of the Isherwood family"),
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    perception = { one_in = 4 },
    worn = "NC_Isherwood_female_worn",
    weapon = "NC_ISHERWOOD_rifle",
    shop_groups = "NC_ISHERWOOD_CLAIRE_misc",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "speech", bonus = { rng = { 2, 4 } } },
        { skill = "cooking", bonus = { rng = { 4, 8 } } },
        { skill = "firstaid", bonus = { rng = { 3, 6 } } },
        { skill = "survival", bonus = { rng = { 3, 6 } } },
        { skill = "pistol", bonus = { rng = { 3, 6 } } },
        { skill = "rifle", bonus = { rng = { 4, 8 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CLAIRE",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("Is that a U.S. Marshal's badge you're wearing?"),
        no = ccb.content.text("Hi, what brings you here?"),
    },
    replies = {
        {
            text = ccb.content.text("Yes, I'm a marshal."),
            next_topic = "TALK_LEAVE_NOW_MARSHAL_CLAIRE",
            opinion = { trust = -20, value = -20 },
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_LEAVE_NOW_MARSHAL_CLAIRE",
            opinion = { trust = -20, value = -20 },
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("Hi, nice farm you have here."),
            next_topic = "TALK_ISHERWOOD_CLAIRE_TALK1",
            actions = {
                actions.set_actor_value("speaker", "u_met_Claire_Isherwood", "yes"),
                actions.set_actor_value("speaker", "u_met_an_isherwood", "yes"),
            },
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
        {
            text = ccb.content.text("Hi, Jack suggested I stop by and say hello."),
            next_topic = "TALK_ISHERWOOD_CLAIRE_TALK3",
            actions = { actions.set_actor_value("speaker", "u_met_Claire_Isherwood", "yes") },
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_Jack_Isherwood" } }) }),
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
        {
            text = ccb.content.text("Let's trade."),
            actions = { "start_trade" },
            next_topic = "TALK_ISHERWOOD_CLAIRE",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
        {
            text = ccb.content.text("Hey, when would more of this stuff be ready?"),
            next_topic = "TALK_ISHERWOOD_CLAIRE_RESTOCK",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CLAIRE_RESTOCK",
    line = ccb.content.text("Around <restock_time_point>."),
    replies = { { text = ccb.content.text("Alright then, bye."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CLAIRE_TALK1",
    line = ccb.content.text("I live here with my husband, Jack.  He is working out in his shop."),
    replies = {
        {
            text = ccb.content.text("You are lucky to have your family still together."),
            next_topic = "TALK_ISHERWOOD_CLAIRE2",
        },
        {
            text = ccb.content.text("Must be nice, to have the quiet place amid so much madness."),
            next_topic = "TALK_CLAIRE_FARM",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CLAIRE2",
    line = ccb.content.text("You don't need as much luck if you are prepared and work together.  We've had our losses, my brother in law, Barry, was our best hunter but things are so different now…"),
    replies = {
        { text = ccb.content.text("What happened to Barry?"), next_topic = "TALK_BARRY" },
        {
            text = ccb.content.text("A farm must be a pretty safe place these days."),
            next_topic = "TALK_CLAIRE_FARM",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CLAIRE_TALK3",
    line = ccb.content.text("Well, nice to meet you.  I imagine Jack was boasting about my herbal remedies, he's proud of what we've put together here."),
    replies = {
        {
            text = ccb.content.text("He did mention you make remedies, are they effective?"),
            next_topic = "TALK_CLAIRE_MEDICINE",
        },
        {
            text = ccb.content.text("Must be nice, to have the quiet place amid so much madness."),
            next_topic = "TALK_CLAIRE_FARM",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CLAIRE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CLAIRE_MEDICINE",
    line = ccb.content.text("I have always studied and made some natural remedies, but now they are more essential than ever.  Who knows the next time we'll see a trained doctor.  These remedies aren't always as effective, but they can do the job in a pinch."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CLAIRE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BARRY",
    line = ccb.content.text("Some of their cows were killed before we realized what was happening, Barry and Carlos went into the forest to find the predator but it was like nothing they'd ever seen.  Carlos may be willing to tell you more."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CLAIRE_TOPICS",
            actions = { actions.set_actor_value("speaker", "u_learned_barry_missing", "yes") },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "u_learned_barry_missing", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CLAIRE_FARM",
    line = ccb.content.text("We've always tried to live a quiet life out here, I suppose we are doing better than most."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CLAIRE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CLAIRE_HUSBAND",
    line = ccb.content.text("Jack and I have been together for 40 years.  He's been my anchor through all of this chaos."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CLAIRE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CLAIRE_DAUGHTER",
    line = ccb.content.text("Jesse and her family live up at the horse farm.  They may have some jobs for you."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CLAIRE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CLAIRE_BROTHER",
    line = ccb.content.text("Eddie's dairy is at the end of the road.  He's may have some jobs for you if you are interested."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CLAIRE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LEAVE_NOW_MARSHAL_CLAIRE",
    line = ccb.content.text("You should get off our land, you have no business here."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CLAIRE_TOPICS",
    line = ccb.content.text("Ask away."),
    replies = {
        {
            text = ccb.content.text("Tell me about your husband, is he around?"),
            next_topic = "TALK_CLAIRE_HUSBAND",
        },
        {
            text = ccb.content.text("Your daughter lives down the road?"),
            next_topic = "TALK_CLAIRE_DAUGHTER",
        },
        {
            text = ccb.content.text("Where is your brother's place?"),
            next_topic = "TALK_CLAIRE_BROTHER",
        },
        {
            text = ccb.content.text("A farm must be a pretty safe place these days."),
            next_topic = "TALK_CLAIRE_FARM",
        },
        {
            text = ccb.content.text("You are lucky to have your family still together."),
            next_topic = "TALK_ISHERWOOD_CLAIRE2",
        },
        {
            text = ccb.content.text("Let's trade."),
            native_actions = { "start_trade" },
            next_topic = "TALK_ISHERWOOD_CLAIRE",
        },
        { text = ccb.content.text("Can I do anything for you?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_CLAIRE_1",
    name = ccb.content.text("Gather 50 dandelions"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 3,
    value = 20000,
    item = "raw_dandelion",
    item_count = 50,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_ISHERWOOD_CLAIRE_2",
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        item_rewards = {
            { item = "thyme_oil", count = 2, container = "jar_glass_sealed" },
            { item = "poppy_pain", count = 20, container = "jar_glass_sealed" },
        },
    },
    dialogue = {
        describe = ccb.content.text("I could use some help foraging ingredients."),
        offer = ccb.content.text("I could use some fresh dandelions for the next batch of wine.  Can you bring me 50 dandelions?"),
        accepted = ccb.content.text("Thank you, I'll put these to good use."),
        rejected = ccb.content.text("Oh well.  Maybe some other time, thanks."),
        advice = ccb.content.text("You can find them in the fields during the spring and summer months."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Thanks.  Here's a small reward to show my appreciation for your help."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("I wonder if the wildlife ate all the greens…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_CLAIRE_2",
    name = ccb.content.text("Find 20 bee balm seeds"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 3,
    value = 20000,
    item = "seed_bee_balm",
    item_count = 20,
    followup = "MISSION_ISHERWOOD_CLAIRE_3",
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = {
        item_rewards = {
            { item = "pine_tea", count = 2, container = "jar_glass_sealed" },
            { item = "royal_jelly", count = 1 },
            { item = "bee_balm_tea", count = 2, container = "jar_glass_sealed" },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I could use some seeds from the forest."),
        offer = ccb.content.text("We could use some seeds for the next planting season.  Can you bring me 20 bee balm seeds?"),
        accepted = ccb.content.text("Thank you.  It's important to have a good stock before the flu season hits."),
        rejected = ccb.content.text("Oh well.  Maybe some other time, thanks."),
        advice = ccb.content.text("You should search through the forest, make sure to check in the underbrush for bee balm and then harvest its seeds."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Wow, perfect.  Here are some of my own remedies and if those don't work try my other gift."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("I'll have to find someone more at home in the forest…"),
    },
}

-- om_special is a no-op here - we are already at 'Isherwood Farm Mutable'. I added it to suppress a linter false positive.
ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_CLAIRE_3",
    name = ccb.content.text("Find and capture a cat"),
    goal = "MGOAL_FIND_MONSTER",
    difficulty = 4,
    value = 100000,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    start = {
        target = {
            special = "Isherwood Farm Mutable",
            terrain = "cabin_isherwood",
            reveal_radius = 1,
            random = true,
            min_distance = 8,
        },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        { id = "mon_cat_isherwood", pack_size = { 3, 6 }, x = 20, y = 22, target = true },
                    },
                },
            },
        },
        item_rewards = { { item = "chicken_cage", count = 1 } },
    },
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = {
        handler = "mark_u_did_claire_missions",
        item_rewards = { { item = "isherwood_herbal_remedies", count = 1 } },
    },
    dialogue = {
        describe = ccb.content.text("I could use a barn cat to keep the mice down."),
        offer = ccb.content.text("I saw some feral cats out by the old cabin.  Can you capture one for me?"),
        accepted = ccb.content.text("Thank you!  Please hurry back!  Take this cage so you have a chance of capturing one."),
        rejected = ccb.content.text("I didn't want to use chemicals on these rats."),
        advice = ccb.content.text("Take this pet carrier; if you can get close to a cat, you can put it inside.  If you're having problems, try befriending it with cat food."),
        inquire = ccb.content.text("Have you found a cat?"),
        success = ccb.content.text("Thank you so much, I want you to have this copy of my natural remedy journal.  I'll name this handsome fellow Joshua."),
        success_lie = ccb.content.text("What?!  You're lying, I can tell!  Did you even bring back my cage?"),
        failure = ccb.content.text("Oh no!  I guess they are too nimble for you…"),
    },
}
