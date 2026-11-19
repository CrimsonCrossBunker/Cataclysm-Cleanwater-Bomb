local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ALLY_TUTORIAL_SHOUTS",
    line = ccb.content.text("Sometimes you need to give orders in a hurry.  You can use the 'C'hat command to shout a single specific order.  If I hear you, I'll do what you say, as will anyone else following you that hears it.\n  Some orders will override other instructions you've given me.  If you change my instructions when I've got an override command, I'll tell you which ones are overridden.  You can shout an order to clear any overrides, or talk to me and tell me to clear them."),
    replies = {
        {
            text = ccb.content.text("Good to know.  What orders can I give?"),
            next_topic = "TALK_ALLY_TUTORIAL_COMMANDS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ALLY_TUTORIAL_COMBAT",
    line = ccb.content.text("It's a dangerous world out there, right?  So we fight to survive.  I'm on your side, and I'll stick with you, but if I think the situation is too dangerous, I'll be honest, I'm going to run.\n  You can't tell me not to run, because I'm going to flee if things are bad, but you can tell me a safe place to retreat by using the zones manager (keybind 'Y').  I'll run toward the closest place you've designated - and you can set zones on vehicles, so if you've got a car, you could tell me to retreat there.\n  If I see you running but I think it's safe, I'll stay and fight, but you can tell me run with you and I'll stick by you as best I can.\n  You can give me some instructions on when I should attack, but I'll make my own decisions about who - I'll try to defend myself and you, but if you tell me to stay in one place I'll stay there.\n  I'll use guns and grenades if I have them, but you can tell me to not use grenades or not use loud weapons or to not use ranged weapons at all.  If I'm shooting, you can tell me how much to aim and whether to try to avoid shooting you or not.  I'm not so good at recognizing safe shots, so stay out of my line of fire no matter what.\n  I'll respect your rules for what types of weapons to use, but I'll choose what to use from my stuff.\n  You can also tell me to hold the line and fight at chokepoints, but I'm not great at recognizing them so I may go off to fight something elsewhere anyway."),
    replies = {
        {
            text = ccb.content.text("Can I give you orders quickly in combat?"),
            next_topic = "TALK_ALLY_TUTORIAL_SHOUTS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ALLY_TUTORIAL_TRAINING",
    line = ccb.content.text("If I'm better at a skill than you, I can help you improve.  But it's boring to teach a lot, so I'm not going to do it very often.  And I'm not going to do it when we're in danger or if I'm hungry or tired or if you're driving.\n  If we're someplace safe and you're reading a book that improves skills, I'll listen if I don't have that skill.  You can even read me books for skills that you already have.\n  If you give me a book that teaches a skill and that's accessible to someone with my current skill, you can ask me about my current activity and tell me to read it, and I'll learn from the book.  But while I'm reading, I won't be following you around, so make sure I'm in a safe place.\n  And don't bother asking me about learning or teaching martial arts styles.  My brain just doesn't work that way, so I don't know any to teach you and it's pointless trying to get me to learn any."),
    replies = {
        {
            text = ccb.content.text("Instead of reading to you, can we just talk?"),
            next_topic = "TALK_ALLY_TUTORIAL_SOCIAL",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ALLY_TUTORIAL_MULE",
    line = ccb.content.text("You give me something to carry, I'll carry it.  But I only have so many pockets and I'm only so strong, so I'll drop stuff that's too big to carry.\n  I'll also wear stuff - I'll decide what I want to wear, but you can take stuff from me.  If I'm wearing something I shouldn't, you can bump into me and sort my armor to get me to take if off.\n  I don't like wearing a lot of gear, so if you give me a lot of bulky stuff and things that don't fit, I'm going to take them off and probably drop them.\n  Also, since we're friends, I'll give you anything I'm carrying, no questions asked.\n  Oh, yeah, if I'm hungry or thirsty and I'm carrying food, I'll eat it.  Same if I need to recharge my bionics and I have some fuel.  So you might want to watch what you give me, y'know?"),
    replies = {
        {
            text = ccb.content.text("You can use bionics?  How does that work?"),
            next_topic = "TALK_ALLY_TUTORIAL_CBMS",
        },
    },
}
