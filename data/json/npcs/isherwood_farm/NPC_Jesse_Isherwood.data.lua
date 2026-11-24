local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Horse trainer for the Isherwood family.
ccb.content.define_npc {
    id = "isherwood_jesse",
    unique_name = ccb.content.text("Jesse Isherwood"),
    gender = "female",
    class = "NC_ISHERWOOD_JESSE",
    attitude = 0,
    mission = "GUARD",
    age = 43,
    height = 168,
    strength = 7,
    dexterity = 9,
    intelligence = 8,
    perception = 9,
    personality = { aggression = 2, bravery = 4, collector = 1, altruism = 3 },
    chat = "TALK_ISHERWOOD_JESSE",
    missions_offered = "MISSION_ISHERWOOD_JESSE_1",
    faction = "isherwood_family",
}

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_JESSE",
    name = ccb.content.text("Jesse Isherwood"),
    job_description = ccb.content.text("I'm a horse trainer, part of the Isherwood family"),
    traits = {
        { trait = "WEAKSTOMACH" },
        { trait = "ANTIJUNK" },
        { trait = "ANIMALEMPATH" },
        { trait = "SKIN_PINK" },
        { trait = "eye_color", variant = "blue" },
        { trait = "hair_ponytail", variant = "brown" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    worn = "NC_Isherwood_female_worn",
    weapon = "NC_ISHERWOOD_rifle",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "speech", bonus = { rng = { 6, 9 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "survival", bonus = { rng = { 3, 6 } } },
        { skill = "gun", bonus = { rng = { 3, 6 } } },
        { skill = "rifle", bonus = { rng = { 4, 6 } } },
        { skill = "archery", bonus = { rng = { 4, 6 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_JESSE",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("Leave our property, Marshal."),
        no = ccb.content.text("Hello.  We don't see many people these days."),
    },
    replies = {
        {
            text = ccb.content.text("Yeah, I'm a Marshal, what are you going to do about it?"),
            next_topic = "TALK_LEAVE_NOW_MARSHAL",
            actions = { "hostile" },
            opinion = { trust = -20, value = -20 },
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_LEAVE_NOW_MARSHAL",
            opinion = { trust = -20, value = -20 },
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("Hi, it looks like you are doing well here."),
            next_topic = "TALK_ISHERWOOD_JESSE_TALK1",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
            actions = { actions.set_actor_value("speaker", "u_met_Jesse_Isherwood", "yes") },
        },
        {
            text = ccb.content.text("Hi, Jack and Claire suggested I come down here and meet you."),
            next_topic = "TALK_MET_JACK_CLAIRE",
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_Jack_Isherwood" } }) }),
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_JESSE_TALK1",
    line = ccb.content.text("It would be a lot harder without family.  Keeping the animals safe is essential to our future."),
    replies = {
        {
            text = ccb.content.text("Sounds like you are betting on civilization not coming back."),
            next_topic = "TALK_ISHERWOOD_JESSE_OPINION",
        },
        {
            text = ccb.content.text("Do you have any animal care tips?"),
            next_topic = "TALK_ISHERWOOD_JESSE_TIPS",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JESSE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_JESSE_OPINION",
    line = ccb.content.text("We can't wait for someone else to fix things, we need to take care of ourselves."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JESSE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_JESSE_TIPS",
    line = ccb.content.text("Horses make good all around companions.  They can get places that cars can't and also help when all the engines fail.  They become very trusting if you feed them some nice fodder."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JESSE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MET_JACK_CLAIRE",
    line = ccb.content.text("Oh good, I'm sure Jack wanted to put you to work.  If you're interested, I could use a hand clearing out the woods.  My son, Chris has his hands full trying to keep the predators under control."),
    replies = {
        {
            text = ccb.content.text("I'd like to speak with Carlos too about some work."),
            next_topic = "TALK_JESSE_CARLOS1",
        },
        {
            text = ccb.content.text("Is Chris around?  I'd like to know what he's run into out in the woods."),
            next_topic = "TALK_JESSE_CHRIS",
        },
        { text = ccb.content.text("What needs killing?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JESSE_TOPICS",
        },
        {
            text = ccb.content.text("I'm not interested right now.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_JESSE_CARLOS1",
    line = ccb.content.text("He's out back in the workshop."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JESSE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_JESSE_CHRIS",
    line = ccb.content.text("He's out doing some surveying, we are planning on adding a fence line and some defenses."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JESSE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_JESSE_CARLOS2",
    line = ccb.content.text("Carlos will be in his workshop if he isn't out hunting.  He is trying to get a forge set up."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JESSE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LEAVE_NOW_MARSHAL",
    line = ccb.content.text("You should get off my farm, I won't deal with a government stooge."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_JESSE_TOPICS",
    line = ccb.content.text("Go on…"),
    replies = {
        {
            text = ccb.content.text("Looks like you are doing well here."),
            next_topic = "TALK_ISHERWOOD_JESSE_TALK1",
        },
        {
            text = ccb.content.text("Do you have any animal care tips?"),
            next_topic = "TALK_ISHERWOOD_JESSE_TIPS",
        },
        {
            text = ccb.content.text("Jack and Claire suggested I come talk to you."),
            next_topic = "TALK_MET_JACK_CLAIRE",
        },
        {
            text = ccb.content.text("I'd like to speak with Carlos too about some work."),
            next_topic = "TALK_JESSE_CARLOS2",
        },
        { text = ccb.content.text("Is Chris around?"), next_topic = "TALK_JESSE_CHRIS" },
        { text = ccb.content.text("Can I do anything for you?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_JESSE_1",
    name = ccb.content.text("Kill wolves"),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 5,
    value = 50000,
    followup = "MISSION_ISHERWOOD_JESSE_2",
    start = {
        target = { terrain = "forest_thick", reveal_radius = 1, random = true, min_distance = 8 },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        { id = "mon_wolf", pack_size = { 4, 8 }, x = 3, y = 9, target = true },
                    },
                },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("We could use some help killing some wolves."),
        offer = ccb.content.text("There's been some wolves that keep scaring our chickens and horses, I'd be grateful if you can kill them."),
        accepted = ccb.content.text("Wonderful, let me know when it is done."),
        rejected = ccb.content.text("Thanks anyway, we will try some traps."),
        advice = ccb.content.text("A gun will probably help."),
        inquire = ccb.content.text("Did you kill it?"),
        success = ccb.content.text("I appreciate it, I've got this old saddle I want you to have.  I'll be happy to put a horse under it if you want to do some more heroics."),
        success_lie = ccb.content.text("Show me the bodies."),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = { item_rewards = { { item = "horse_tack", count = 1 } } },
}

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_JESSE_2",
    name = ccb.content.text("Kill monsters"),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 8,
    value = 80000,
    start = {
        target = { terrain = "forest_thick", reveal_radius = 1, random = true, min_distance = 15 },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        { id = "mon_flying_polyp", pack_size = { 3, 6 }, x = 11, y = 11, target = true },
                    },
                },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("We could use some help killing some monsters."),
        offer = ccb.content.text("We could use some help killing a pack of monsters.  I don't know what they are, but they're very fast, I'm willing to outfit you with a horse if you succeed."),
        accepted = ccb.content.text("Be ready for anything."),
        rejected = ccb.content.text("Thanks anyway, we will try some traps."),
        advice = ccb.content.text("A gun will probably help."),
        inquire = ccb.content.text("Did you kill it?"),
        success = ccb.content.text("I appreciate it, this will help keep our animals safe.  This is, Steve, he's a good, steady horse.  You should talk to Carlos about some armor for him."),
        success_lie = ccb.content.text("Show me the bodies."),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        actions = {
            ccb.content.dialogue_actions.purchase_pet("mon_horse", { count = 1, name = ccb.content.text("Steve") }),
            ccb.content.dialogue_actions.set_actor_value("speaker", "u_did_jesse_missions", "yes"),
        },
    },
}
