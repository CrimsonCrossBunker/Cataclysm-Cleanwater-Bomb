local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Project2",
    line = {
        when = predicates.handler("dlg_p_dda_14d6d86ed426"),
        yes = ccb.content.text("They're pretty big.  This isn't something you'd carry around with you.  They fire .30 cal bullets using compressed air that we'd make inside the basement and then pipe up to individual storage tanks for the guns that would be good for a few hundred shots each.  The design should be capable of auto or semi-auto fire, at a range that's pretty comparable to a gunpowder-based weapon.  It takes out some of the most limited parts of ranged weapons: no gunpowder, no brass casings, just lead that we melt into my mold.  It's not soundless, but it's not as loud as a chemical weapon.  There are tons of advantages.  Only trouble is, I can't convince the Free Merchants to give me the parts I need, even though it's for our own defense.\"  She grimaces.  \"Being one of the 'surface people' is so frustrating.  I'm pretty sure they talk about these decisions downstairs, behind our backs, and we're just not part of the process and can't advocate for our own projects."),
        no = ccb.content.text("Well, these things are a standard .30 caliber.  They should be compatible with any similar rifle barrel.  It would be pretty easy to repurpose some rifle parts into large air weapons that we could use without relying on gunpowder, and without so much noise.  I'm still drawing up an actual design though, I have a bunch of features I want.  Ask me again in a couple weeks and I'll give you some more info."),
    },
    replies = {
        {
            text = ccb.content.text("Is there some way I can help you get the stuff you need?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.handler("dlg_p_dda_14d6d86ed426"),
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Project3",
    line = {
        when = predicates.handler("dlg_p_dda_f8ea0408a5a9"),
        yes = {
            when = predicates.handler("dlg_p_dda_f7b8fa61ed7a"),
            yes = ccb.content.text("It's finally ready!  The pipes are laid to the first patch of ground we'll set turrets up in and I'd like for you to join me to go inspect how they are working.  I'll let you know when I'm ready to go."),
            no = ccb.content.text("I'm really making headway.  We've done some live demonstrations with a working device, and now it's just a matter of manufacturing a few of them.  We should be ready for release in a week or two."),
        },
        no = ccb.content.gendered_line("Things are coming along.  I have a lot of studying to do before I know how to fix my design issues, but the book you brought definitely has everything I need.  Now that I've got some progress to show, administration is much more willing to help me get the parts I need.  You've been a great gofer, but I can probably handle the rest on my own.  Check back in a week or two!", { "speaker" }),
    },
    replies = {
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Personal1",
    line = {
        when = predicates.handler("dlg_p_dda_37c4c4e2de83"),
        yes = {
            when = predicates.handler("dlg_p_dda_14d6d86ed426"),
            yes = {
                when = predicates.handler("dlg_p_dda_179329b6cb3b"),
                yes = ccb.content.text("It's getting bad.  We've been stuck in here for months, nothing changing, nothing improving.  We can't go outside, we don't have enough to eat, and we didn't choose to be with each other.  I don't know how long we can stay like this before somebody snaps."),
                no = ccb.content.text("There's good and there's bad.  We're all pretty sick of being cooped up in here for months, never knowing if there's going to be food to eat or not.  It's starting to look like they're never going to let us go down to the secure basement, and none of us have slept well since we were brought in.  We know we've got it pretty good… we're safe, we're alive.  It's just, like, what kind of life are we even living?"),
            },
            no = ccb.content.text("It's been over a month now, so I guess I'm starting to get used to it.  Things were pretty rough after Sean died, but it wasn't our first big loss and it won't be the last I guess.  I've made a couple friends, and in a weird way we're all like family.  We were all hoping they'd let us downstairs sooner than this though.  We're never quite sure if there's going to be enough food to go around.  I'm really hoping I can lose myself in this project.  Still haven't had a good night's sleep since <the_cataclysm>."),
        },
        no = ccb.content.text("Living here?  Yeah, I guess I live here now.  It's… it's weird.  We're crowded into this tiny space, I don't know these people, but we're sharing bathrooms and we've all been through the same stuff.  It's not great.  At night we can hear the <zombies> outside, and we all just lie there awake, thinking the same things but too scared to talk about it."),
    },
    replies = {
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
