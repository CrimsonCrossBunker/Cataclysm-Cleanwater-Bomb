local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "tacoma_PabloNunez",
    unique_name = ccb.content.text("Pablo Nunez"),
    gender = "male",
    suffix = ccb.content.text("bookkeeper"),
    class = "NC_TACOMA_Pablo",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_TACOMA_Pablo_1",
    age = 28,
    height = 184,
    strength = 10,
    dexterity = 8,
    intelligence = 10,
    perception = 10,
    personality = { aggression = 1, bravery = 3, collector = 1, altruism = 3 },
    faction = "free_merchants",
}

-- Pablo is a young professional who survived with his wife, but she was pregnant and lost the baby.
ccb.content.define_npc_class {
    id = "NC_TACOMA_Pablo",
    name = ccb.content.text("Bookkeeper"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    worn = "TACOMA_Pablo_worn",
    carry = "TACOMA_Pablo_carried",
    weapon = "TACOMA_Pablo_wield",
    traits = {
        { trait = "QUICK" },
        { trait = "Exp_Bookkeeping1" },
        { trait = "SKIN_MEDIUM" },
        { trait = "eye_color", variant = "brown" },
        { trait = "hair_short", variant = "black" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        { skill = "bashing", bonus = 3 },
        { skill = "computer", bonus = 4 },
        { skill = "cooking", bonus = 1 },
        { skill = "driving", bonus = 2 },
        { skill = "fabrication", bonus = 2 },
        { skill = "mechanics", bonus = 2 },
        { skill = "melee", bonus = 3 },
        { skill = "speech", bonus = 2 },
        { skill = "swimming", bonus = 1 },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Pablo_1",
    line = ccb.content.text("*looks up at you from a ledger, takes a moment to place you, then smiles broadly.  \"Great to see you, my friend.  To what do I owe the pleasure?\""),
    replies = {
        {
            text = ccb.content.text("Hi, Pablo!  How are things going here?"),
            next_topic = "TALK_TACOMA_Pablo_2",
        },
        {
            text = ccb.content.text("Hello, Pablo!  What's with the trailer?"),
            next_topic = "TALK_TACOMA_Pablo_Trailer1",
        },
        {
            text = ccb.content.text("Hey, Pablo!  I heard you might be willing to trade for propane?"),
            next_topic = "TALK_TACOMA_Pablo_Propane1",
            when = predicates.any_equal({ "knows", { scope = "speaker", key = "knowledge_propane_scavenging" } }),
        },
        {
            text = ccb.content.text("Hey, Pablo!  Dana said you had some plans to build a bakery?"),
            next_topic = "TALK_TACOMA_Pablo_Bakery1",
            when = predicates.any_equal({ "knows", { scope = "speaker", key = "knowledge_tacoma_bakery" } }),
        },
        {
            text = ccb.content.text("Just popping in to say hi.  Talk to you later!"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Pablo_2",
    line = ccb.content.text("Can't complain,\" he stretches his neck and pops his shoulder.  \"No, really, I can't.  The work is hard, but people here really want to *do* something, not just hide inside and hope someone saves us.  I've been helping doing general labor a bit, but also working out an inventory system for our supplies.  It's already helped us get a few important bits in earlier than we'd have noticed otherwise.  Post-apocalyptic accounting, ha!  Who'd have thought?"),
    replies = {
        {
            text = ccb.content.text("Keeping inventory is similar to accounting?  Really?"),
            next_topic = "TALK_TACOMA_Pablo_Accounting1",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Pablo_Accounting1",
    line = ccb.content.text("If you want the honest truth, only a bit.  It's not much like filing income tax.  Still, I know my way around a spreadsheet and I don't mind staring at numbers all day.  I think people were dubious at first, but now that it's starting to show real value they're coming around."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Pablo_Trailer1",
    line = ccb.content.text("Oh, Dana tells that story better than me.  Basically we found it at an old trailer park and she liked the bakery, so we figured out a way to get it back here.  We definitely earned some cred for coming with our own shelter."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Pablo_Bakery1",
    line = ccb.content.text("Yeah, she would say that.\"  He makes intense eye contact.  \"Not just a bakery, my friend.  A real, post apocalyptic, honest-to-god culinary experience!  We're planning to grow food and crops here.  Central's plan is to import our crops directly, and pay us for our work.  I don't think they've even thought much about transport, outside just shipping them back home.  If we do local site processing we can prevent storage losses, and make higher value material to sell out!  And Central still benefits from having a dedicated bread basket!"),
    replies = {
        {
            text = ccb.content.text("Do you know anything about building a 'culinary experience'?"),
            next_topic = "TALK_TACOMA_Pablo_Bakery2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Pablo_Bakery2",
    line = ccb.content.text("I'm being a bit tongue-in-cheek there.  Really I want some big wood fired ovens, tools for milling grain, tinning and canning equipment, stuff like that.  We'll make flour, jam, pickles, bread, maybe some sauerkraut and things.  All the old school ways of preserving food, from before fridges were commonplace."),
    replies = {
        {
            text = ccb.content.text("Okay, but do you know anything about that?"),
            next_topic = "TALK_TACOMA_Pablo_Bakery3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Pablo_Bakery3",
    line = ccb.content.text("Well…\" he tugs jokingly at his collar as though letting off steam.  \"I know a bit.  I used to make pickles and jams as a hobby.  With my mom.  When I was a teenager.  But I know the principles!  And Dana knows more than you'd think about grain and flour because she's a huge nerd for her craft.  We do have some knowledge gaps between design and implementation though."),
    replies = {
        { text = ccb.content.text("What kind of gaps?"), next_topic = "TALK_TACOMA_Pablo_Bakery4" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Pablo_Bakery4",
    line = ccb.content.text("Not where you might think.\"  He sets aside his ledger and pulls out a page of bullet-point notes written in neat block letters.  \"Everyone is on board with the idea and the amount of actual building to get it online is small enough that the carpenters are willing to help out, so I don't need any assistance with design.  For the really short term I basically just need materials.  I've been collecting spare wood, but to get a good wood-fired oven I need to secure a source of firebrick.  In the longer run, Dana knows the principles of milling, but I need a resource book if I want to set up a functioning mill, first a muscle-powered one and then a windmill for long term.  I wish I'd thought of asking Jenny.  She's a mechanical engineer, but she would probably know how to get me started at least.  I'm also still looking into how to make a good vermin-proof cellar.  Longer term, I will need to work my way around our reliance on sugar, salt, and vinegar from before the Cataclysm, but our stocks of those will hold out for months while I sort things out."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "message_jenny_tacoma_mill", "known"),
                actions.set_actor_value("speaker", "firebricks_tacoma_bakery", "known"),
                actions.set_actor_value("speaker", "rootcellar_tacoma_bakery", "known"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Pablo_Bakery-Firebricks1",
    line = ccb.content.gendered_line("Seriously?  You've already done so much.  I won't say no, though.", { "speaker" }),
    on_enter = {
        { actions = { actions.offer_mission("MISSION_TACOMA_Pablo_Firebricks"), actions.set_actor_value("speaker", "firebricks_tacoma_bakery", "helped") } },
    },
    replies = {
        {
            text = ccb.content.text("No problem.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Well, I'd better go look into that."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Pablo_Bakery-Engineer1",
    line = ccb.content.text("I… I honestly don't know why I didn't think of that.  I could even have asked the supply caravans to do it.  If it comes down to it though, I trust you more than them.  Would you mind?"),
    on_enter = {
        {
            actions = {
                actions.assign_mission("MISSION_TACOMA_Pablo_Message"),
                actions.set_actor_value("speaker", "message_jenny_tacoma_mill", "helped"),
            },
        },
    },
    replies = {
        { text = ccb.content.text("Sure.  <done_conversation_section>"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Sure, I'll see what I can do."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Pablo_Bakery-RootCellar1",
    line = ccb.content.text("Oh… oh, ok!  It's a good thing you showed me this, my basic guesses missed some important points.  Thanks, this will be helpful for a lot more than just the bakery."),
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "rootcellar_tacoma_bakery", "helped") },
        },
    },
    replies = {
        {
            text = ccb.content.text("No problem.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("Any time!  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_TACOMA_Pablo_2", "TALK_TACOMA_Pablo_Trailer1", "TALK_TACOMA_Pablo_Accounting1", "TALK_TACOMA_Pablo_Bakery1", "TALK_TACOMA_Pablo_Bakery-Firebricks1", "TALK_TACOMA_Pablo_Bakery-Engineer1", "TALK_TACOMA_Pablo_Bakery-RootCellar1" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("I heard you might be willing to trade for propane?"),
            next_topic = "TALK_TACOMA_Pablo_Propane1",
            when = predicates.any_equal({ "knows", { scope = "speaker", key = "knowledge_propane_scavenging" } }),
        },
        {
            text = ccb.content.text("Dana said you had some plans to build a bakery?"),
            next_topic = "TALK_TACOMA_Pablo_Bakery1",
            when = predicates.any_equal({ "knows", { scope = "speaker", key = "knowledge_tacoma_bakery" } }),
        },
        {
            text = ccb.content.text("I don't mind keeping my eye out for some firebricks for you."),
            next_topic = "TALK_TACOMA_Pablo_Bakery-Firebricks1",
            when = predicates.all({ predicates.any_equal({ "known_deleted", { scope = "speaker", key = "firebricks_tacoma_bakery" } }), predicates.negate(predicates.any_equal({ "helped", { scope = "speaker", key = "firebricks_tacoma_bakery" } })) }),
        },
        {
            text = ccb.content.text("I can pass a note to Jenny about helping with the mill designs, if you want."),
            next_topic = "TALK_TACOMA_Pablo_Bakery-Engineer1",
            when = predicates.all({ predicates.any_equal({ "known_deleted", { scope = "speaker", key = "message_jenny_tacoma_mill" } }), predicates.negate(predicates.any_equal({ "helped", { scope = "speaker", key = "message_jenny_tacoma_mill" } })) }),
        },
        {
            text = ccb.content.text("[Survival 4, Fabrication 4] I know how to build a good root cellar.  Here, let me show you."),
            next_topic = "TALK_TACOMA_Pablo_Bakery-RootCellar1",
            when = predicates.handler("dlg_p_dda_2a7e7eb6a6b0"),
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_TACOMA_Pablo_Firebrick",
    name = ccb.content.text("Get Pablo some fire bricks."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 1000,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    item = "fire_brick",
    item_count = 20,
    dialogue = {
        describe = ccb.content.text("Find some fire bricks to help Pablo build an oven."),
        offer = ccb.content.text("n/a"),
        accepted = ccb.content.text("n/a"),
        rejected = ccb.content.text("n/a"),
        advice = ccb.content.text("n/a"),
        inquire = ccb.content.text("n/a"),
        success = ccb.content.text("n/a"),
        success_lie = ccb.content.text("n/a"),
        failure = ccb.content.text("n/a"),
    },
}

ccb.content.define_mission {
    id = "MISSION_TACOMA_Pablo_Message",
    name = ccb.content.text("Pass a message to Jenny Forcette."),
    goal = "MGOAL_NULL",
    difficulty = 2,
    value = 1000,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Ask Jenny Forcette if she can help Pablo Nunez with his mill designs."),
        offer = ccb.content.text("n/a"),
        accepted = ccb.content.text("n/a"),
        rejected = ccb.content.text("n/a"),
        advice = ccb.content.text("n/a"),
        inquire = ccb.content.text("n/a"),
        success = ccb.content.text("n/a"),
        success_lie = ccb.content.text("n/a"),
        failure = ccb.content.text("n/a"),
    },
}
