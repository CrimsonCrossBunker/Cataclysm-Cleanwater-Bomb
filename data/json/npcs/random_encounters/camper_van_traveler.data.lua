local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "traveler_camper_van",
    class = "NC_CAMPER_VAN_TRAVELER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_NPC_CAMPER_VAN_TRAVELER",
    faction = "no_faction",
}

ccb.content.define_npc_class {
    id = "NC_CAMPER_VAN_TRAVELER",
    name = ccb.content.text("Scavenger"),
    job_description = ccb.content.text("I'm just trying to survive."),
    traits = {
        { group = "BG_survival_story_EVACUEE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    common = false,
    price_rules = {
        { category = "food", premium = 2.5 },
        { item = "gasoline", premium = 2.5 },
        { item = "water_clean", premium = 2.5 },
    },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "pistol", bonus = { rng = { 2, 5 } } },
        { skill = "rifle", bonus = { rng = { 0, 3 } } },
        { skill = "archery", bonus = { rng = { 0, 3 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CAMPER_VAN_TRAVELER_EXODII_MISSION_WAREHOUSE",
    line = {
        joined = {
            ccb.content.text("&You describe the warehouse to the best of your ability.  <npc_name> considers for a moment"),
            {
            when = predicates.any_equal({ "no", { scope = "interlocutor", key = "exodii_mission_wh_correct" } }),
            yes = ccb.content.gendered_line(", then frowns.  \"I don't believe I've heard about anything like that, no.  Sorry.\"", { "interlocutor" }),
            no = ccb.content.text(", nodding along.  \"Yeah, I remember something like that a while back.  Pretty memorable building, I think it's what you're looking for.\""),
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

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CAMPER_VAN_TRAVELER_DESTINATION",
    line = {
        when = predicates.any_equal({ "north", { scope = "interlocutor", key = "dialogue_travel_direction_travel_direction" } }),
        yes = ccb.content.gendered_line("I'm going north, up towards the border and the big wide wilderness.  I heard that there's some sort of safe spot up there, where people didn't go crazy and try to kill each other.  I don't know whether or not that's true, but at the very least, the colder climate might help keep the <zombies> down.", { "interlocutor" }),
        no = {
            when = predicates.any_equal({ "south", { scope = "interlocutor", key = "dialogue_travel_direction_travel_direction" } }),
            yes = ccb.content.text("I'm going south.  Hopefully somebody down there fared better than the people I knew up here.  Besides, I won't have to worry about freezing my <freaking> butt off when winter comes."),
            no = {
                when = predicates.any_equal({ "east", { scope = "interlocutor", key = "dialogue_travel_direction_travel_direction" } }),
                yes = ccb.content.gendered_line("I'm going east, towards the coastline.  I heard some rumors that Rhode Island was still holding itself together, so I'm going to go and check that out.  Heck, I might just go out to sea myself, live on an old oil rig or something like that.", { "interlocutor" }),
                no = {
                    when = predicates.any_equal({ "west", { scope = "interlocutor", key = "dialogue_travel_direction_travel_direction" } }),
                    yes = ccb.content.text("I'm going west, see how things are out there in tumbleweed territory.  You see, the Midwest didn't have a whole lot of people in it compared the East Coast, so there logically shouldn't be as many <zombies> as there are here.  I just hope that everything hasn't collapsed, that someone's still holding on."),
                    no = ccb.content.text("ERROR: DIRECTION PARAMETERS EITHER NOT PICKED OR OUT OF BOUNDS"),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("When will you be leaving?"),
            next_topic = "TALK_NPC_CAMPER_VAN_TRAVELER_LEAVING_WHEN",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CAMPER_VAN_TRAVELER_LEAVING_WHEN",
    line = ccb.content.text("I'll be gone here in a day or two, just stopping long enough to get some supplies and fix anything wrong with the camper."),
    replies = { { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CAMPER_VAN_TRAVELER_TRADE",
    line = ccb.content.text("I don't have a whole lot, but I've got a few things that I could stand to be rid of, too much weight tanks the gas mileage.  I could always use more fuel, food, and clean water if you have any to spare.  Entertainment is also appreciated, it's pretty fucking boring looking at nothing but road for 10 hours a day."),
    replies = {
        {
            text = ccb.content.text("Let's take a look."),
            next_topic = "TALK_NPC_CAMPER_VAN_TRAVELER",
            native_actions = { "start_trade" },
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CAMPER_VAN_TRAVELER_INTERESTING_THINGS",
    line = {
        when = predicates.handler("dlg_p_dda_93de4f1e1331"),
        yes = ccb.content.gendered_line("I haven't found anything out of the ordinary, just a bunch of <zombies> and the ruins of our old lives.", { "interlocutor" }),
        no = {
            when = predicates.handler("dlg_p_dda_2fad9a32b6ea"),
            yes = ccb.content.gendered_line("Actually, I came across a group of farmers on my way here.  They were a little suspicious, but turned out to be pretty nice.  Good place to buy some food, if they're still around.", { "interlocutor" }),
            no = {
                when = predicates.handler("dlg_p_dda_ffef735f5e6b"),
                yes = ccb.content.gendered_line("I found a small cabin out in the woods, someone was living there and had some serious chemistry equipment.  I managed to get good medical supplies from there.  They even had some oddball things too, like fucking napalm and black powder.", { "interlocutor" }),
                no = {
                    when = predicates.handler("dlg_p_dda_c854bbaab2c0"),
                    yes = ccb.content.gendered_line("I ran in to someone living in an old barn, didn't want anything to do with the world.  The odd thing is, they looked like one of those old, Wild West cowboys.", { "interlocutor" }),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("How do I get to that farm?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_DIRECTIONS_2",
            when = predicates.handler("dlg_p_dda_965ef3fae5ff"),
            actions = { actions.set_actor_value("interlocutor", "camper_van_traveler_mission_directions", "isherwood"), actions.assign_mission("directions_isherwood_traveler") },
            switch = true,
        },
        {
            text = ccb.content.text("How do I get to that cabin?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_DIRECTIONS_2",
            when = predicates.handler("dlg_p_dda_730976137644"),
            actions = { actions.set_actor_value("interlocutor", "camper_van_traveler_mission_directions", "chem_chabin"), actions.assign_mission("directions_cabin") },
            switch = true,
        },
        {
            text = ccb.content.text("Where were they at?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_DIRECTIONS_2",
            when = predicates.handler("dlg_p_dda_676606e9ce0a"),
            actions = { actions.set_actor_value("interlocutor", "camper_van_traveler_mission_directions", "cowboy"), actions.assign_mission("directions_cowboy") },
            switch = true,
        },
        {
            text = ccb.content.text("Ah, that's nothing new to me.  Thanks anyway though."),
            next_topic = "TALK_NPC_CAMPER_VAN_TRAVELER",
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("<end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}

-- This should also be included as part of a randomly selected list of backgrounds in the future.
ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CAMPER_VAN_TRAVELER_BACKSTORY",
    line = ccb.content.gendered_line("I used to travel a lot before <the_cataclysm>, and I've had this camper with me for a while now.  I was at home when the riots started, so I grabbed everything I could from my house and hopped in the camper.  I nearly wrecked on my way out of town when some crazy people tried to smash my van, but I made it out.  I've been on the move ever since.", { "interlocutor" }),
    replies = { { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" } },
}

ccb.content.define_mission {
    id = "directions_isherwood_traveler",
    name = ccb.content.text("Check out that farm"),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = {
        target = { special = "Isherwood Farm Mutable", terrain = "farm_isherwood_1", reveal_radius = 5 },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("."),
        offer = ccb.content.text("."),
        accepted = ccb.content.text("."),
        rejected = ccb.content.text("."),
        advice = ccb.content.text("Be careful.  Seems like a rough place to me."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Sweet."),
        success_lie = ccb.content.text("Sweet."),
        failure = ccb.content.text("That's unfortunate."),
    },
}

ccb.content.define_mission {
    id = "directions_cabin",
    name = ccb.content.text("Check out that cabin"),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = { target = { terrain = "chemical_lab_ocu", special = "Occupied Chem Lab", reveal_radius = 5 } },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("."),
        offer = ccb.content.text("."),
        accepted = ccb.content.text("."),
        rejected = ccb.content.text("."),
        advice = ccb.content.text("Be careful.  Seems like a rough place to me."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Sweet."),
        success_lie = ccb.content.text("Sweet."),
        failure = ccb.content.text("That's unfortunate."),
    },
}

ccb.content.define_mission {
    id = "directions_cowboy",
    name = ccb.content.text("Check out that desolate barn"),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = { target = { terrain = "desolatebarn", special = "desolate barn", reveal_radius = 5 } },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("."),
        offer = ccb.content.text("."),
        accepted = ccb.content.text("."),
        rejected = ccb.content.text("."),
        advice = ccb.content.text("Be careful.  Seems like a rough place to me."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Sweet."),
        success_lie = ccb.content.text("Sweet."),
        failure = ccb.content.text("That's unfortunate."),
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_NPC_CAMPER_VAN_TRAVELER", "TALK_NPC_CAMPER_VAN_TRAVELER_DESTINATION", "TALK_NPC_CAMPER_VAN_TRAVELER_BACKSTORY", "TALK_NPC_CAMPER_VAN_TRAVELER_LEAVING_WHEN" },
    replies = {
        {
            text = ccb.content.text("Do you have anything that you'd like to sell?"),
            next_topic = "TALK_NPC_CAMPER_VAN_TRAVELER_TRADE",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        },
        {
            text = ccb.content.text("I'd like to ask you a few questions."),
            next_topic = "TALK_FRIEND_CONVERSATION",
            when = predicates.handler("w16b_p_dda_b49f7ca57e70"),
        },
        {
            text = ccb.content.text("I'm looking for a specific, strange building.  I wonder if you've heard anything about it?"),
            next_topic = "TALK_NPC_CAMPER_VAN_TRAVELER_EXODII_MISSION_WAREHOUSE",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }), predicates.has_mission("EXODII_MISSION_WAREHOUSE"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "asked_about_exodii_warehouse_mission" } })) }),
            actions = { actions.handler("w16b_a_dda_9812bef589e2") },
        },
        {
            text = ccb.content.text("Where did you say you were going again?"),
            next_topic = "TALK_NPC_CAMPER_VAN_TRAVELER_DESTINATION",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_NPC_CAMPER_VAN_TRAVELER_BACKSTORY",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        },
        {
            text = ccb.content.text("I'd like to ask you a few questions."),
            next_topic = "TALK_FRIEND_CONVERSATION",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        },
        {
            text = ccb.content.text("Have you found anything out of the ordinary out in the wastes?"),
            next_topic = "TALK_NPC_CAMPER_VAN_TRAVELER_INTERESTING_THINGS",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_camper_van_traveler_gave_directions" } })) }),
            actions = { actions.handler("w16b_a_dda_f1418abfd320"), actions.set_actor_value("interlocutor", "dialogue_camper_van_traveler_gave_directions", "yes") },
            switch = true,
        },
        {
            text = ccb.content.text("Have you found anything out of the ordinary out in the wastes?"),
            next_topic = "TALK_NPC_CAMPER_VAN_TRAVELER_INTERESTING_THINGS",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_camper_van_traveler_gave_directions" } }) }),
            switch = true,
            default = true,
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CAMPER_VAN_TRAVELER",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        yes = ccb.content.text("<greet>"),
        no = ccb.content.gendered_line("I didn't think anyone was around here.  Pleased to meet you, I'm <npc_name>.", { "interlocutor" }),
    },
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "dialogue_first_meeting_knows_u", "yes"), actions.handler("w16b_a_dda_8585463a3e0a") } },
    },
    replies = {
        {
            text = ccb.content.text("What's in that RV of yours?  Couldn't be anything you need, so hand over your stuff."),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } })),
            trial = { kind = "intimidate", difficulty = 30 },
            success = { next_topic = "TALK_WEAPON_DROPPED", actions = { "drop_weapon" }, opinion = { trust = -4, fear = 3 } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
        {
            text = ccb.content.text("Good to meet you too.  What are you doing out here?"),
            next_topic = "TALK_NPC_CAMPER_VAN_TRAVELER_DESTINATION",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } })),
        },
        {
            text = ccb.content.text("<end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}
