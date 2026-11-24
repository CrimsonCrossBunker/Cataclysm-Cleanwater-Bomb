local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- A survivor raising rabbits, all by themselves. Give special quests to give rabbits to player
ccb.content.define_npc {
    id = "warrener",
    unique_name = ccb.content.text("Mr. Lapin"),
    suffix = ccb.content.text("Warrener"),
    gender = "male",
    class = "NC_Rabbit_Raiser",
    attitude = 0,
    mission = "GUARD",
    missions_offered = "MISSION_Warrener_LOG_1",
    chat = "TALK_WARRENER",
    faction = "lapin",
}

-- This is a unique NPC who doesn't get randomly selected background traits
ccb.content.define_npc_class {
    id = "NC_Rabbit_Raiser",
    name = ccb.content.text("Mr. Lapin"),
    job_description = ccb.content.text("I raise rabbits."),
    common = false,
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "survival", bonus = { rng = { 1, 5 } } },
        { skill = "melee", bonus = { rng = { 2, 4 } } },
    },
    traits = {
        { "FLEET2", 100 },
        { "GOODHEARING", 100 },
        { "DEFT", 100 },
        { "ANIMALEMPATH2", 100 },
        { "LIGHTFUR", 100 },
        { "HOOVES", 100 },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WARRENER",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("Are you here to protect us?"),
        no = ccb.content.text("Pleased to meet you."),
    },
    replies = {
        {
            text = ccb.content.text("I'm just trying to get by."),
            next_topic = "TALK_WARRENER_TRYING",
        },
        { text = ccb.content.text("What are you doing here?"), next_topic = "TALK_WARRENER_DOING" },
        {
            text = ccb.content.text("Heard anything about the outside world?"),
            next_topic = "TALK_WARRENER_WORLD",
        },
        { text = ccb.content.text("You look different?"), next_topic = "TALK_WARRENER_MUTATION" },
        { text = ccb.content.text("Anything I can help with?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text("About that work…"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.assigned_missions(1, 1),
        },
        {
            text = ccb.content.text("About that work…"),
            next_topic = "TALK_MISSION_LIST_ASSIGNED",
            when = predicates.assigned_missions(2),
        },
        {
            text = ccb.content.text("Any jobs you need done?"),
            when = predicates.all({ predicates.negate(predicates.assigned_missions(1, 1)), predicates.negate(predicates.assigned_missions(2)) }),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("Do you need any resources?"),
            next_topic = "TALK_LAPIN_RESOURCES",
        },
        {
            text = ccb.content.text("Where did you get that giant firefly terrarium?"),
            next_topic = "TALK_LAPIN_FIREFLY",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WARRENER_TRYING",
    line = ccb.content.text("Getting by will do for now."),
    replies = { { text = ccb.content.text("I guess it has to."), next_topic = "TALK_WARRENER" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WARRENER_DOING",
    line = ccb.content.text("I raise my rabbits, I seem to have more in common with them every day."),
    replies = { { text = ccb.content.text("Well, then…"), next_topic = "TALK_WARRENER" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WARRENER_WORLD",
    line = ccb.content.text("People come to me to learn how to keep rabbits.  They learn and they go.  I like to think I'm making the world better."),
    replies = {
        { text = ccb.content.text("…"), next_topic = "TALK_WARRENER" },
        {
            text = ccb.content.text("Anyone nearby I should meet?"),
            next_topic = "TALK_WARRENER_ISHERWOOD",
        },
        {
            text = ccb.content.text("That sounds optimistic?"),
            next_topic = "TALK_WARRENER_WORLD_OPTIMISTIC",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WARRENER_ISHERWOOD",
    line = ccb.content.text("There is a family of nearby farmers that I trade with.  I'd appreciate it if you could go check on them."),
    replies = {
        {
            text = ccb.content.text("Seems like a deal to me."),
            next_topic = "TALK_WARRENER_ISHERWOOD_MISSION_ACCEPTED",
            actions = { actions.offer_mission("MISSION_Warrener_ISHERWOOD") },
        },
        {
            text = ccb.content.text("That seems rather dangerous, I think I'll pass."),
            next_topic = "TALK_WARRENER",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WARRENER_ISHERWOOD_MISSION_ACCEPTED",
    line = ccb.content.text("It can be quite a hike depending on your transportation.  Lot of bad news between here and there."),
    replies = {
        { text = ccb.content.text("Don't worry, I'll be careful."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("Just a walk in the woods."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WARRENER_WORLD_OPTIMISTIC",
    line = ccb.content.text("If I teach one hundred people how to raise rabbits, that's potentially a hundred communities given food and fur before those people teach anyone else."),
    replies = {
        {
            text = ccb.content.text("That's the most hopeful thing I've heard so far."),
            next_topic = "TALK_WARRENER",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LAPIN_FIREFLY",
    line = ccb.content.text("A traveler brought this to me in return for some rabbits.  Said that he'd gotten it from a scientist out in the swamps but it took up too much space in his car."),
    replies = { { text = ccb.content.text("It's quite unique!"), next_topic = "TALK_WARRENER" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WARRENER_MUTATION",
    line = {
        when = predicates.has_any_trait("speaker", { "CANINE_EARS", "LUPINE_EARS", "FELINE_EARS", "URSINE_EARS", "ELFA_EARS", "LIGHTFUR" }),
        yes = ccb.content.text("Same way you got yours, I bet."),
        no = ccb.content.text("CRISPR?  Radiation?  Something in the water?  Maybe it was bunnies."),
    },
    replies = {
        { text = ccb.content.text("So it goes."), next_topic = "TALK_WARRENER" },
        {
            text = ccb.content.text("You're disgusting."),
            next_topic = "TALK_WARRENER_MUTATION_INSULT",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WARRENER_MUTATION_INSULT",
    line = {
        when = predicates.has_any_trait("speaker", { "CANINE_EARS", "LUPINE_EARS", "FELINE_EARS", "URSINE_EARS", "ELFA_EARS", "LIGHTFUR" }),
        yes = ccb.content.text("I'm very sorry to tell you this, but you should look in a mirror."),
        no = ccb.content.text("Insulting people who could help you is unlikely to aid survival."),
    },
    replies = {
        {
            text = ccb.content.text("…"),
            success = {
                native_actions = { "end_conversation" },
                opinion = { trust = -1, fear = -2, value = -1, anger = 1 },
                next_topic = "TALK_DONE",
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LAPIN_RESOURCES",
    line = ccb.content.text("The bunnies and I love adding some diversity to the menu and I always need materials for patching fences."),
    repeat_replies = {
        {
            items = {
                "log", "2x4", "wood_panel", "wood_sheet", "material_sand", "clay_lump", "nail",
                "lc_wire", "apple", "banana", "orange", "blueberries", "strawberries", "raspberries",
                "huckleberries", "mulberries", "plums", "carrot", "cabbage", "lettuce", "onion",
            },
            reply = { text = ccb.content.text("Delivering <topic_item>."), next_topic = "TALK_DELIVER_ASK" },
        },
    },
    replies = {
        {
            text = ccb.content.text("That's all for now.  <done_conversation_section>"),
            next_topic = "TALK_WARRENER",
        },
        {
            text = ccb.content.text("That's all for now.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_Warrener_LOG_1",
    name = ccb.content.text("Timber!"),
    description = ccb.content.text("Bring five logs."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 1,
    value = 0,
    item = "log",
    item_count = 5,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_Warrener_FOOD_2",
    dialogue = {
        describe = ccb.content.text("I need 5 logs for fences."),
        offer = ccb.content.text("I need to build fences and ditches around my rabbits.  Could you find about… five logs for me?"),
        accepted = ccb.content.text("Don't forget to tell me when you have them."),
        rejected = ccb.content.text("It's okay, I can do without them.  Just let me know if you reconsider."),
        advice = ccb.content.text("There's a lot of places to look.  Trees are pretty common."),
        inquire = ccb.content.text("How is the search going?  Have you found 'em?"),
        success = ccb.content.text("I really appreciate your help.  Don't worry, you won't leave empty-handed."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("Don't worry about it, it's not that important."),
    },
    finish = { item_rewards = { { item = "cattlefodder", count = 2 } } },
}

ccb.content.define_mission {
    id = "MISSION_Warrener_FOOD_2",
    name = ccb.content.text("Sweets"),
    description = ccb.content.text("Find 25 blackberries."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 0,
    item = "blackberries",
    item_count = 25,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("I need 25 blackberries."),
        offer = ccb.content.text("Fruits would let me break the monotony of grains and meats."),
        accepted = ccb.content.text("Thanks for accepting this task.  Otherwise I might kill a stranger for some oranges.  Just kidding."),
        rejected = ccb.content.text("Just let me know if you change your mind."),
        advice = ccb.content.text("Find someone growing berries or an orchard."),
        inquire = ccb.content.text("Have you found the fruit?"),
        success = ccb.content.text("Thank you for your help.  Here's your reward."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("It's not a big deal, it isn't that urgent."),
    },
    finish = { item_rewards = { { item = "petpack", count = 1 } } },
}

ccb.content.define_mission {
    id = "MISSION_Warrener_ISHERWOOD",
    name = ccb.content.text("Visit the Isherwoods"),
    description = ccb.content.text("There is a family nearby that I'd like you to check in on.  After you talk to all of them, come back to me and tell me how they are doing."),
    goal = "MGOAL_CONDITION",
    difficulty = 3,
    start = {
        target = { terrain = "farm_isherwood_2", special = "Isherwood Farm Mutable", reveal_radius = 3 },
    },
    value = 5000,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("Have you checked on them?"),
        success = ccb.content.text("Good, that's one less thing to worry about."),
        success_lie = ccb.content.text("I'm glad to hear they are fine.  Why haven't they been by then?"),
        failure = ccb.content.text("At least you came back with your life…"),
    },
    complete_when = "complete_mission_warrener_isherwood",
}
