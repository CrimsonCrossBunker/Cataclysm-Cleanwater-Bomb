local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Balthazar is not in a good position right now and will try to make people help them out of pity
ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_WEAK",
    line = ccb.content.text("I'm Balthazar and have been stuck in this bunker ever since the sky ruptured!  I don't really know what's happening out there and need someone to help me.  The power to the bunker has been running low and the air & water filtration are failing intermittently."),
    replies = {
        {
            text = ccb.content.text("What do you need help with?"),
            next_topic = "TALK_BALTHAZAR_MEET_DESCRIPTION_WEAK",
        },
        {
            text = ccb.content.text("What's in it for me?"),
            next_topic = "TALK_BALTHAZAR_MEET_REWARD_WEAK",
        },
        {
            text = ccb.content.text("Why don't these robots attack me?"),
            next_topic = "TALK_BALTHAZAR_MEET_ROBOT_WEAK",
        },
        {
            text = ccb.content.text("Hold on, why are you locked in here?"),
            next_topic = "TALK_BALTHAZAR_MEET_BUNKER_WEAK",
        },
        {
            text = ccb.content.text("So who are you?"),
            next_topic = "TALK_BALTHAZAR_MEET_BALTHAZAR_WEAK",
        },
        { text = ccb.content.text("Walk away."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_DESCRIPTION_WEAK",
    line = ccb.content.text("The bunker has a field of solar panels nearby but some of the staff damaged them badly when they turned into those… things.  I need you to gather at least 12 panels so I can stabilize my power output."),
    replies = {
        {
            text = ccb.content.text("Alright, I'll see what I can gather."),
            next_topic = "TALK_BALTHAZAR_MEET_ACCEPTED_MISSION_WEAK",
            actions = { actions.assign_mission("MISSION_GET_SOLAR_PANELS_BALTHAZAR") },
        },
        {
            text = ccb.content.text("What's in it for me?"),
            next_topic = "TALK_BALTHAZAR_MEET_REWARD_WEAK",
        },
        {
            text = ccb.content.text("Why don't these robots attack me?"),
            next_topic = "TALK_BALTHAZAR_MEET_ROBOT_WEAK",
        },
        {
            text = ccb.content.text("Hold on, why are you locked in here?"),
            next_topic = "TALK_BALTHAZAR_MEET_BUNKER_WEAK",
        },
        {
            text = ccb.content.text("So who are you?"),
            next_topic = "TALK_BALTHAZAR_MEET_BALTHAZAR_WEAK",
        },
        { text = ccb.content.text("Walk away."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_ACCEPTED_MISSION_WEAK",
    line = ccb.content.text("You'll help me?!  Thank you so, so much.  I really wasn't looking forward to dying a slow death in here.  I think the power will be enough for a while but please hurry up."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_balthazar_u_discovered_balthazar_fac", "yes"),
            },
            once = "discovered_balthazar",
        },
    },
    replies = {
        {
            text = ccb.content.text("What should I do once I bring them to you?"),
            next_topic = "TALK_BALTHAZAR_MEET_DELIVERY_WEAK",
        },
        { text = ccb.content.text("Walk away."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_DELIVERY_WEAK",
    line = ccb.content.text("I can remotely control a few of the maintenance bots.  All I need you to do is drop them off at the intercom I've managed to set up and I'll get to work installing them."),
    replies = { { text = ccb.content.text("Got it."), next_topic = "TALK_DONE" } },
}

-- Balthazar is not in a good position right now and will act feeble to try and underpay people
ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_REWARD_WEAK",
    line = ccb.content.text("I don't have much.  All I have in here is some MREs, bullets and a few guns so I'll let you take your pick when you bring some panels."),
    replies = {
        {
            text = ccb.content.text("You're locked in there, right?  How would I get them?"),
            next_topic = "TALK_BALTHAZAR_MEET_REWARD_EXCUSE_WEAK",
        },
        {
            text = ccb.content.text("That doesn't sound too promising…"),
            next_topic = "TALK_BALTHAZAR_MEET_REWARD_NEGOTIATE_WEAK_1",
        },
        {
            text = ccb.content.text("Sounds good."),
            next_topic = "TALK_BALTHAZAR_MEET_DESCRIPTION_WEAK_1",
        },
    },
}

-- Balthazar will lie so as to not reveal that they are an AI
ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_REWARD_EXCUSE_WEAK",
    line = ccb.content.text("The airlock is the only part that is malfunctioning, luckily it's connected to the ventilation systems so I made a bot that can traverse them."),
    replies = {
        {
            text = ccb.content.text("Sounds good."),
            next_topic = "TALK_BALTHAZAR_MEET_DESCRIPTION_WEAK",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_REWARD_NEGOTIATE_WEAK_1",
    line = ccb.content.text("W-Wait no, n- no, I- I'll give you all I have.  All I request to keep is some food, a gun, and a bullet for if things get bad."),
    on_enter = {
        { once = "first_negotiations_solar_balthazar", actions = { actions.handler("dlg_a_dda_ad980b24ebca") } },
    },
    replies = {
        {
            text = ccb.content.text("You're locked in there, right?  How would I get them?"),
            next_topic = "TALK_BALTHAZAR_MEET_REWARD_EXCUSE_WEAK",
        },
        {
            text = ccb.content.text("How about a little more, huh?"),
            next_topic = "TALK_BALTHAZAR_MEET_REWARD_NEGOTIATE_WEAK_2",
        },
        {
            text = ccb.content.text("That's better."),
            next_topic = "TALK_BALTHAZAR_MEET_DESCRIPTION_WEAK",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_REWARD_NEGOTIATE_WEAK_2",
    line = ccb.content.text("I-I-What?  It's all I have, I can't give you more."),
    on_enter = {
        { once = "second_negotiations_solar_balthazar", actions = { actions.handler("dlg_a_dda_48f3c26bafa2") } },
    },
    replies = {
        {
            text = ccb.content.text("Surely you have something more exotic in there."),
            next_topic = "TALK_BALTHAZAR_MEET_REWARD_NEGOTIATE_WEAK_3",
        },
        {
            text = ccb.content.text("So you also don't have anything else in the \"control center\"?"),
            next_topic = "TALK_BALTHAZAR_MEET_REWARD_NEGOTIATE_WEAK_CAUGHT",
            when = predicates.handler("dlg_p_dda_afc82d95f444"),
        },
        {
            text = ccb.content.text("Fine."),
            next_topic = "TALK_BALTHAZAR_MEET_DESCRIPTION_WEAK",
        },
        {
            text = ccb.content.text("No deal."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_REWARD_NEGOTIATE_WEAK_3",
    line = ccb.content.text("Y- You know what?  Fuck you, I'll just wait for someone else."),
    on_enter = { { actions = { "end_conversation" } } },
    replies = { { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_ROBOT_WEAK",
    line = ccb.content.text("This bunker has a control center for the local bots so I made them only attack when attacked first."),
    on_enter = {
        { once = "knows_control_center", actions = { actions.handler("dlg_a_dda_219009214fa4") } },
    },
    replies = {
        {
            text = ccb.content.text("Sounds useful."),
            next_topic = "TALK_BALTHAZAR_MEET_DESCRIPTION_WEAK",
        },
        {
            text = ccb.content.text("So you do have some tech you can give me."),
            next_topic = "TALK_BALTHAZAR_MEET_REWARD_NEGOTIATE_WEAK_CAUGHT",
            when = predicates.handler("dlg_p_dda_a29af93c992a"),
        },
        {
            text = ccb.content.text("Walk away."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_REWARD_NEGOTIATE_WEAK_CAUGHT",
    line = ccb.content.text("Wh- Alright, you got me, I can offer you a bot from the control center as well, but that is truly all I have."),
    on_enter = {
        { once = "third_negotiations_solar_balthazar", actions = { actions.handler("dlg_a_dda_cfe8d38967d1") } },
    },
    replies = {
        {
            text = ccb.content.text("I knew you had more."),
            next_topic = "TALK_BALTHAZAR_MEET_DESCRIPTION_WEAK",
        },
        {
            text = ccb.content.text("Surely you have some more in there."),
            next_topic = "TALK_BALTHAZAR_MEET_REWARD_NEGOTIATE_WEAK_3",
        },
        {
            text = ccb.content.text("Walk away."),
            next_topic = "TALK_DONE",
        },
    },
}

-- This never happened, Balthazar took advantage of the confusion that the Cataclysm brought and shot the guards in its lucidity.
ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_BUNKER_WEAK",
    line = ccb.content.text("When the riots were getting bad, we were assigned to hold this bunker for some eggheads.  Then when the skies broke some of my comrades just started shooting all around, so I fled into this bunker.  Something messed with the doors and I've been locked in here since."),
    replies = {
        {
            text = ccb.content.text("That sounds rough."),
            next_topic = "TALK_BALTHAZAR_MEET_BUNKER_FOLLOWUP_WEAK",
        },
        {
            text = ccb.content.text("So who are you?"),
            next_topic = "TALK_BALTHAZAR_MEET_BALTHAZAR_WEAK",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_BUNKER_FOLLOWUP_WEAK",
    line = ccb.content.text("Just gotta keep my head down and focus on the now."),
    replies = {
        {
            text = ccb.content.text("Good luck."),
            next_topic = "TALK_BALTHAZAR_MEET_DESCRIPTION_WEAK",
        },
    },
}

-- Balthazar is, as usual, lying through their teeth
ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_BALTHAZAR_WEAK",
    line = ccb.content.text("I'm a combat engineer who got sent here to hold this bunker.  I guess I'm still accomplishing that, huh."),
    replies = {
        {
            text = ccb.content.text("I guess so."),
            next_topic = "TALK_BALTHAZAR_MEET_DESCRIPTION_WEAK",
        },
        {
            text = ccb.content.text("How come you're locked up?"),
            next_topic = "TALK_BALTHAZAR_MEET_BUNKER_WEAK",
        },
    },
}

-- Balthazar is in a good position right now and will treat people as buyable goods
-- Not implemented yet, will start from second mission onward
ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_STRONG",
    line = ccb.content.text("I have no need for you right now."),
    replies = { { text = ccb.content.text("Walk away."), next_topic = "TALK_DONE" } },
}
