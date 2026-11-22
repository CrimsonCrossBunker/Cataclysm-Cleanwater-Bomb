local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE6",
    line = {
        choices = {
            {
            when = predicates.handler("dlg_p_dda_6e953b181395"),
            yes = ccb.content.gendered_line("&<npc_name> sighs and pauses for a moment.\n\n\"It's been so long now.  I barely even remember what I was doing.  There was so much confusion and violence in those last days.  My family didn't understand the threat, even though I tried to tell them.  I know what you think I am, but look what's happened!  The dead are walking, the sky is cracking open, and…  well, I can't even talk about it.  Isn't it obvious something bigger is going on?\"", { "interlocutor" }),
            no = ccb.content.text("&<npc_name> sighs and pauses for a moment.\n\n\"Listen…  I know what you think I am, but the threats are real.  The dead are walking, strange hellspawn crawling out of…  well, I can't even talk about it.  Whatever demonic, technological abomination, bio-weapon the communists unleashed on the world is definitely out of their control.  Look around you!  Isn't it obvious something bigger is going on?\""),
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("Something bigger?  You mean you think someone did this intentionally?"),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE7",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE7",
    line = {
        choices = {
            {
            when = predicates.handler("dlg_p_dda_6e953b181395"),
            yes = ccb.content.gendered_line("I thought I knew at one point.  There were so many signs of manipulation and control.  I thought maybe they were trying to discredit the protests, but when the violence broke out it seemed to be everywhere.  There was footage on the news of people fighting, destroying property, eating animals and… each other in the street.  I thought at some point they were going to sweep in and seize control, but it just never happened.", { "interlocutor" }),
            no = ccb.content.text("It's an invasion.  Or, at least, I think that's what they were trying to do at first.  Sudden bouts of violence, sending agitators to riots, doing false flags with covert and overt agents alike…  When they couldn't get what they wanted, they went full 'scorched earth'.  They decided to destroy everything instead."),
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("What do you mean?  Who is 'they'?"),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE8",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE8",
    line = {
        choices = {
            {
            when = predicates.handler("dlg_p_dda_6e953b181395"),
            yes = ccb.content.text("The government.  Whoever was left, really.  I don't know…  I'm starting to think that maybe some of those folks were right…  Maybe this is some kind of punishment for humanity.  Maybe some god decided they'd had enough of us.  Or maybe there's no answer.  I can't explain some of the things I've seen."),
            no = ccb.content.gendered_line("You know, the elites.  The ones who have always had control will continue having control, no matter what it costs.  If it means destroying everything to be king of the ashes, they'll do it.  I used to think it was China, for sure, but I'm not so sure anymore.  I figured they would probably be here by now, putting on their crown.  Maybe they're still waiting to make their move…", { "interlocutor" }),
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("I think you might be right.  The government probably does have something to do with it."),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE9_GOVERNMENT",
        },
        {
            text = ccb.content.text("[Spiritual] I feel like this could definitely be some kind of divine punishment."),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE9_GOD",
            when = predicates.has_trait("speaker", "SPIRITUAL"),
        },
        {
            text = ccb.content.text("Maybe the explanation is more scientific.  Zombies and flesh-eating monsters only come from supervillains and gods in fiction."),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE9_SKEPTIC",
            when = predicates.all({ predicates.minimum_attribute("speaker", "intelligence", 7), predicates.negate(predicates.has_trait("speaker", "SPIRITUAL")) }),
        },
        {
            text = ccb.content.text("[US Marshal] I actually used to be a US Marshal, and there were crazy rumors coming from all over back in the day.  A buddy of mine heard that China built a portal to another dimension.  Or a time machine.  Someone else claimed it was America who made it, and it was actually some kind of doomsday device.  There was a lot of money getting sunk into the Department of Energy, DARPA, military contractors…  We all knew something was up, but it was impossible to say what."),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE9_FED",
            when = predicates.has_any_trait("speaker", { "PROF_FED" }),
        },
        {
            text = ccb.content.text("[Hub 01 Ancillary] I have an idea what happened.  This might sound strange, but I've been doing jobs for these people in a hidden bunker who gave me some high-tech armor and told me our reality… 'broke' somehow.  That's why those crazy portal storms keep happening.  They also told me it's probably going to get worse."),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE9_HUB01",
            when = predicates.has_any_trait("speaker", { "PROF_HUB01_ANCILLIARY" }),
        },
        {
            text = ccb.content.text("I met this woman who was… uh… obsessed with bones?  She said that since <the_cataclysm>, the bones of living things 'hum' with some kind of special power and that she wants to collect lots of them to either end the world or save the world.  I'm honestly still not entirely clear how or what's supposed to happen…  How about that idea?  Did THAT ever cross your mind?"),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE9_BONE_SEER",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } }),
        },
        {
            text = ccb.content.text("Honestly, it's probably aliens.  I can't really think of another reasonable explanation for all of this."),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE9_ALIENS",
        },
        {
            text = ccb.content.text("I don't think there's any explanation.  Sometimes bad things just happen."),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE9_CHAOS",
        },
    },
}
