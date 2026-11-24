local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_LUMBERMILL_LOGGER",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_talked_to_logger" } }),
        yes = ccb.content.text("Hello there.  Nice to see you, <name_g>."),
        no = ccb.content.text("A stranger out here?  Who are you?"),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_first_meeting_talked_to_logger", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you."),
            next_topic = "TALK_NPC_LUMBERMILL_LOGGER_INTRO",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_talked_to_logger" } })),
        },
        {
            text = ccb.content.text("Hands up, <name_b>!"),
            trial = { kind = "intimidate", difficulty = 30 },
            success = {
                next_topic = "TALK_WEAPON_DROPPED",
                actions = { "drop_weapon" },
                opinion = { trust = -4, fear = 3 },
            },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_talked_to_logger" } })),
        },
        {
            text = ccb.content.text("Pleasure to see you again."),
            next_topic = "TALK_NPC_LUMBERMILL_LOGGER_INTRO",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_talked_to_logger" } }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_LUMBERMILL_LOGGER_MISSION_WAREHOUSE",
    line = {
        joined = {
            ccb.content.text("&You describe the warehouse to the best of your ability.  The logger considers for a moment"),
            {
            when = predicates.any_equal({ "no", { scope = "interlocutor", key = "exodii_mission_wh_correct" } }),
            yes = ccb.content.gendered_line(", then frowns.  \"I think I'd remember something like that, no.  Sorry.\"", { "interlocutor" }),
            no = ccb.content.gendered_line(", looking thoughtful.  \"You know, around the time things really went bad, I remember a really awful portal storm.  A while later, I saw something like that in the distance.  Could be what you're talking about.\"", { "interlocutor" }),
        },
        },
    },
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "asked_about_exodii_warehouse_mission", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Oh well.  Thanks anyway.  I'll go ask around."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "no", { scope = "interlocutor", key = "exodii_mission_wh_correct" } }),
            actions = { actions.handler("dlg_a_dda_399f0cdb5f50") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_LUMBERMILL_LOGGER_TALK_TO_MANAGER",
    line = {
        choices = {
            ccb.content.text("You mean you're still looking for wood?  Crazy… but we had a suspicion folks might show up in an emergency.  Talk to the manager if you want to make an order."),
            ccb.content.text("Well, the machinery works just fine.  We were always self-sufficient and <the_cataclysm> only really made that more apparent.  So if you want to place an order and help keep the operation running, talk to the manager.  We'll trade you for our wood."),
        },
    },
    replies = { { text = ccb.content.text("Sounds good, thanks."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_LUMBERMILL_LOGGER_STORY",
    line = {
        when = predicates.has_trait("interlocutor", "BGSS_No_Past_2"),
        yes = ccb.content.gendered_line("I'll be honest, I don't remember a whole lot about what I was doing here.  I know that I cut trees, but not much else.  Good thing I have friends here, they've helped me out a lot.", { "interlocutor" }),
        no = {
            when = predicates.has_trait("interlocutor", "BGSS_No_Past_3"),
            yes = ccb.content.gendered_line("I'll be honest, I don't remember a whole lot about what I was doing here.  I know that I cut trees, but not much else.  Good thing I have friends here, they've helped me out a lot.", { "interlocutor" }),
            no = {
                choices = {
                    ccb.content.gendered_line("Not much to it.  I worked here as a logger before <the_cataclysm> began.  When all went to hell, I was on the job and had to hole up here with my coworkers.  Good news is we all came out fine, and the boss decided to keep the mill running.  I don't know how much longer we can last, though; not unless we make some contact with other people.  Customers, I guess you might call 'em.", { "interlocutor" }),
                    ccb.content.text("Well, I'm a logger here.  Seasonal work but good pay… or it was, at least.  Before that first <zombie> showed up and made it clear how bad things were really getting."),
                    ccb.content.text("I'm a lumberjack out here.  Things were quiet for a long time.  We're pretty far out in the woods so it was kind of a shock to find out just how bad it'd gotten in civilization.  We had a couple close run-ins ourselves.  My friend over there almost got eaten!  But we still have resources that I'm sure people can use."),
                    ccb.content.text("My comrades and I were lucky to be in the right place at the right time, I suppose.  We keep really busy out here, so we didn't expect <the_cataclysm> to land right in our lap like that.  Luckily these axes can chop more than wood.  They'll take a good chunk out of anything nasty that threatens our mill."),
                    ccb.content.text("Well, I work here.  Welcome to the mill.  Used to be trucks in and out of here all the time but you're the first face we've seen in a while."),
                    ccb.content.gendered_line("New to the job… or, well, whatever's happening now.  I still cut trees and run logs through the saw from time to time, so I guess you'd call me a logger.  Things have only gotten weirder after those fucking <zombies> nearly killed us.  I'm not sure how much longer we'll last…", { "interlocutor" }),
                },
            },
        },
    },
    replies = { { text = ccb.content.text("Hope it goes well."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_LUMBERMILL_LOGGER_INTRO",
    line = ccb.content.text("Do you need something?"),
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_NPC_LUMBERMILL_LOGGER_STORY",
        },
        {
            text = ccb.content.text("I'd like to ask you a few questions."),
            next_topic = "TALK_FRIEND_CONVERSATION",
            when = predicates.handler("w16b_p_dda_13cced564466"),
        },
        {
            text = ccb.content.text("I'm looking for a specific, strange building.  I wonder if you've heard anything about it?"),
            next_topic = "TALK_NPC_LUMBERMILL_LOGGER_MISSION_WAREHOUSE",
            when = predicates.all({ predicates.has_mission("EXODII_MISSION_WAREHOUSE"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "asked_about_exodii_warehouse_mission" } })) }),
            actions = { actions.handler("w16b_a_dda_9812bef589e2") },
        },
        {
            text = ccb.content.text("How do things work around here now?"),
            next_topic = "TALK_NPC_LUMBERMILL_LOGGER_TALK_TO_MANAGER",
        },
        {
            text = ccb.content.text("Any jobs you need done?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.all({ predicates.negate(predicates.assigned_missions(1, 1)), predicates.negate(predicates.assigned_missions(2)) }),
        },
        {
            text = ccb.content.text("Nah, see ya."),
            next_topic = "TALK_DONE",
        },
    },
}
