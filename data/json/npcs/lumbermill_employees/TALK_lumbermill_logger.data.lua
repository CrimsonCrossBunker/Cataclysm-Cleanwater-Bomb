local ccb = require("ccb")
local actions = ccb.content.dialogue_actions
local predicates = ccb.content.dialogue_predicates



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
