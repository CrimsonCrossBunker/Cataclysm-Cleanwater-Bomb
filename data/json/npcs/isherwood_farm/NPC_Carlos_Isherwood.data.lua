local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Dairy farmer the Isherwood family.
-- Brother of Eddie, husband of Jesse.  Father of Lisa and Chris, cousin of Luke.  Son of Claire and Jack, nephew of Barry.
ccb.content.define_npc {
    id = "isherwood_carlos",
    unique_name = ccb.content.text("Carlos Isherwood"),
    gender = "male",
    class = "NC_ISHERWOOD_CARLOS",
    attitude = 0,
    mission = "GUARD",
    age = 44,
    height = 176,
    strength = 9,
    dexterity = 8,
    intelligence = 7,
    perception = 9,
    personality = { aggression = -2, bravery = 4, collector = -2, altruism = -1 },
    chat = "TALK_ISHERWOOD_CARLOS",
    missions_offered = "MISSION_ISHERWOOD_CARLOS_1",
    faction = "isherwood_family",
}

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_CARLOS",
    name = ccb.content.text("Carlos Isherwood"),
    job_description = ccb.content.text("I'm Jesse's husband, part of the Isherwood family."),
    traits = {
        { trait = "NIGHTVISION" },
        { trait = "BADKNEES" },
        { trait = "GOODMEMORY" },
        { trait = "SKIN_TAN" },
        { trait = "eye_color", variant = "gray" },
        { trait = "hair_short", variant = "gray" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    worn = "NC_Isherwood_male_worn",
    weapon = "NC_ISHERWOOD_rifle",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "speech", bonus = { rng = { 2, 4 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "survival", bonus = { rng = { 7, 10 } } },
        { skill = "gun", bonus = { rng = { 4, 8 } } },
        { skill = "rifle", bonus = { rng = { 7, 10 } } },
        { skill = "archery", bonus = { rng = { 8, 10 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ISHERWOOD_CARLOS", "TALK_ISHERWOOD_CARLOS_ConvincedMarshal" },
    replies = {
        {
            text = ccb.content.text("Hi, looks like you are building a forge setup."),
            next_topic = "TALK_ISHERWOOD_CARLOS_TALK1",
            actions = {
                actions.set_actor_value("speaker", "u_met_Carlos_Isherwood", "yes"),
                actions.set_actor_value("speaker", "u_met_an_isherwood", "yes"),
            },
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")) }),
        },
        {
            text = ccb.content.text("Hi, Jack and Claire suggested I come talk to you about a job."),
            next_topic = "TALK_CARLOS_FORGE1",
            actions = { actions.set_actor_value("speaker", "u_met_Carlos_Isherwood", "yes") },
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_learned_about_jesse" } }) }),
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
    id = "TALK_ISHERWOOD_CARLOS",
    line = {
        joined = {
            ccb.content.text("*is an older middle-aged man, well-muscled and darkly tanned, with worried lines around the corners of his eyes and mouth.  He looks up as you get close"),
            {
                when = predicates.wears("speaker", "badge_marshal"),
                yes = ccb.content.text(", and then puts his hand on the butt of the rifle slung across his back.  \"I see that badge, I think you need to keep on walking, straight off this property.\""),
                no = {
                    when = predicates.actor_state("speaker", "male"),
                    yes = ccb.content.text(", then smiles distantly.  \"Hello Sir, what brings you here?\""),
                    no = ccb.content.text(", then smiles distantly.  \"Hello Ma'am, what brings you here?\""),
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
            actions = { actions.set_first_topic("TALK_ISHERWOOD_CARLOS_SawMarshal") },
            opinion = { trust = -20, value = -20 },
            when = predicates.wears("speaker", "badge_marshal"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CARLOS_SawMarshal",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("* glares at you, his hand moving again to his gun.  \"I see that badge, I think you need to keep on walking, straight off this property.\""),
        no = ccb.content.text("*rolls his eyes.  \"I'm not an idiot.  You think if you don't wear your badge, I won't know who you're working for?  Get out of here.\""),
    },
    replies = {
        {
            text = ccb.content.text("Look, I took it off to show I'm not here as a marshal.  I'm just here as a traveler, someone who can maybe help you out.  I know you've got problems bigger than you can handle right now."),
            next_topic = "TALK_ISHERWOOD_CARLOS_MarshalSaveBarry",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "u_learned_barry_missing" } }), predicates.negate(predicates.wears("speaker", "badge_marshal")) }),
        },
        { text = ccb.content.text("…[Leave.]"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CARLOS_ConvincedMarshal",
    line = {
        joined = {
            ccb.content.text("*looks up warily as you approach"),
            {
                when = predicates.wears("speaker", "badge_marshal"),
                yes = ccb.content.gendered_line(", looking at your marshal badge immediately.  \"You said you'd keep that goddamn piece of tin out of my sight.\"", { "speaker" }),
                no = ccb.content.text(".  \"Yeah?\""),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Oh, right… [Leave.]"),
            next_topic = "TALK_DONE",
            opinion = { trust = -10, value = -10 },
            when = predicates.wears("speaker", "badge_marshal"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CARLOS_MarshalSaveBarry",
    line = ccb.content.text("*struggles to think of a reply for a moment, then drops his hand from his gun.  \"We've got that under control, but you're not wrong.  An extra pair of hands wouldn't hurt, just now.  Just keep that damn badge out of my sight.\""),
    on_enter = { { actions = { actions.set_first_topic("TALK_ISHERWOOD_CARLOS_ConvincedMarshal") } } },
    replies = {
        {
            text = ccb.content.text("Fine.  Thanks.  Tell me more about what happened to Barry."),
            next_topic = "TALK_CARLOS_BARRY",
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_learned_barry_missing" } }) }),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CARLOS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CARLOS_TALK1",
    line = ccb.content.text("It is coming together.  I want to make our own tools, repair our items and even create some weapons and ammunition reloading."),
    replies = {
        { text = ccb.content.text("What do you need?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text("I heard about Barry, can you tell me what captured him?"),
            next_topic = "TALK_CARLOS_BARRY",
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_learned_barry_missing" } }) }),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CARLOS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARLOS_BARRY",
    line = ccb.content.text("It was pink and really fast, it had lots of limbs, definitely not human.\"  Carlos rubs the back of his hand idly, staring into space.  \"It easily kept up with us when we tried to escape, horrifying stuff.  Barry just dropped to the ground, and the thing swept him away."),
    replies = {
        {
            text = ccb.content.text("You all just gonna leave him out there to his fate?"),
            next_topic = "TALK_CARLOS_BARRY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CARLOS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARLOS_BARRY2",
    line = ccb.content.text("*frowns at you.  \"Of course not.  We tracked it for a while, but lost the trail.  Right now we don't have the resources to try to rescue him.  My son, Chris, has been trying to pick up the trail again and figure out a rescue plan.\""),
    replies = {
        {
            text = ccb.content.text("I could help.  Where did Chris go?"),
            next_topic = "TALK_CARLOS_BARRY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CARLOS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARLOS_BARRY3",
    line = ccb.content.text("*shakes his head.  \"Leave Chris be, he knows what he's doing.  Give him some time.  Calling more attention to him could get both of you killed.\""),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CARLOS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARLOS_FORGE1",
    line = ccb.content.text("The big item I need is an anvil, once I have that I can get a lot of repairs done.\"  He smiles briefly.  \"Can't exactly head to town to get it done anymore, but I learned a bit of old world metalwork from my granddad."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CARLOS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARLOS_FORGE2",
    line = ccb.content.text("*gestures around the workspace, which looks more set up.  \"I'm figuring things out, getting it worked out.  It's been a while since I did this kind of metalwork.\""),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CARLOS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARLOS_FORGE3",
    line = ccb.content.text("Yeah, it's coming along nice.\"  He slaps the surface of the anvil.  \"Thanks for this, I'm still getting my skills back up, but it's going to be real helpful."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CARLOS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARLOS_CHRIS1",
    line = ccb.content.text("Chris is hiking the perimeter of our land, planning some defense options.\"  He looks you up and down.  \"Best just let him be."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CARLOS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARLOS_CHRIS2",
    line = ccb.content.text("*looks at you curiously.  \"Should be where you saw him last.  He's not missing again, is he?\""),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CARLOS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CARLOS_TOPICS",
    line = ccb.content.text("Go on…"),
    replies = {
        {
            text = ccb.content.text("I heard about Barry, can you tell me what captured him?"),
            next_topic = "TALK_CARLOS_BARRY",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "u_learned_barry_missing" } }), predicates.negate(predicates.wears("speaker", "badge_marshal")) }),
        },
        {
            text = ccb.content.text("Is your forge operational?"),
            next_topic = "TALK_CARLOS_FORGE1",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "carlos_has_anvil" } })),
        },
        {
            text = ccb.content.text("Is your forge operational?"),
            next_topic = "TALK_CARLOS_FORGE2",
            when = predicates.handler("dlg_p_dda_97cadd917dd3"),
        },
        {
            text = ccb.content.text("Is your forge operational?"),
            next_topic = "TALK_CARLOS_FORGE3",
            when = predicates.handler("dlg_p_dda_e8988dc59f31"),
        },
        {
            text = ccb.content.text("Where can I find Chris?"),
            next_topic = "TALK_CARLOS_CHRIS1",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "u_found_chris_for_carlos" } })),
        },
        {
            text = ccb.content.text("Where can I find Chris?"),
            next_topic = "TALK_CARLOS_CHRIS2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_found_chris_for_carlos" } }),
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_CARLOS_1",
    name = ccb.content.text("Find an anvil"),
    goal = "MGOAL_CONDITION",
    complete_when = "complete_mission_isherwood_carlos_1",
    difficulty = 5,
    value = 50000,
    item_count = 1,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_ISHERWOOD_CARLOS_2",
    dialogue = {
        describe = ccb.content.text("I need an anvil to do advanced metal work."),
        offer = ccb.content.text("I could really use an anvil."),
        accepted = ccb.content.text("You might be able to find one in a hardware store or similar."),
        rejected = ccb.content.text("Thanks anyway, we'll find the time to make it ourselves."),
        advice = ccb.content.text("If you can't find one, maybe you can make one for me."),
        inquire = ccb.content.text("Do you have the anvil?"),
        success = ccb.content.text("I appreciate it, this will really make a difference, here's some horse armor I've been working on.  Eventually I'll have the whole herd outfitted."),
        success_lie = ccb.content.text("What good does this do me?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        actions = {
            { handler = "deliver_isherwood_carlos_anvil" },
            { item = "leather_armor_horse", count = 1 },
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "carlos_has_anvil", "yes"),
            ccb.content.dialogue_actions.record_time({ scope = "global", key = "timer_carlos_has_anvil" }),
        },
        map_updates = {
            {
                terrain = "horse_farm_isherwood_4",
                layout = {
                    tile_edits = {
                        { shape = "point", operation = "furniture", id = "f_anvil", x = 6, y = 12 },
                    },
                },
            },
        },
    },
}

-- om_special is a no-op here - we are already at 'Isherwood Farm Mutable'. I added it to suppress a linter false positive.
ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_CARLOS_2",
    name = ccb.content.text("Find Chris Isherwood"),
    goal = "MGOAL_TALK_TO_NPC",
    difficulty = 3,
    value = 20000,
    start = {
        target = {
            special = "Isherwood Farm Mutable",
            terrain = "cabin_isherwood",
            reveal_radius = 1,
            random = true,
            min_distance = 2,
        },
        map_updates = {
            { layout = { npc_placements = { { id = "isherwood_chris", x = 8, y = 17, target = true } } } },
        },
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        handler = "mark_u_found_chris_for_carlos",
        item_rewards = { { item = "chainmail_armor_horse", count = 1 } },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Chris hasn't come back from his latest search for Barry, I'm getting concerned."),
        offer = ccb.content.text("Can you go find my son and tell him to check in with us."),
        accepted = ccb.content.text("Thank you."),
        rejected = ccb.content.text("Oh well.  I hope he turns up soon."),
        advice = ccb.content.text("He might be on the property somewhere, maybe by that old cabin near the entrance, sometimes he camps there."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Thanks, I was getting ready to go look myself.  Now that I have the anvil, I've been working on new armor for the horses, take this prototype I made."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("I hope he didn't meet Barry's fate…"),
    },
}
