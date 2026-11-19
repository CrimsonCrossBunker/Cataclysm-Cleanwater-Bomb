local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_New",
    line = {
        joined = {
            ccb.content.text("Us call us the Exodii, eh?  An' other things, but that'n's good.  This're our home, such as it.  This'n's monicked as Rubik, and tassed with a trade an'.  You lookin' to trade?  Us'n's alay for the scrap, metal an' more as it be."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("We call ourselves the Exodii, eh?  And other things, but that's good.  This is our home, such as it is.  I'm called Rubik, and I've been assigned to trade with you.  Are you looking to trade?  We're always looking for scrap, metal and more."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_New_NL_Interface",
    line = {
        joined = {
            ccb.content.text("Us call us the Exodii, eh?  An' other things, but that'n's good.  This're our home, such as it.  This'n's monicked as Rubik, and tassed with a trade an'.  You lookin' to trade?  Us'n's alay for the scrap, metal an' more as it be."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("We call ourselves the Exodii, eh?  And other things, but that's good.  This is our home, such as it is.  I'm called Rubik, and I've been assigned to trade with you.  Are you looking to trade?  We're always looking for scrap, metal and more."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_New_NL_Interface2",
    line = {
        joined = {
            ccb.content.text("&The towering cyborg listens intently, bowing its entire torso now and again, in a sort of understanding nod.  Unseen speakers emit a whistle, like a human impressed, tinged with only the faintest amount of static.  \"S'a tale, no doubt.  At times, we happen by places this'n might call \"labyrinths.\"   Apples an' pears down to otherlands, in their own right.  The Exodii keeps the reckonin'.  An there's one \"nearby\", so t'speak, spotted by a green Exodii 'emself.  That's the one, this'n takes it.  So we've got accord.  We're kin by circumstance has it, aye?  Yer welcome here, n' this'n will remember n' yark the tale.\""),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("Now that's a story.  Sometimes, we find places we call \"labyrinths.\"  Stairs down to other worlds.  We keep track of them.  And, one is nearby, spotted by a novice Exodii, themselves.  That'd be the one you were trapped in, I believe.  So, I guess we're related, by circumstance, at least.  You're welcome here, and I'll remember and tell your story."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_DoneTrade",
    line = {
        choices = {
            ccb.content.text("Good an' fine, then."),
            ccb.content.text("Have it as ye'll see."),
            {
                joined = {
                    ccb.content.text("For a card an' a wink, eh?"),
                    ccb.content.text("\"\n\n[TRANSLATE:] \""),
                    ccb.content.text("That was a good exchange."),
                },
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Stock_Medieval",
    line = {
        joined = {
            ccb.content.text("That be a right welcher, eh?  Afore us'n were to this land, the preface were on a half-score century by the reckonin'.  Landed us in amidst of a war'd turned wrong, for an' as the dead had come back in.  By the butcher's block, not much an unusual case, really.  The Enemy makes us fight.  By an' by, we came in, an' by then the killin' fields were plump and ready to harvest the bronze.  'Tain't no steel-of-the-lake, but 'tis a good dross metal for holdin' off a nibblin' mouth, so we kept a few o' their vestments an' stickers for to trade."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("It's a bit of a surprise, isn't it?  Before we came here, we were in a place about 600 years earlier in time, or so.  We landed in the middle of a war that turned wrong when the dead started joining back in.  Truth be told, not a very unusual situation.  The Enemy makes us fight.  By and by, we came in, and by then the killing fields were ready for us to harvest their bronze.  It's not Avalonian steel, but it's a good strong metal for stopping a nibbling mouth, so we kept some of their armor and weapons to trade."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Stock_Nomad",
    line = {
        joined = {
            ccb.content.text("Ah, a real monger's eye, ye be.  Them's the mettle o' many a year of trials.  Us'n've been clashin wi' the Enemy for a long an' then, an' o'er the turns us've worked out some vestments for the job.  Keep's a walker walkin' longer, an I'm ken.  This'n keeps some o' the parst in an' around, but ye'd be tassed to make the vestment with the grease o' your own brow."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("Ah, you've got a discerning eye.  They're the result of many years of work.  We've been fighting the Enemy for a long time, and over the years we've worked out some armor for the job.  Keeps you going a bit longer in the field, if you ask me.  I keep some of the parts in stock, but you'll have to put it together yourself."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Stock_Nomad2",
    line = {
        joined = {
            ccb.content.text("This 'n that, an I'm ken.  It be made for a fine wander, beladen with the goods o' the hunt, y'see.  By which I'm to say, 'tis well suited to carry all ye can wrest from the cold arms o' the deadlands, without troublin' your gait nor makin' it easy for the cold clutch o' the scrabblin' arm.  Be an' it is tough as a tarket's nut, I'd razz."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("This and that, you know.  It's made for a traveling scavenger, you see.  What I mean is, it's well suited to carry around whatever you pick up in the wastelands, without making it too hard to get around nor giving any easy handholds for scrambling arms.  That, and I'd say it's as tough as nails."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Stock_Nomad3",
    line = {
        joined = {
            ccb.content.text("'Tis as simple as comes to a wobble.  Our vestment be oft made from the fine clothes and hides of the land, and our jibber tears the stuff o' life apart here and there when us'n travel.  For as some can be saved if care be taken, there be no case to store nigh enough o' this.  That, an' our manuc-makers run as hot as a sunstone, no spit'n taste for that which we don't use usselves."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("It's a simple matter of how we teleport.  Our clothes are often made from cloth and hides from wherever we visit, and our teleporter tears living stuff apart here and there when we travel.  Some can be saved if we take care, but there's no room to store nearly enough extra.  That, and our fabricators are always busy, no time to waste on stuff we don't need for ourselves."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_AskedRestock",
    line = {
        joined = {
            ccb.content.text("HEH, ye c'nnae get enough o' ol' Rubik's merchandise, eh?  Sure as 'ell, come back after <restock_time_point>."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("HEH, you can't get enough of old Rubik's merchandise, eh?  Sure as hell, come back after <restock_time_point>."),
        },
    },
}
