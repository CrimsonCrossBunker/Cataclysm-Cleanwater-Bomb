local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_RURAL_1_STORY1",
    line = {
        choices = {
            {
                when = predicates.actor_state("interlocutor", "female"),
                yes = ccb.content.text("I lived alone, on the old family property way out of town.  My husband passed away a bit over a month before this started… cancer.  If anything good has come out of all this, it's that I finally see a positive to losing him so young.  I'd been shut in for a while anyway.  When the news started talking about Chinese bio weapons and sleeper agents, and showing the rioting in Boston and such, I curled up with my canned soup and changed the channel."),
                no = ccb.content.text("I lived alone, on the old family property way out of town.  My wife passed away a bit over a month before this started… cancer.  If anything good has come out of all this, it's that I finally see a positive to losing her so young.  I'd been shut in for a while anyway.  When the news started talking about Chinese bio weapons and sleeper agents, and showing the rioting in Boston and such, I curled up with my canned soup and changed the channel."),
            },
        },
    },
    replies = {
        { text = ccb.content.text("What happened next?"), next_topic = "BGSS_RURAL_1_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_RURAL_1_STORY2",
    line = ccb.content.gendered_line("Well, it built up a bit.  There was that acid rain, it burnt up one of my tractors.  Not that I'd been working the fields since… well, it'd been a terrible year and I hadn't done much worth doing.  There were explosions and things, and choppers overhead.  I was scared, kept the curtains drawn, kept changing the channels.  Then, one day, there were no channels to change to.  Just the emergency broadcast, over and over.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("What happened next?"), next_topic = "BGSS_RURAL_1_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_RURAL_1_STORY3",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_BGSS_rural_1_started_quest" } }),
        yes = ccb.content.gendered_line("That was the first thing to really shake me out of it.  I didn't really have any very close friends, but there were people back in town I cared about a bit.  I had sent some texts, but I hadn't really twigged that they hadn't replied for days.  I got in my truck and tried to get back to town.  Didn't get far before I hit a <zombie> infested pileup blocking the highway, and that's when I started to put it all together.  Never did get to town.  Unfortunately I led the <zombies> back to my farm, and had to bug out of there.  And now I'm here with you.", { "interlocutor" }),
        no = ccb.content.gendered_line("That was the first thing to really shake me out of it.  I didn't really have any very close friends, but there were people back in town I cared about a bit.  I had sent some texts, but I hadn't really twigged that they hadn't replied for days.  I got in my truck and tried to get back to town.  Didn't get far before I hit a <zombie> infested pileup blocking the highway, and that's when I started to put it all together.  Never did get to town.  Unfortunately I led the <zombies> back to my farm, and had to bug out of there.  Might go back and clear it out, someday.", { "interlocutor" }),
    },
    replies = {
        {
            text = ccb.content.text("I could help you clear out your farm if you wanted.  You just have to show me the way…"),
            when = predicates.handler("w16b_p_dda_90b0afd7b6d0"),
            trial = { kind = "persuade", difficulty = 30, modifiers = { { score = "TRUST", scale = 6 }, { score = "VALUE", scale = 3 }, { score = "ANGER", scale = -6 } } },
            success = { next_topic = "BGSS_RURAL_1_FARMSUCCESS", actions = { actions.handler("w16b_a_dda_31d3731a9cd1") } },
            failure = { next_topic = "BGSS_RURAL_1_FARMFAILURE", actions = { actions.handler("w16b_a_dda_73816ff3f794"), actions.set_actor_value("speaker", "general_BGSS_rural_1_asked_about_quest", "yes") }, opinion = { trust = -1 } },
        },
        {
            text = ccb.content.text("Thanks for telling me that.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("<end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_RURAL_1_FARMSUCCESS",
    line = ccb.content.text("I guess you look sturdy enough to take them on.  I marked the spot for you."),
    replies = {
        {
            text = ccb.content.text("Thanks for the directions.  I'll check it out."),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_RURAL_1_FARMFAILURE",
    line = ccb.content.text("I don't know if I trust you quite like that, just giving away so many personal details all at once.  Maybe later…"),
    replies = { { text = ccb.content.text("Sorry, didn't mean to intrude."), next_topic = "TALK_NONE" } },
}

ccb.content.define_mission {
    id = "directions_rural_1_FARM",
    name = ccb.content.text("Check out that farm"),
    description = ccb.content.text("You were told to check out a farm that might be infested with zombies."),
    goal = "MGOAL_GO_TO",
    difficulty = 3,
    value = 0,
    start = {
        target = { special = "Farm Mutable", terrain = "farm_3", reveal_radius = 3 },
        handler = "mark_mission_BGSS_rural_1_started_quest",
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("Any luck finding the farm?"),
        success = ccb.content.text("I don't know how I can ever make it up to you!  I barely made it out of this place alive.  I wasn't sure I'd ever see it again, to be honest."),
        success_lie = ccb.content.text("Great!"),
        failure = ccb.content.text("I guess I don't blame you.  I knew it wouldn't be easy."),
    },
}
