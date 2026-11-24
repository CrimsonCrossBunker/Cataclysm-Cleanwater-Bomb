local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Dairy farmer's son in the Isherwood family.
-- Son of Eddie, nephew of Carlos and Jesse.  Cousin of Lisa and Chris.  Grandson of Claire and Jack, great-nephew of Barry.
ccb.content.define_npc {
    id = "isherwood_luke",
    unique_name = ccb.content.text("Luke Isherwood"),
    gender = "male",
    class = "NC_ISHERWOOD_LUKE",
    attitude = 0,
    mission = "GUARD",
    age = 16,
    height = 181,
    strength = 8,
    dexterity = 9,
    intelligence = 7,
    perception = 8,
    personality = { aggression = 2, bravery = 8, collector = 1, altruism = 2 },
    chat = "TALK_ISHERWOOD_LUKE",
    missions_offered = "MISSION_ISHERWOOD_LUKE_1",
    faction = "isherwood_family",
}

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_LUKE",
    name = ccb.content.text("Luke Isherwood"),
    job_description = ccb.content.text("I'm Eddie's son, part of the Isherwood family"),
    traits = {
        { trait = "FLEET" },
        { trait = "TOUGH" },
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
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "survival", bonus = { rng = { 3, 6 } } },
        { skill = "gun", bonus = { rng = { 3, 6 } } },
        { skill = "rifle", bonus = { rng = { 4, 8 } } },
        { skill = "fabrication", bonus = { rng = { 2, 7 } } },
        { skill = "archery", bonus = { rng = { 4, 8 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE",
    line = {
        joined = {
            ccb.content.text("*is a young man in his mid teens, wearing threadbare but clean work trousers and a plain shirt with a few holes in it.  He looks you up and down as you approach"),
            {
            when = predicates.wears("speaker", "badge_marshal"),
            yes = ccb.content.text(", then scowls as he spots the Old Guard Marshal badge gleaming on your chest.  \"I see that badge.  You should leave before my father spots it.\""),
            no = {
                when = predicates.any_equal({ "seen", { scope = "speaker", key = "isherwood_luke_marshal_badge" } }),
                yes = ccb.content.text(", and nods once when he sees you've taken off your marshal badge.  \"Tread carefully around here, we don't have a lot of respect for your type of lawman.\""),
                no = {
                    when = predicates.actor_state("speaker", "male"),
                    yes = ccb.content.text(", then raises a hand to greet you.  \"Hello.\""),
                    no = ccb.content.text(", then raises his hand to his forehead in an old fashioned hat-tipping sort of gesture.  \"Hello.\""),
                },
            },
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_LEAVE_NOW_LUKE",
            when = predicates.wears("speaker", "badge_marshal"),
            actions = { actions.set_actor_value("speaker", "isherwood_luke_marshal_badge", "seen") },
            opinion = { trust = -20, value = -20 },
        },
        {
            text = ccb.content.text("What's wrong with me being a marshal?"),
            next_topic = "TALK_ISHERWOOD_LUKE_Marshal",
            when = predicates.all({ predicates.any_equal({ "seen", { scope = "speaker", key = "isherwood_luke_marshal_badge" } }), predicates.negate(predicates.wears("speaker", "badge_marshal")) }),
        },
        {
            text = ccb.content.text("Your dad said you were out here fixing up this place."),
            next_topic = "TALK_ISHERWOOD_LUKE_TALK1",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_Eddie_Isherwood" } }),
            actions = { actions.set_actor_value("speaker", "u_met_Luke_Isherwood", "yes"), actions.set_actor_value("speaker", "u_met_an_isherwood", "yes") },
        },
        {
            text = ccb.content.text("How are those books doing for you?"),
            next_topic = "TALK_ISHERWOOD_LUKE_BOOKS1",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "u_did_luke_missions" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "u_saved_barry_isherwood" } })) }),
        },
        {
            text = ccb.content.text("Chris and I have a little project for you that we've cooked up, if you're interested."),
            next_topic = "TALK_ISHERWOOD_LUKE_Truck_Bomb",
            when = predicates.handler("dlg_p_dda_da2ff9750594"),
        },
        {
            text = ccb.content.text("We've got the truck, what's next?"),
            next_topic = "TALK_ISHERWOOD_LUKE_Truck_Bomb_Plan_Part_2",
            when = predicates.handler("dlg_p_dda_06109bce9e89"),
        },
        {
            text = ccb.content.text("I've got the dynamite you requested, I can't wait to see how this works out."),
            next_topic = "TALK_ISHERWOOD_LUKE_Truck_Bomb_Plan_Done",
            when = predicates.all({ predicates.has_mission("MISSION_LUKE_RETRIEVE_TRUCK_EXPLOSIVES"), predicates.has_inventory("speaker", "dynamite", 20) }),
            actions = { actions.transfer_items("dynamite", 20), actions.finish_mission("MISSION_LUKE_RETRIEVE_TRUCK_EXPLOSIVES", { success = true }) },
        },
        {
            text = ccb.content.text("How are those books doing for you?"),
            next_topic = "TALK_ISHERWOOD_LUKE_BOOKS2",
            when = predicates.handler("dlg_p_dda_17932503160e"),
        },
        {
            text = ccb.content.text("How are those books doing for you?"),
            next_topic = "TALK_ISHERWOOD_LUKE_BOOKS3",
            when = predicates.handler("dlg_p_dda_a0ce66305f5e"),
        },
        {
            text = ccb.content.text("Hey, what are you doing out here?"),
            next_topic = "TALK_ISHERWOOD_LUKE2",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE_Marshal",
    line = ccb.content.text("I don't see how it's much of your business what our story is.  You can try asking my dad, Eddie, if you really want.  Just don't start acting like some little piece of tin in your pocket means you can come in like you own the place."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "isherwood_luke_marshal_questions", "known") },
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE_TALK1",
    line = ccb.content.text("Yeah, I work on it when I have the time.  I can't leave the farm too long, so I can't find some things I need."),
    replies = {
        {
            text = ccb.content.text("Maybe I can help out.  What do you need?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("Must be tough having the world fall apart when you had you future to look forward to."),
            next_topic = "TALK_ISHERWOOD_LUKE3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE_BOOKS1",
    line = ccb.content.text("*gestures to where they sit on a shelf.  \"I've been trying to look at them, but I can't focus too much right now.\"  He smiles sadly.  \"Hope to get to them soon.\""),
    replies = {
        {
            text = ccb.content.text("Because of Barry?"),
            next_topic = "TALK_ISHERWOOD_LUKE_BOOKS_BARRY",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_learned_barry_missing" } }),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE_BOOKS_BARRY",
    line = ccb.content.text("*winces a little at the name.  \"Yeah.  Because of Barry.\"  You can see he'd rather not pursue the topic."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE_BOOKS2",
    line = ccb.content.text("*smiles.  \"Bit early to tell, but I've been doing some night time reading and trying a few things out.\""),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE_BOOKS3",
    line = ccb.content.text("*smiles brightly.  \"Real great, thanks!  I've learned a lot from them already.  Tried my hand at some basic stuff, it's fun to learn new things.\""),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE2",
    line = {
        joined = {
            ccb.content.text("*gestures around at the worn down shed surrounding you.  \"I've been cleaning up this old building to make it into a workshop.  I want to put up a pottery kiln and forge.  My dad doesn't want me leaving the farm to find some things"),
            {
                when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_saved_barry_isherwood" } }),
                yes = ccb.content.text(", says it is too dangerous.  After what happened with Barry, well, I tend to agree with him.\"  He smiles thinly.  \"Don't want you to have to run out saving another one of us, right?\""),
                no = ccb.content.text(", says it's too dangerous.  I used to think he was being a pain in the butt, but lately…\" he stops abruptly, and says nothing more."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Maybe I can help out.  What do you need?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE3",
    line = ccb.content.text("I know all the grown-ups worry about us, but I think we can adapt better than them in the long run.  Chris - my cousin - has some interesting thoughts on the matter."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "u_heard_about_chris", "yes"),
                actions.set_actor_value("speaker", "u_heard_about_chris_ideas", "yes"),
            },
        },
    },
    replies = {
        { text = ccb.content.text("Where can I find Chris?"), next_topic = "TALK_LUKE_CHRIS" },
        {
            text = ccb.content.text("What sort of ideas does Chris have?"),
            next_topic = "TALK_LUKE_CHRIS2",
        },
        {
            text = ccb.content.text("That is a good idea, what do you need?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text("I'm not interested right now.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LUKE_EDDIE_NoBarry",
    line = ccb.content.text("&His shoulders slump a little at the question.  \"Things have been tough for my dad since Barry was captured.  He works till he falls asleep most nights…\""),
    replies = {
        { text = ccb.content.text("What happened to Barry?"), next_topic = "TALK_LUKE_BARRY" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LUKE_EDDIE_YesBarry",
    line = ccb.content.text("*looks around, then leans in just a little closer.  \"He's doing OK now that Barry's home, but, well, things still aren't the same.  I imagine that'll take time.\""),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LUKE_BARRY",
    line = ccb.content.text("*goes a bit pale.  \"I shouldn't have said that.  Not my place to talk to a stranger about it.\""),
    replies = {
        {
            text = ccb.content.text("I already know Barry got captured.  I just wanted to know a bit more about it.  Maybe I can help."),
            next_topic = "TALK_LUKE_BARRY2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_learned_barry_missing" } }),
        },
        {
            text = ccb.content.text("I might be able to help, though."),
            next_topic = "TALK_LUKE_BARRYhelp",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "u_learned_barry_missing" } })),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LUKE_BARRY2",
    line = ccb.content.text("*frowns.  \"I don't know how much I can tell you.  Your best bet is to talk to Uncle Carlos.\""),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LUKE_BARRYhelp",
    line = ccb.content.text("I really… okay.  Maybe ask my grandma, Claire.  She'll know if it's okay to talk about."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LUKE_CHRIS",
    line = ccb.content.text("Chris is a little older than me, he's up at the horse farm with his parents and sister, Lisa."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "u_heard_about_chris", "yes") } } },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LUKE_CHRIS2",
    line = ccb.content.text("Well, he doesn't agree that what we're doing here will last.  He thinks things will only get worse.\"  Luke shrugs, as if to say he doesn't have a strong opinion on the matter.  \"It's tough to get the adults to listen though, much less agree with his solution.  You can go talk to him more about it if you want."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LEAVE_NOW_LUKE",
    line = ccb.content.text("You won't find any help here."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE_TOPICS",
    line = ccb.content.text("Go on…"),
    replies = {
        {
            text = ccb.content.text("Must be tough having the world fall apart when you had you future to look forward to."),
            next_topic = "TALK_ISHERWOOD_LUKE3",
        },
        {
            text = ccb.content.text("Tell me about your dad."),
            next_topic = "TALK_LUKE_EDDIE_NoBarry",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_Eddie_Isherwood" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "u_saved_barry_isherwood" } })) }),
        },
        {
            text = ccb.content.text("Tell me about your dad."),
            next_topic = "TALK_LUKE_EDDIE_YesBarry",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_Eddie_Isherwood" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "u_saved_barry_isherwood" } }) }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE_Truck_Bomb",
    line = ccb.content.text("How does this all come together?"),
    replies = {
        {
            text = ccb.content.text("Well, we are going to turn this truck into a bomb that'll give us a big enough opening in the tower to let out some of the heat and gas.  But small enough that it won't kill Barry unless it's right next to him."),
            next_topic = "TALK_ISHERWOOD_LUKE_Truck_Bomb_Is_Crazy",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE_Truck_Bomb_Is_Crazy",
    line = ccb.content.text("Are you serious?  This is your brother we are risking here!"),
    replies = {
        {
            text = ccb.content.text("Exactly, and I wouldn't do anything to risk him unnecessarily."),
            next_topic = "TALK_ISHERWOOD_LUKE_Truck_Bomb_Plan",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE_Truck_Bomb_Plan",
    line = ccb.content.text("OK so I have an idea on how we can breach that tower.  We need a truck and some dynamite.  I've heard about some bandits in a truck robbing people nearby.  If you can take care of the bandits I'll pick up the truck later"),
    replies = {
        {
            text = ccb.content.text("I think I can manage two bandits."),
            actions = { actions.assign_mission("MISSION_LUKE_RETRIEVE_TRUCK") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text("Surely we can think of a better way in."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE_Truck_Bomb_Plan_Part_2",
    line = ccb.content.text("So now that we've got the truck we need the boom.  See if you can find some dynamite at the old mines?  Once we got the dynamite I'll rig that up to a kitchen timer and we'll have a bomb on wheels.  I'll need 50lbs to light that truck up like the 4th of July!"),
    replies = {
        {
            text = ccb.content.text("This is gonna rad as heck as long as it works."),
            actions = { actions.assign_mission("MISSION_LUKE_RETRIEVE_TRUCK_EXPLOSIVES") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        { text = ccb.content.text("Not doing it."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE_Truck_Bomb_Plan_Done",
    line = ccb.content.text("I've got everything I need to make this breaching truck for us.  Thanks!"),
    replies = { { text = ccb.content.text("[heck yeah]"), next_topic = "TALK_ISHERWOOD_LUKE_TOPICS" } },
}

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_LUKE_1",
    name = ccb.content.text("Find The Art of Glassblowing book"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "glassblowing_book",
    item_count = 1,
    finish = {
        map_updates = {
            {
                terrain = "rural_outbuilding",
                layout = {
                    item_placements = {
                        { id = "glassblowing_book", x = 5, y = 9, faction = "isherwood_family" },
                    },
                },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_ISHERWOOD_LUKE_2",
    dialogue = {
        describe = ccb.content.text("I need more knowledge to get the glass blowing started."),
        offer = ccb.content.text("I could really use a book on glass blowing.  With the internet gone, I don't have any handy references."),
        accepted = ccb.content.text("Fantastic, I'm not supposed to leave our land."),
        rejected = ccb.content.text("Oh well, figured I'd have to do a lot of practice anyway."),
        advice = ccb.content.text("A library, bookstore or a glass blower's studio should have one."),
        inquire = ccb.content.text("Do you have the book?"),
        success = ccb.content.text("I appreciate it, this will make my life so much easier."),
        success_lie = ccb.content.text("I don't see a book…?"),
        failure = ccb.content.text("At least you escaped with your life…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_LUKE_2",
    name = ccb.content.text("Find a copy of DIY Compendium"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 3,
    value = 20000,
    item = "textbook_fabrication",
    item_count = 1,
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = {
        map_updates = {
            {
                terrain = "rural_outbuilding",
                layout = {
                    item_placements = {
                        { id = "textbook_fabrication", x = 5, y = 9, faction = "isherwood_family" },
                    },
                },
            },
        },
        handler = { "mark_u_did_luke_missions", "record_timer_luke_isherwood_books" },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("I need more knowledge to get better pottery."),
        offer = ccb.content.text("I could really use the book, DIY Compendium.  With the internet gone, I don't have any handy references."),
        accepted = ccb.content.text("Fantastic, I'm not supposed to leave our land."),
        rejected = ccb.content.text("Oh well, figured I'd have to do a lot of practice anyway."),
        advice = ccb.content.text("A library, bookstore should have one, schools are another good idea."),
        inquire = ccb.content.text("Do you have the book?"),
        success = ccb.content.text("I appreciate it, this will make my life so much easier."),
        success_lie = ccb.content.text("I don't see a book…?"),
        failure = ccb.content.text("At least you escaped with your life…"),
    },
}

-- Dialogue for this mission is handled externally.
ccb.content.define_mission {
    id = "MISSION_LUKE_RETRIEVE_TRUCK",
    name = ccb.content.text("Retrieve the Truck for Luke Isherwood"),
    description = ccb.content.text("Kill the two bandits for Luke Isherwood to get their truck."),
    goal = "MGOAL_ASSASSINATE",
    difficulty = 5,
    value = 0,
    start = {
        target = { terrain = "trailhead_shack_z0", special = "trailhead_shack", reveal_radius = 1 },
        map_updates = {
            {
                layout = {
                    npc_placements = {
                        { id = "bandit", x = 5, y = 8, target = true },
                        { id = "bandit", x = 5, y = 9, target = true },
                    },
                    vehicle_placements = {
                        {
                            id = "pickup",
                            chance = 100,
                            fuel = 100,
                            rotation = 0,
                            faction = "hells_raiders",
                            x = { 5 },
                            y = { 8 },
                        },
                    },
                },
            },
        },
    },
    finish = { actions = { { handler = "start_isherwood_truck" } } },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("."),
        offer = ccb.content.text("."),
        accepted = ccb.content.text("."),
        rejected = ccb.content.text("."),
        advice = ccb.content.text("."),
        inquire = ccb.content.text("."),
        success = ccb.content.text("."),
        success_lie = ccb.content.text("."),
        failure = ccb.content.text("."),
    },
}

-- Dialogue for this mission is handled externally.
ccb.content.define_mission {
    id = "MISSION_LUKE_RETRIEVE_TRUCK_EXPLOSIVES",
    name = ccb.content.text("Retrieve Some Dynamite for Luke"),
    description = ccb.content.text("Get 50 pounds of dynamite for Luke Isherwood to make a bomb.  There's a known shipment at a mine in the region."),
    goal = "MGOAL_NULL",
    difficulty = 5,
    value = 0,
    start = {
        target = { terrain = "mine_entrance_loading_zone", special = "Generic mine", reveal_radius = 1 },
        map_updates = {
            {
                layout = {
                    vehicle_placements = {
                        { id = "truck_trailer_explosives", chance = 100, rotation = 270, x = { 7 }, y = { 7 } },
                    },
                },
            },
        },
    },
    finish = { handler = "advance_world_isherwood_luke_truck_coming_by_1" },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("."),
        offer = ccb.content.text("."),
        accepted = ccb.content.text("."),
        rejected = ccb.content.text("."),
        advice = ccb.content.text("."),
        inquire = ccb.content.text("."),
        success = ccb.content.text("."),
        success_lie = ccb.content.text("."),
        failure = ccb.content.text("."),
    },
}
