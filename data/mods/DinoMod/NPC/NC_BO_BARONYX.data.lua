local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc_class {
    id = "NC_SWAMPER",
    name = ccb.content.text("Swamper"),
    job_description = ccb.content.text("The great eaters have returned and they must be fed."),
    traits = { { trait = "SPIRITUAL" }, { trait = "PRETTY" }, { trait = "PSYCHOPATH" } },
    common = false,
    perception = { rng = { 0, 2 } },
    strength = { rng = { 0, 2 } },
    intelligence = { rng = { 0, 2 } },
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "dodge", bonus = { rng = { 4, 8 } } },
        { skill = "bashing", bonus = { rng = { 3, 6 } } },
        { skill = "cutting", bonus = { rng = { 3, 6 } } },
    },
}

-- A charismatic religious leader and CEO.
ccb.content.define_npc {
    id = "SWAMPER_Bo_Baronyx",
    unique_name = ccb.content.text("Bo Baronyx"),
    gender = "male",
    suffix = ccb.content.text("CEO"),
    class = "NC_SWAMPER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_SWAMPER",
    faction = "swamper",
    missions_offered = "MISSION_SWAMPER_GATHER_MEAT",
}

ccb.content.define_dialogue_topic {
    id = "TALK_SWAMPER",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_swamper" } }),
        yes = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_eating_asked_about_eating" } }),
            yes = ccb.content.text("The eaters will be fed."),
            no = ccb.content.text("Welcome.  Are you hungry friend?"),
        },
        no = ccb.content.text("You look hungry friend.  So much hunger in this world.  This is the time of the eaters."),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_first_meeting_talked_to_swamper", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Hello.  Who are the eaters?"),
            next_topic = "TALK_SWAMPER_EATING",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_eating_asked_about_eating" } })),
            actions = { actions.set_actor_value("speaker", "dialogue_eating_asked_about_eating", "yes") },
        },
        {
            text = ccb.content.text("So about the eaters…"),
            next_topic = "TALK_SWAMPER_EATING",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_eating_asked_about_eating" } }),
        },
        {
            text = ccb.content.text("You mentioned some pretenders before.  What does that mean?"),
            next_topic = "TALK_SWAMPER_PRETENDER",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_NC_SWAMPER_MISSION_1" } }),
        },
        {
            text = ccb.content.text("Would you like to join me on my travels?"),
            next_topic = "TALK_SUGGEST_FOLLOW_SWAMPER",
            when = predicates.negate(predicates.actor_state("interlocutor", "following")),
        },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_SWAMPER",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Is there a way I can help feed the eaters?"),
            next_topic = "TALK_MISSION_LIST_SWAMPER",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_eating_asked_about_eating" } }),
        },
        {
            text = ccb.content.text("I have to get going.  Take care, CEO Baronyx."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SWAMPER_EATING",
    line = ccb.content.text("The great eaters have returned, along with the false ones.  We must feed the eaters and destroy the pretenders, child."),
    replies = {
        {
            text = ccb.content.text("Who are you talking about?"),
            next_topic = "TALK_SWAMPER_EATING2",
        },
        {
            text = ccb.content.text("No thank you, I'd like to leave now."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SWAMPER_EATING2",
    line = ccb.content.text("This Cataclysm has woken the great eaters, lost in time, returned them to the world to do their great work, to multiply and fill the land with their song.  The time of man is over, but we few who remain can do our part to protect this new world from the pretenders, who would steal the meat."),
    replies = {
        {
            text = ccb.content.text("So what do you do with the meat?"),
            next_topic = "TALK_SWAMPER_MEAT",
        },
        {
            text = ccb.content.text("Who are the great eaters and the pretenders?"),
            next_topic = "TALK_SWAMPER_EATING3",
        },
        {
            text = ccb.content.text("Are there any others left?"),
            next_topic = "TALK_SWAMPER_OTHERS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SWAMPER_EATING3",
    line = ccb.content.text("The great eaters are the ones that were lost, what we call dinosaurs, whose meat we took and who are taking it back.  The pretenders are those others that have come to steal the meat of this world.  It does not belong to them and we will take it from their mouths."),
    replies = {
        {
            text = ccb.content.text("Okay, so you worship dinosaurs.  Understood."),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SWAMPER_OTHERS",
    line = ccb.content.text("The Swampers knew these times would return and we prepared for them.  When others wasted their time and meat, we fed and grew strong, and we filled our stores with meat for this day."),
    replies = {
        { text = ccb.content.text("Yes, very good."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text("You keep talking about meat.  Why is meat so important?"),
            next_topic = "TALK_SWAMPER_MEAT",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SWAMPER_MEAT",
    line = ccb.content.text("The meat makes the great eaters strong.  We gather the meat and feed them, and in the end we too will serve the eaters in death as we do in life.  This was always our purpose and we lucky few have lived to see it."),
    replies = {
        {
            text = ccb.content.text("Our purpose?  How do you know?"),
            next_topic = "TALK_SWAMPER_END",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SWAMPER_END",
    line = ccb.content.text("The return of the great eaters was foretold by a prophet.  We faithful have been waiting and preparing since the revelation."),
    replies = {
        {
            text = ccb.content.text("I guess it must be nice to be proven right."),
            next_topic = "TALK_SWAMPER_JOIN",
        },
        { text = ccb.content.text("This is crazy."), next_topic = "TALK_SWAMPER_INSULT" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SWAMPER_JOIN",
    line = ccb.content.text("You understand our purpose.  I welcome you to this work, all are needed to feed the eaters."),
    replies = { { text = ccb.content.text("Thank you."), next_topic = "TALK_SWAMPER" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SWAMPER_INSULT",
    line = ccb.content.text("You deny what you see right in front of you.  This world is what was foretold."),
    replies = { { text = ccb.content.text("Yeah, alright."), next_topic = "TALK_SWAMPER" } },
}

ccb.content.define_mission {
    id = "MISSION_SWAMPER_GATHER_MEAT",
    name = ccb.content.text("Gather meat for Bo Baronyx.  About 8 should do it."),
    difficulty = 1,
    value = 10000,
    goal = "MGOAL_FIND_ITEM",
    item = "meat",
    item_count = 8,
    origins = { "ORIGIN_SECONDARY" },
    finish = {
        actions = {
            ccb.content.dialogue_actions.set_actor_value("speaker", "general_mission_NC_SWAMPER_MISSION_1", "yes"),
            ccb.content.dialogue_actions.purchase_pet("mon_eoraptor", { count = 1, name = ccb.content.text("Bamm-Bamm") }),
        },
    },
    dialogue = {
        describe = ccb.content.text("The eaters are hungry.  They need meat."),
        offer = ccb.content.text("If you wish to feed the eaters, your work will be rewarded.  Go out, butcher a pure animal.  Not a false eater, the meat must be good to eat.  Then bring me the meat and I will see to the eaters."),
        accepted = ccb.content.text("Excellent.  The eaters must feed."),
        rejected = ccb.content.text("Understood.  The great eaters will feed either way."),
        advice = ccb.content.text("Some of the animals have become touched by the pretenders in recent days, larger and more dangerous, producing tainted mutant meat.  This will not work for the great eaters, it must be the true meat."),
        inquire = ccb.content.text("Have you brought meat?"),
        success = ccb.content.text("The eaters will feed.  Oh, this one seems to like you."),
        success_lie = ccb.content.text("The eaters will feed I am sure."),
        failure = ccb.content.text("I see no meat.  There is meat in the forests and swamps waiting for the eaters."),
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_LIST_SWAMPER",
    line = {
        when = predicates.available_missions("interlocutor", 0, 0),
        yes = {
            when = predicates.assigned_missions(0, 0),
            yes = ccb.content.text("The eaters have fed.  They will be hungry again in time."),
            no = {
                when = predicates.assigned_missions(2),
                yes = ccb.content.text("You know what to do."),
                no = ccb.content.text("That is all for now."),
            },
        },
        no = {
            when = predicates.available_missions("interlocutor", 2),
            yes = {
                when = predicates.assigned_missions(0, 0),
                yes = ccb.content.text("The great eaters must be fed.  Are you ready?"),
                no = {
                    when = predicates.assigned_missions(2),
                    yes = ccb.content.text("There is still more work to do.  Are you ready?"),
                    no = ccb.content.text("There is meat ready for the feeding.  Are you ready to gather it?"),
                },
            },
            no = {
                when = predicates.assigned_missions(0, 0),
                yes = ccb.content.text("The eaters are hungry."),
                no = {
                    when = predicates.assigned_missions(2),
                    yes = ccb.content.text("There is more meat needed."),
                    no = ccb.content.text("I know of eaters ready for meat."),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("I see."),
            next_topic = "TALK_NONE",
            when = predicates.available_missions("interlocutor", 0, 0),
        },
        {
            text = ccb.content.text("I'm listening."),
            next_topic = "TALK_MISSION_OFFER_SWAMPER",
            when = predicates.negate(predicates.available_missions("interlocutor", 0, 0)),
        },
        {
            text = ccb.content.text("Maybe another time CEO Baronyx."),
            next_topic = "TALK_NONE",
            when = predicates.negate(predicates.available_missions("interlocutor", 0, 0)),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_OFFER_SWAMPER",
    line = ccb.content.text("If you are ready to be of service to the great eaters, go and find meat and bring it back.  There is always need for more."),
    replies = {
        {
            text = ccb.content.text("Happy to be of service to the great eaters.  I'm in."),
            next_topic = "TALK_MISSION_ACCEPTED_SWAMPER",
            native_actions = { "assign_mission" },
        },
        { text = ccb.content.text("Not interested."), next_topic = "TALK_MISSION_REJECTED_SWAMPER" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_ACCEPTED_SWAMPER",
    line = ccb.content.text("Excellent.  Make it happen."),
    replies = {
        {
            text = ccb.content.text("Consider it done.  But I also wanted to ask…"),
            next_topic = "TALK_SWAMPER",
        },
        {
            text = ccb.content.text("Where should I start?"),
            next_topic = "TALK_MISSION_ADVICE_SWAMPER",
        },
        {
            text = ccb.content.text("Can you share some equipment to aid me in this?"),
            next_topic = "TALK_SHARE_EQUIPMENT_SWAMPER",
        },
        { text = ccb.content.text("I'm off then."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_ADVICE_SWAMPER",
    line = ccb.content.text("The great eaters are not picky, any pure meat will do, but mutant and tainted meat are not good enough."),
    replies = {
        {
            text = ccb.content.text("So, meat from a creature that isn't a zombie, or a giant monster.  Got it."),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SHARE_EQUIPMENT_SWAMPER",
    line = ccb.content.text("Of course, you should find everything you need here."),
    replies = { { text = ccb.content.text("That explains the knives then."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SUGGEST_FOLLOW_SWAMPER",
    line = {
        when = predicates.has_trait("speaker", "seer_mark"),
        yes = ccb.content.text("Oh, you know my friend Brigitte.  Well in that case, let's go!"),
        no = ccb.content.text("No, I must remain here to oversee the company."),
    },
    replies = {
        {
            text = ccb.content.text("Of course CEO Baronyx."),
            next_topic = "TALK_NONE",
            when = predicates.negate(predicates.has_trait("speaker", "seer_mark")),
        },
        {
            text = ccb.content.text("Sweet!"),
            native_actions = { "follow" },
            when = predicates.has_trait("speaker", "seer_mark"),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Not just now.  You should remain here to oversee the company."),
            when = predicates.has_trait("speaker", "seer_mark"),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_REJECTED_SWAMPER",
    line = ccb.content.text("Of course, the company will be ready when you are and the great eaters will feed either way."),
    replies = {
        {
            text = ccb.content.text("Maybe some other time.  Changing the topic…"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("Alright, but I have to go now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SWAMPER_PRETENDER",
    line = ccb.content.text("It was foretold that as the great eaters returned, so too would the pretenders, who would come to steal the meat.  Very little is asked of us, except that we do all we can to ensure that the true great eaters received as much meat as possible and the pretenders go hungry."),
    replies = {
        {
            text = ccb.content.text("Yes CEO Baronyx, very good CEO Baronyx."),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("This makes no sense and I'm done talking about it."),
            next_topic = "TALK_DONE",
        },
    },
}
