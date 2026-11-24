local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- A generic guard for the Free Merchants faction.
ccb.content.define_npc {
    id = "guard",
    suffix = ccb.content.text("Guard"),
    class = "NC_FREE_MERCH_GUARD",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_GUARD",
    faction = "free_merchants",
}

-- Night shift guard for the Free Merchants faction.
ccb.content.define_npc {
    id = "night_guard",
    suffix = ccb.content.text("Guard"),
    class = "NC_FREE_MERCH_GUARD_NIGHT",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_GUARD",
    faction = "free_merchants",
}

ccb.content.define_dialogue_topic {
    id = "TALK_GUARD",
    line = {
        choices = {
            ccb.content.text("I'm not in charge here, you're looking for someone else…"),
            ccb.content.text("Keep civil or I'll bring the pain."),
            ccb.content.text("Just on watch, move along."),
            ccb.content.text("Don't distract me.  I'm on watch."),
            {
                when = predicates.conversation_state("daylight"),
                yes = { choices = { ccb.content.text("Hello.  Welcome to our safe zone.") } },
                no = { choices = { ccb.content.text("Good evening.  Welcome to our safe zone.") } },
            },
            {
                when = predicates.actor_state("speaker", "male"),
                yes = {
                    choices = { ccb.content.text("Sir."), ccb.content.text("Rough out there, isn't it?") },
                },
                no = {
                    choices = {
                        ccb.content.text("Ma'am"),
                        ccb.content.text("Ma'am, you really shouldn't be traveling out there."),
                    },
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you offer any help?"),
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
            next_topic = "TALK_GUARD_Boris_Mission_1",
        },
        {
            text = ccb.content.text("How did you get saddled with guard duty?"),
            next_topic = "TALK_GUARD_FM_BACKGROUND",
        },
        {
            text = ccb.content.text("Heard anything about an helicopter crash?"),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "sunken_helicopter_tip_offer" } }), predicates.negate(predicates.has_mission("MISSION_FIND_SUNKEN_HELICOPTER")) }),
            next_topic = "TALK_GUARD_FM_SUNKEN_HELICOPTER_ANECDOTE",
        },
        { text = ccb.content.text("Don't mind me…"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GUARD_FM_BACKGROUND",
    line = {
        choices = {
            ccb.content.text("Nothing too fancy.  We have a rota of anyone able bodied that can handle themselves."),
            ccb.content.text("None of your business really, is it."),
            ccb.content.gendered_line("I've seen my share of zombies, I'm one of the ones that's ready to take em on.  Nothing more.", { "interlocutor" }),
            ccb.content.text("Gotta earn my keep."),
            ccb.content.text("It's honest work, and now and then I get to take a zombie down."),
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GUARD_Boris_Mission_1",
    line = {
        choices = {
            ccb.content.text("Talk to one of the bosses about that.  You'd have to pay me to go back there though, that's gonna be a hell of a job."),
            ccb.content.text("I don't have a lot of free time for that sort of thing.  Maybe talk to the shopkeep, they know more about scheduling and stuff."),
            ccb.content.text("Nah."),
            ccb.content.text("I'd rather stand around looking threatening than scrub gore out of the tiles."),
            ccb.content.text("Not unless you pay me.  Try the shopkeep, they can sell our services just like anything else."),
        },
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes"),
            },
        },
    },
    replies = { { text = ccb.content.text("Well, thanks anyway."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GUARD_FM_SUNKEN_HELICOPTER_ANECDOTE",
    line = {
        choices = {
            ccb.content.text("Sure yeah, I remember, I was on caravan duty when I saw it, it got caught in of those weird storms, as we started driving away I heard a big splash sound."),
            ccb.content.text("No, sorry…"),
            ccb.content.text("I didn't see it myself but I heard the rumors about it, apparently it crashed somewhere nearby but I haven't seen any smoke or corpse."),
            ccb.content.text("Oh the helicopter?  Yeah, I tried finding the crash site around where the guy said he heard the crash but I didn't find nothing."),
            ccb.content.text("The crashed helicopter?  Eh, I'm pretty sure it's just a story, no one ever found anything."),
            ccb.content.text("Oh, yes, what a story, I almost wish I had been there to see it, almost."),
            ccb.content.text("Yeah I was part of the caravan that spotted it, it was headed east then when the storm broke out it got caught by some kind of creature, I heard gunshots then it started flying down rapidly, I heard it crash but I'm not sure where exactly."),
            ccb.content.text("Yes I was told the story by the others, I'm glad I wasn't there though, I hate those storms."),
            ccb.content.text("I dunno, I wasn't there but I overheard some guy talking about it."),
            ccb.content.text("You know how it is, people talk, I mean sure, there was one of those weird storms at the time but the helicopter story?  I don't believe it."),
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
