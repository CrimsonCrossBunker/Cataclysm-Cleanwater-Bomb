local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Schizophrenic beggar in the refugee center.
ccb.content.define_npc {
    id = "refugee_beggar2",
    unique_name = ccb.content.text("Dino Dave"),
    gender = "male",
    temporary_suffix = "Beggar",
    class = "NC_BEGGAR_2",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_BEGGAR_2",
    faction = "lobby_beggars",
    missions_offered = "MISSION_BEGGAR_2_BOX_SMALL",
}

-- All the beggars have been camping inside the evac shelter because they're too weak and unskilled to make it on their own.
ccb.content.define_npc_class {
    id = "NC_BEGGAR_2",
    name = ccb.content.text("Beggar"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -3, -2 } },
    dexterity = { rng = { -5, -1 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { -6, -2 } },
    worn = "NC_BEGGAR_2_worn",
    carry = "EMPTY_GROUP",
    weapon = "EMPTY_GROUP",
    traits = {
        { trait = "GLASSJAW" },
        { trait = "ADDICTIVE" },
        { trait = "HOARDER" },
        { trait = "SLOWHEALER" },
        { trait = "SLOWRUNNER" },
        { trait = "CHEMIMBALANCE" },
        { trait = "HEAVYSLEEPER" },
        { trait = "FLIMSY2" },
        { trait = "SCHIZOPHRENIC" },
        { trait = "SLOWLEARNER" },
        { trait = "PACIFIST" },
        { group = "Appearance_demographics" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2",
    line = {
        when = predicates.available_missions("interlocutor", 0, 0),
        yes = {
            when = predicates.assigned_missions(0, 0),
            yes = ccb.content.text("We've done it!  We've solved the list!"),
            no = ccb.content.text("How's things with you?  My cardboard collection is getting quite impressive."),
        },
        no = ccb.content.text("Have I told you about cardboard, friend?  Do you have any?"),
    },
    replies = {
        {
            when = predicates.assigned_missions(1, 1),
            text = ccb.content.text("About that shopping list of yours…"),
            next_topic = "TALK_MISSION_INQUIRE",
        },
        {
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_dinodave_cardboard_donor" } }), predicates.negate(predicates.available_missions("interlocutor", 0, 0)) }),
            text = ccb.content.text("Is there anything else I can do for you?"),
            next_topic = "TALK_MISSION_OFFER",
        },
        {
            when = predicates.all({ predicates.available_missions("interlocutor", 0, 0), predicates.assigned_missions(0, 0), predicates.negate(predicates.has_mission("MISSION_BEGGAR_2_PERMISSION")) }),
            text = ccb.content.text("What are you going to do with all that cardboard now?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_JOBSDONE",
            actions = { actions.set_actor_value("speaker", "general_recruit_dave_happy", "yes") },
        },
        {
            when = predicates.all({ predicates.has_mission("MISSION_BEGGAR_2_PERMISSION"), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_Dave_Permission" } }) }),
            text = ccb.content.text("We've done it, Dave!  Smokes says you can build yourself a house up on the roof if you want.  You've got to keep it nice and clean, and help out the people down here by looking out for zombies, but you can still use the washrooms and things downstairs when you need to.  What do you say?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_PERMISSION",
        },
        { text = ccb.content.text("Cardboard?"), next_topic = "TALK_REFUGEE_BEGGAR_2_CARDBOARD" },
        {
            text = ccb.content.text("Why are you sitting out here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_REFUGEE",
        },
        {
            text = ccb.content.text("Are you seriously wearing a dinosaur costume?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_DINOSAUR",
        },
        {
            text = ccb.content.text("Do you need something to eat?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_GIVE_FOOD",
        },
        { text = ccb.content.text("Get away from me."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("…"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_GIVE_FOOD",
    line = {
        when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
        yes = ccb.content.text("Oh nice.  Crunchings and munchings.  That's a cool, a cool thing."),
        no = ccb.content.gendered_line("Yeah, I'm real hungry and they put drugs in most of the food.  I can see you're not like that.", { "speaker" }),
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I'm sorry, I was wrong.  I can't help you."),
            next_topic = "TALK_DONE",
        },
    },
    repeat_replies = {
        {
            categories = { "food" },
            reply = {
                text = ccb.content.text("Here, you can have this <topic_item>."),
                next_topic = "TALK_REFUGEE_BEGGAR_2_GAVE_FOOD",
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_GAVE_FOOD",
    line = ccb.content.text("I can tell when it has stuff in it, it's got a sandy texture.  But this doesn't.  Thanks again."),
    on_enter = {
        { actions = { "u_bulk_donate" } },
        { actions = { actions.handler("w16b_a_dda_ee5ac56a72a9") } },
    },
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2",
        },
        {
            text = ccb.content.text("No problem.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_CARDBOARD",
    line = ccb.content.text("I'm building a house out of cardboard.  The sandman doesn't want me to, but I told him to go fuck himself."),
    replies = {
        {
            text = ccb.content.text("Why cardboard?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_CARDBOARD2",
        },
        { text = ccb.content.text("The sandman?"), next_topic = "TALK_REFUGEE_BEGGAR_2_SANDMAN" },
        {
            text = ccb.content.text("Would you like me to give you some cardboard?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_GIVECARDBOARD",
        },
        {
            text = ccb.content.text("Why are you sitting out here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_REFUGEE",
        },
        {
            text = ccb.content.text("Are you seriously wearing a dinosaur costume?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_DINOSAUR",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_CARDBOARD2",
    line = ccb.content.text("There's so much of it now, and the zombies are afraid of it.  It's kept me safe so far.  The beta rays come from the center point of the zombie, so it hits the cardboard and can't penetrate.  The reflection can stop any further damage."),
    replies = {
        {
            text = ccb.content.text("Would you like me to give you some cardboard?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_GIVECARDBOARD",
        },
        {
            text = ccb.content.text("Why are you sitting out here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_REFUGEE",
        },
        {
            text = ccb.content.text("Are you seriously wearing a dinosaur costume?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_DINOSAUR",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_GIVECARDBOARD",
    line = ccb.content.text("Kind of a question's that?  Yeah man, you got cardboard, I got a whole… a whole shopping list.  Got it here."),
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "mission_dinodave_cardboard_donor", "yes") },
        },
    },
    replies = {
        { text = ccb.content.text("What's next on the list?"), next_topic = "TALK_MISSION_LIST" },
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
    id = "TALK_REFUGEE_BEGGAR_2_SANDMAN",
    line = ccb.content.text("If you don't know who he is, I definitely can't tell you.  He talks to everyone, if you didn't hear him that means you can't be trusted, except to help me out."),
    replies = {
        { text = ccb.content.text("…<done_conversation_section>"), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_REFUGEE",
    line = ccb.content.text("These cowards are afraid of me.  They won't let me into their base.  I'm going to build my new house and I won't let them in."),
    replies = {
        {
            text = ccb.content.text("You said you were building a house?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_CARDBOARD",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_DINOSAUR",
    line = ccb.content.text("No."),
    replies = {
        {
            text = ccb.content.text("I… I can see you wearing it.  Why are you wearing that?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_WEARING",
        },
        {
            text = ccb.content.text("What was that about cardboard?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_CARDBOARD",
        },
        {
            text = ccb.content.text("Why are you sitting out here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_REFUGEE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_WEARING",
    line = ccb.content.text("You ask me what I can see, but I don't tell you what you see.  Sometimes we have shields up, to protect ourselves."),
    replies = {
        {
            text = ccb.content.text("What was that about cardboard?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_CARDBOARD",
        },
        {
            text = ccb.content.text("Why are you sitting out here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_REFUGEE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_JOBSDONE",
    line = {
        joined = {
            ccb.content.text("Well… I had it all pretty together, "),
            {
                when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_beggars_recruited" } }),
                yes = ccb.content.text("but the others have left, and "),
                no = ccb.content.text("and I feel bad with all the help you've given me already, but "),
            },
            ccb.content.text("now the masters won't let me build my sanctuary.  I know I can't build it in here, they wouldn't allow it.  They won't listen to me when I ask for a safe place.  They just want me to disappear, like the others.  Can you help me figure them out?"),
        },
    },
    replies = {
        {
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_beggars_recruited" } })),
            text = ccb.content.text("Why don't you leave this place?  Come with me, I could use some help out there."),
            next_topic = "TALK_REFUGEE_BEGGAR_2_JOIN",
        },
        {
            text = ccb.content.text("Sure, Dave.  One last favor, I think I can talk to Smokes about finding you a place to go."),
            actions = { actions.assign_mission("MISSION_BEGGAR_2_PERMISSION") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I'll have to think on that, Dave, I've done a lot already."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_PERMISSION",
    line = ccb.content.text("The roof!  So high!  So lofty!  I can hardly believe it!  This will be a nicer house than I had before everything went funny.  I can watch out, I'm happy to do that.  And it'll be nice to still have a bathroom!  Come see me there, my friend.  I will not disappoint you."),
    on_enter = {
        { actions = { actions.finish_mission("MISSION_BEGGAR_2_PERMISSION", { success = true }), actions.set_first_topic("TALK_DINODAVE_1"), actions.update_map("cardboard_castle_1_main", "evac_center_13_z1"), actions.handler("dlg_a_dda_4add61d2f558") } },
    },
    replies = {
        {
            text = ccb.content.text("I'll see you on the rooftop.  Good luck, Dave."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_JOIN",
    line = ccb.content.text("No!  I just got everything together.  I am not leaving, not now.  Everything's finally coming together!"),
    replies = {
        {
            text = ccb.content.text("Well, OK then, Dave.  One last favor, I think I can talk to Smokes about finding you a place to go."),
            actions = { actions.assign_mission("MISSION_BEGGAR_2_PERMISSION") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I'll have to think on it, Dave, I've done a lot already."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_BEGGAR_2_BOX_SMALL",
    name = ccb.content.text("Bring 40 small cardboard boxes"),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_FIND_ITEM",
    item = "box_small",
    item_count = 40,
    followup = "MISSION_BEGGAR_2_DUCT_TAPE",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Gotta start small right?  Little ones for keeping little things safe.  I could use 'em."),
        offer = ccb.content.text("Gotta start small right?  Little ones for keeping little things safe.  I could use 'em.  I need a bunch of 'em.  Little ones, you know?  Can you bring me like… like… forty?"),
        accepted = ccb.content.text("Oh man, thanks so much my friend.  You won't regret it."),
        rejected = ccb.content.text("I didn't think so."),
        advice = ccb.content.text("Watch out, he's looking for it too."),
        inquire = ccb.content.text("Got the little ones yet?"),
        success = ccb.content.text("Oh this is so great, so great!"),
        success_lie = ccb.content.text("Oh this is so great, so great!"),
        failure = ccb.content.text("Oh, that's too bad.  Guess they're eating it all."),
    },
}

ccb.content.define_mission {
    id = "MISSION_BEGGAR_2_DUCT_TAPE",
    name = ccb.content.text("Bring a roll of duct tape (200 charges)"),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_FIND_ITEM",
    item = "duct_tape",
    item_count = 200,
    followup = "MISSION_BEGGAR_2_BOX_MEDIUM",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("These ones are good, good ones.  They need something to, you know, bind them together.  Surround them, light side, dark side."),
        offer = ccb.content.text("These ones are good, good ones.  They need something to, you know, bind them together.  Surround them, light side, dark side.  Bring me the Force!"),
        accepted = ccb.content.text("Oh man, thanks so much my friend.  You won't regret it."),
        rejected = ccb.content.text("I didn't think so."),
        advice = ccb.content.text("Watch out, he's looking for it too."),
        inquire = ccb.content.text("It's all around us… but did you get it in a crude matter form?"),
        success = ccb.content.text("Oh this is so great, so great!"),
        success_lie = ccb.content.text("Oh this is so great, so great!"),
        failure = ccb.content.text("Oh, that's too bad.  Guess they're eating it all."),
    },
}

ccb.content.define_mission {
    id = "MISSION_BEGGAR_2_BOX_MEDIUM",
    name = ccb.content.text("Bring 10 cardboard boxes"),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_FIND_ITEM",
    item = "box_medium",
    item_count = 10,
    followup = "MISSION_BEGGAR_2_PLASTIC_SHEET",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Ten bigger ones now please.  The list doesn't lie.  You've done so well."),
        offer = ccb.content.text("Ten bigger ones now please.  The list doesn't lie.  You've done so well.  I got a little more on the list, but we're more than half there."),
        accepted = ccb.content.text("Oh man, thanks so much my friend.  You won't regret it."),
        rejected = ccb.content.text("I didn't think so."),
        advice = ccb.content.text("Watch out, he's looking for it too."),
        inquire = ccb.content.text("Any luck?  Bigger ones?"),
        success = ccb.content.text("I'm so happy now!"),
        success_lie = ccb.content.text("I'm so happy now!"),
        failure = ccb.content.text("Oh, that's too bad.  Guess they're eating it all."),
    },
}

ccb.content.define_mission {
    id = "MISSION_BEGGAR_2_PLASTIC_SHEET",
    name = ccb.content.text("Bring 10 large plastic sheets"),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_FIND_ITEM",
    item = "plastic_sheet",
    item_count = 10,
    followup = "MISSION_BEGGAR_2_BOX_LARGE",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("If I can set it up in here I won't need it, but they might drive me out, so I guess I need some plastic just in case.  I don't like it, the sandman can smell through plastic, but I think the cardboard is stronger."),
        offer = ccb.content.text("If I can set it up in here I won't need it, but they might drive me out, so I guess I need some plastic just in case.  I don't like it, the sandman can smell through plastic, but I think the cardboard is stronger.  Please bring me some plastic sheets."),
        accepted = ccb.content.text("We're almost there, now."),
        rejected = ccb.content.text("I didn't think so."),
        advice = ccb.content.text("They keep a lot of this stuff in hardware stores and lumber yards."),
        inquire = ccb.content.text("I really feel bad sending you on this one, it's dangerous.  Have you found anything?"),
        success = ccb.content.text("Nice, this will do perfectly!"),
        success_lie = ccb.content.text("Nice, this will do perfectly!"),
        failure = ccb.content.text("Oh, that's too bad."),
    },
}

ccb.content.define_mission {
    id = "MISSION_BEGGAR_2_BOX_LARGE",
    name = ccb.content.text("Bring 5 large cardboard boxes"),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_FIND_ITEM",
    item = "box_large",
    item_count = 5,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("This is the last thing I need from you.  I've been collecting the other parts myself, it's been easier with more cardboard around.  Can you bring me five more really big cardboard boxes?"),
        offer = ccb.content.text("This is the last thing I need from you.  I've been collecting the other parts myself, it's been easier with more cardboard around.  Can you bring me five more really big cardboard boxes?  Five more cardboard boxes, as big as it gets.  I have a few already stored up, that should be all I need."),
        accepted = ccb.content.text("Yes!  The home stretch!"),
        rejected = ccb.content.text("Oh man, but we're so close!"),
        advice = ccb.content.text("Try looking in cargo storage areas."),
        inquire = ccb.content.text("Did you bring me those last few boxes?"),
        success = ccb.content.text("Brilliant!  You're a true hero.  I'll see if I can find a place to set these up now."),
        success_lie = ccb.content.text("Brilliant!  You're a true hero.  I'll see if I can find a place to set these up now."),
        failure = ccb.content.text("No!  Oh god, no, this can't be happening…"),
    },
}

-- todo2: migrate u refugee happiness to global
ccb.content.define_mission {
    id = "MISSION_BEGGAR_2_PERMISSION",
    name = ccb.content.text("Talk to Smokes about finding Dave a place to call home."),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_CONDITION",
    item_count = 5,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I have it, I have it all, but I can't find a place to put it.  Will you ask the masters?  Maybe?  I've tried but they ignore me."),
        offer = ccb.content.text("I have it, I have it all, but I can't find a place to put it.  Will you ask the masters?  Maybe?  I've tried but they ignore me.  I just need a place to put it all, a place I can be safe, and not make anyone upset."),
        accepted = ccb.content.text("Thank you!  I'm sorry, I thought we were done, but we can do this!"),
        rejected = ccb.content.text("Oh man, but we're so close!"),
        advice = ccb.content.text("Maybe somewhere they can't see me?  Where I can just be me?"),
        inquire = ccb.content.text("Did you ask the masters?"),
        success = ccb.content.text("The roof!  So high!  So lofty!  Come see me there, my friend.  I will not disappoint you."),
        success_lie = ccb.content.text("I don't understand."),
        failure = ccb.content.text("No!  Oh god, no, this can't be happening…"),
    },
    finish = {
        actions = {
            { handler = "advance_world_dave_castle_stage_by_1" },
            { handler = "advance_counter_refugee_center_refugee_happiness_by_1" },
            ccb.content.dialogue_actions.update_map("refcenter_unlock_roofstairs", "evac_center_13"),
            ccb.content.dialogue_actions.update_map("beggar_2_remove_lobbycardboard", "evac_center_18"),
        },
    },
    complete_when = "complete_mission_beggar_2_permission",
}

ccb.content.define_mapgen {
    kind = "update",
    id = "cardboard_castle_1_main",
    layout = {
        nested = { { x = 0, y = 17, id = "cardboard_castle_1_main" } },
        transform_placements = { { id = "unlock_door", x = { 0, 23 }, y = { 0, 23 } } },
        tile_edits = { { shape = "point", operation = "remember_position", id = "dave_castle", x = 4, y = 19 } },
    },
}

-- First iteration of Dino Dave's cardboard castle - main floor.
ccb.content.define_mapgen {
    kind = "nested",
    id = "cardboard_castle_1_main",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||-|||",
            "|__CC|",
            "|____|",
            "||-|||",
            "|__BB|",
            "||||||",
        },
        nested = { { x = 0, y = 0, z = 1, id = "cardboard_castle_1_roof" } },
        furniture = {
            ["|"] = "f_cardboard_wall",
            ["-"] = "f_cardboard_door",
            _ = "f_cardboard_floor",
            C = "f_cardboard_box",
            B = "f_floor_mattress",
        },
    },
}

-- First iteration of Dino Dave's cardboard castle - roof.
ccb.content.define_mapgen {
    kind = "nested",
    id = "cardboard_castle_1_roof",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "______",
            "______",
            "______",
            "______",
            "______",
            "______",
        },
        furniture = { _ = "f_cardboard_roof" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "refcenter_unlock_roofstairs",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_door_metal_c", x = 1, y = 14 },
            { shape = "point", operation = "terrain", id = "t_door_metal_c", x = 21, y = 14 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "beggar_2_remove_lobbycardboard",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "furniture",
                id = "f_clear",
                x = 6,
                y = 1,
                end_x = 8,
                end_y = 1,
            },
        },
    },
}
