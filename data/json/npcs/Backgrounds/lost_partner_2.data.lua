local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_2_STORY1",
    line = {
        when = predicates.has_effect("interlocutor", "player_BGSS_SAIDNO"),
        yes = ccb.content.gendered_line("I said, I don't wanna talk about it.  How are you not understanding this?", { "interlocutor" }),
        no = {
            when = predicates.has_effect("interlocutor", "player_BGSS_SAIDYES"),
            yes = ccb.content.gendered_line("Like I said, it's a lame story, but I guess it won't kill me to tell it one more time.", { "interlocutor" }),
            no = ccb.content.text("Just another fucked-up tale of love and loss.  Not one I like to tell."),
        },
    },
    replies = {
        {
            text = ccb.content.text("It might help to get it off your chest."),
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDNO")), predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDYES")) }),
            trial = {
                kind = "persuade",
                difficulty = 50,
                modifiers = { { score = "TRUST", scale = 2 }, { score = "VALUE", scale = 3 } },
            },
            success = { next_topic = "BGSS_LOST_PARTNER_2_STORY2" },
            failure = { next_topic = "BGSS_LOST_PARTNER_2_NOTYET" },
        },
        {
            text = ccb.content.text("Suck it up.  If we're going to work together I need to know you."),
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDNO")), predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDYES")) }),
            trial = {
                kind = "intimidate",
                difficulty = 50,
                modifiers = {
                    { score = "BRAVERY", scale = 2 },
                    { score = "TRUST", scale = 1 },
                    { score = "ANGER", scale = -2 },
                },
            },
            success = { next_topic = "BGSS_LOST_PARTNER_2_STORY2" },
            failure = { next_topic = "BGSS_LOST_PARTNER_2_FUCKOFF" },
        },
        {
            text = ccb.content.text("You said you lost someone."),
            when = predicates.has_effect("interlocutor", "player_BGSS_SAIDYES"),
            next_topic = "BGSS_LOST_PARTNER_2_STORY3",
        },
        {
            text = ccb.content.text("Never mind.  Sorry I brought it up."),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_2_NOTYET",
    line = ccb.content.text("I appreciate the sentiment, but I don't think it would.  Drop it."),
    replies = {
        {
            text = ccb.content.text("OK."),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 7000 }) },
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 7000 }) },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_2_FUCKOFF",
    line = ccb.content.text("Oh, just shut the fuck up already.  This doesn't have anything to do with you, or with us."),
    replies = {
        {
            text = ccb.content.text("…"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 14000 }) },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_2_STORY2",
    line = {
        choices = {
            {
                when = predicates.actor_state("interlocutor", "female"),
                yes = ccb.content.text("All right, fine.  I had someone.  I lost him."),
                no = ccb.content.text("All right, fine.  I had someone.  I lost her."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("What happened?"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "BGSS_LOST_PARTNER_2_STORY3",
        },
        {
            text = ccb.content.text("Never mind.  Sorry I brought it up."),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_2_STORY3",
    line = {
        choices = {
            {
                when = predicates.actor_state("interlocutor", "female"),
                yes = ccb.content.text("He was at home when the bombs started dropping and the world went to hell.  I was at work.  I tried to make it to our house, but the city was a war zone.  Things I can't describe lurching through the streets, crushing people and cars.  Soldiers trying to stop them, but hitting people in the crossfire as much as anything.  And then the collateral damage would get right back up and join the enemy.  If it hadn't been for my husband, I would have just left, but I did what I could and I slipped through.  I actually made it alive."),
                no = ccb.content.text("She was at home when the bombs started dropping and the world went to hell.  I was at work.  I tried to make it to our house, but the city was a war zone.  Things I can't describe lurching through the streets, crushing people and cars.  Soldiers trying to stop them, but hitting people in the crossfire as much as anything.  And then the collateral damage would get right back up and join the enemy.  If it hadn't been for my wife, I would have just left, but I did what I could and I slipped through.  I actually made it alive."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("You must have seen some shit."),
            next_topic = "BGSS_LOST_PARTNER_2_SOMESHIT",
        },
        {
            text = ccb.content.text("I take it home was bad."),
            next_topic = "BGSS_LOST_PARTNER_2_HOME1",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_2_SOMESHIT",
    line = ccb.content.gendered_line("Yeah.  I really did.  It took me two days to make it across the city on foot, camping out in dumpsters and places like that.  I started moving more by night, and I learned right away to avoid the military.  They were a magnet for the <zombies>, and they were usually stationed where the monsters were coming.  Some parts of the city were pretty tame at first.  There were a few chunks where people had been evacuated or cleared out, and the <zombies> didn't really go there.  Later on, others like me started moving into those neighborhoods, so I switched and started running through the blasted out downtown.  I had to anyway, to get home.  By the time I made the switch though, the fighting was starting to die off, and I was mostly just avoiding attention from zombies and other things.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("I take it home was bad."),
            next_topic = "BGSS_LOST_PARTNER_2_HOME1",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_2_HOME1",
    line = ccb.content.gendered_line("The first warning was that I had to move from the preserved parts of the city to the burnt out ones to get home.  It only got worse.  There was a police barricade right outside my house, with a totally useless pair of automated turrets sitting in front just idly watching the zombies lurch by.  That was before someone switched them to kill everybody, back when it only killed trespassing humans.  Good times, you can always trust bureaucracy to fuck things up in the most spectacular way possible.  Anyway, the house itself was half collapsed, a SWAT van had plowed into it.  I think I knew what I was going to see in there, but I had made it that far and I wasn't going to turn back.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("You must have seen some shit on the way there."),
            next_topic = "BGSS_LOST_PARTNER_2_SOMESHIT",
        },
        {
            text = ccb.content.text("Did you make it into the house?"),
            next_topic = "BGSS_LOST_PARTNER_2_HOME2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_2_HOME2",
    line = {
        choices = {
            {
                when = predicates.actor_state("interlocutor", "female"),
                yes = ccb.content.text("I did.  Took a few hours to get an opening.  And you wanna know the fucked up part?  Like, out of all this?  My husband was still alive.  He'd been in the basement the whole time, pinned under a collapsed piece of floor.  And he'd lost a ton of blood, he was delirious by the time I found him.  I couldn't get him out, so I gave him food and water and just stayed with him and held his hand until he passed.  And then… well, then I did what you have to do to the dead now.  And then I packed up the last few fragments of my life, and I try to never look back."),
                no = ccb.content.text("I did.  Took a few hours to get an opening.  And you wanna know the fucked up part?  Like, out of all this?  My wife was still alive.  She'd been in the basement the whole time, pinned under a collapsed piece of floor.  And she'd lost a ton of blood, she was delirious by the time I found her.  I couldn't get her out, so I gave her food and water and just stayed with her and held her hand until she passed.  And then… well, then I did what you have to do to the dead now.  And then I packed up the last few fragments of my life, and I try to never look back."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Thanks for telling me that.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
