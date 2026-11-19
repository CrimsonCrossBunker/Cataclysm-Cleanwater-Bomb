local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_RefCenter",
    line = ccb.content.text("You'd do better to talk to the people here about it.  Seems like a bunch of them gathered here in the early days of <the_cataclysm> and managed to make it through.  It's the biggest bunch of survivors I've found yet, but most of them hunker up in the basement.  I can understand the urge.  We've all been through way too much.  They say they don't have room for more people though, so I'm just here to do some shopping, see if there's work to be done, then move on."),
    replies = {
        {
            text = ccb.content.text("What are you shopping for?"),
            next_topic = "TALK_RC_John_Bailey_Shopping",
        },
        {
            text = ccb.content.text("\"Move on\" where?"),
            next_topic = "TALK_RC_John_Bailey_OnMyWay",
        },
        {
            text = ccb.content.text("What kind of work are you looking for?"),
            next_topic = "TALK_RC_John_Bailey_Work",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_RefCenter",
    line = ccb.content.text("You'd do better to talk to the people here about it.  Seems like a bunch of them gathered here in the early days of <the_cataclysm> and managed to make it through.  It's the biggest bunch of survivors I've found yet, but most of them hunker up in the basement.  I can understand the urge.  We've all been through way too much.  They say they don't have room for more people though, so I'm just here to do some shopping, see if there's work to be done, then move on."),
    replies = {
        {
            text = ccb.content.text("What are you shopping for?"),
            next_topic = "TALK_RC_John_Bailey_Shopping",
        },
        {
            text = ccb.content.text("\"Move on\" where?"),
            next_topic = "TALK_RC_John_Bailey_OnMyWay",
        },
        {
            text = ccb.content.text("What kind of work are you looking for?"),
            next_topic = "TALK_RC_John_Bailey_Work",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_OnMyWay",
    line = ccb.content.text("Who can say, really?  I don't really have a strong plan.  Depends on how this trip goes.  Once my vehicle is full up, I'll have to head back to my hideout and check on everyone there.  I don't like being gone too long."),
    replies = {
        {
            text = ccb.content.text("What are you shopping for?"),
            next_topic = "TALK_RC_John_Bailey_Shopping",
        },
        {
            text = ccb.content.text("Who is \"everyone\"?"),
            next_topic = "TALK_RC_John_Bailey_Faction",
        },
        {
            text = ccb.content.text("Are you looking for work?"),
            next_topic = "TALK_RC_John_Bailey_Work",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_Faction",
    line = ccb.content.text("Huh, well, the short story is, I got my wife and kids out of town in the really, really early days.  She's got great intuition for stuff and when she told me to get ready to leave town, I figured at worst we'd have an unnecessary early spring vacation in my dad's old cabin, you know?  Obviously, turns out trusting her gut saved us all and then some.  Things were still tough, but from what I've heard, I might be the only person left on the Eastern Seaboard who still has his whole nuclear family.  Still got a lot of survivor's guilt for that… still lost everyone else.  Anyway, one thing led to another and we gathered a few other people that we watch out for.  My man Darius, he joined up early on and he and I do the scouting and scavenging and watch each others' backs."),
    replies = {
        {
            text = ccb.content.text("Where are you guys located?  Can I join up too?"),
            next_topic = "TALK_RC_John_Bailey_Faction2",
        },
        {
            text = ccb.content.text("Tell me about Darius."),
            next_topic = "TALK_RC_John_Bailey_Darius",
        },
        {
            text = ccb.content.text("How did you know things were going to go wrong?"),
            next_topic = "TALK_RC_John_Bailey_Intuition",
        },
        {
            text = ccb.content.text("That seems like a pretty unlikely story."),
            next_topic = "TALK_RC_John_Bailey_Doubt",
        },
        {
            text = ccb.content.text("Can you give me any advice?"),
            next_topic = "TALK_RC_John_Bailey_Advice",
        },
        {
            text = ccb.content.text("What did you used to do before?"),
            next_topic = "TALK_RC_John_Bailey_Background",
        },
        {
            text = ccb.content.text("Let's change the subject.  What did you say you were doing here?"),
            next_topic = "TALK_RC_John_Bailey_2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_Faction2",
    line = ccb.content.text("I'll be straight with you, I don't want to tell you too much about my people, okay?  You seem all right, don't get me wrong, but I've seen some scary fuckin' people out there, who come on all normal and then try to bite your face off when they get you alone.  Everyone's reaction to the world's end is a bit different.  Things are stable with my people now, but we don't really welcome new faces anymore.  I wish it weren't that way.  Maybe if you and I get to know each other better some day, I'll change my mind."),
    replies = {
        {
            text = ccb.content.text("Tell me about Darius."),
            next_topic = "TALK_RC_John_Bailey_Darius",
        },
        {
            text = ccb.content.text("How did you know things were going to go wrong?"),
            next_topic = "TALK_RC_John_Bailey_Intuition",
        },
        {
            text = ccb.content.text("Your whole story seems a bit unlikely."),
            next_topic = "TALK_RC_John_Bailey_Doubt",
        },
        {
            text = ccb.content.text("Can you give me any advice?"),
            next_topic = "TALK_RC_John_Bailey_Advice",
        },
        {
            text = ccb.content.text("What did you used to do before?"),
            next_topic = "TALK_RC_John_Bailey_Background",
        },
        {
            text = ccb.content.text("Let's change the subject.  What did you say you were doing here?"),
            next_topic = "TALK_RC_John_Bailey_2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_Darius",
    line = ccb.content.text("Talk to Darius if you want to know about Darius.  He's a good man, and he won't bite-- ugh, sorry, that's a turn of phrase we should probably retire, hey?  Anyway.  I don't know if we'd have made it through the first days without him.  He gets a bit jumpy around crowds since the riots though, so he's out watching our stuff."),
    replies = {
        {
            text = ccb.content.text("Where are you guys located?  Can I join up too?"),
            next_topic = "TALK_RC_John_Bailey_Faction2",
        },
        {
            text = ccb.content.text("How did you know things were going to go wrong?"),
            next_topic = "TALK_RC_John_Bailey_Intuition",
        },
        {
            text = ccb.content.text("Your whole story seems a bit unlikely."),
            next_topic = "TALK_RC_John_Bailey_Doubt",
        },
        {
            text = ccb.content.text("Can you give me any advice?"),
            next_topic = "TALK_RC_John_Bailey_Advice",
        },
        {
            text = ccb.content.text("What did you used to do before?"),
            next_topic = "TALK_RC_John_Bailey_Background",
        },
        {
            text = ccb.content.text("Let's change the subject.  What did you say you were doing here?"),
            next_topic = "TALK_RC_John_Bailey_2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_Intuition",
    line = ccb.content.text("Sometimes, I kinda wonder why other people *didn't* know things were going to go wrong.  Hindsight is twenty-twenty, I guess.  I'll be honest though, as much as I'd like to pat myself on the back, it wasn't me that figured it out.  When the really early riots started out, even though they were way up in the Midwest, my wife just had a bad feeling.  We'd been thinking of a getaway anyway, and I had some time off, so we took it as an excuse to get out to the cabin and wait for everything to blow over.  Here we are.  It wasn't so much knowing how things were going to go, more just straight luck that we trusted our - *her* - gut at the right time and lucked out."),
    replies = {
        {
            text = ccb.content.text("Where are you guys located?  Can I join up too?"),
            next_topic = "TALK_RC_John_Bailey_Faction2",
        },
        {
            text = ccb.content.text("Tell me about Darius."),
            next_topic = "TALK_RC_John_Bailey_Darius",
        },
        {
            text = ccb.content.text("Your whole story seems a bit unlikely."),
            next_topic = "TALK_RC_John_Bailey_Doubt",
        },
        {
            text = ccb.content.text("Can you give me any advice?"),
            next_topic = "TALK_RC_John_Bailey_Advice",
        },
        {
            text = ccb.content.text("What did you used to do before?"),
            next_topic = "TALK_RC_John_Bailey_Background",
        },
        {
            text = ccb.content.text("Let's change the subject.  What did you say you were doing here?"),
            next_topic = "TALK_RC_John_Bailey_2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_Doubt",
    line = ccb.content.text("*chuckles.  \"Lucky for me then it doesn't matter if you believe me.  I do gotta say though, it's funny you and I, a pair of actual real-live zombie hunters, are talking face to face and you think my *survival story* is the unlikely thing.\""),
    replies = {
        {
            text = ccb.content.text("Where are you guys located?  Can I join up too?"),
            next_topic = "TALK_RC_John_Bailey_Faction2",
        },
        {
            text = ccb.content.text("Tell me about Darius."),
            next_topic = "TALK_RC_John_Bailey_Darius",
        },
        {
            text = ccb.content.text("How did you know things were going to go wrong?"),
            next_topic = "TALK_RC_John_Bailey_Intuition",
        },
        {
            text = ccb.content.text("Can you give me any advice?"),
            next_topic = "TALK_RC_John_Bailey_Advice",
        },
        {
            text = ccb.content.text("What did you used to do before?"),
            next_topic = "TALK_RC_John_Bailey_Background",
        },
        {
            text = ccb.content.text("Let's change the subject.  What did you say you were doing here?"),
            next_topic = "TALK_RC_John_Bailey_2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_Work",
    line = ccb.content.text("I do odd jobs if people need help.  Not on a volunteer basis you understand, but I try not to be unfair about it either.  Lots of people need a bit of help these days, often just with little things a scavenger like me can find for them.  It's easy for folks like you and me to underestimate how scared a lot of people are to go back out in that place.  The situation's bad enough as it is, but these kind of people took refuge back when it was true chaos out there.  Lots of trauma to unpack there.  Anyway, if there's little things I can do for them, I try to help where I can, so long as it doesn't put me in too much danger."),
    replies = {
        {
            text = ccb.content.text("You look like you can handle yourself in a fight.  What's your zombie kill count?"),
            next_topic = "TALK_RC_John_Bailey_ZKC",
        },
        {
            text = ccb.content.text("I could use someone like you.  Want to travel with me?"),
            next_topic = "TALK_RC_John_Bailey_Join",
        },
        {
            text = ccb.content.text("You seem to know a lot about how people feel."),
            next_topic = "TALK_RC_John_Bailey_Trauma",
        },
        {
            text = ccb.content.text("You've got that right.  People like you and I are made of stronger stuff."),
            next_topic = "TALK_RC_John_Bailey_Exceptional",
        },
        {
            text = ccb.content.text("People should learn to fend for themselves, not just get you to hand everything to them."),
            next_topic = "TALK_RC_John_Bailey_ToughLove",
        },
        {
            text = ccb.content.text("Can you give me any advice?"),
            next_topic = "TALK_RC_John_Bailey_Advice",
        },
        {
            text = ccb.content.text("What did you used to do before?"),
            next_topic = "TALK_RC_John_Bailey_Background",
        },
        {
            text = ccb.content.text("Let's change the subject.  What did you say you were doing here?"),
            next_topic = "TALK_RC_John_Bailey_2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_ZKC",
    line = ccb.content.text("*laughs a bit sheepishly.  \"Seems distasteful to keep track of that stuff, doesn't it?\"  He touches a series of notches on his <mywp>.  \"I'm human though.  I'm up to <npc_val:zkc_john> so far.  Seems like a lot to me, especially since I try to avoid actually engaging the enemy if I can help it.\""),
    replies = {
        {
            text = ccb.content.text("I could use someone like you.  Want to travel with me?"),
            next_topic = "TALK_RC_John_Bailey_Join",
        },
        {
            text = ccb.content.text("You seem to know a lot about how people feel."),
            next_topic = "TALK_RC_John_Bailey_Trauma",
        },
        {
            text = ccb.content.text("Can you give me any advice?"),
            next_topic = "TALK_RC_John_Bailey_Advice",
        },
        {
            text = ccb.content.text("What did you used to do before?"),
            next_topic = "TALK_RC_John_Bailey_Background",
        },
        {
            text = ccb.content.text("Let's change the subject.  What did you say you were doing here?"),
            next_topic = "TALK_RC_John_Bailey_2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_Join",
    line = ccb.content.text("*sizes you up and down, and shakes his head sadly.  \"Darius and I have a good thing going, and a third person would be hard to justify, especially these days.  Trust comes hard.  I'm sorry.  I hope you've got someone to watch your back, but it can't be me.\""),
    replies = {
        {
            text = ccb.content.text("You look like you can handle yourself in a fight.  What's your zombie kill count?"),
            next_topic = "TALK_RC_John_Bailey_ZKC",
        },
        {
            text = ccb.content.text("You seem to know a lot about how people feel."),
            next_topic = "TALK_RC_John_Bailey_Trauma",
        },
        {
            text = ccb.content.text("That's a shame.  We'd be a good team.  People like you and I are made of stronger stuff."),
            next_topic = "TALK_RC_John_Bailey_Exceptional",
        },
        {
            text = ccb.content.text("Damn straight.  People should learn to fend for themselves."),
            next_topic = "TALK_RC_John_Bailey_ToughLove",
        },
        {
            text = ccb.content.text("Can you give me any advice?"),
            next_topic = "TALK_RC_John_Bailey_Advice",
        },
        {
            text = ccb.content.text("What did you used to do before?"),
            next_topic = "TALK_RC_John_Bailey_Background",
        },
        {
            text = ccb.content.text("Let's change the subject.  What did you say you were doing here?"),
            next_topic = "TALK_RC_John_Bailey_2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_Trauma",
    line = ccb.content.text("Yeah, I, uh… I know a bit about that stuff.  Hard not to empathize, especially when I know I'm not quite as hard as others, by sheer luck.  Besides, there are so few of us left now.  What's the point in wasting time judging other people for how hard they took the end of the world?"),
    replies = {
        {
            text = ccb.content.text("It sounds like you have some past there.  You want to talk about it?"),
            next_topic = "TALK_RC_John_Bailey_Trauma2",
        },
        {
            text = ccb.content.text("You look like you can handle yourself in a fight.  What's your zombie kill count?"),
            next_topic = "TALK_RC_John_Bailey_ZKC",
        },
        {
            text = ccb.content.text("I could use someone like you.  Want to travel with me?"),
            next_topic = "TALK_RC_John_Bailey_Join",
        },
        {
            text = ccb.content.text("Can you give me any advice?"),
            next_topic = "TALK_RC_John_Bailey_Advice",
        },
        {
            text = ccb.content.text("What did you used to do before?"),
            next_topic = "TALK_RC_John_Bailey_Background",
        },
        {
            text = ccb.content.text("Let's change the subject.  What did you say you were doing here?"),
            next_topic = "TALK_RC_John_Bailey_2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_Trauma2",
    line = ccb.content.text("Not really, no.  It's old stuff, and there's enough going on.  Let's just say I'm no stranger to loss, either my own or others'."),
    replies = {
        {
            text = ccb.content.text("You look like you can handle yourself in a fight.  What's your zombie kill count?"),
            next_topic = "TALK_RC_John_Bailey_ZKC",
        },
        {
            text = ccb.content.text("I could use someone like you.  Want to travel with me?"),
            next_topic = "TALK_RC_John_Bailey_Join",
        },
        {
            text = ccb.content.text("Can you give me any advice?"),
            next_topic = "TALK_RC_John_Bailey_Advice",
        },
        {
            text = ccb.content.text("What did you used to do before?"),
            next_topic = "TALK_RC_John_Bailey_Background",
        },
        {
            text = ccb.content.text("Let's change the subject.  What did you say you were doing here?"),
            next_topic = "TALK_RC_John_Bailey_2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_Exceptional",
    line = ccb.content.text("*raises an eyebrow.  \"I don't know about that.  You should be careful about thinking people who don't make the same choices as you are inferior.  Sure, not everyone's suited to scavenge, but a scavenger's got to have a safe home, too.\""),
    replies = {
        {
            text = ccb.content.text("You look like you can handle yourself in a fight.  What's your zombie kill count?"),
            next_topic = "TALK_RC_John_Bailey_ZKC",
        },
        {
            text = ccb.content.text("I could use someone like you.  Want to travel with me?"),
            next_topic = "TALK_RC_John_Bailey_Join",
        },
        {
            text = ccb.content.text("You seem to know a lot about how people feel."),
            next_topic = "TALK_RC_John_Bailey_Trauma",
        },
        {
            text = ccb.content.text("Fuck that.  People should learn to fend for themselves."),
            next_topic = "TALK_RC_John_Bailey_ToughLove",
        },
        {
            text = ccb.content.text("Can you give me any advice?"),
            next_topic = "TALK_RC_John_Bailey_Advice",
        },
        {
            text = ccb.content.text("What did you used to do before?"),
            next_topic = "TALK_RC_John_Bailey_Background",
        },
        {
            text = ccb.content.text("Let's change the subject.  What did you say you were doing here?"),
            next_topic = "TALK_RC_John_Bailey_2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_ToughLove",
    line = ccb.content.text("*rubs his stubble, looking thoughtful.  \"I agree it's important to be independent, but don't forget, working together is what makes us better than the undead.  It's how we got out of the trees and fields, and into civilization.  Anyway, I don't want to talk philosophy at you.  If you're doing well on your own, more power to you!\""),
    replies = {
        {
            text = ccb.content.text("You look like you can handle yourself in a fight.  What's your zombie kill count?"),
            next_topic = "TALK_RC_John_Bailey_ZKC",
        },
        {
            text = ccb.content.text("I could use someone like you.  Want to travel with me?"),
            next_topic = "TALK_RC_John_Bailey_Join",
        },
        {
            text = ccb.content.text("You seem to know a lot about how people feel."),
            next_topic = "TALK_RC_John_Bailey_Trauma",
        },
        {
            text = ccb.content.text("That's for the weaklings.  People like you and I are made of stronger stuff."),
            next_topic = "TALK_RC_John_Bailey_Exceptional",
        },
        {
            text = ccb.content.text("I don't know, the zombies sure seem to work together to me."),
            next_topic = "TALK_RC_John_Bailey_ToughLove2",
        },
        {
            text = ccb.content.text("Can you give me any advice?"),
            next_topic = "TALK_RC_John_Bailey_Advice",
        },
        {
            text = ccb.content.text("What did you used to do before?"),
            next_topic = "TALK_RC_John_Bailey_Background",
        },
        {
            text = ccb.content.text("Let's change the subject.  What did you say you were doing here?"),
            next_topic = "TALK_RC_John_Bailey_2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_ToughLove2",
    line = ccb.content.text("*chuckles.  \"If you can call it that, sure.  So maybe we should do our best to be better at that than the zombies.  Seems pretty reasonable to me, and it's a pretty low bar to clear.\""),
    replies = {
        {
            text = ccb.content.text("You look like you can handle yourself in a fight.  What's your zombie kill count?"),
            next_topic = "TALK_RC_John_Bailey_ZKC",
        },
        {
            text = ccb.content.text("I could use someone like you.  Want to travel with me?"),
            next_topic = "TALK_RC_John_Bailey_Join",
        },
        {
            text = ccb.content.text("You seem to know a lot about how people feel."),
            next_topic = "TALK_RC_John_Bailey_Trauma",
        },
        {
            text = ccb.content.text("Can you give me any advice?"),
            next_topic = "TALK_RC_John_Bailey_Advice",
        },
        {
            text = ccb.content.text("What did you used to do before?"),
            next_topic = "TALK_RC_John_Bailey_Background",
        },
        {
            text = ccb.content.text("Let's change the subject.  What did you say you were doing here?"),
            next_topic = "TALK_RC_John_Bailey_2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_Advice",
    line = ccb.content.text("Sure, I guess.  I don't know if I know anything you don't, you seem like you can handle yourself.  I've made it this far by not engaging whenever possible.  I'm never going to kill all the zombies out there.  Darius and I try not to fight if we can avoid it, and if we can't, we try to always have the advantage.  Numbers, weaponry, terrain.  Zombies are clumsy and stupid so we lead them across bushes and things to trip and stumble.  We take high ground and let them plough into ladders like idiots while we stick 'em with spears from above.  Mostly, though, we try not to be seen.  We use bikes instead of cars because they don't make noise and don't need gas, plus we can take forest trails and things and avoid traffic jams.  Those things are suicide.  We try to avoid the cities, and when we do go close, we stick to the outskirts and raid the outlying houses.  In those, we keep crouched and try to get deep into the building fast, or down into the basement, so that little noises don't carry much and nothing from outside can see us.  Also, zombies being idiots, closing the blinds is a great move.  I always keep a crowbar for opening doors and windows, but I try not to use it if I can avoid it.  Darius can pick locks, which is slower but doesn't make noise.  We get a lot more mileage from raiding gas stations and other rural sites, where if there are a few zombies, we can usually lead them away."),
    replies = {
        {
            text = ccb.content.text("What about things other than zombies?"),
            next_topic = "TALK_RC_John_Bailey_Advice2",
        },
        {
            text = ccb.content.text("What did you used to do before?"),
            next_topic = "TALK_RC_John_Bailey_Background",
        },
        {
            text = ccb.content.text("Let's change the subject.  What did you say you were doing here?"),
            next_topic = "TALK_RC_John_Bailey_2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_Advice2",
    line = ccb.content.text("Oh, jeez, yeah.  The world really went to shit, didn't it?  Well, I've seen some weird alien things.  Our rule is 'scared is better than dead'.  If we don't know what something is and how to kill it, we steer wide and clear.  One time I saw this flaming eyeball a long way off, I was scouting from a cell phone tower.  It made eye contact with me and I just started hallucinating shit.  Darius stopped me from falling right off the tower.  Stuff like that is why I think you have to be a bit off your rocker to travel these days unless you have no choice.  Anything we don't know, we turn around and pedal hard.  So far, we haven't met anything our bikes can't outrun."),
    replies = {
        {
            text = ccb.content.text("Let's change the subject.  What did you say you were doing here?"),
            next_topic = "TALK_RC_John_Bailey_2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_Background",
    line = ccb.content.text("That's a tougher question than you might think.  I've had quite the life.  My dad was a mechanic, and when I was young I used to help around the shop quite a bit.  I started out thinking I was going to get into that line of work, but then I got sidetracked and wound up getting into computers and electrical work for a long time.  Did part of an electrical engineering degree, then decided it wasn't for me and quit that.  Spent a bit of time doing freelance electrical and programming work, then got recruited by a startup that was designing and programming medical equipment.  I was supposed to be a general technician, but through a weird series of events I wound up in sales, then management.  I hated management, and I'd made a big nest egg from my share stock, so I cashed out and tried to retire young.  That was a dumb move, I was bored as hell, so I finished off my degree and started doing on-call teaching work for shop, computers, math, and things like that at a college and high school level.  Just part time, and I spent the rest of my time outdoors, hiking and whatnot."),
    replies = {
        {
            text = ccb.content.text("That is one hell of a life.  You must have some useful skills to teach."),
            next_topic = "TALK_RC_John_Bailey_Teach",
        },
        {
            text = ccb.content.text("Let's change the subject.  What did you say you were doing here?"),
            next_topic = "TALK_RC_John_Bailey_2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
