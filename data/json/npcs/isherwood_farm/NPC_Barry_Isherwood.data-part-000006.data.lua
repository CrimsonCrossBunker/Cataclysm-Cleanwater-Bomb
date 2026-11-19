local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_TOWER_family2",
    line = ccb.content.text("Fair enough, you asked for it.\"  He stretches his arms out.  \"Jack and I stayed close, even after my old man and I fell out, so when it looked like he was going to be saddled with the entire farm to run, I took a good long look at my life and realized I hated it.  It was never the farm I was trying to get away from, you know?  I packed up my things, quit my job, and came out to help Jack.  Never looked back.\"  He chuckles.  \"Damn hard finding a partner for a guy like me out here though.  I was in a long-term relationship when I left, but that fell apart.  I haven't been too lonely though, I've got my people."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "u_knows_barry_family_story", "yes") } } },
    replies = {
        {
            text = ccb.content.text("[PER 9] Was your choice in partners part of the problem with your father?"),
            next_topic = "TALK_ISHERWOOD_BARRY_TOWER_family3",
            when = predicates.minimum_attribute("speaker", "perception", 9),
        },
        {
            text = ccb.content.text("Thanks for taking the time to talk to me.  I had some other questions."),
            next_topic = "TALK_ISHERWOOD_BARRY_askback",
        },
        {
            text = ccb.content.text("Thanks for the story.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_TOWER_family3",
    line = ccb.content.text("&His eyebrows shoot up, briefly surprised, then he smiles.  \"You nailed it in one.  Yeah, we're talking about a rural farmer in the nineties, here.  My dad never understood me, even before he knew, and he did find out, although I tried to keep the closet door closed.  Jack, though, he always saw me for me.  Never let it change our relationship.  That's real love, and that's what made me come back when he needed me.  Meanwhile, the man I thought I'd marry, back in Bunyan, he couldn't be assed even to come out and see the family farm, let alone think about moving here.  He was dead weight, and I've never doubted that decision.\"  He shrugs.  \"There's folks like me wherever you go, I've had a few relationships since then.  Just nothing that stuck, and I'm okay with that.  If nothing else, it proved what I already knew: aside from my old man, none of my family treated me or them any different for it.  They're good people.\""),
    on_enter = { { actions = { actions.set_actor_value("speaker", "u_knows_barry_is_gay", "yes") } } },
    replies = {
        {
            text = ccb.content.text("Thanks for taking the time to talk to me.  I had some other questions."),
            next_topic = "TALK_ISHERWOOD_BARRY_askback",
        },
        {
            text = ccb.content.text("Thanks for the story.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_TOWER_farm",
    line = ccb.content.text("Oh, yeah, now I remember.  That farm I was talking about is where I live, almost the whole Isherwood family lives there, including me.  I just wanted to get back home as fast as possible so I can see everyone again, and so everyone knows that I'm okay."),
    on_enter = {
        {
            once = "u_learned_about_farm",
            actions = { actions.clear_actor_value("speaker", "general_knowledge_u_dont_know_about_farm") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Can you give me some directions to it?"),
            next_topic = "TALK_ISHERWOOD_BARRY_TOWER_farm_directions",
        },
        {
            text = ccb.content.text("That's pretty cool.  <done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_BARRY_askback",
            actions = { actions.set_actor_value("speaker", "general_knowledge_u_thinking_about_farm", "yes") },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "general_knowledge_u_thinking_about_farm", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_TOWER_farm_directions",
    line = ccb.content.text("Sure, can I please see your map?\"  Barry takes your map, orients himself, and points out a route to the farm.  \"Once we've done that, I'll head on myself so everyone won't be surprised by you coming.  Sound good?"),
    replies = {
        {
            text = ccb.content.text("Sounds good to me, let's hit the road."),
            next_topic = "TALK_DONE",
            actions = {
                actions.assign_mission("MISSION_ISHERWOOD_BARRY_RETURN_TO_FARM"),
                actions.clear_actor_value("speaker", "general_knowledge_u_thinking_about_farm"),
            },
        },
        {
            text = ccb.content.text("I'd like to think about it some more."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "general_knowledge_u_thinking_about_farm", "yes") },
        },
    },
}
