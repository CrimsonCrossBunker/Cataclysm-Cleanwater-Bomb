local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Dairy farmer of the Isherwood family.
-- Brother of Carlos, BIL of Jesse.  Uncle of Lisa and Chris, father of Luke.  Son of Claire and Jack, nephew of Barry.
ccb.content.define_npc {
    id = "isherwood_eddie",
    unique_name = ccb.content.text("Eddie Isherwood"),
    gender = "male",
    class = "NC_ISHERWOOD_EDDIE",
    attitude = 0,
    mission = "GUARD",
    age = 41,
    height = 179,
    strength = 9,
    dexterity = 7,
    intelligence = 7,
    perception = 8,
    personality = { aggression = -4, bravery = -1, collector = 1, altruism = 1 },
    chat = "TALK_ISHERWOOD_EDDIE",
    missions_offered = "MISSION_ISHERWOOD_EDDIE_1",
    faction = "isherwood_family",
}

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_EDDIE",
    name = ccb.content.text("Eddie Isherwood"),
    job_description = ccb.content.text("I'm a dairy farmer, part of the Isherwood family"),
    traits = {
        { trait = "ASTHMA" },
        { trait = "JITTERY" },
        { trait = "OPTIMISTIC" },
        { trait = "SKIN_TAN" },
        { trait = "eye_color", variant = "hazel" },
        { trait = "hair_short", variant = "black" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    perception = { one_in = 4 },
    worn = "NC_Isherwood_male_worn",
    weapon = "NC_ISHERWOOD_rifle",
    shop_groups = "NC_ISHERWOOD_EDDIE_misc",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "speech", bonus = { rng = { 2, 4 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "survival", bonus = { rng = { 3, 6 } } },
        { skill = "gun", bonus = { rng = { 3, 6 } } },
        { skill = "rifle", bonus = { rng = { 4, 8 } } },
        { skill = "archery", bonus = { rng = { 4, 8 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ISHERWOOD_EDDIE", "TALK_ISHERWOOD_EDDIE_ConvincedMarshal" },
    replies = {
        {
            text = ccb.content.text("Nice dairy, must be tough keeping it running."),
            next_topic = "TALK_ISHERWOOD_EDDIE_TALK1",
            actions = {
                actions.set_actor_value("speaker", "u_met_Eddie_Isherwood", "yes"),
                actions.set_actor_value("speaker", "u_met_an_isherwood", "yes"),
            },
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
        {
            text = ccb.content.text("Have anything to trade?"),
            next_topic = "TALK_ISHERWOOD_EDDIE",
            actions = { "start_trade" },
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
        {
            text = ccb.content.text("When will your cows produce again?"),
            next_topic = "TALK_ISHERWOOD_EDDIE_RESTOCK",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_EDDIE",
    line = {
        joined = {
            ccb.content.text("*is a sun-worn, middle-aged man with crows feet and graying hair.  He looks up as you approach, "),
            {
                when = predicates.wears("speaker", "badge_marshal"),
                yes = ccb.content.text("then sneers as he spots the Old Guard Marshal badge gleaming on your chest.  \"I already told your kind not to come around here.  You need to keep on walking, straight off this property.\""),
                no = {
                    when = predicates.actor_state("speaker", "male"),
                    yes = ccb.content.text("then gives you a little greeting wave.  \"Hello Sir, what brings you here?\""),
                    no = ccb.content.text("then gives you a little greeting wave.  \"Hello Ma'am, what brings you here?\""),
                },
            },
        },
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
            text = ccb.content.text("…[Leave.]"),
            next_topic = "TALK_DONE",
            opinion = { trust = -20, value = -20 },
            actions = { actions.set_first_topic("TALK_ISHERWOOD_EDDIE_SawMarshal") },
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("Luke said you guys have some issues with the Old Guard.  What's up with that?"),
            next_topic = "TALK_ISHERWOOD_EDDIE_Marshal",
            when = predicates.all({ predicates.any_equal({ "known", { scope = "speaker", key = "isherwood_luke_marshal_questions" } }), predicates.negate(predicates.wears("speaker", "badge_marshal")) }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_EDDIE_SawMarshal",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("*glares at your marshal badge.  \"I said, keep *walking*, G-man.\""),
        no = ccb.content.text("*spits on the ground, glancing at where your marshal badge would have been, and shaking his head.  \"Nice try.  You can take off the badge, but I know what you are, I'm not some country rube.  Get out.\""),
    },
    replies = {
        {
            text = ccb.content.text("<color_green>[Social 3]</color> I swear, I'm not here to cause trouble.  I just volunteer with those guys to help travelers, things like that.  I don't speak for them."),
            next_topic = "TALK_ISHERWOOD_EDDIE_MarshalOff_Convince",
            when = predicates.handler("dlg_p_dda_35ada2d8d64b"),
        },
        {
            text = ccb.content.text("<color_yellow>[Social <3]</color> I took it off man, what more do you want from me?"),
            next_topic = "TALK_ISHERWOOD_EDDIE_MarshalOff_GoAway",
            when = predicates.handler("dlg_p_dda_76314c46821c"),
        },
        {
            text = ccb.content.text("Fine, I'm gone."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_EDDIE_ConvincedMarshal",
    line = {
        joined = {
            ccb.content.text("*looks up warily as you approach"),
            {
                when = predicates.wears("speaker", "badge_marshal"),
                yes = ccb.content.text(", looking at your marshal badge immediately.  \"Nope.  Agreement or not, I'm not talking to you while you're wearing their sign, and I don't appreciate the disrespect.\""),
                no = ccb.content.text(", his eyes darting to the spot where your marshal badge would be.  \"What now?\""),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("…[Leave.]"),
            next_topic = "TALK_DONE",
            opinion = { trust = -10, value = -10 },
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("What's the deal with you and the Old Guard, anyway?"),
            next_topic = "TALK_ISHERWOOD_EDDIE_Marshal",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_EDDIE_Marshal",
    line = ccb.content.text("*spits on the ground.  \"Didn't much care for the government and the cops before everything happened, care for them quite a bit less now.  We've had a run-in or two with the folks calling themselves the 'Old Guard'.  That's all I care to say about it.  They'll never be welcome on my land and I don't believe for a second that they didn't cause all this in the first place.\""),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_EDDIE_TOPICS",
        },
        {
            text = ccb.content.text("Thanks for telling me.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_EDDIE_MarshalOff_Convince",
    line = ccb.content.text("*grimaces.  \"Fine, I'll give you a chance, but you don't mess with me or my family, you understand?  This is our land, not yours.  Or theirs.\""),
    on_enter = { { actions = { actions.set_first_topic("TALK_ISHERWOOD_EDDIE_ConvincedMarshal") } } },
    replies = {
        {
            text = ccb.content.text("Thanks for hearing me out."),
            next_topic = "TALK_ISHERWOOD_EDDIE_TOPICS",
        },
        {
            text = ccb.content.text("Thanks.  I'll give you space for now."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_EDDIE_MarshalOff_GoAway",
    line = ccb.content.text("I feel like maybe you didn't hear me right.  Get.  Off.  My.  Land."),
    replies = {
        {
            text = ccb.content.text("You can't make me."),
            next_topic = "TALK_LEAVE_NOW_MARSHAL",
            native_actions = { "hostile" },
            opinion = { trust = -20, value = -20 },
        },
        {
            text = ccb.content.text("…[Leave.]"),
            next_topic = "TALK_DONE",
            opinion = { trust = -20, value = -20 },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_EDDIE_Marshal",
    line = ccb.content.text("*spits on the ground.  \"Didn't much care for the government and the cops before everything happened, care for them quite a bit less now.  We've had a run-in or two with the folks calling themselves the 'Old Guard'.  That's all I care to say about it.  They'll never be welcome on my land and I don't believe for a second that they didn't cause all this in the first place.\""),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_EDDIE_TOPICS",
        },
        {
            text = ccb.content.text("Thanks for telling me.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_EDDIE_RESTOCK",
    line = ccb.content.text("If the cows don't get anything nasty it should be around <restock_time_point>."),
    replies = { { text = ccb.content.text("Cheers, bye."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_EDDIE_TALK1",
    line = ccb.content.text("I run this dairy with my son, Luke.  It's been a tough job keeping the herd together, hasn't left a lot of time for other projects."),
    replies = {
        {
            text = ccb.content.text("I heard about Barry, such a tragedy.  Can you tell me more about what happened?"),
            next_topic = "TALK_ISHERWOOD_EDDIE2",
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_learned_barry_missing" } }) }),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_EDDIE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_EDDIE2",
    line = ccb.content.text("*speaks in a quiet monotone, like he's reading off a page.  \"Barry and Carlos went to hunt down something that killed our livestock, they tracked it into the forest.  It grabbed Barry and ran off, you might be able to get Carlos to tell you the story, if he can bring himself to share what happened.\""),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_EDDIE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_JACK_CLAIRE",
    line = ccb.content.text("Yeah, I could use some help getting materials.  I want to outfit that old building across the road with some kilns.  We want to make our own jars and pottery so we aren't dependent on scavenging."),
    replies = {
        {
            text = ccb.content.text("That is a good idea, what do you need?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_EDDIE_TOPICS",
        },
        {
            text = ccb.content.text("I'm not interested right now.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EDDIE_LUKE",
    line = ccb.content.text("Luke was going to start college this year, now everything is upside down.  He is adaptable though, had an idea to begin manufacturing our own jars and pottery.  He's out in the old outbuilding right now, cleaning up the place."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "u_heard_about_luke", "yes") } } },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_EDDIE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EDDIE_JESSE",
    line = ccb.content.text("Jesse manages the horses and other livestock, she is amazing with animals."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_EDDIE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EDDIE_CARLOS",
    line = ccb.content.text("Carlos will be in his workshop if he isn't out hunting.  He is trying to get a forge set up."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "u_learned_about_forge", "yes") } } },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_EDDIE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_EDDIE_TOPICS",
    line = ccb.content.text("Go on…"),
    replies = {
        {
            text = ccb.content.text("Your son helps with the dairy?"),
            next_topic = "TALK_EDDIE_LUKE",
        },
        {
            text = ccb.content.text("So, Jesse runs the horse farm?"),
            next_topic = "TALK_EDDIE_JESSE",
        },
        { text = ccb.content.text("Where can I find Carlos?"), next_topic = "TALK_EDDIE_CARLOS" },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_ISHERWOOD_EDDIE",
            native_actions = { "start_trade" },
        },
        { text = ccb.content.text("Can I do anything for you?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_EDDIE_1",
    name = ccb.content.text("Gather 120 Rocks"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "rock",
    item_count = 120,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_ISHERWOOD_EDDIE_2",
    dialogue = {
        describe = ccb.content.text("We need to build some kilns."),
        offer = ccb.content.text("I could use 120 rocks to construct some kilns."),
        accepted = ccb.content.text("You can break up some larger stones, or gather them up from the fields."),
        rejected = ccb.content.text("Thanks anyway, we'll find the time to get them ourselves."),
        advice = ccb.content.text("Mining would always be an option if you had the resources."),
        inquire = ccb.content.text("Do you have the stone?"),
        success = ccb.content.text("I appreciate it, this will make Luke happy."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        map_updates = {
            {
                terrain = "rural_outbuilding",
                layout = {
                    nested = { { x = 0, y = 0, id = "isherwood_outbuilding_kilns" } },
                    tile_edits = {
                        { shape = "point", operation = "furniture", id = "f_kiln_empty", x = 8, y = 13 },
                        { shape = "point", operation = "furniture", id = "f_forge_rock", x = 9, y = 6 },
                        { shape = "point", operation = "furniture", id = "f_clay_kiln", x = 7, y = 6 },
                    },
                },
            },
        },
        item_rewards = {
            { item = "meat_smoked", count = 12 },
            { item = "milk", count = 12, container = "jar_3l_glass_sealed" },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_EDDIE_2",
    name = ccb.content.text("Gather 2000 units of sand"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 3,
    value = 20000,
    item = "material_sand",
    item_count = 2000,
    followup = "MISSION_ISHERWOOD_EDDIE_3",
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        item_rewards = {
            { item = "butter", count = 6 },
            { item = "milk", count = 12, container = "jar_3l_glass_sealed" },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I do have some resource gathering I could use help with."),
        offer = ccb.content.text("Now that the forge is set up, we could use 2000 units of sand to get production going."),
        accepted = ccb.content.text("Thank you."),
        rejected = ccb.content.text("Oh well.  I'll try to find time to get it myself, thanks."),
        advice = ccb.content.text("You can find it along river banks, or maybe landscaping supplies and hardware stores."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Thanks, now Luke can get started.  Here's a token of my thanks."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("I wonder where all the sand went…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_EDDIE_3",
    name = ccb.content.text("Gather 100 units of clay"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 3,
    value = 20000,
    item = "clay_lump",
    item_count = 100,
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = {
        actions = {
            ccb.content.dialogue_actions.set_actor_value("speaker", "u_did_eddie_missions", "yes"),
            { item = "rope_6", count = 1 },
            ccb.content.dialogue_actions.purchase_pet("mon_cow", { count = 1, name = ccb.content.text("Daisy") }),
            { item = "cattlefodder", count = 3 },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I do have some resource gathering I could use help if you have time."),
        offer = ccb.content.text("Now that the clay kiln is set up, we could use 100 units of clay to get production going."),
        accepted = ccb.content.text("Thank you."),
        rejected = ccb.content.text("Oh well.  I'll try to find time to get it myself, thanks."),
        advice = ccb.content.text("You can find it along river banks, or maybe look for deposits in the forest."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Thanks, now Luke can get started making jugs, We'd like to give you a cow, Here's Daisy, take good care of her and she'll provide you with milk."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("I wonder where all the sand went…"),
    },
}
