local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_2_STORY1",
    line = ccb.content.gendered_line("Same as most people who didn't get killed straight up during the riots.  I went to one of those stupid <freaking> evacuation death traps.  I actually lived there for a while with three others.  One guy who I guess had watched a lot of movies kinda ran the show, because he seemed to really know what was going on.  Spoiler alert: he fucking didn't.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What happened to your original crew?"),
            when = predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDNO")),
            trial = {
                kind = "persuade",
                difficulty = 30,
                modifiers = { { score = "BRAVERY", scale = 1 }, { score = "TRUST", scale = 1 } },
            },
            success = { next_topic = "BGSS_EVACUEE_2_STORY2" },
            failure = { next_topic = "BGSS_EVACUEE_2_NOTYET" },
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_2_STORY2",
    line = ccb.content.gendered_line("Things went south when our fearless leader decided we had to put down one of the other survivors that had been bitten.  Her husband felt a bit strongly against that, and I wasn't too keen on it either; by this point, he'd already been wrong about a lot.  Well, he took matters into his own hands and killed her.  Then her husband decided one good turn deserves another, and killed the idiot.  And then she got back up and I killed her again, and pulped our former leader.  Unfortunately she'd given her husband a hell of a nip during the struggle, when he couldn't get his shit together enough to fight back.  Not that I fucking blame him.  We made it out of there together, but it was too much for him, he clearly wasn't in it anymore… the bite got infected, but it was another <zombie> that finally killed him.  And then I was alone.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_2_NOTYET",
    line = ccb.content.text("What do you think happened?  You see them around anywhere?"),
    on_enter = {
        {
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 14000 }) },
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_EVACUEE_2_IDEAS1",
    line = ccb.content.gendered_line("Well, I assume you know about the riots and the military and police and the freakin' nightmare monsters walking the earth beside zombies, right?  If you're asking what I think caused it all, well, I dunno.  My best guess it was some huge government overreach, maybe some kind of experimental bioweapon that got away.  They tried to lie so much at the start about everything that was going on, I don't think the whole 'Chinese attack' shit measures up.  They were trying to cover something up.  As for the real end times, maybe the rest of the world tried to contain it.  I heard there were honest-to-god nukes going off here on American soil.  To me that seems like somewhere else, maybe Europe, trying to get whatever is going on here contained.  Maybe it even worked.  It's bad now but it's not like it was.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
