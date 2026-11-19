local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_Warrener",
    line = ccb.content.text("Don't know anything to help.  Sounds like a you job.  If I were you, I wouldn't get involved."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_ISHERWOOD",
    line = ccb.content.text("I'm not fahkin' heahtless, but I don't think you should be involved.  Doesn't strike me as a lucrative deal, yeah?  That's all I got to say on that."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_ROBOFAC_MERC_1_RADIO",
    line = ccb.content.text("Whateva' you got goin' on is between yous guys - and I mean you n' Cranberry.  We don't talk much."),
    replies = {
        {
            text = ccb.content.text("Well that's odd, but okay.  Thanks."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_BEM_jabberwock_mission",
    line = ccb.content.text("Sure fahkin' have - heard whispers all over that bahr about shit like that.  We know bettah than most monsters'r real, yeah?  Lock'n'load pal."),
    replies = {
        {
            text = ccb.content.text("You're not wrong.  Thanks."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_BEM_human_sample_mission",
    line = ccb.content.text("Yeah… sounds about right for heah.  Do it n' get paid."),
    replies = {
        {
            text = ccb.content.text("Sure, sounds good."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_CHEMIST",
    line = ccb.content.text("Yeah, that ain't how a good story starts, but see this through.  Might make a good tradin' pahrtnah."),
    replies = { { text = ccb.content.text("Yeah, alright."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_EXODII_CHOP_SHOP",
    line = ccb.content.text("Those robots give me the heebies, and I think it's in our bests interests if ya' don't go fahkin' around with something run by our employah, yeah?  Don' bite the hand that feeds."),
    replies = {
        {
            text = ccb.content.text("Yeah, you're probably right."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_ROBOFAC_CHOP_SHOP",
    line = ccb.content.text("Tell ya' what it's gonna be a real pissah.  I'm not sayin' someone has been blabbin', but I do know there's a group'a ex cops doing some kinda' secretive work for the intercom.  If it's them protectin' the place, they're geahed-up to the teeth.  'Hit Squad' wasn't on my bingo-list of post-apocalyptic dreams, but heah we are."),
    replies = {
        {
            text = ccb.content.text("Here are the coordinates.  Can you give me any intel from your old maps?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_CHOP_SHOP_INTEL",
        },
        { text = ccb.content.text("Thanks, Pat."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_BOTH_CHOP_SHOP",
    line = ccb.content.text("Tell ya' what it's gonna be a real pissah.  I'm not sayin' someone has been blabbin', but I do know there's a group'a ex cops doing some kinda' secretive work for the intercom.  If it's them protectin' the place, they're geahed-up to the teeth.  'Hit Squad' wasn't on my bingo-list of post-apocalyptic dreams, but heah we are.  In any case, those robots give me the heebies, and I don't think it's in our best interests to cross our employahs.  But, if they say you can loot the place, loot the place.  Maybe you find their little robot friend and take them back, get a fat payday.  I'd keep a log for the bosses though, yeah?"),
    replies = {
        {
            text = ccb.content.text("Here are the coordinates.  Can you give me any intel from your old maps?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_CHOP_SHOP_INTEL",
        },
        { text = ccb.content.text("Thanks, Pat."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" },
    },
}
