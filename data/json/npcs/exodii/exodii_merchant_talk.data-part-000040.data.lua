local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Dialect_Anglic",
    line = ccb.content.text(
        --~ I'm a lowlife from old Upper Landing, this is my way of talking.  Everyone from where I come from talks like this.
        "Be an' as us're a dock climber from ol' Upper Landin', this'll be our way o' yarkin'.  All an' all from our green an' brown yark like this'n."),
    replies = {
        {
            text = ccb.content.text("Tell me about \"ol' Upper Landing\".  What was your home like?"),
            next_topic = "TALK_EXODII_MERCHANT_Home",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Scythean",
    line = ccb.content.text(
        --~ Ha!  A new part of our crew.  Signed up early on in the world we were in before.  He's a really tough guy, and the node appreciates his grit.  (Recites some poetry), as it were.  I think he's pretty good as a military commander.
        "Ha!  A new string and beans, an I'm ken.  Latched and keyed in the bright shine o' the deadland afore this'n.  He be a thing o' fire and bronze, an' the node appreciates his grit.  \"A cnight of old, clade in shining steel, leading the hoste onward to glorie,\" as 'twere.  This'n finds him an apt one to give rede.  To command in battle, that's t'yark."),
    replies = {
        {
            text = ccb.content.text("You know, every so often you talk normally and I realize you could probably drop the whole accent if you wanted to."),
            next_topic = "TALK_EXODII_MERCHANT_Anglic_Tease",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I think I've had about enough of trying to figure out what you're talking about, see you later."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Anglic_Tease",
    line = ccb.content.text(
        --~ Maybe, but where's the fun in that?  Besides, quoting poetry is one thing, but changing the way I speak all the time takes a lot of practice.
        "Mayhap, but where'd be the fun in that?  Asides, quoth poetry is one thing, but changin' this'n's whole yark for always takes a lot o' practice."),
    replies = {
        {
            text = ccb.content.text("What was it you were saying before, about the mission you had for me?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_intro",
        },
        {
            text = ccb.content.text("Well, a person can get sick of trying to piece it together.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Meetcute",
    line = ccb.content.text(
        --~ Right.  You see, it's when two compatible people randomly happen into each other and take a liking to one another.  It's a bit of Anglic slang.
        "Aye.  Ye kennit, when two of a sort happen upon each other as per chance, an' find a liking to another?  'Tis a bit o' Anglic yark."),
    replies = {
        {
            text = ccb.content.text("Yeah, that's what I thought it meant, just… nevermind.  What were you saying about the job?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_intro",
        },
        {
            text = ccb.content.text("I don't know what kind of game you're playing, but I'm out for a bit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Hempen1",
    line = ccb.content.text(
        --~ That takes me way back.  That's a bit of the old King's Landing right there, you know, calling back from when I was just little.  It… ah, it's really hard for me to think about those old days.  Maybe another time.
        "*seems to become wistful for a moment.  \"Harks this'n yonder, right so.  'Tis a bit o' t'ol' King's Landing right there, kennit, yarkin' from back when Rubik were nigh smaller than a kelpie.  It…\"  Rubik's gravelly voice falters.  \"Ah, 'tis mightily tassed to hearken back yonder.  Mayhap another time.\""),
    replies = {
        {
            text = ccb.content.text("Maybe later then.  What were you saying about the job?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_intro",
        },
        {
            text = ccb.content.text("You know, I think it'd be best if I just got going."),
            next_topic = "TALK_DONE",
        },
    },
}
